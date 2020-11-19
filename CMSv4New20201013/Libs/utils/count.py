# -*- coding: utf-8 -*-#
# ----------------------------------------------------------
# Name:         count.py
# Description:  统计当前用例总条数
# e-Mail:       yifei1193@163.com
# Date:         2020/10/26 14:13
# ----------------------------------------------------------

import sys
import os

current_path = sys.path[0]
father_path = os.path.split(current_path)[0] 
root_path = os.path.split(father_path)[0]
sys.path.append(root_path)

counter = 0

class Count:
    def __init__(self, path=root_path):
        """
        path默认值'“.” 代表统计当前路径
        """
        self.path = path
        self.file_paths = []
        self.countable_files = []

    def list_files(self):
        """
        """
#         列出当前路径下所有的文件夹和文件名
#         file_paths = []
        files = os.listdir(self.path)
        for file in files:
            if file.split("_")[0].isdigit():    # 我们的suite都是00_upgrade这种格式的
                file_path = os.path.join(self.path, file) #得到suite的完整路径
                self.file_paths.append(file_path) # 所有suite的完整路径保存到列表中


    def iter_file_path(self):
        for file in self.file_paths:
            for home, dir_path, file_name in os.walk(file): # 迭代出suite中的所有文件
                for file in file_name:
                    if not file == "__init__.robot" and file.split('.')[1] == 'robot': #去除“__init__.py 和后缀不是.robot的文件”
                        self.countable_files.append(os.path.join(home, file)) # 把符合条件的用例路径保存到列表中

    def count(self):
        self.list_files()
        self.iter_file_path()
        
        global counter
        for file in self.countable_files:
            with open(file, 'r', encoding='utf8') as fp:
                line = fp.readlines()
                for l in line:
                    if l.find("sbrxAuto") != -1: #如果这一句包含了"sbrxAuto" ,计数器加一 
                        counter += 1
        return counter
    
    def get_cases(self):
        """get all the cases ID in the code"""
        self.list_files()
        self.iter_file_path()
        
        cases = []
        for file in self.countable_files:
            with open(file, 'r', encoding='utf8') as fp:
                line = fp.readlines()
                for l in line:
                    if l.find("sbrxAuto") != -1: 
                        cases.append(l.split(":")[0].strip())
        return cases


if __name__ == '__main__':
    c = Count()
    result = c.count()
    print("共有用例{}条".format(result))

    



