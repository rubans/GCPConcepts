import os
from git import Repo
import shutil
import os

def clone(repository, branch, local_dir):
    if os.path.exists(local_dir):
        shutil.rmtree(local_dir)
    Repo.clone_from(
    repository,
    local_dir,
    branch=branch
    )

def get_changed_files(repository, commit):
    # local_dir = "TMP"
    # if os.path.exists(local_dir):
    #     shutil.rmtree(local_dir)
    
    # repo = Repo.clone_from(
    # repository,
    # local_dir,
    # branch=branch
    # )
    repo = Repo(repository)
    print(f'Changed files for {commit}')
    print(f'''Changed files for master  {repo.commit('origin/master')}''')

    changed_files = []
    headcommit = repo.commit(commit)
    for diff_file in repo.commit('origin/master').diff(headcommit):
        changed_files.append(diff_file.a_path)

    for file in changed_files:
       print(file)

    
    # shutil.rmtree(local_dir)
    return changed_files


