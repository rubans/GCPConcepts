import os
import json
import requests
from jsonpath_ng import jsonpath
from jsonpath_ng.ext import parse

from constants import UNIT_TEST_FILE_NAME,PROJECT_TESTING_DIR,COMPLIANCE_TEST_FILE_NAME
import glob 
from  utils.gcs_utils import download_file_as_string
from  utils.file_utils import file_to_list,read_txt_file

MATCHER = '''$.profiles[*].controls[*].results[?status != passed]'''

merge_id = os.environ['MERGE_ID']
gitlab_proect_id = os.environ['GITLAB_PROJECT_ID']
reports_bucket = os.environ['REPORTS_BUCKET']
gitlab_api_token = os.environ['GITLAB_TOKEN']
build = os.environ['BUILD']
repository =  os.environ['REPOSITORY']
DOMAIN = repository[repository.index('//') + 2: repository.index('/',repository.index('//') + 2)]

os.chdir(PROJECT_TESTING_DIR)

def add_comment_to_merge_request(project_id,merge_id, token, comment):
    headers = {'Content-Type': 'text/plain', 'PRIVATE-TOKEN': token}
    params = {'body' : comment}
    url = f"https://{DOMAIN}/api/v4/projects/{project_id}/merge_requests/{merge_id}/notes"
    r = requests.post(url,headers=headers, params= params)
    print(r.status_code)
    print(r.content)

def evaluate_test_result(module, build, test_type):
    print(f"Download results for {test_type} for module : {module}")
    test = download_file_as_string(reports_bucket,f"reports/{module}/{test_type}-{build}.json")
    json_content = json.loads(test)
    jsonpath_expression = parse(MATCHER)

    match = jsonpath_expression.find(json_content)
    msg = ""
    if not match:
        msg = f"All {test_type} passed for module: {module}"  
    else: 
        errors = list(map(lambda x: f"{x.value['code_desc']} \n {x.value['message']}" , match))
        msg = f"# {test_type} failed for module: {module} \n \n"  + "\n".join(errors)
   
    print(f"Message for module {module}: {msg}")
    return msg


for module in file_to_list(UNIT_TEST_FILE_NAME):
    msg = evaluate_test_result(module, build ,'unit-test')
    add_comment_to_merge_request(gitlab_proect_id,merge_id, gitlab_api_token, msg)

for module in file_to_list(COMPLIANCE_TEST_FILE_NAME):
    msg = evaluate_test_result(module, build,'compliance-test')
    add_comment_to_merge_request(gitlab_proect_id,merge_id, gitlab_api_token, msg)
