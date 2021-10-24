import os 

UNIT_TEST_DIR_SELECTOR= 'kitchen.yml'
COMPLIANCE_TEST_DIR_SELECTOR= 'compliance.txt'

PROJECT_TESTING_DIR = os.getcwd() + "/" + 'WORKING_DIR'
COMPLIANCE_TEST_TMP_DIR=  os.getcwd() + "/" + 'TMP_COMPLIANCE'
UNIT_TEST_FILE_NAME = PROJECT_TESTING_DIR + "/" + 'modules_unit.txt'
COMPLIANCE_TEST_FILE_NAME = PROJECT_TESTING_DIR + "/" + 'modules_compliance.txt'
