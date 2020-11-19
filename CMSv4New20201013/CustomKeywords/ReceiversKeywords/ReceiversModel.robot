*** Keywords ***
Add Sites
    [Arguments]    ${siteName}    ${parentSite}
    Click Receivers Panel
    Click Site    ${parentSite}
    Click Add Site Icon
    Sleep    1
    Get CMS Window    Add Site
    Enter Site Name    ${siteName}
    Click Proceed

Rename Sites
    [Arguments]    ${oldSiteName}    ${newSiteName}
    Add New Sites    ${oldSiteName}    All Receivers    Blank
    Click Site    ${oldSiteName}
    Right Click Site    ${oldSiteName}
    Sleep    1
    Click Rename Button
    Sleep    1
    Clear Rename Site Box    ${oldSiteName}
    Enter SiteName Into Rename Box    ${newSiteName}

Delete Site Model
    [Arguments]    ${siteName}
    Add New Sites    ${siteName}    All Receivers    Blank
    Delete Sites    ${siteName}

Add User To Sites
    [Arguments]    ${siteName}    ${username}    ${role}
    Change User Role    ${username}    ${username}    ${username}    a@a.com    Sz!12345    Sz!12345
    ...    CMS User
    Sleep    1
    @{sitelist}    Evaluate    "${siteName}".split(",")
    : FOR    ${siteItem}    IN    @{sitelist}
    \    Add Sites    ${siteItem}    All Receivers
    \    Sleep    1
    \    Add User To Site    ${siteItem}    ${username}    ${role}

Add User To Sites - Copy
    [Arguments]    ${siteName}    ${username}    ${role}
    Change User Role    ${username}    ${username}    ${username}    a@a.com    Sz!12345    Sz!12345
    ...    CMS User
    Sleep    1
    Add Sites    ${siteName}    All Receivers
    Sleep    1
    Add User To Site    ${siteName}    ${username}    ${role}

Add User To Sites-copy20200814
    [Arguments]    ${siteName}    ${username}    ${role}
    Change User Role    ${username}    ${username}    ${username}    a@a.com    Sz!12345    Sz!12345
    ...    CMS User
    Sleep    1
    @{sitelist}    Evaluate    "${siteName}".split(",")
    : FOR    ${siteItem}    IN    @{sitelist}
    \    Add Sites    ${siteItem}    All Receivers
    \    Sleep    1
    \    Add User To Site    ${siteItem}    ${username}    ${role}

Join User To Child Site First And Parent Site After
    [Arguments]    ${username}    ${parentSite}    ${childSite}    ${parentSiteRole}    ${childSiteRole}
    Change User Role    ${username}    ${username}    ${username}    a@a.com    Sz!12345    Sz!12345
    ...    CMS User
    Sleep    1
    Add Sites    ${parentSite}    All Receivers
    Sleep    1
    Add Sites    ${childSite}    ${parentSite}
    Sleep    1
    Add User To Site    ${childSite}    ${username}    ${childSiteRole}
    Sleep    1
    Add User To Site    ${parentSite}    ${username}    ${parentSiteRole}
    Sleep    1

Add User to Site And Update Role
    [Arguments]    ${siteName}    ${username}    ${roleBefore}    ${roleAfter}
    Add User To Sites    ${siteName}    ${username}    ${roleBefore}
    Sleep    2
    Click Site    ${siteName}
    Sleep    2
    Click Users Tab
    Sleep    2
    Run Keyword If    '${roleAfter}' == 'CMS Admin'    Set To CMS Admin    ${username}
    Run Keyword If    '${roleAfter}' == 'CMS Monitor'    Set To CMS Monitor    ${username}

Add User to Site And Delete User
    [Arguments]    ${siteName}    ${username}    ${role}
    Add User To Sites    ${siteName}    ${username}    ${role}
    Sleep    2
    Click Site    ${siteName}
    Sleep    2
    Click Users Tab
    Sleep    2
    Site Contains User    ${siteName}    ${username}    ${role}
    Click Delete Icon    ${username}

Join Receivers
    [Arguments]    ${siteBefore}    ${siteAfter}    ${receiver}
    Click Site    ${siteBefore}
    Sleep    2
    Click Receivers Tab
    @{receiverList}    Evaluate    '${receiver}'.split(",")
    : FOR    ${receiverItem}    IN    @{receiverList}
    \    Select Receiver    ${receiverItem}
    Right Click Site    ${siteAfter}
    Click Join Receivers Button

Join Receiver To Site
    [Arguments]    ${siteBefore}    ${siteAfter}    ${receiver}
    Add Sites    ${siteAfter}    ${siteBefore}
    Sleep    2
    Join Receivers    ${siteBefore}    ${siteAfter}    ${receiver}

Release Receivers
    [Arguments]    ${siteBefore}    ${siteAfter}    ${receiver}
    Click Site    ${siteAfter}
    Sleep    2
    Click Receivers Tab
    @{receiverList}    Evaluate    '${receiver}'.split(",")
    : FOR    ${receiverItem}    IN    @{receiverList}
    \    Select Receiver    ${receiverItem}
    Right Click Site    ${siteAfter}
    Click Release Receivers Button

