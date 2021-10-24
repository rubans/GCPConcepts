"""
Utility module for interaction with GCS api
"""
import json, os
from datetime import datetime
from google.cloud import storage






def move_file(blob_name, source_bucket_name, destination_bucket_name):
    """Move file from source_bucket_name to destination_bucket_name"""
    # create storage client
    storage_client = storage.Client()
    source_blob_name = "{}".format(blob_name)
    """Appeding current time to the archived file."""

    destination_blob_name = f"{blob_name}"
    source_bucket = storage_client.bucket(source_bucket_name)
    source_blob = source_bucket.blob(source_blob_name)
    destination_bucket = storage_client.bucket(destination_bucket_name)
    try:
        blob_copy = source_bucket.copy_blob(
            source_blob, destination_bucket, destination_blob_name
        )
    except:
        raise Exception("Error copying blob {}".format(blob_name))

    print("Blob {} in bucket {} copied to blob {} in bucket {}.".format(
        source_blob.name,
        source_bucket.name,
        blob_copy.name,
        destination_bucket.name,
    ))
    print("Copying complete, deleting source blob {} in bucket {}.".format(source_blob.name, source_bucket.name))
    source_blob.delete()


def upload_blob(bucket_name, source_file_name, destination_blob_name):
    """Uploads a file to the bucket."""
    # bucket_name = "your-bucket-name"
    # source_file_name = "local/path/to/file"
    # destination_blob_name = "storage-object-name"

    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)

    blob.upload_from_filename(source_file_name)

    print(
        "File {} uploaded to {}.".format(
            source_file_name, destination_blob_name
        )
    )


def check_blob(bucket_name, filename):
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(filename)
    return blob.exists()


def list_files(bucketName, file_location):
    """List all files in GCP bucket."""
    # create storage client
    storage_client = storage.Client()
    # get bucket with name
    bucket = storage_client.get_bucket(bucketName)
    files = bucket.list_blobs(prefix=file_location)

    blob_list = [file.name for file in files if '.' in file.name]
    file_names = []
    for file_path in blob_list:
        head_tail = os.path.split(file_path)
        if head_tail[0] == file_location:
            file_names.append(head_tail[1])
    return file_names


def download_file(bucket, input_file_location, download_file_location):
    """Read a json from GCS bucket"""
    # create storage client
    storage_client = storage.Client()
    # get bucket with name
    bucket = storage_client.get_bucket(bucket)
    # get bucket data as blob
    blob = bucket.get_blob(input_file_location)
    # convert to string
    blob.download_to_filename(download_file_location)

def download_file_as_string(bucket, input_file_location):
    """Read a json from GCS bucket"""
    # create storage client
    storage_client = storage.Client()
    # get bucket with name
    bucket = storage_client.get_bucket(bucket)
    # get bucket data as blob
    blob = bucket.get_blob(input_file_location)
    # convert to string
    return blob.download_as_string()