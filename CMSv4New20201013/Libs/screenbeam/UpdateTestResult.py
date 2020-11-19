#encoding=utf-8
'''
Created on Oct 15, 2020

@author: Edmond
'''

import testlink
import pymysql
import time

# connect to test link
url = "http://192.168.3.5/testlink/lib/api/xmlrpc/v1/xmlrpc.php"
key = "ed15067e3bf176295b3e464c84a12656"  # test link personal key
my_testlink = testlink.TestLinkHelper(url, key).connect(testlink.TestlinkAPIClient)


# Database info 
host = '192.168.3.6'
user = 'root'
password = 'shenzhen2013'
database = 'screenbeam'

build_name = "11.0.8.8"
test_plan_ID = 15537

class UpdateTestResult():
    
    def connect_To_Database(self):
        """
        connect to database.
        """
        conn = pymysql.connect(host, user, password, database, charset='utf8')
        cursor = conn.cursor()
        return cursor
    
    def Update_test_result_to_database(self,caseId, tb_name,test_time, tester, case_name, software,TcResult, comment, bug, product, case_time, test_type, author):
        """
        update test result to database.
        
        """
        cursor = self.connect_To_Database()
        result = cursor.execute("select case_id,software from result_tb where case_id = %s",(caseId))
        if result == 0:
            cursor.execute("Insert Into result_tb(case_id, tb_name,test_time, tester, case_name, software, result, comment, bug, product, case_time, test_type, author) Values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(caseId,tb_name, test_time, tester, case_name, software, TcResult, comment, bug, product, case_time, test_type, author))
            cursor.connection.commit()
        elif result == 1:
            cursor.execute("Update result_tb set test_time=%s, case_name=%s, software=%s, result=%s, comment=%s, bug=%s, case_time=%s WHERE case_id=%s AND software=%s",(test_time, case_name, software, TcResult, comment, bug, case_time,caseId, software))
            cursor.connection.commit()
        elif result > 1:
            cursor.execute("Delete From result_tb where case_id = %s AND software = %s",(caseId,software))
            cursor.connection.commit()
            cursor.execute("Insert Into result_tb(case_id,tb_name,test_time, tester, case_name, software, result, comment, bug, product, case_time, test_type, author) Values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(caseId,tb_name,test_time, tester, case_name, software, TcResult, comment, bug, product, case_time, test_type, author))
            cursor.connection.commit()
        else:
            print('No Operator.') 
        print("Write database done.")
        cursor.close()
        
    
    def Read_Database_And_Update_TestLink(self,testPlanID,buildName,software):
        """
        Read all test result of target firmware from database, and then parse result, write to testlink.
        need appoint correct test plan ID and build name.
        """
        self.firmware = software
        self.testPlanID = testPlanID
        self.buildName = buildName
        cursor = self.connect_database()
        cursor.execute("select case_id,test_time,tester,bug,result,comment,software from result_tb where software = %s",(self.firmware))
        allTestResult = cursor.fetchall()
        for record in allTestResult:
            case_ID = record[0]
            bug = record[3]
            result = record[4][0].lower()
            software = record[6]
            self.report_test_result(self.testPlanID, case_ID, result, bug, '2', 0, self.buildName)
        cursor.close()
        print("Update test result done.")
    
    # report test result, validated
    def report_test_result(self, test_plan_id, test_case_id, final_test_result, test_notes, execduration, platform_name, build_name):
        localtime = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
        my_testlink.reportTCResult(testcaseid=test_case_id, testplanid=test_plan_id, status=final_test_result,
                                  guess=True, testcaseexternalid=None, platformname=platform_name, buildname=build_name, execduration=execduration,
                                   timestamp=localtime, steps=[], notes=test_notes)
        
if __name__ == '__main__':
                
    testLK = UpdateTestResult()
    testLK.Update_test_result_to_database(12345,'result_tb','2020-10-16 10:20:33', 'edmond', 'demo', '1111', 'Pass', 'comment', 'bug', 'sb11xx', '2020-10-16 10:25:20', 'auto', 'edmond')
    # testLK.Read_Database_And_Update_TestLink('11.1.8.146')
    testLK.report_test_result(test_plan_ID, 13052, 'p', 'pass', '2', 0, build_name)
