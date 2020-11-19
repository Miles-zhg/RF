*** Settings ***

*** Keywords ***
Current User Should Contain Panel
    [Arguments]    ${username}    ${password}    ${haveList}    ${notHaveList}    ${caseid}
    Log    Running Case-${caseid}
    Login    ${username}    ${password}
    Should Contain Panel    ${haveList}
    Should Not Contain Panel    ${notHaveList}
    Log    Done Case-${caseid}
    [Teardown]    Close Browser

Current User Should Not Contain Panel
    [Arguments]    ${username}    ${password}    ${paneList}    ${caseid}
    Log    Running Case-${caseid}
    Login    ${username}    ${password}
    @{paneList}    GetPaneList    ${paneList}
    Sleep    2
    :FOR    ${item}    IN    @{paneList}
    \    ${itemTemp}    Set Variable    ${item}
    \    ${itemTemp}    Set Variable If    '${itemTemp}' == 'Dashboard'    ${DashboardPaneL}    ${itemTemp}
    \    ${itemTemp}    Set Variable If    '${itemTemp}' == 'Receivers'    ${ReceiversPaneL}    ${itemTemp}
    \    ${itemTemp}    Set Variable If    '${itemTemp}' == 'Scheduler'    ${SchedulerPaneL}    ${itemTemp}
    \    ${itemTemp}    Set Variable If    '${itemTemp}' == 'Receiver Log'    ${ReceiverLogPaneL}    ${itemTemp}
    \    ${itemTemp}    Set Variable If    '${itemTemp}' == 'Scheduler Log'    ${SchedulerLogPaneL}    ${itemTemp}
    \    ${itemTemp}    Set Variable If    '${itemTemp}' == 'USB Provisioning'    ${USBProvisioningPaneL}    ${itemTemp}
    \    ${itemTemp}    Set Variable If    '${itemTemp}' == 'Member Management'    ${MemberManagementPaneL}    ${itemTemp}
    \    ${itemTemp}    Set Variable If    '${itemTemp}' == 'Change Root Password'    ${ChageRootPasswordPaneL}    ${itemTemp}
    \    ${itemTemp}    Set Variable If    '${itemTemp}' == 'About'    ${AboutPaneL}    ${itemTemp}
    \    Page Should Contain Element    ${itemTemp}
    Log    Done Case-${caseid}
    [Teardown]    Close Browser
