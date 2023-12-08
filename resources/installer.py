import base64
import binascii
import errno
import gzip
from hashlib import sha256
import json
import os
from pathlib import Path
from urllib.request import urlopen, Request

url_template = "https://jagex.akamaized.net/direct6/launcher-win/pieces/{}/{}.solidpiece"
dirname = os.getcwd()

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

def http_get(url):
    if not url.startswith("https"):
        raise Exception("Only HTTPS is supported.")
    with urlopen(Request(url)) as response:
        return {
            "status_code": response.status,
            "content": response.read()
        }

def download_gzip_deflate_and_validate(url, filename, digest):
    print ("Downloading file from: {}".format(url))
    response = http_get(url)
    if response["status_code"] == 200:
        # Remove the first 6 bytes from the file. There is a set of what appear to be proprietary magic bytes placed here in the header, I assume something Solid State Network's DIRECT protocol uses.
        content = response["content"][6:]

        with open(filename, 'wb') as f:
            f.write(content)
        try:
            with gzip.open(filename, 'rb') as compressed_file:
                # Read and decompress the data
                decompressed_data = compressed_file.read()
        except Exception as e:
            print(f"Skipping because it is not a gzip archive...")
            return
        # Save the decompressed data to an output file
        with open(filename, 'wb') as output_file:
            output_file.write(decompressed_data)

        # Validate the the checksum matches what is expected in the validated JWT
        with open(filename, 'rb') as file_to_hash:
            # Validate the digest
            checksum = sha256(file_to_hash.read()).hexdigest()
            print ("Expected: {} Recieved: {}".format(digest, checksum))
            if checksum != digest:
                raise Exception("For {} expected a checksum of {}, but got {}.".format(filename, digest, checksum))
        

        print("Decompressed data saved to:", filename)
    else:
        print(f"Failed to download file: {response['status_code']}")

def fetch_metafile(url):
    response = http_get(url)
    if response["status_code"] == 200:
        return response["content"].decode()
    else:
        raise Exception(f"Failed to fetch metafile, status code: {response['status_code']}")

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
def cleanup():
    for p in Path(".").glob("*.solidpiece"):
        p.unlink()
    for p in Path(".").glob("combined_file"):
        p.unlink()

def main():
    metafile_url_template = "https://jagex.akamaized.net/direct6/launcher-win/metafile/{}/metafile.json"

    catalog_url = "https://jagex.akamaized.net/direct6/launcher-win/alias.json"

    catalog_json = http_get(catalog_url)

    metafile_url = metafile_url_template.format(json.loads(catalog_json["content"])['launcher-win.production'])

    print('Latest metafile_url: {}'.format(metafile_url))

    metafile_json = json.loads(http_get(metafile_url)["content"])

    try:
        global digest_list
        global pad_array
        global file_list

        digest_list = metafile_json.get("pieces").get("digests")
        file_list = metafile_json.get("files")
        pad_array = metafile_json.get("pad")

        downloaded_file_pieces = []

        for digest in digest_list:
            digest_string = base64.b64decode(digest).hex()
            print(digest_string)
            downloaded_file_pieces.append(digest_string)
            download_gzip_deflate_and_validate(url_template.format(digest_string[0:2], digest_string), digest_string + ".solidpiece", digest_string)
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
    cleanup()
