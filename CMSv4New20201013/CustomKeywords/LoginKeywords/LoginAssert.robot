*** Settings ***
Resource          LoginModel.robot
Resource          ..\\..\\Elements\\Common\\HomeroomLocator.robot

*** Keywords ***
Login Success
    [Arguments]    ${username}    ${password}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running Case -------- ${caseid}
    Login    ${username}    ${password}
    Sleep    2
    Page Should Contain Element    ${welcomeTextL}
    Page Should Contain Element    ${currentUserL}/p[@class="user-label" and text()="${username}"]
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done case-${caseid}
    [Teardown]    Close Browser

Login Fail
    [Arguments]    ${username}    ${password}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running Case -------- ${caseid}
    Login    ${username}    ${password}
    Sleep    2
    Comment    Alert Should Be Present    text=${message}
    Page Should Contain Element    ${AlertL}
    Sleep    2
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done Case -------- ${caseid}
    [Teardown]    Close Browser
