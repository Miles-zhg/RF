*** Settings ***
Resource          ..\\..\\Elements\\DashboardLocator\\DashboardLocator.robot

*** Keywords ***
Get Total Receiver Number
    ${number}    Get Text    ${totalRXL}
    [Return]    ${number}

Total Number Should Be
    [Arguments]    ${number}
    ${numTmp}    Get Total Receiver Number
    Should Be Equal    ${numTmp}    ${number}

Get Idle Receiver Number
    ${number}    Get Text    ${idleRXL}
    [Return]    ${number}

Idle Number Should Be
    [Arguments]    ${number}
    ${numTmp}    Get Idle Receiver Number
    Should Be Equal    ${numTmp}    ${number}

Get Busy Receiver Number
    ${number}    Get Text    ${busyRXL}
    [Return]    ${number}

Busy Number Should Be
    [Arguments]    ${number}
    ${numTmp}    Get Busy Receiver Number
    Should Be Equal    ${numTmp}    ${number}

Get Offline Receiver Number
    ${number}    Get Text    ${offlineRXL}
    [Return]    ${number}

Offline Number Should Be
    [Arguments]    ${number}
    ${numTmp}    Get Offline Receiver Number
    Should Be Equal    ${numTmp}    ${number}
