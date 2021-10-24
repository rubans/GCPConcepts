
import os
import shutil

def get_parent(path):
    if '/' in path:
        dirs =  path.split('/')
        return dirs[len(dirs)-1]
    else:
        return path

def filter_dirs(allowed_dirs):
    def get_ignored(path, filenames):
        ret = []
        for filename in filenames:
            if not (filename  in allowed_dirs or get_parent(path)  in allowed_dirs): 
                ret.append(filename)
        return ret
    return  get_ignored

def copy_dirs(input_path, outputh_path, dirs):
    if os.path.exists(outputh_path):
        shutil.rmtree(outputh_path)
    shutil.copytree(input_path, outputh_path, ignore=filter_dirs(dirs),dirs_exist_ok=True)

def read_txt_file(path):
    with open(path, 'r') as f:
        return f.read()

def list_to_file(path,list):
    "\n".join(list)
    with open(path, 'w+') as f:
        f.write( "\n".join(list))

def file_to_list(path):
    with open(path) as f:
        return list(map(lambda line: line.strip(), f.readlines()))

