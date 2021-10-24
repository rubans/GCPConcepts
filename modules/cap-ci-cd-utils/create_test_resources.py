import  constants

import os
from  utils.file_utils import file_to_list


unit_test_modules = file_to_list(constants.UNIT_TEST_FILE_NAME)
compliance_test_modules = file_to_list(constants.COMPLIANCE_TEST_FILE_NAME)

modules = unit_test_modules + list(set(compliance_test_modules) - set(unit_test_modules))

os.chdir(constants.PROJECT_TESTING_DIR)

for module in modules:
    cwd = os.getcwd()
    os.chdir(module)
    print("Exec kitchen converge for module: {0}".format(os.getcwd()))
    cmd_res = os.system("kitchen converge")
    os.chdir(cwd)
