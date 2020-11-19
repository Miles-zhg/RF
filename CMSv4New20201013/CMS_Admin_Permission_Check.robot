*** Settings ***
Resource          .\\Elements\\Common\\HomeroomLocator.robot
Resource          .\\CustomKeywords\\HomeroomKeywords\\PanelAssert.robot
Library           SeleniumLibrary
Resource          .\\CustomKeywords\\LoginKeywords\\LoginModel.robot
Resource          .\\CustomKeywords\\Common.robot
Resource          .\\CustomKeywords\\HomeroomKeywords\\PanelActions.robot
Resource          .\\CustomKeywords\\MemerManageKeywords\\MemberManagementActions.robot
Resource          .\\CustomKeywords\\MemerManageKeywords\\MemberManagementModel.robot
Resource          .\\CustomKeywords\\MemerManageKeywords\\MemberManagementAssert.robot
Resource          .\\CustomKeywords\\LoginKeywords\\LoginAssert.robot
Resource          .\\CustomKeywords\\ReceiversKeywords\\ReceiversActions.robot
Resource          .\\CustomKeywords\\ReceiversKeywords\\ReceiversModel.robot
Resource          .\\CustomKeywords\\ReceiversKeywords\\ReceiversAssert.robot
Resource          .\\CustomKeywords\\SchedulerKeywords\\SchedulerActions.robot
Resource          .\\CustomKeywords\\SchedulerKeywords\\SchedulerModel.robot
Resource          .\\CustomKeywords\\SchedulerKeywords\\SchedulerAssert.robot
Library           OperatingSystem

*** Test Cases ***
Set Global CMS Admin Users
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]
    Add User To Site And Verify    CMSAdmin Site    CMSAdmin    CMS Admin    Blank
    Set Global Variable    ${CMSAdminUser}    CMSAdmin
    Set Global Variable    ${CMSAdminUserPsw}    Sz!12345
    Sleep    2
    Join Receivers    All Receivers    CMSAdmin Site    ${receiver}
    [Teardown]    Close Browser

Check CMS Admin User Panel
    [Template]    Current User Should Contain Panel
    ${CMSAdminUser}    ${CMSAdminUserPsw}    Dashboard,Receivers,Scheduler,About    Member Management,Change Root Password,Receiver Log,Scheduler Log,USB Provisioning    279

CMS Admin Users Can't Add Site
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Add Site Icon Is Not Available
    282
    [Teardown]    Close Browser

Verify Right Click Menu On Site Is Not Available
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Right Click Menu On Site Is Not Available
    CMSAdmin Site    283
    [Teardown]    Close Browser

Verify Users Tab Is Not Available
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Users Tab Is Not Available
    284
    [Teardown]    Close Browser

Verify Actions Items
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Actions List
    Settings,Update Firmware,Set Background,Set Screen Saver,Reboot,Reset To Default,Switch CMS for Receivers,Install Certificate,Receiver Log    Blank    Update Credentials    ${receiver}    285-294
    [Teardown]    Close Browser

Verify Delete Receiver Is Not Available
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Delete Receiver Button Is Not Available
    295
    [Teardown]    Close Browser

Verify Edit Receiver Description
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Edit Receiver Description
    ${receiver}    296
    [Teardown]    Close Browser

Verify Export Receiver
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Export Receiver
    ${receiver}    ReceiverTable.csv    296
    [Teardown]    Close Browser

Verify Add Task
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Add New Task
    CMSAmin_Task    CMSAmin_Task    Reboot    Once    Blank    416
    [Teardown]    Close Browser

Verify Delete Task
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Delete Tasks
    417-Delete Task    417-Delete Task    Reboot    Once    Blank    Delete    417
    419-Delete Task    419-Delete Task    Reboot    Once    Blank    Right Click    419
    [Teardown]    Close Browser

Verify Edit Task
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Edit Task
    418-CMA Admin-Edit-Task    418-CMA Admin-Edit-Task    Reboot    Once    Blank    418-CMA Admin-Edit-Task_New    418-CMA Admin-Edit-Task_New
    ...    Upload Logs    Minutes    418
    [Teardown]    Close Browser

Verify Add Receiver To Task
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Add Receivers To Task
    420-CMSAdmin-Add Receiver To Task    420-CMSAdmin-Add Receiver To Task    Reboot    Once    Blank    ${receiver}    420
    [Teardown]    Close Browser

Verify Remove Receiver From Task
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Remove Receivers From Task
    422-CMSAdmin-Remove Receiver From Task    422-CMSAdmin-Remove Receiver From Task    Reboot    Once    Blank    ${receiver}    422
    [Teardown]    Close Browser

Verify Advanced Settings Tab Exists
    [Setup]    Login    ${CMSAdminUser}    ${CMSAdminUserPsw}
    [Template]    Verify Advanced Settings Tab Exists
    ${receiver}    FALSE    421
    [Teardown]    Close Browser
