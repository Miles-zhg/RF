#-*- coding:utf-8 -*-
# '''
#     created by edmond 2020-06-05
#     如果screenbeam lib导入失败，可能是testlink的Python API 和pymysql没有安装，在cmd中执行“pip install TestLink-API-Python-client”
#     和 pip install pymysql
#     安装即可
#     edmond added 
# '''

from screenbeam.FillResult import FillResult
from screenbeam.CheckCaseID import CheckCaseID
from screenbeam.UpdateTestResult import UpdateTestResult

__version__ = '1.0'

class screenbeam(FillResult,CheckCaseID,UpdateTestResult):
	ROBOT_LIBRARY_SCOPE = "Global"
