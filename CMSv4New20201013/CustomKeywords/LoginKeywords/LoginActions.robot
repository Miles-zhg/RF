*** Settings ***
Resource          ..\\..\\Elements\\Common\\LoginLocator.robot

*** Keywords ***
Input Login Username
    [Arguments]    ${username}
    Input Text    ${LoginUsernameL}    ${username}

Input Login Password
    [Arguments]    ${password}
    Input Text    ${LoginPasswordL}    ${password}

Click Login Button
    Click Button    ${LoginButtonL}
