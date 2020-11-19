*** Settings ***
Resource          ..\\..\\Elements\\ReceiversPaneLocator\\ReceiversPaneLocator.robot
Resource          ..\\..\\Elements\\ReceiversPaneLocator\\ReceiverSettingsLocator.robot

*** Keywords ***
Click Add Site Icon
    Click Element    ${AddSiteIconL}

Click Root Site
    Click Element    ${RootSiteL}

Enter Site Name
    [Arguments]    ${sitename}
    Run Keyword If    '${sitename}' != 'Blank'    SeleniumLibrary.Input Text    ${siteNameBoxL}    ${sitename}

Click Site
    [Arguments]    ${siteName}
    Wait Until Page Contains Element    //div[@class="site-title "]/div[text()="${siteName}"]
    Wait Until Keyword Succeeds    3    1    Click Element    //div[@class="site-title "]/div[text()="${siteName}"]

Site Exists
    [Arguments]    ${siteName}
    Page Should Contain Element    //div[@class="site-title "]/div[text()="${siteName}"]

Get SiteName ContextHelp
    ${contextHelp}    SeleniumLibrary.Get Text    ${siteNameContextHelpL}
    [Return]    ${contextHelp}

Right Click Site
    [Arguments]    ${siteName}
    Right Click Element    //div[@class="site-title "]/div[text()="${siteName}"]

Click Rename Button
    Click Element    ${renameSiteButtonL}

Click Add Users Button
    Click Element    ${addUserButtonL}

Click Join Receivers Button
    Click Element    ${joinReceiveButtonL}

Click Release Receivers Button
    Click Element    ${releaseReceiverButtonL}

Click Delete Site Button
    Click Element    ${deleteSiteButtonL}

Enter SiteName Into Rename Box
    [Arguments]    ${siteName}
    SeleniumLibrary.Input Text    ${renameSiteInputL}    ${siteName}    false
    Press Keys    ${renameSiteInputL}    RETURN

Site Not Exist
    [Arguments]    ${siteName}
    Page Should Not Contain Element    //div[@class="site-title "]/div[text()="${siteName}"]

Clear Rename Site Box
    [Arguments]    ${siteName}
    ${length}    Evaluate    len("${siteName}")
    Repeat Keyword    ${length} times    Press Keys    ${renameSiteInputL}    \ue003

Delete Sites
    [Arguments]    ${siteName}
    Click Site    ${siteName}
    Right Click Site    ${siteName}
    Sleep    1
    Click Delete Site Button
    Sleep    1
    Get CMS Window    Delete Site
    Click Proceed

Click Add to SBAdmin
    Click Element    ${sbAdminAddButtonL}

Select User In Left Box
    [Arguments]    ${username}
    Click Element    //div[@class="input-user-box"]/div[text()="${username}"]

Add User To SBAdmin
    [Arguments]    ${username}
    Wait Until Keyword Succeeds    3    1    Select User In Left Box    ${username}
    Click Add to SBAdmin

Add User To SBMonitor
    [Arguments]    ${username}
    Wait Until Keyword Succeeds    3    1    Select User In Left Box    ${username}
    Click Add to SBMonitor

Click Add to SBMonitor
    Click Element    ${sbMonitorAddButtonL}

Add User To Site
    [Arguments]    ${siteName}    ${username}    ${role}
    Click Site    ${siteName}
    Right Click Site    ${siteName}
    Click Add Users Button
    sleep    1
    Get CMS Window    Add Users to Site
    @{rolelist}    Evaluate    "${role}".split(",")
    : FOR    ${roleItem}    IN    @{rolelist}
    \    Run Keyword If    '${roleItem}' == 'CMS Admin'    Add User To SBAdmin    ${username}
    \    Run Keyword If    '${roleItem}' == 'CMS Monitor'    Add User To SBMonitor    ${username}
    Click Proceed

Click Users Tab
    Click Element    ${usersTabL}

Site Contains User
    [Arguments]    ${siteName}    ${username}    ${role}
    Page Should Contain Element    //table[@id="user-table"]/tbody/tr[td[1][text()="${siteName}"] and td[3][text()="${username}"] and td[5]/select/option[@selected and text()="${role}"]]

Site Should Not Contain User
    [Arguments]    ${siteName}    ${username}    ${role}
    Page Should Not Contain Element    //table[@id="user-table"]/tbody/tr[td[1][text()="${siteName}"] and td[3][text()="${username}"] and td[5]/select/option[@selected and text()="${role}"]]

Add User To Site-copy20200814
    [Arguments]    ${siteName}    ${username}    ${role}
    Click Site    ${siteName}
    Right Click Site    ${siteName}
    Click Add Users Button
    sleep    1
    Get CMS Window    Add Users to Site
    Run Keyword If    '${role}' == 'CMS Admin'    Add User To SBAdmin    ${username}
    Run Keyword If    '${role}' == 'CMS Monitor'    Add User To SBMonitor    ${username}
    Click Proceed

