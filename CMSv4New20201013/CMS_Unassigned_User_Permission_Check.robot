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
Resource          .\\CustomKeywords\\DashboardKeywords\\DashboardActions.robot
Resource          .\\CustomKeywords\\DashboardKeywords\\DashboardModel.robot
Resource          .\\CustomKeywords\\DashboardKeywords\\DashboardAssert.robot
Library           OperatingSystem

*** Test Cases ***
Set Global Unassigned User
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    Update User Role    CMSUnassignedUser    CMSUnassignedUser    CMSUnassignedUser    a@a.com    Sz!12345    Sz!12345
    ...    CMS User    Blank
    Set Global Variable    ${CMSUnassignedUser}    CMSUnassignedUser
    Set Global Variable    ${CMSUnassignedUserPsw}    Sz!12345
    [Teardown]    Close Browser

Check Dashboard
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Dashboard
    0    0    0    0    249
    [Teardown]    Close Browser

Check CMS Unassigned User Panel
    [Template]    Current User Should Contain Panel
    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}    Dashboard,Receivers,Scheduler,About    Member Management,Change Root Password,Receiver Log,Scheduler Log,USB Provisioning    449

CMS Unassigned Users Can't Add Site
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Add Site Icon Is Not Available
    452
    [Teardown]    Close Browser

Verify Users Tab Is Not Available
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Users Tab Is Not Available
    453
    [Teardown]    Close Browser

Verify Actions Items
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Actions List
    Blank    Settings,Update Firmware,Set Background,Set Screen Saver,Reboot,Reset To Default,Switch CMS for Receivers,Install Certificate,Receiver Log    Update Credentials    Blank    454-462,473
    [Teardown]    Close Browser

Verify Delete Receiver Is Not Available
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Delete Receiver Button Is Not Available
    463
    [Teardown]    Close Browser

Verify Edit Receiver Description Is Not Available
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Edit Receiver Description Is Not Available
    Blank    464
    [Teardown]    Close Browser

Verify Export Receiver Is Not Available
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Export Receiver Is Not Available
    465
    [Teardown]    Close Browser

Verify Add Task Is Not Available
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Add Task Is Not Available
    467
    [Teardown]    Close Browser

Verify Delete Task Is Not Available
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Delete Task Is Not Available
    CMSAmin_Task    Right Click    470
    CMSAmin_Task    Delete    468
    [Teardown]    Close Browser

Verify Edit Task Is Not Available
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Edit Task Is Not Available
    CMSAmin_Task    469
    [Teardown]    Close Browser

Verify Add Receivers To Task Is Not Available
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Add Receivers To Task Is Not Available
    CMSAmin_Task    471
    [Teardown]    Close Browser

Verify Remove Receivers From Task Is Not Available
    [Setup]    Login    ${CMSUnassignedUser}    ${CMSUnassignedUserPsw}
    [Template]    Verify Remove Receivers From Task Is Not Available
    CMSAmin_Task    472
    [Teardown]    Close Browser
