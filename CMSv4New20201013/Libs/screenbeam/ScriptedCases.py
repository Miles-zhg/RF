# encoding=utf-8
import testlink
import pymysql
import time
import os
import sys

current_path = sys.path[0]
father_path = os.path.split(current_path)[0] 
root_path = os.path.split(father_path)[0]
sys.path.append(root_path)

from Libs.utils.count import Count
from Libs.utils.dbHelper import DBHelper
from SyncCasesToDB import SyncCasesToDB


# connect to test link
url = "http://192.168.3.5/testlink/lib/api/xmlrpc/v1/xmlrpc.php"
key = "ed15067e3bf176295b3e464c84a12656"  # test link personal key

# Database info 
host = '192.168.3.6'
user = 'root'
password = 'shenzhen2013'
database = 'screenbeam'

#testlink project info
product = "SBWD1100/SB1100Plus"
testlink_project = "ScreenBeam-Receiver(Automation)"
root_dir_project = ""



class ScriptedCases():
    """已经代码实现了的用例在数据库中修改complete_status = 1"""
    
    def __init__(self):
        
        self.count = Count()
        my_testlink = testlink.TestLinkHelper(url, key).connect(testlink.TestlinkAPIClient)
        self.dbHelper = DBHelper(host=host,user=user,password=password,db_name=database)
    
    def mark_cases_In_DB(self):
        
        current_cases = self.count.get_cases()
        result = self.dbHelper.query(tb="caseId_tb",col=("prefix_exteral_id",))
     
        #data_list:数据库中以后的所有用例（和testlink同步）
        data_list = [row[0] for row in result]
    
        invliad_caseID = []

        for internal_case_ID in current_cases:
            if internal_case_ID in data_list:
                self.dbHelper.update(tb="caseId_tb",col="complete_status",value=1,condition=("prefix_exteral_id='{}'".format(internal_case_ID)))
            else:
                invliad_caseID.append(internal_case_ID)
        if invliad_caseID:
            print("Unavailable case IDs: {}".format(invliad_caseID))
            
        print("Updated status finished.")
    
if __name__ == '__main__':
    s = ScriptedCases()
#     s.mark_cases_In_DB()
    s.Change_Execute_Type_Automator()


