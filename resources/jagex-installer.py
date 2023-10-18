import requests
import json
import base64
import gzip
import pprint
import os
from pathlib import Path
import errno

url_template = "http://jagex-akamai.aws.snxd.com/direct6/launcher-win/pieces/{}/{}.solidpiece"
dirname = os.path.dirname(__file__)

def mkdir_p(path):
    try:
        parent_path = Path(path)
        os.makedirs(parent_path.parent.absolute(), exist_ok=True)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else: raise

def get_abs_path(relative_path):
    return os.path.join(dirname, relative_path)

def download_and_gzip_deflate(url, filename):
    print ("Downloading file from: {}".format(url))
    response = requests.get(url)
    if response.status_code == 200:
        # Remove the first 6 bytes from the file. There is a set of what appear to be proprietary magic bytes placed here in the header, I assume something Solid State Network's DIRECT protocol uses.
        content = response.content[6:]

        with open(filename, 'wb') as f:
            f.write(content)
        try:
            with gzip.open(filename, 'rb') as compressed_file:
                # Read and decompress the data
                decompressed_data = compressed_file.read()
        except Exception as e:
            print(f"An error occurred. Skipping because it is not a gzip: {e}")
            return
        # Save the decompressed data to an output file
        with open(filename, 'wb') as output_file:
            output_file.write(decompressed_data)

        print("Decompressed data saved to:", filename)
    else:
        print(f"Failed to download file: {response.status_code}")

def fetch_metafile(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response.content.decode()
    else:
        raise Exception(f"Failed to fetch metafile, status code: {response.status_code}")

def decode_base64(encoded_str):
    try:
        # Ensure the string is padded to a multiple of 4 characters
        padded_str = encoded_str + '=' * ((4 - len(encoded_str) % 4) % 4)
        
        # Decode the base64 string
        decoded_bytes = base64.b64decode(padded_str)
        
        # Return the decoded bytes
        return decoded_bytes
    except binascii.Error:
        print("An error occurred: Incorrect padding or corrupted data.")
        return None

def main():
    # TODO make this grab the latest release instead of hard-coding, although this should work for awhile since the launcher auto-updates itself on launch.
    # That piece reliably on linux.
    metafile_url = "http://jagex-akamai.aws.snxd.com/direct6/launcher-win/metafile/d589817a9dbde1cb1c6f1cde1e81b5284db1c5d0617577e3c3b987406ca2b50b/metafile.json"
    
    try:
        metafile = fetch_metafile(metafile_url)
        global digest_list
        global pad_array
        global file_list
        
        items = metafile.split('.')
        for item in items:
            decoded_bytes = decode_base64(item)
            if decoded_bytes is not None:
                decoded_str = decoded_bytes.decode('utf-8')
                metafile_json = json.loads(decoded_str)
                if metafile_json.get('files') is not None:
                    digest_list = metafile_json.get("pieces").get("digests")
                    file_list = metafile_json.get("files")
                    pad_array = metafile_json.get("pad")
                    break

        downloaded_file_pieces = []

        for digest in digest_list:
            digest_string = base64.b64decode(digest).hex()
            print(digest_string)
            downloaded_file_pieces.append(digest_string)
            download_and_gzip_deflate(url_template.format(digest_string[0:2], digest_string), digest_string + ".solidpiece")
        with open(get_abs_path('combined_file'), 'wb') as combined_file:
            for item in downloaded_file_pieces:
                with open("{}.solidpiece".format(item), 'rb') as temp_file:
                    content = temp_file.read()
                    combined_file.write(content)
        with open(get_abs_path('combined_file'), 'rb') as source_file:
            for file in file_list:
                print('Building {} by splitting off {} bytes of the combined zip'.format(file['name'], file['size']))                
                file_output = source_file.read(file['size'])
                output_file_path = get_abs_path(file['name'])
                # Make sure the directory we are writing to exists
                mkdir_p(output_file_path)
                with open(output_file_path, 'wb') as output:
                    output.write(file_output)
                
        
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
