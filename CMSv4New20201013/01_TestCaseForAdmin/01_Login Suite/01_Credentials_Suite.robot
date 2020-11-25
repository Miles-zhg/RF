*** Settings ***
Library           SeleniumLibrary
Resource          ../../Elements/Common/CommonVariables.txt
Resource          ../../CustomKeywords/Common.robot
Resource          ../../CustomKeywords/LoginKeywords/LoginModel.robot
Resource          ../../CustomKeywords/LoginKeywords/LoginAssert.robot


*** Test Cases ***
sbcms-498:Default Administrator User Login
    [Template]    Login Success
    Administrator    Screenbeam    498
sbcms-1 : Login-Blank Username-Blank Password
    [Template]    Login Fail
    Blank    Blank    1
sbcms-2 : Login-Blank Username-Invalid Password
    [Template]    Login Fail
    Blank    123456    2
    
sbcms-4 : Login-Invalid Username-Blank Password
    [Template]    Login Fail
    Admin    Blank    4

sbcms-3 : Login-Blank Username-Valid Password  
    [Template]    Login Fail  
    Blank    Sz!12345    3
    
sbcms-5 : Login-Invaild Username-Invalid Password
    [Template]    Login Fail 
    Admin    Admin    5
sbcms-6 : Login-Invaild Username-Valid Password
    [Template]    Login Fail     
    Admin    Sz!12345    6
sbcms-7 : Login-Valid Username-Blank Password
    [Template]    Login Fail 
    Administrator    Blank    7
sbcms-8 : Login-Vaild username-Invalid Password    
    [Template]    Login Fail 
    Administrator    Sz!234    8

sbcms-9 : Login-Valid Username - Valid Password 
    [Template]    Login Success
    Administrator    Screenbeam    9

