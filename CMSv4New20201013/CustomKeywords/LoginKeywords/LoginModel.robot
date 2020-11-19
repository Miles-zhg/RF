*** Settings ***
Resource          LoginActions.robot

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    Open Url
    Run Keyword If    '${username}' != 'Blank'    Input Login Username    ${username}
    Run Keyword If    '${password}' != 'Blank'    Input Login Password    ${password}
    Click Login Button
    Sleep    2
