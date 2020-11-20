# -*- coding:utf-8 -*-
__author__ = 'edmond'
import sys
from bs4 import BeautifulSoup
import json, re
import testlink
import os
from robot.api import logger

import importlib
importlib.reload(sys)
  
os.environ['TESTLINK_API_PYTHON_SERVER_URL'] = "http://192.168.3.5/testlink/lib/api/xmlrpc/v1/xmlrpc.php"
os.environ['TESTLINK_API_PYTHON_DEVKEY'] = "be80e909553744b2bb5244edaaa582ba"
  
class ReportTestLink(object):
    def __init__(self):
        self.tls = None
  
    def connect_testlink(self, TESTLINK_API_PYTHON_SERVER_URL, TESTLINK_API_PYTHON_DEVKEY):
        os.environ['TESTLINK_API_PYTHON_SERVER_URL'] = TESTLINK_API_PYTHON_SERVER_URL
        os.environ['TESTLINK_API_PYTHON_DEVKEY'] = TESTLINK_API_PYTHON_DEVKEY
        self.tls = testlink.TestLinkHelper().connect(testlink.TestlinkAPIClient)
        print("TestLink connected successfully.")
  
    def report(self, report_xml_path, testplanid, buildname, user, platformname="0"):
        '''
        :param report_xml_path: rf测试报告xml文件路径
        :param testplanid: 测试计划id
        :param buildname: 测试计划的name
        :param user: 执行用例人，要和秘钥对应 或者测试计划设置为公共
        :param platformname: 平台 默认为0
        :return:
        '''
        caseoutlist = self._parse_reportxml(report_xml_path)
        for i in caseoutlist:
            caseid = i.get("caseid", "")
            if caseid != '':
                try:
                    self.tls.reportTCResult(testcaseid=caseid, testplanid=testplanid, buildname=buildname,
                                            status=i.get("status", 'f'),
                                            notes=i.get("notes", ""),
                                            user=user, platformname=platformname)
                except Exception as e:
                    logger.info(u"Upload result excepted:%s" % e)
                    print(e)
  
    def _parse_reportxml(self, report_xml_path):
        f = open(report_xml_path, "r")
        body = f.read()
        soup = BeautifulSoup(body, "lxml")
        caselist = soup.findAll("test")
        a = []
        for i in caselist:
            case = {}
            execution = ''
            case['casename'] = i.attrs['name']
            if 'TestLink.testcaseID' in i.text:
                doclist = i.findAll('doc')
                for s in doclist:
                    if 'TestLink.testcaseID' in s.text:
                        execution = re.findall(r"TestLink.testcaseID=\[(.+?)\]", s.text, re.S)[0]
                        execution = execution.replace('[', '').replace(']', '')
            if execution == '':
                continue
            case['caseid'] = execution
            status = i.find('status', attrs={'critical': 'yes'}).attrs['status']
            if status == 'PASS':
                status = 'p'
            if status == "FAIL":
                status = 'f'
            if status == '':
                continue
            case['status'] = status
            case['endtime'] = i.status.attrs['endtime']
            case['notes'] = i.find('status', attrs={'critical': 'yes'}).text
            a.append(case)
        return a
  
  
if __name__ == "__main__":
   rtl = ReportTestLink()
   rtl.connect_testlink('http://192.168.3.5/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 'be80e909553744b2bb5244edaaa582ba')
#   rtl.report(r'D:\robot_src\LMI_SB1100AndSB1100P\Jenkins_Report_SB1100\output.xml', '6119', '11.0.8.1','robot')
   rtl.report(sys.argv[1], sys.argv[2], sys.argv[3],'robot')