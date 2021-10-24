import os
import glob 
from constants import UNIT_TEST_FILE_NAME,PROJECT_TESTING_DIR
from  utils.gcs_utils import upload_blob
from  utils.file_utils import file_to_list

reports_bucket = os.environ['REPORTS_BUCKET']
build = os.environ['BUILD']

modules = file_to_list(UNIT_TEST_FILE_NAME)
os.chdir(PROJECT_TESTING_DIR)


for module in modules:
    cwd = os.getcwd()
    os.chdir(module)
    cmd_res = os.system("kitchen verify")
    print("Upload results for unit test for module : {0}".format(os.getcwd()))
    upload_blob(reports_bucket,".kitchen/logs/default-terraform.log", f"reports/{module}/unit-test-{build}-log")
    upload_blob(reports_bucket,"output.json", f"reports/{module}/unit-test-{build}.json")
    os.chdir(cwd)