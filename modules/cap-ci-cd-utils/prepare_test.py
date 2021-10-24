import  constants
import glob 
from  utils.git_utils import *
import argparse
from utils.file_utils import list_to_file
import os


def extract_modules_with_file_selector(file_selector):
    dirs = glob.glob( f'**/{file_selector}', recursive=True)
    return (list(map(lambda x: x[0:-(len(file_selector) + 1)], dirs)))

def is_module_changed(module, changed_file):
    for file in changed_file:
        if file.startswith(module):
            return True
    return False


parser = argparse.ArgumentParser(description='Prepare compliance test.')
parser.add_argument('git_user', 
                    help='git_user')
parser.add_argument('git_token', 
                    help='git_token')
args = parser.parse_args()

print('Read git user')
user = args.git_user

print('Read git token')
token = args.git_token

print(os.environ['COMMIT'])
print(os.environ['REPOSITORY'])
print(os.environ['SOURCE_BRANCH'])
print(os.environ['TARGET_BRANCH'])


print('clone controls repository')
print(constants.PROJECT_TESTING_DIR)
clone(f'''https://{user}:{token}@pscode.lioncloud.net/psinnersource/cloud/gcp-cap/modules.git''',os.environ['SOURCE_BRANCH'], constants.PROJECT_TESTING_DIR)


print(constants.COMPLIANCE_TEST_TMP_DIR)
clone(f'''https://{user}:{token}@pscode.lioncloud.net/psinnersource/cloud/gcp-cap/compliance-tests.git''','master', constants.COMPLIANCE_TEST_TMP_DIR)

print('get changed files')
changed_files = get_changed_files(constants.PROJECT_TESTING_DIR, os.environ['COMMIT'])
print(changed_files)


os.chdir(constants.PROJECT_TESTING_DIR)
unit_test_modules = extract_modules_with_file_selector(constants.UNIT_TEST_DIR_SELECTOR)

print(unit_test_modules)

filtered_unit_test_modules = list(filter(lambda s: is_module_changed(s,changed_files), unit_test_modules))
print(f'Modules under unit tests {filtered_unit_test_modules}')
list_to_file(constants.UNIT_TEST_FILE_NAME, filtered_unit_test_modules)

compliance_test_modules = extract_modules_with_file_selector(constants.COMPLIANCE_TEST_DIR_SELECTOR)
print(compliance_test_modules)
filtered_compliance_test_modules = list(filter(lambda s: is_module_changed(s,changed_files), compliance_test_modules))
print(f'Modules under compliance tests {filtered_compliance_test_modules}')
list_to_file(constants.COMPLIANCE_TEST_FILE_NAME, filtered_compliance_test_modules)