Set To CMS Admin
    [Arguments]    ${username}
    Wait Until Page Contains Element    //td[3 and text()="${username}"]/following-sibling::td[2]/select
    Select From List By Value    //td[3 and text()="${username}"]/following-sibling::td[2]/select    ScreenBeamAdmin

Set To CMS Monitor
    [Arguments]    ${username}
    Wait Until Page Contains Element    //td[3 and text()="${username}"]/following-sibling::td[2]/select
    Select From List By Value    //td[3 and text()="${username}"]/following-sibling::td[2]/select    ScreenBeamMonitorToASite

Click Receivers Tab
    Click Element    ${receiversTabL}

Select Receiver
    [Arguments]    ${receiver}
    Wait Until Page Contains Element    //table[@id="receiver-table"]/tbody/tr[td[1 and text()="${receiver}"]]
    Click Element    //table[@id="receiver-table"]/tbody/tr[td[1 and text()="${receiver}"]]    CTRL

Site Should Contain Receiver
    [Arguments]    ${siteName}    ${receiver}
    Page Should Contain Element    //table[@id="receiver-table"]/tbody/tr[td[1][text()="${receiver}"] and td[2][text()="${siteName}"]]

Site Should Not Contain Receiver
    [Arguments]    ${siteName}    ${receiver}
    Page Should Not Contain Element    //table[@id="receiver-table"]/tbody/tr[td[1][text()="${receiver}"] and td[2][text()="${siteName}"]]

Actions Item Should Be Invisable
    [Arguments]    ${action}
    Page Should Not Contain Element    //a[@class="dropdown-item dropdown-item" and text()="${action}"]

Click Actions Button
    Click Element    ${actionsButtonL}

Click Settings Button
    Click Element    ${settingsButtonL}

Click Update Firmware Button
    Click Element    ${updateFirmwareButtonL}

Click Set Background Button
    Click Element    ${setBackgroundButtonL}

Click Set Screen Saver Button
    Click Element    ${setScreenSaverButtonL}

Click Reboot Button
    Click Element    ${rebootButtonL}

Click Reset To Default Button
    Click Element    ${resetButtonL}

Click Update Credentials Button
    Click Element    ${updateCredentialsButtonL}

Click Switch CMS for Receivers Button
    Click Element    ${switchCMSButtonL}

Click Install Certificate Button
    Click Element    ${installCertButtonL}

Click Receiver Log Button
    Click Element    ${receiverLogButtonL}

Click Actions Item Button
    [Arguments]    ${actionItem}
    Click Element    //a[@class="dropdown-item dropdown-item" and text()="${actionItem}"]

Should Not Contain Add Site Icon
    Page Should Not Contain Element    ${AddSiteIconL}

Right Click Item On Site Should Be Grayed Out
    [Arguments]    ${item}
    Page Should Contain Element    //div[@class="context-menu-item context-disabled" and text()="${item}"]

Should Not Contain Users Tab
    Page Should Not Contain Element    ${usersTabL}

Click Modify Receivers
    Wait Until Page Contains Element    ${modifyReceiversButtonL}
    Wait Until Keyword Succeeds    3    1    Click Element    ${modifyReceiversButtonL}

Click Delete Receiver
    Wait Until Page Contains Element    ${deleteReceiverButtonL}
    Wait Until Keyword Succeeds    3    1    Click Element    ${deleteReceiverButtonL}

Click Edit Receiver Description
    Wait Until Page Contains Element    ${editRxDescButtonL}
    Wait Until Keyword Succeeds    3    1    Click Element    ${editRxDescButtonL}

Should Not Contain Delete Receiver Button
    Page Should Not Contain Element    ${deleteReceiverButtonL}

Click Export
    Wait Until Page Contains Element    ${exportButtonL}
    Wait Until Keyword Succeeds    3    1    Click Element    ${exportButtonL}

Click CSV
    Wait Until Page Contains Element    ${CSVButtonL}
    Wait Until Keyword Succeeds    3    1    Click Element    ${CSVButtonL}

Should Not Contain Advanced Settings Tab
    Page Should Not Contain Element    ${advancedSettingsTabL}

Should Contain Advanced Settings Tab
    Page Should Contain Element    ${advancedSettingsTabL}

Open Receiver Settings Window
    [Arguments]    ${receiver}
    Select Receiver    ${receiver}
    Sleep    2
    Click Actions Button
    Sleep    2
    Click Settings Button

Exported Receiver Is Empty
    Click Export
    Click CSV
    Sleep    1
    Get Right Corner Alert    There are no receivers.

Get Site List
    @{siteElement}    Get WebElements    ${siteL}
    ${siteListTmp}    Set Variable    ${EMPTY}
    : FOR    ${siteElement}    IN    @{siteElement}
    \    ${siteName}    Get Text    ${siteElement}
    \    ${siteListTmp}    Set Variable If    "${siteName}" != "Unassigned"    ${siteListTmp},${siteName}    ${siteListTmp}
    ${siteLIst}    Evaluate    "${siteListTmp}".strip(",")
    @{siteList}    Evaluate    "${siteLIst}".split(",")
    [Return]    @{siteLIst}
