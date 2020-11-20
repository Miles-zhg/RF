# -*- coding: utf-8 -*-#
# ----------------------------------------------------------
# Name:         dbHelper.py
# Description:
# e-Mail:       yifei1193@163.com
# Date:         11/16/2020 3:01 PM
# ----------------------------------------------------------

import pymysql

class DBHelper():
    def __init__(self,host,user,password,port=3306,db_name= "screenbeam",charset="UTF8"):
        self.host = host
        self.user = user
        self.password = password
        self.port = port
        self.db_name=db_name

        self.connector = pymysql.connect(host=self.host,user=self.user,
                                         password=self.password,port=self.port,
                                         database=self.db_name)

        self.cursor = self.connector.cursor()

    def insert_one(self,tb,values=(),col=()):
        """
        insert one data to tb
        :param col:
        :param values:
        :param tb: target table name
        :param value: the values which in tuple type
        :return: None
        """
        if col:
            col_str = ",".join(x for x in col)
            values_str = ','.join(x for x in values)
            sentence = "insert into {}({}) values ({})".format(tb,col_str,values_str)
        else:
            values_str = ','.join(x for x in values)
            sentence = "insert into {} values ({})".format(tb,values_str)
#         print(sentence)
#         exit(1)
        try:
            self.cursor.execute(sentence)
            self.connector.commit()
        except Exception as e:
            print(e)

    def query(self, tb,condition="",col=('*',)):
        """
        query from the tb, condition should like this: "name = 'kenny' "
        :param tb: table name
        :param condition: conditions which behind where
        :return: return the result as a tuple
        """
        col_str = ','.join(x for x in col)
#         print(col_str)
        # exit(1)
        if condition:
            sentence = "select {} from {} where {}".format(col_str,tb,condition)
        else:
            sentence = "select {} from {}".format(col_str,tb)
        try:
            self.cursor.execute(sentence)
            result = self.cursor.fetchall()
            return result
        except Exception as e:
            print(e)
            return None

    def delete_one(self,tb,condition):
        """
        delete one item for tb
        :param tb: table
        :param condition: the condition for delete
        :return: None
        """
        self.cursor.execute("delete from {} where {}".format(tb,condition))
        self.connector.commit()

    def update(self,tb,col,value,condition):
        """
        update the values which stored in the db in conditions
        :param tb: table name
        :param col: which column you want to update
        :param value: the new value
        :param condition: the condition
        :return: None
        """
        sentence = 'update {} set {} = "{}" where {}'.format(tb,col,value,condition)
#         print("sentence:{}".format(sentence))
        try:
            self.cursor.execute(sentence)
            self.connector.commit()
        except Exception as e:
            print(e)

    def __del__(self):
        self.cursor.close()
        self.connector.close()

if __name__ == '__main__':
    dbHelper = DBHelper("192.168.3.6","root","shenzhen2013",db_name="screenbeam_test")
    # dbHelper.delete_one("result_tb","id=9")
    dbHelper.insert_one("caseId_tb",values=("a","b"))


