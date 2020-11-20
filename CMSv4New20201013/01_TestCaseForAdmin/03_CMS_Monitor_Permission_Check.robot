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
Set Global CMS monitor User
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    Add User To Site And Verify    CMSMonitorSite    CMSMonitor    CMS Monitor    Blank
    Set Global Variable    ${CMSMonitorUser}    CMSMonitor
    Set Global Variable    ${CMSMonitorUserPsw}    Sz!12345
    Sleep    2
    Join Receivers    All Receivers    CMSMonitorSite    ${receiver}
    [Teardown]    Close Browser

Check CMS Monitor User Panel
    [Template]    Current User Should Contain Panel
    ${CMSMonitorUser}    ${CMSMonitorUserPsw}    Dashboard,Receivers,Scheduler,About    Member Management,Change Root Password,Receiver Log,Scheduler Log,USB Provisioning    425

CMS Monitor Users Can't Add Site
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Add Site Icon Is Not Available
    428
    [Teardown]    Close Browser

Verify Right Click Menu On Site Is Not Available
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Right Click Menu On Site Is Not Available
    CMSMonitorSite    429
    [Teardown]    Close Browser

Verify Users Tab Is Not Available
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Users Tab Is Not Available
    430
    [Teardown]    Close Browser

Verify Actions Items
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Actions List
    Blank    Settings,Update Firmware,Set Background,Set Screen Saver,Reboot,Reset To Default,Switch CMS for Receivers,Install Certificate,Receiver Log    Update Credentials    ${receiver}    431-439
    [Teardown]    Close Browser

Verify Delete Receiver Is Not Available
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Delete Receiver Button Is Not Available
    440
    [Teardown]    Close Browser

Verify Edit Receiver Description Is Not Available
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Edit Receiver Description Is Not Available
    ${receiver}    441
    [Teardown]    Close Browser

Verify Export Receiver
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Export Receiver
    ${receiver}    ReceiverTable.csv    442
    [Teardown]    Close Browser

Verify Add Task Is Not Available
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Add Task Is Not Available
    444
    [Teardown]    Close Browser

Verify Delete Task Is Not Available
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Delete Task Is Not Available
    CMSAmin_Task    Right Click    445
    CMSAmin_Task    Delete    447
    [Teardown]    Close Browser

Verify Edit Task Is Not Available
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Edit Task Is Not Available
    CMSAmin_Task    446
    [Teardown]    Close Browser

Verify Add Receivers To Task Is Not Available
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Add Receivers To Task Is Not Available
    CMSAmin_Task    448
    [Teardown]    Close Browser

Verify Remove Receivers From Task Is Not Available
    [Setup]    Login    ${CMSMonitorUser}    ${CMSMonitorUserPsw}
    [Template]    Verify Remove Receivers From Task Is Not Available
    CMSAmin_Task    Blank
    [Teardown]    Close Browser
