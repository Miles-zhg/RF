# encoding=utf-8
import testlink
import pymysql
import time

import os
import sys

current_path = sys.path[0]
father_path = os.path.split(current_path)[0] 
ROOT_PATH = os.path.split(father_path)[0]
sys.path.append(ROOT_PATH)

from Libs.utils.dbHelper import DBHelper
from Libs.utils.count import Count

dbHelper  = DBHelper("192.168.7.222",user="root",password="")
# exit(1)
# connect to test link
url = "http://192.168.3.5/testlink/lib/api/xmlrpc/v1/xmlrpc.php"
key = "ed15067e3bf176295b3e464c84a12656"  # test link personal key

# Database info 
host = '192.168.7.222'
user = 'root'
password = ''
database = 'screenbeam'

#testlink project info
product = "CMSE"
testlink_project = "ScreenBeam-CMS"


class SyncCasesToDB():
    
    def __init__(self):
        self.project_id = ''
        self.suites_list = []
        self.testcase_info_dict = {}
        self.target_project_name = testlink_project
        self.conn = pymysql.connect(host, user, password, database, charset='utf8')
        self.cursor = self.conn.cursor()
        self.my_testlink = testlink.TestLinkHelper(url, key).connect(testlink.TestlinkAPIClient)
        self.count = Count()
        self.dbHelper = DBHelper(host=host,user=user,password=password,db_name=database)

    def __del__(self):
        self.cursor.connection.commit()
        self.conn.close()
    
    def _get_test_case(self, test_case_id):
        casename = self.my_testlink.getTestCase(testcaseid=test_case_id)
        return casename
    
    def get_Suites_From_Target_Project(self) -> list:
        """
        
        Get project ID and top suite IDs.
        
        """
        projects = self.my_testlink.getProjects()
        
        for project in projects:
            if project["name"] == self.target_project_name:
                self.project_id = project["id"]
                break
        print("Get target project ID done.")    
        top_suites = self.my_testlink.getFirstLevelTestSuitesForTestProject(self.project_id)
        
        for suite in top_suites:
            
            self.suites_list.append(suite["id"])
        print("Get top suite of project done.")
           
        return self.suites_list
    
    def get_Cases_Info_From_suites(self):
        
        """
        it must be run "get_Suites_From_Target_Project" first.
        get project all test cases and return as dict, main key is API ID of case, value include other info.
        
        """
        self.get_Suites_From_Target_Project()
        cases_fullpath = dict()
        print("Parsing test suite...")
        for suite in self.suites_list:
            test_cases = self.my_testlink.getTestCasesForTestSuite(suite, True, None)
            for test_case in test_cases:
                case_API_ID = test_case["id"]
                fullpath = self.my_testlink.getFullPath(int(case_API_ID))
                r_path = fullpath[str(case_API_ID)]
                r2_path = ''
                
                for j in r_path:
                    r2_path = r2_path + j + '>'
                    
                case = self._get_test_case(case_API_ID)
                external_id = case[0]["tc_external_id"]
                prefix_exteral_id = case[0]["full_tc_external_id"]
                prefix = prefix_exteral_id[0:len(prefix_exteral_id)-len(external_id)]
                casename = prefix_exteral_id + ":" + case[0]["name"]
                testType = case[0]["execution_type"]
                priority = case[0]["importance"]
                author = case[0]["author_login"]
                comment = case[0]["preconditions"]
                synctime = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
                
                cases_fullpath[case_API_ID] = r2_path + casename
                case_tuple = (prefix,external_id,prefix_exteral_id,casename, testType, cases_fullpath[case_API_ID],comment, product, self.target_project_name,synctime,author,priority)
                self.testcase_info_dict[case_API_ID] = case_tuple
        print("Parse test case done from every top suites.")                
        return self.testcase_info_dict
    
    def Update_Case_To_Database(self):
        
        """ 
        Wirte all cases to db.
        
        """
        self.get_Cases_Info_From_suites()
        print("Query caseID_tb, get current exist testlink ids.")
        sql_query =  "select testlink_id from caseId_tb"
        query_result = self.cursor.execute(sql_query)
        data_list = [row[0] for row in self.cursor.fetchall()]
        update_sql = "Update caseId_tb set name=%s, test_type= %s, full_path= %s, comment= %s, product= %s, project= %s, synctime= %s, author= %s,priority= %s WHERE testlink_id= %s"
        insert_sql = "INSERT INTO caseId_tb(testlink_id,prefix,external_id,prefix_exteral_id,name,test_type,full_path,comment,product,project,author,priority) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        
        print("Updating caseID_tb...")
        for key in self.testcase_info_dict.keys():
            testcaseId = key
            prefix = self.testcase_info_dict[key][0]
            external_id = self.testcase_info_dict[key][1]
            prefix_exteral_id = self.testcase_info_dict[key][2]
            testcase_name = self.testcase_info_dict[key][3]
            testType = self.testcase_info_dict[key][4]
            full_path = self.testcase_info_dict[key][5]
            comment = self.testcase_info_dict[key][6]
            product = self.testcase_info_dict[key][7]
            project = self.testcase_info_dict[key][8]
            synctime = self.testcase_info_dict[key][9]
            author = self.testcase_info_dict[key][10]
            priority = self.testcase_info_dict[key][11]
            
            if int(key) in data_list:
                self.cursor.execute(update_sql, (testcase_name,testType,full_path,comment,product,project,synctime,author,priority,testcaseId))
            else:
                self.cursor.execute(insert_sql, (testcaseId, prefix, external_id, prefix_exteral_id, testcase_name,testType,full_path,comment,product,project,author,priority))
        print("Update caseID_tb done")
    
    def _change_Case_ExecuteType(self, test_case_id, execute_type):
        """
        Update case execute type.
        args["executiontype"]: 
        1 = TESTCASE_EXECUTION_TYPE_MANUAL, 
        2 = TESTCASE_EXECUTION_TYPE_AUTO
        
        """
        self.my_testlink.setTestCaseExecutionType(test_case_id, 1, self.project_id, execute_type)

    
    def modify_Case_Execute_Type(self):
        """
        Change all cases execute types to "manual" in TestLink.
        
        """
        self.get_Cases_Info_From_suites()
        print("***Updating is execute type for all case on testlink.")

        for key in self.testcase_info_dict:
            self._change_Case_ExecuteType(self.testcase_info_dict[key][2], 1)
#             self._change_Case_ExecuteType(self.testcase_info_dict[key][2], {'execution_type': 'TESTCASE_EXECUTION_TYPE_MANUAL'})
        print("***Update done.")
    
    
    def mark_cases_In_DB(self):
        """
        Mark the scripted case on the database as automatic.
        the column is "complete_status" in caseId_tb
        
        """
        
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
    
    def Change_Execute_Type_Automator(self):
        """
       Change the execution type of the script case to "auto" on TestLink.
        
        """
        self.Update_Case_To_Database()
        print("***Updating cases execute_type")
        for case in self.count.get_cases():
            for value in self.testcase_info_dict.values():
                if value[2] == case:
                    self._change_Case_ExecuteType(case,2)
        print("***Update execute_type of relate cases  to auto done.")
    
if __name__ == '__main__':
    
    testlink_Object = SyncCasesToDB()
#     testlink_Object.modify_Case_Execute_Type()
#     testlink_Object.Change_Execute_Type_Automator()
    testlink_Object.Update_Case_To_Database()