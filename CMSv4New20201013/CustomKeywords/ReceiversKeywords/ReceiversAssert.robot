*** Keywords ***
Add New Sites
    [Arguments]    ${siteName}    ${parentSite}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Sites    ${siteName}    ${parentSite}
    Sleep    2
    Site Exists    ${siteName}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Add Site And Verify Duplicate
    [Arguments]    ${siteName}    ${parentSite}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Sites    ${siteName}    ${parentSite}
    Sleep    2
    Site Exists    ${siteName}
    Sleep    1
    Add Sites    ${siteName}    ${parentSite}
    Sleep    1
    Get Right Corner Alert    The site name ${siteName} already exists.
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Add Site And Verify Blank
    [Arguments]    ${siteName}    ${parentSite}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Sites    ${siteName}    ${parentSite}
    ${contextHelp}    Get SiteName ContextHelp
    Should Be Equal    ${contextHelp}    Site name must be between 2 and 36 characters
    Click Close Button
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Rename Site And Verify
    [Arguments]    ${oldSiteName}    ${newSiteName}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Rename Sites    ${oldSiteName}    ${newSiteName}
    Sleep    2
    Site Exists    ${newSiteName}
    Site Not Exist    ${oldSiteName}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Delete Site And Verify
    [Arguments]    ${siteName}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Delete Site Model    ${siteName}
    Sleep    2
    Site Not Exist    ${siteName}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Add User To Site And Verify
    [Arguments]    ${siteName}    ${username}    ${role}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add User To Sites    ${siteName}    ${username}    ${role}
    @{sitelist}    Evaluate    "${siteName}".split(",")
    : FOR    ${siteItem}    IN    @{sitelist}
    \    Sleep    2
    \    Click Site    ${siteItem}
    \    Click Users Tab
    \    Sleep    2
    \    Site Contains User    ${siteItem}    ${username}    ${role}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Add User To Site And Verify-copy
    [Arguments]    ${siteName}    ${username}    ${role}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add User To Sites    ${siteName}    ${username}    ${role}
    @{sitelist}    Evaluate    "${siteName}".split(",")
    : FOR    ${siteItem}    IN    @{sitelist}
    \    Sleep    2
    \    Click Site    ${siteItem}
    \    Click Users Tab
    \    Sleep    2
    \    Site Contains User    ${siteItem}    ${username}    ${role}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Add Different Roles In The Same Site To User
    [Arguments]    ${siteName}    ${username}    ${role}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add User To Sites    ${siteName}    ${username}    ${role}
    @{rolelist}    Evaluate    "${role}".split(",")
    @{sitelist}    Evaluate    "${siteName}".split(",")
    : FOR    ${siteItem}    IN    @{sitelist}
    \    Sleep    2
    \    Click Site    ${siteItem}
    \    Click Users Tab
    \    Sleep    2
    \    Site Contains User    ${siteItem}    ${username}    @{rolelist}[0]
    \    Site Should Not Contain User    ${siteItem}    ${username}    @{rolelist}[1]
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Join User To Child Site First And Parent Site After
    [Arguments]    ${username}    ${parentSite}    ${childSite}    ${parentSiteRole}    ${childSiteRole}    ${parentFlag}
    ...    ${childFlag}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Join User To Child Site First And Parent Site After    ${username}    ${parentSite}    ${childSite}    ${parentSiteRole}    ${childSiteRole}
    Sleep    2
    Click Site    ${childSite}
    Sleep    2
    Click Users Tab
    Sleep    2
    Run Keyword If    '${childFlag}' == 'YES'    Site Contains User    ${childSite}    ${username}    ${childSiteRole}
    Run Keyword If    '${childFlag}' == 'NO'    Site Should Not Contain User    ${childSite}    ${username}    ${childSiteRole}
    Sleep    2
    Click Site    ${parentSite}
    Sleep    2
    Click Users Tab
    Sleep    2
    Run Keyword If    '${parentFlag}' == 'YES'    Site Contains User    ${parentSite}    ${username}    ${parentSiteRole}
    Run Keyword If    '${parentFlag}' == 'NOT'    Site Should Not Contain User    ${parentSite}    ${username}    ${parentSiteRole}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Update Site User Role
    [Arguments]    ${siteName}    ${username}    ${roleBefore}    ${roleAfter}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add User to Site And Update Role    ${siteName}    ${username}    ${roleBefore}    ${roleAfter}
    Sleep    2
    Get Right Corner Alert    Successfully Update Site User Role
    Sleep    2
    Site Contains User    ${siteName}    ${username}    ${roleAfter}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Delete Site User Role
    [Arguments]    ${siteName}    ${username}    ${role}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add User to Site And Delete User    ${siteName}    ${username}    ${role}
    Sleep    2
    Get Right Corner Alert    Successfully Delete Site User
    Sleep    2
    Site Should Not Contain User    ${siteName}    ${username}    ${role}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Join Receiver To Site
    [Arguments]    ${siteBefore}    ${siteAfter}    ${receiver}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Join Receiver To Site    ${siteBefore}    ${siteAfter}    ${receiver}
    Sleep    1
    Get Right Corner Alert    Successfully joined receiver(s) to ${siteAfter}.
    Sleep    2
    @{receiverList}    Evaluate    '${receiver}'.split(",")
    : FOR    ${receiverItem}    IN    @{receiverList}
    \    Site Should Contain Receiver    ${siteAfter}    ${receiverItem}
    \    Comment    Deselect Receiver
    \    Select Receiver    ${receiverItem}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Release Receiver From Site
    [Arguments]    ${siteBefore}    ${siteAfter}    ${receiver}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Release Receiver From Site    ${siteBefore}    ${siteAfter}    ${receiver}
    Sleep    1
    Get Right Corner Alert    Successfully released receivers.
    Sleep    2
    @{receiverList}    Evaluate    '${receiver}'.split(",")
    : FOR    ${receiverItem}    IN    @{receiverList}
    \    Click Site    ${siteAfter}
    \    Sleep    2
    \    Site Should Not Contain Receiver    ${siteAfter}    ${receiverItem}
    \    Click Site    All Receivers
    \    Sleep    2
    \    Site Should Contain Receiver    Top    ${receiverItem}
    \    Comment    Deselect Receiver
    \    Select Receiver    ${receiverItem}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Actions List
    [Arguments]    ${actionsAvailable}    ${actionsNotAvailable}    ${actionsInvisable}    ${receiver}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Run Keyword If    "${actionsAvailable}" != "Blank"    Actions List Should Be Available    ${actionsAvailable}    ${receiver}
    Run Keyword If    "${actionsNotAvailable}" != "Blank"    Actions List Should Not Be Available    ${actionsNotAvailable}    ${receiver}
    Run Keyword If    "${actionsInvisable}" != "Blank"    Actions List Should Be Invisable    ${actionsInvisable}    ${receiver}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Add Site Icon Is Not Available
    [Arguments]    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Click Receivers Panel
    Sleep    2
    Should Not Contain Add Site Icon
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Right Click Menu On Site Is Not Available
    [Arguments]    ${siteName}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Right Click Menu On Site Is Not Available    ${siteName}    Rename,Add Users,Join Receivers,Release Receivers,Delete Site
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Users Tab Is Not Available
    [Arguments]    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Users Tab Should Not Be Available
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Delete Receiver Button Is Not Available
    [Arguments]    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Delete Receiver Button Should Not Be Available
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Edit Receiver Description
    [Arguments]    ${receiver}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Edit Receiver Description    ${receiver}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Export Receiver
    [Arguments]    ${receiver}    ${fileName}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Comment    Clear All Exported File Before Testing
    Clear All Exported File
    Sleep    2
    Export Receiver    ${receiver}
    Sleep    10
    Should Contain Exported File    ${fileName}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Advanced Settings Exists
    [Arguments]    ${receiver}    ${hasflag}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Check Advanced Settings Tab    ${receiver}    ${hasflag}
    Sleep    2
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Advanced Settings Tab Exists
    [Arguments]    ${receiver}    ${hasflag}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Check Advanced Settings Tab    ${receiver}    ${hasflag}
    Sleep    2
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Edit Receiver Description Is Not Available
    [Arguments]    ${receiver}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Edit Receiver Description Is Not Available    ${receiver}
    Sleep    2
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Export Receiver Is Not Available
    [Arguments]    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Click Receivers Panel
    Sleep    2
    Exported Receiver Is Empty
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Delete Online Receiver Is Not Available
    [Arguments]    ${receivers}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Delete Receiver    ${receivers}
    Sleep    2
    Get Right Corner Alert    Unable to delete receivers.
    Click Close Button
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Delete Offline Receiver Is Available
    [Arguments]    ${receivers}    ${number}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Delete Receiver    ${receivers}
    Sleep    2
    Get Right Corner Alert    Successfully deleted ${number} receiver
    Click Root Site
    Sleep    2
    ${receiverList}    Evaluate    "${receivers}".split(",")
    :FOR    ${receiverItem}    IN    ${receiverList}
    Site Should Not Contain Receiver    Top    ${receiverItem}
    END
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1
