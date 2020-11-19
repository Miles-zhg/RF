*** Settings ***
Resource          ..\\..\\Elements\\Common\\HomeroomLocator.robot
Resource          ..\\..\\Elements\\Common\\GlobalLocator.robot

*** Keywords ***
GetPaneList
    [Arguments]    ${paneList}
    ${listTemp}    Set Variable    ${paneList}
    Comment    ${listTemp}    Evaluate    "${listTemp} ".replace('Dashboard','${DashboardPaneL}')
    Comment    ${listTemp}    Evaluate    "${listTemp}".replace("Memember Management",'${MemberManagementPaneL}')
    Comment    ${listTemp}    Evaluate    "${listTemp}".replace("Change Root Password",'${ChageRootPasswordPaneL}')
    Comment    ${listTemp}    Evaluate    "${listTemp}".replace("Receivers",'${ReceiversPaneL}')
    Comment    ${listTemp}    Evaluate    "${listTemp}".replace("Scheduler",'${SchedulerPaneL}')
    Comment    ${listTemp}    Evaluate    "${listTemp}".replace("Receiver Log",'${ReceiverLogPaneL}')
    Comment    ${listTemp}    Evaluate    "${listTemp}".replace("Scheduler Log",'${SchedulerLogPaneL}')
    Comment    ${listTemp}    Evaluate    "${listTemp}".replace("USB Provisioning",'${USBProvisioningPaneL}')
    Comment    ${listTemp}    Evaluate    "${listTemp}".replace("About",'${AboutPaneL}')
    @{panelist}    Evaluate    "${listTemp}".split(",")
    [Return]    @{panelist}

Should Contain Panel
    [Arguments]    ${paneList}
    @{paneList}    GetPaneList    ${paneList}
    Sleep    2
    : FOR    ${item}    IN    @{paneList}
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

Should Not Contain Panel
    [Arguments]    ${paneList}
    @{paneList}    GetPaneList    ${paneList}
    Sleep    2
    : FOR    ${item}    IN    @{paneList}
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
    \    Page Should Not Contain Element    ${itemTemp}

Click Member Management Panel
    Wait Until Page Contains Element    ${MemberManagementPaneL}
    Click Element    ${MemberManagementPaneL}

Click Receivers Panel
    Wait Until Page Contains Element    ${ReceiversPaneL}
    Wait Until Keyword Succeeds    3    2    Click Element    ${ReceiversPaneL}

Click Scheduler Panel
    Wait Until Page Contains Element    ${SchedulerPaneL}
    Click Element    ${SchedulerPaneL}

Click Dashboard Panel
    Wait Until Page Contains Element    ${DashboardPaneL}
    Click Element    ${DashboardPaneL}

Click Change Root Password Panel
    Wait Until Page Contains Element    ${ChageRootPasswordPaneL}
    Click Element    ${ChageRootPasswordPaneL}
