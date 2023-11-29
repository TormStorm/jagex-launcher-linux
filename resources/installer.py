import requests
import json
import base64
import gzip
import pprint
import os
from pathlib import Path
import errno
import sys
import base64
import jwcrypto.jwt, jwcrypto.jwk
import cryptography.x509
from cryptography.hazmat.primitives.serialization import Encoding, PublicFormat
from cryptography.hazmat.primitives.asymmetric import padding
import pprint
from hashlib import sha256
import datetime

url_template = "http://jagex-akamai.aws.snxd.com/direct6/launcher-win/pieces/{}/{}.solidpiece"
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

def download_gzip_deflate_and_validate(url, filename, digest):
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
def cleanup():
    for p in Path(".").glob("*.solidpiece"):
        p.unlink()
    for p in Path(".").glob("combined_file"):
        p.unlink()

def main():
    # TODO make this grab the latest release instead of hard-coding, although this should work for awhile since the launcher auto-updates itself on launch.
    # That piece reliably on linux.
    metafile_url_template = "http://jagex-akamai.aws.snxd.com/direct6/launcher-win/metafile/{}/metafile.json"
    # This is the fingerprint of the certificate that signed the JWT we are using from the jagex CDN so we can validate we are trusting the right certificate chain.
    JAGEX_PACKAGE_CERTIFICATE_SHA256_HASH = "848bae7e92dc58570db50cdfc933a78204c1b00f05d64f753a307ebbaed2404f"

    catalog_url = "https://jagex.akamaized.net/direct6/launcher-win/alias.json"

    catalog_json = requests.get(catalog_url)

    metafile_url = metafile_url_template.format(json.loads(catalog_json.content)['launcher-win.production'])

    print('Latest metafile_url: {}'.format(metafile_url))

    metafile_json = requests.get(metafile_url)

    jwt = metafile_json.content.strip()
    jwt = jwcrypto.jwt.JWT(jwt=jwt.decode("ascii"))
    
    # Load and deserialize JWT
    jwt = requests.get(metafile_url).content.strip()
    jwt = jwcrypto.jwt.JWT(jwt=jwt.decode("ascii"))

    # Deserialize the leaf certificate and validate the fingerprint of the certificate
    trust_path = jwt.token.jose_header.get("x5c", [])
    leaf_cert_b64 = trust_path[0]
    leaf_cert_sha256_hash = sha256(leaf_cert_b64.encode('utf8')).hexdigest()

    print ("Validating fingerprint of the certificate that signed the JWT...")
    if leaf_cert_sha256_hash != JAGEX_PACKAGE_CERTIFICATE_SHA256_HASH:
        raise Exception("The certificate in the JWT header does not match the expected fingerprint.")

    leaf_cert = cryptography.x509.load_der_x509_certificate(
        base64.b64decode(leaf_cert_b64))

    # Derive public key from the package cert and convert to JWK
    public_key = leaf_cert.public_key()
    public_key = public_key.public_bytes(Encoding.PEM, PublicFormat.PKCS1)
    public_key = jwcrypto.jwk.JWK.from_pem(public_key)

    # Validate JWT and access claims
    jwt.validate(public_key)
    print('''The jwt has validated against the certificate. 
        Issuer: {}
        Subject: {}
        Expiration UTC: {}
        '''.format(leaf_cert.issuer, leaf_cert.subject, leaf_cert.not_valid_after))

    # Build certificate chain
    trust_path = jwt.token.jose_header.get("x5c", [])
    trust_path = [
        cryptography.x509.load_der_x509_certificate(base64.b64decode(cert))
        for cert in trust_path
    ]

    # Verify certificate chain
    for i in range(len(trust_path) - 1):
        issuer_certificate = trust_path[i + 1]
        subject_certificate = trust_path[i]
        issuer_public_key = issuer_certificate.public_key()
        issuer_public_key.verify(
            subject_certificate.signature,
            subject_certificate.tbs_certificate_bytes,
            padding.PKCS1v15(),
            subject_certificate.signature_hash_algorithm,
        )
        # Verify certificate expiration
        current_time = datetime.datetime.utcnow()
        if current_time < issuer_certificate.not_valid_before or current_time > issuer_certificate.not_valid_after:
            raise Exception("Issuer certificate has expired.")

    try:
        global digest_list
        global pad_array
        global file_list
        
        verified_claims_json = json.loads(jwt.claims)

        digest_list = verified_claims_json.get("pieces").get("digests")
        file_list = verified_claims_json.get("files")
        pad_array = verified_claims_json.get("pad")

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
