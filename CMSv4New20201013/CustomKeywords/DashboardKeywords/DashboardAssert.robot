*** Keywords ***
Verify Dashboard
    [Arguments]    ${totalNum}    ${idleNum}    ${busyNum}    ${offlineNum}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running Case -------- ${caseid}
    Dashboard Number Shoud Be    ${totalNum}    ${idleNum}    ${busyNum}    ${offlineNum}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done case-${caseid}
