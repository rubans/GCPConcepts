import os
from constants import COMPLIANCE_TEST_TMP_DIR,PROJECT_TESTING_DIR,COMPLIANCE_TEST_FILE_NAME,COMPLIANCE_TEST_DIR_SELECTOR
from  utils.gcs_utils import upload_blob
from  utils.file_utils import file_to_list, copy_dirs

reports_bucket = os.environ['REPORTS_BUCKET']
build = os.environ['BUILD']

modules = file_to_list(COMPLIANCE_TEST_FILE_NAME)
os.chdir(PROJECT_TESTING_DIR)


for module in modules:
    cwd = os.getcwd()
    os.chdir(module)
    control_dirs = file_to_list(COMPLIANCE_TEST_DIR_SELECTOR)

    print('copy dirs')
    copy_dirs(COMPLIANCE_TEST_TMP_DIR + '/controls', './test/integration/default/controls', control_dirs)

    cmd_res = os.system("kitchen verify")
    print("Upload results for unit test for module : {0}".format(os.getcwd()))
    upload_blob(reports_bucket,".kitchen/logs/default-terraform.log", f"reports/{module}/compliance-test-{build}-log")
    upload_blob(reports_bucket,"output.json", f"reports/{module}/compliance-test-{build}.json")
    os.chdir(cwd)

