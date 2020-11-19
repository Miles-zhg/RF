*** Keywords ***
Dashboard Number Shoud Be
    [Arguments]    ${totalNum}    ${idleNum}    ${busyNum}    ${offlineNum}
    Click Dashboard Panel
    Sleep    2
    Total Number Should Be    ${totalNum}
    Idle Number Should Be    ${idleNum}
    Busy Number Should Be    ${busyNum}
    Offline Number Should Be    ${offlineNum}