Release Receiver From Site
    [Arguments]    ${siteBefore}    ${siteAfter}    ${receiver}
    Verify Join Receiver To Site    ${siteBefore}    ${siteAfter}    ${receiver}    Blank
    Sleep    2
    Release Receivers    ${siteBefore}    ${siteAfter}    ${receiver}

Actions List Should Be Available
    [Arguments]    ${actions}    ${receiver}
    Click Receivers Panel
    Sleep    2
    Run Keyword If    "${receiver}" != "Blank"    Select Receiver    ${receiver}
    Sleep    2
    @{actionsList}    Evaluate    '${actions}'.split(",")
    : FOR    ${actionItem}    IN    @{actionsList}
    \    Click Actions Button
    \    Sleep    2
    \    Click Actions Item Button    ${actionItem}
    \    Sleep    2
    \    Get CMS Window    ${actionItem}
    \    Sleep    2
    \    Click Close Button
    \    Sleep    2
    Comment    Deselect Receiver
    Run Keyword If    "${receiver}" != "Blank"    Select Receiver    ${receiver}

Actions List Should Not Be Available
    [Arguments]    ${actions}    ${receiver}
    Click Receivers Panel
    Sleep    2
    Run Keyword If    "${receiver}" != "Blank"    Select Receiver    ${receiver}
    Sleep    2
    @{actionsList}    Evaluate    '${actions}'.split(",")
    : FOR    ${actionItem}    IN    @{actionsList}
    \    Click Actions Button
    \    Sleep    2
    \    Click Actions Item Button    ${actionItem}
    \    Sleep    1
    \    Get Right Corner Alert    Please select one or more receiver(s)
    \    Sleep    2
    \    Should Not Contain CMS Window    ${actionItem}
    Comment    Deselect Receiver
    Run Keyword If    "${receiver}" != "Blank"    Select Receiver    ${receiver}

Actions List Should Be Invisable
    [Arguments]    ${actions}    ${receiver}
    Click Receivers Panel
    Sleep    1
    Run Keyword If    "${receiver}" != "Blank"    Select Receiver    ${receiver}
    Sleep    2
    @{actionsList}    Evaluate    '${actions}'.split(",")
    : FOR    ${actionItem}    IN    @{actionsList}
    \    Click Actions Button
    \    Sleep    2
    \    Actions Item Should Be Invisable    ${actionItem}
    Comment    Deselect Receiver
    Run Keyword If    "${receiver}" != "Blank"    Select Receiver    ${receiver}

Right Click Menu On Site Is Not Available
    [Arguments]    ${siteName}    ${items}
    Click Receivers Panel
    Sleep    2
    Click Site    ${siteName}
    Sleep    1
    Right Click Site    ${siteName}
    @{itemList}    Evaluate    "${items}".split(",")
    : FOR    ${item}    IN    @{itemList}
    \    Right Click Item On Site Should Be Grayed Out    ${item}

Users Tab Should Not Be Available
    Click Receivers Panel
    Sleep    2
    Should Not Contain Users Tab

Delete Receiver Button Should Not Be Available
    Click Receivers Panel
    Sleep    2
    Click Modify Receivers
    Sleep    2
    Should Not Contain Delete Receiver Button

Edit Receiver Description
    [Arguments]    ${receiver}
    Click Receivers Panel
    Sleep    2
    Select Receiver    ${receiver}
    Sleep    2
    Click Modify Receivers
    Sleep    2
    Click Edit Receiver Description
    Sleep    2
    Get CMS Window    Receiver Description
    Click Close Button
    Sleep    2
    Select Receiver    ${receiver}

Export Receiver
    [Arguments]    ${receiver}
    Click Receivers Panel
    Sleep    2
    Select Receiver    ${receiver}
    Sleep    2
    Click Export
    Sleep    2
    Click CSV
    Sleep    2
    Select Receiver    ${receiver}

Check Advanced Settings Tab
    [Arguments]    ${receiver}    ${hasflag}
    Click Receivers Panel
    Sleep    2
    Open Receiver Settings Window    ${receiver}
    Sleep    2
    Run Keyword If    "${hasflag}" == "TRUE"    Should Contain Advanced Settings Tab
    Run Keyword If    "${hasflag}" != "TRUE"    Should Not Contain Advanced Settings Tab
    Click Close Button
    Sleep    2
    Select Receiver    ${receiver}

Edit Receiver Description Is Not Available
    [Arguments]    ${receiver}
    Click Receivers Panel
    Sleep    2
    Run Keyword If    "${receiver}" != "Blank"    Select Receiver    ${receiver}
    Sleep    2
    Click Modify Receivers
    Sleep    2
    Click Edit Receiver Description
    Sleep    1
    Get Right Corner Alert    Please select one or more receiver(s)
    Should Not Contain CMS Window    Receiver Description

Delete Receiver
    [Arguments]    ${receivers}
    Click Receivers Panel
    Sleep    2
    Click Receivers Tab
    Sleep    2
    Select Receivers    ${receivers}
    Click Modify Receivers
    Sleep    2
    Click Delete Receiver
    Sleep    2
    Get CMS Window    Delete Receivers
    Click Proceed

Clear Site List
    Click Receivers Panel
    Sleep    2
    @{siteListTmp}    Get Site List
    :FOR    ${siteName}    IN    @{siteListTmp}
    \    Delete Sites    ${siteName}
