*** Settings ***
Library           SeleniumLibrary
Resource          .\\Elements\\Common\\CommonVariables.txt
Resource          .\\CustomKeywords\\Common.robot
Resource          .\\CustomKeywords\\LoginKeywords\\LoginModel.robot
Resource          .\\CustomKeywords\\LoginKeywords\\LoginAssert.robot

*** Test Cases ***
Login Success
    [Setup]    No Operation
    [Template]    Login Success
    Administrator    Screenbeam    498
    Administrator    Screenbeam    9
    [Teardown]    No Operation

Login Fail
    [Template]    Login Fail
    Blank    Blank    1
    Blank    123456    2
    Blank    Sz!12345    3
    Admin    Blank    4
    Admin    Admin    5
    Admin    Sz!12345    6
    Administrator    Blank    7
    Administrator    Sz!234    8

Test
    @{list}    Create List    MD    CD
    Evaluate    ${list}.extend("AD")
    Log    ----${list}-----
    :FOR    ${item}    IN    @{list}
    \    Log    ${item}
