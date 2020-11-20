# encoding=utf-8
import testlink
import pprint
import time
from robot.api import logger


# connect to test link
url = "http://192.168.3.5/testlink/lib/api/xmlrpc/v1/xmlrpc.php"
key = "ed15067e3bf176295b3e464c84a12656"  # test link personal key
my_testlink = testlink.TestLinkHelper(url, key).connect(testlink.TestlinkAPIClient)

#testlink project info
testlink_project = "ScreenBeam-Receiver(Automation)"

start_time = ''
class CheckCaseID():
    
    def _get_test_case(self, test_case_id):
        case = my_testlink.getTestCase(testcaseid=test_case_id)
        testCase_ID = case[0]["testcase_id"]
#         pprint.pprint(testCase_ID)
        return testCase_ID
    
    def _get_Suites_From_Target_Project(self, target_project_name):
        self.target_project_name = target_project_name
        self.start_time = time.time()
        projects = my_testlink.getProjects()
#         pprint.pprint(projects)
        project_id = ''
        suites_list = []
        
        for project in projects:
            if project["name"] == target_project_name:
#                 print("Project index：" + str(projects.index(project)))
#                 print("Project ID：" + project["id"])
                project_id = project["id"]
                break
        print("Get target project ID done.")    
        top_suites = my_testlink.getFirstLevelTestSuitesForTestProject(project_id)
        
        for suite in top_suites:
            
            suites_list.append(suite["id"])
        print("Get top suite of project done.")
           
        return suites_list
    
    def get_Cases_Dict(self):
        """
        Get all test cases ID from specify project, and return case ID dict.
        
        """
        logger.info('Getting Test Case ID from testlink...', also_console=True)
        testCaseID_dict = {}
        project = my_testlink.getTestProjectByName(testlink_project)

        firstLevelTestSuite = my_testlink.getFirstLevelTestSuitesForTestProject(project["id"])


        for suite in firstLevelTestSuite:
            testcase = my_testlink.getTestCasesForTestSuite(suite['id'],True,None)
            for case in testcase:
                testCaseID_dict[case['external_id']] = case['id']
        logger.info('Got done...', also_console=True)
        return testCaseID_dict
            
    def check_ID_IsExist(self,case_ID,containe):
        self.case_ID = case_ID;
        result = self.case_ID in containe.values()
        return result
    

if __name__ == '__main__':
    
    testlink_Object = CheckCaseID()
    
#     top_suites = testlink_Object.get_Suites_From_Target_Project(testlink_project)
    
#     cases = testlink_Object.get_Cases_ID_From_Suites(top_suites)
    case_dict = testlink_Object.get_Cases_Dict()
    print("用例总数{}".format(len(case_dict)))
    print(case_dict)
    result = testlink_Object.check_ID_IsExist("12804", case_dict)
    print(result)