# -*- coding: utf-8 -*-#
# ----------------------------------------------------------
# Name:         updateDatabase.py
# Description:
# e-Mail:       yifei1193@163.com
# Date:         11/17/2020 3:23 PM
# ----------------------------------------------------------

from dbHelper import DBHelper

import sys
import os

# current_path = sys.path[0]
# father_path = os.path.split(current_path)[0] 
# project_path = os.path.split(father_path)[0]
# sys.path.append(project_path)

from count import Count


def get_case_from_database():
    old = []
    dbhelper = DBHelper(host='192.168.3.6',user='root',password='shenzhen2013')
    results = dbhelper.query("caseId_tb",col=('external_id',),condition="test_type=1 and complete_status=1")
    for result in results:
        old.append(int(result[0]))

    old.sort()
    return old

def update_database(new):
    """insert the result to database"""
    pass
#
#
def check_update():
    """check if the test case increase if yes , update the database"""
    new = []
    old = get_case_from_database()

    c = Count()
#     print(c.path)
    current_case = c.get_cases()
#     print(c.file_paths)
    
    print("current_case:{}".format(current_case))
    for i in current_case:
        new.append(int(i.split('-')[1]))
    new.sort()
    print("old:{}".format(old))
    print("new:{}".format(new))
    print("len old:{}".format(len(old)))
    print("len new:{}".format(len(new)))
    exit(1)
    if old != new:
        update_database(new)

if __name__ == '__main__':
#     old = get_case_from_database()
#     print(old)
#     print(len(old))
    check_update()