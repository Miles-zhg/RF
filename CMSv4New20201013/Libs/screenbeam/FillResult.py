# -*- coding:utf-8 -*-  
#! /usr/bin/python
import testlink
import os

os.environ['TESTLINK_API_PYTHON_SERVER_URL'] = "http://192.168.3.5/testlink/lib/api/xmlrpc/v1/xmlrpc.php"
os.environ['TESTLINK_API_PYTHON_DEVKEY'] = "ed15067e3bf176295b3e464c84a12656"

class FillResult():

    def FillResultToTestLink(self,testcaseid, testplanid, buildname, result, note, user, platformid='0' ):
        """
        Parse XML file and update result to testlink.
        
        1. TestCaseID could check via the exported TestList XML file.
        e.p:
            <testcase internalid="43" name="通过get方式访问网页，参数中包含permit关键字">
        The TestCaseID is 43.      
        2. TestPlanID need to find in TestLink Database.
        Step:
        [root@localhost ~]# mysql -uxxxxx -pxxxxxxxx
        mysql> use testlink
        mysql> select * from testplans;
            +-----+----------------+-------+--------+---------+-----------+------------------------------------------------------------------+
            | id  | testproject_id | notes | active | is_open | is_public | api_key                                                          |
            +-----+----------------+-------+--------+---------+-----------+------------------------------------------------------------------+
            |  76 |              1 |       |      1 |       1 |         1 | 07df3b4860ffbdc1577a669255541bc6578c90f581f0275ce5f3b27109521366 |
            | 176 |              1 |       |      0 |       1 |         0 | a01dbdbabd22c51b453e3c2eef1cb5f884f80bbd0afe3dde745373a6920f8bfb |
            +-----+----------------+-------+--------+---------+-----------+------------------------------------------------------------------+
            2 rows in set (0.00 sec)

        The Test PlanID is 76.        
        3. PlatFormID may be set to 0.
        4. BuildName is the name defined in TestLink.
        5. Result 'p' means 'Passed'; 'f' means 'Failed'.
        6. Note will set in TestLink result description.
        7. User is who execute this case. 
        
        """
        self.testcaseid = testcaseid
        self.testplanid = testplanid
        self.buildname  = buildname
        self.result     = result
        self.note       = note
        self.user       = user
        self.platformid = platformid

        tls = testlink.TestLinkHelper().connect(testlink.TestlinkAPIClient)
        print (self.testcaseid, self.testplanid, self.buildname, self.result, self.note, self.user, self.platformid)
        
        tls.reportTCResult(testcaseid=self.testcaseid, testplanid=self.testplanid, buildname=self.buildname, status=self.result,
                           notes=self.note, user=self.user)

if __name__  == "__main__":

    a = FillResult()    
    a.FillResultToTestLink(testcaseid='sbrx-370', testplanid='6119', buildname='11.0.8.2', result='p', note='some notes',user='robot', platformid='0')
