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

*** Test Cases ***
Set Global CMSSysAdmin Users
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]
    Update User Role    SysAdmin    SysAdmin    SysAdmin    a@a.com    Sz!12345    Sz!12345
    ...    CMS SysAdmin    Blank
    Set Global Variable    ${sysAdminUser}    SysAdmin
    Set Global Variable    ${sysAdminUserPsw}    Sz!12345
    [Teardown]    Close Browser

Clear Data Before Testing
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]
    Comment    Click Member Management Panel
    Comment    Sleep    2
    Comment    ${userNum}    Get Table Length    user-table
    Comment    Comment    Clear Member Management
    Comment    : FOR    ${rowNum}    IN RANGE    ${userNum}
    Comment    \    Sleep    1
    Comment    \    ${username}    Get Text    //table/tbody/tr[1]/td[3]
    Comment    \    Run Keyword If    "${username}" != "SysAdmin"    Click The First Delete Icon    //td/i[text()="delete"]
    Comment    \    Sleep    1
    Comment    Clear Schedule List
    Clear Site List
    [Teardown]    Close Browser

Check Default User Panel
    [Template]    Current User Should Contain Panel
    Administrator    Screenbeam    Member Management,Change Root Password,About    Receivers,Scheduler,Receiver Log,Scheduler Log,USB Provisioning,Dashboard    250

Add Users Ok
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Add Member Success
    chao    chao    chao    c@a.com    Sz!12345    Sz!12345    261
    12    12    1211    c@a.com    Sz!12345    Sz!12345    368
    12345678901234567890    12    20chars    c@a.com    Sz!12345    Sz!12345    369
    Aa1    12    Aa11    c@a.com    Sz!12345    Sz!12345    371
    Aa1    12    lastname12    c@a.com    Sz!12345    Sz!12345    375
    112    12345678901234567890    lastname20chars    c@a.com    Sz!12345    Sz!12345    376
    112    Lastname1    username    c@a.com    Sz!12345    Sz!12345    378
    112    Lastname1    1234    c@a.com    Sz!12345    Sz!12345    382
    112    Lastname1    12345678901234567890    c@a.com    Sz!12345    Sz!12345    383
    112    Lastname1    Aa111    c@a.com    Sz!12345    Sz!12345    385
    112    Lastname1    Aa11127email    12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012@a.co    Sz!12345    Sz!12345    388
    112    Lastname1    Aa118pasword    c@a.com    Sz!12345    Sz!12345    392
    112    Lastname1    Aa1120pasword    c@a.com    123456789012Sz!12345    123456789012Sz!12345    393
    112    Lastname1    Aa11symbospasword    c@a.com    Sz1!@#$%^&*    Sz1!@#$%^&*    395
    [Teardown]    Close Browser

Add Users and Invalidate FirstName
    [Setup]    Login    Administrator    Screenbeam
    [Template]    Add Member And Invalidate Input
    1    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    367
    123456789012345678901    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    370
    Aa`    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa~    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa!    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa@    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa#    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa$    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa%    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa^    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa&    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa*    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa(    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa)    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa_    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa-    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa=    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa+    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa[    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa]    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa{    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa}    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa;    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa:    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa,    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa<    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa>    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa.    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa?    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    Aa/    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    372
    名字    lastname    username    a@a.com    Sz!12345    Sz!12345    FirstName
    ...    373
    [Teardown]    Close Browser

Add Users and Invalidate LastName
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Add Member And Invalidate Input
    firstname    1    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    374
    firstname    123456789012345678901    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    377
    firstname    Aa`    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa~    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa!    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa@    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa#    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa$    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa%    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa^    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa&    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa*    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa(    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa)    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa_    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa-    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa=    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa+    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa[    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa]    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa{    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa}    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa;    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa:    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa'    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa|    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa,    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa<    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa>    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa.    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa?    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    Aa/    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    379
    firstname    名字    username    a@a.com    Sz!12345    Sz!12345    LastName
    ...    380
    [Teardown]    Close Browser

Add Users and Invalidate UserName
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Add Member And Invalidate Input
    firstname    lastname    123    a@a.com    Sz!12345    Sz!12345    UserName
    ...    381
    firstname    lastname    123456789012345678901    a@a.com    Sz!12345    Sz!12345    UserName
    ...    384
    firstname    lastname    AAAA`    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA~    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA!    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA@    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA#    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA$    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA%    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA^    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA&    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA*    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA(    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA)    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA_    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA-    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA=    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA+    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA[    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA]    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA{    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA}    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA;    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA:    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA'    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA|    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA,    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA<    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA>    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA.    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA?    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    AAAA/    a@a.com    Sz!12345    Sz!12345    UserName
    ...    386
    firstname    lastname    用户名字    a@a.com    Sz!12345    Sz!12345    UserName
    ...    387
    [Teardown]    Close Browser

Add Users and Invalidate Email
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Add Member And Invalidate Input
    firstname    lastname    1234    12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012@a.com    Sz!12345    Sz!12345    Email
    ...    389
    firstname    lastname    1234    a@aa    Sz!12345    Sz!12345    Email
    ...    390
    [Teardown]    Close Browser

Add Users and Invalidate Password
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Add Member And Invalidate Input
    firstname    lastname    1234    a@aa.com    Sz!1234    Sz!1234    Password
    ...    391
    firstname    lastname    1234    a@aa.com    1234567890123Sz!12345    1234567890123Sz!12345    Password
    ...    394
    firstname    lastname    1234    a@aa.com    SS!12345    SS!12345    Password
    ...    396
    firstname    lastname    1234    a@aa.com    ss!12345    ss!12345    Password
    ...    397
    firstname    lastname    1234    a@aa.com    Sz!sssss    Sz!sssss    Password
    ...    398
    firstname    lastname    1234    a@aa.com    Sz!12345`    Sz!12345`    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345~    Sz!12345~    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345(    Sz!12345(    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345)    Sz!12345)    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345_    Sz!12345_    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345+    Sz!12345+    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345-    Sz!12345-    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345=    Sz!12345=    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345{    Sz!12345{    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345}    Sz!12345}    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345|    Sz!12345|    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345[    Sz!12345[    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345]    Sz!12345]    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345:    Sz!12345:    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345;    Sz!12345;    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345'    Sz!12345'    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345<    Sz!12345<    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345>    Sz!12345>    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345?    Sz!12345?    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345,    Sz!12345,    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345.    Sz!12345.    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz!12345/    Sz!12345/    Password
    ...    399
    firstname    lastname    1234    a@aa.com    Sz123456    Sz123456    Password
    ...    400
    firstname    lastname    1234    a@aa.com    Sz!12345密码    Sz!12345密码    Password
    ...    401
    firstname    lastname    1234    a@aa.com    Sz!12345    Sz!12346    RePassword
    ...    402
    [Teardown]    Close Browser

Add Users and Invalidate All Blank
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Add Member And Invalidate Input
    Blank    Blank    Blank    Blank    Blank    Blank    Email
    ...    223
    [Teardown]    Close Browser

Add Users and Verify Duplicate
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Add Member And Verify Duplicate
    DuplicateUser    DuplicateUser    DuplicateUser    a@a.com    Sz!12345    Sz!12345    222
    [Teardown]    Close Browser

Add Users and Cancel
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Add Member And Cancel
    CancelUser    CancelUser    CancelUser    a@a.com    Sz!12345    Sz!12345    403
    [Teardown]    Close Browser

Delete User and Verify
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Delete Member And Verify
    DeleteUser    DeleteUser    DeleteUser    a@a.com    Sz!12345    Sz!12345    226
    [Teardown]    Close Browser

Delete Current Login User
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Delete Current Login User
    CurrentUser    CurrentUser    CurrentUser    a@a.com    Sz!12345    Sz!12345    227
    [Teardown]    Close Browser

Update User Info
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Update User Infor
    User    User    User    a@a.com    Sz!12345    Sz!12345    228
    [Teardown]    Close Browser

Update User Password
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Update User Password
    UserChangePassword    UserChangePassword    UserChangePassword    a@a.com    Sz!12345    Sz!12345    Sz12345!
    ...    348
    [Teardown]    Close Browser

Update User Role
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Update User Role
    UserChangeRole    UserChangeRole    UserChangeRole    a@a.com    Sz!12345    Sz!12345    CMS SysAdmin
    ...    264
    UserChangeRole2    UserChangeRole2    UserChangeRole2    a@a.com    Sz!12345    Sz!12345    CMS User
    ...    264
    [Teardown]    Close Browser

Search User
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Verify Search User
    SearchFirstName    searchuser1    searchuser1    searchuser1@a.com    Sz!12345    Sz!12345    SearchFirstName
    ...    229
    searchuser2    SearchLastName    searchuser2    searchuser2@a.com    Sz!12345    Sz!12345    SearchLastName
    ...    229
    searchuser3    searchuser3    SearchUserName    searchuser3@a.com    Sz!12345    Sz!12345    SearchUserName
    ...    229
    searchuser4    searchuser4    searchuser4    searchuser4@a.com    Sz!12345    Sz!12345    searchuser4@a.com
    ...    229
    [Teardown]    Close Browser

Verify Change Root Password
    [Setup]    Login    ${defaultUser}    ${defaultUserPasword}
    [Template]    Verify Change Root Password
    ${defaultUser}    Sz!12345    265
    [Teardown]    Close All Browsers

Add New Sites
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Add New Sites
    Level1-SiteA    All Receivers    240
    Level1-SiteB    All Receivers    240
    Level1-SiteC    All Receivers    240
    Level2-SiteA    Level1-SiteA    404
    Level2-SiteB    Level1-SiteB    404
    Level2-SiteC    Level1-SiteC    404
    Level3-SiteA    Level2-SiteA    405
    Level3-SiteB    Level2-SiteB    405
    Level3-SiteC    Level2-SiteC    405
    !1234 Azz    All Receivers    243
    [Teardown]    Close Browser

Add Duplicate Site
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Add Site And Verify Duplicate
    DuplicateSite    All Receivers    241
    [Teardown]    Close Browser

Add Site And Verify Blank
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Add Site And Verify Blank
    Blank    All Receivers    242
    [Teardown]    Close Browser

Rename Site And Verify
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Rename Site And Verify
    OldSiteName    NewSiteName    247
    [Teardown]    Close Browser

Delete Site And Verify
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Delete Site And Verify
    DeleteSiteName    244
    [Teardown]    Close Browser

Add User To Site And Verify
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Add User To Site And Verify
    CA    User1    CMS Admin    230
    DC    User2    CMS Monitor    251
    Site252-1,Site252-2    User3    CMS Admin    252
    [Teardown]    Close Browser

Add Different Roles In The Same Site To User
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Add Different Roles In The Same Site To User
    Site253-A    User253A    CMS Admin,CMS Monitor    253
    Site253-B    User253B    CMS Monitor,CMS Admin    253
    [Teardown]    Close Browser

Verify Join User To Child Site First And Parent Site After
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Join User To Child Site First And Parent Site After
    User254    ParentSite254    ChildSite254    CMS Admin    CMS Admin    YES    NO
    ...    254
    User255    ParentSite255    ChildSite255    CMS Monitor    CMS Admin    YES    YES
    ...    255
    User256    ParentSite256    ChildSite256    CMS Admin    CMS Monitor    YES    NO
    ...    256
    User339    ParentSite339    ChildSite339    CMS Monitor    CMS Monitor    YES    NO
    ...    339
    [Teardown]    Close Browser

Verify Update Site User Role Via The Dropdown List
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Update Site User Role
    Site345    User345    CMS Monitor    CMS Admin    345
    Site408    User408    CMS Admin    CMS Monitor    408
    [Teardown]    Close Browser

Verify Delete Site User Role Via The Dropdown List
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Delete Site User Role
    Site409    User409    CMS Admin    409
    Site410    User410    CMS Monitor    410
    [Teardown]    Close Browser

Verify Join Receiver To Site
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Join Receiver To Site
    All Receivers    Site412    ${idleReceiver}    412
    All Receivers    Site413    ${idleReceiver},${busyReceiver}    413
    [Teardown]    Close Browser

Verify Release Receiver From Site
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Release Receiver From Site
    All Receivers    Site414    ${idleReceiver}    414
    All Receivers    Site415    ${idleReceiver},${busyReceiver}    415
    [Teardown]    Close Browser

Verify Actions
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Actions List
    Settings,Update Firmware,Set Background,Set Screen Saver,Reboot,Reset To Default,Update Credentials,Switch CMS for Receivers,Install Certificate,Receiver Log    Blank    Blank    ${idleReceiver}    271
    [Teardown]    Close Browser

Verify Add New Task
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Add New Task
    Task-no-endDate-141    Task-no-endDate    Reboot    Once    Blank    141
    Task-with-endDate-142    Task-with-endDate    Reboot    Minutes    End Date    142
    Task-reboot-once-144    Task-reboot-once    Reboot    Once    Blank    144
    Task-149    Task-149    Reset To Default    Once    Blank    149
    Task-150    Task-150    Upload Logs    Once    Blank    150
    Task-151    Task-151    Upload Logs    Once    Blank    151
    Task    Task-358    Upload Logs    Once    Blank    358
    1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111    Task-359    Upload Logs    Once    Blank    359
    `~!@#$%^&*()-=_+[]\\{}|;':,./<>? 123wcq好HAO    Task-361    Upload Logs    Once    Blank    361
    Task-362    Blank    Upload Logs    Once    Blank    362
    Task-363    1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111    Upload Logs    Once    Blank    363
    Task-365    `~!@#$%^&*()-=_+[]\\{}|;':\,./<>? 123wcq好HAO    Upload Logs    Once    Blank    365
    [Teardown]    Close Browser

Verify Add New Task_2
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Add New Task_2
    Task-Minutes-166    Task-Minutes-166    Reboot    Minutes    10    Blank    166
    Task-Daily-167    Task-Daily-167    Reboot    Daily    2    Blank    167
    Task-Weekly-168    Task-Weekly-168    Reboot    Weekly    Monday,Friday    Blank    168
    Task-Monthly-169    Task-Monthly-169    Reboot    Monthly    3    Blank    169
    [Teardown]    Close Browser

Verify Add New Task_3
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Add New Task_3
    Task-UpdateFW-140    Task-UpdateFW-140    Update Firmware    http://192.168.31.192/install.img    Once    Blank    140
    Task-Screensaver-138    Task-Screensaver-138    Set Screen Saver    http://192.168.31.192/screensaver.png    Once    Blank    138
    Task-Background-143    Task-Background-143    Set Background    http://192.168.31.192/background.png    Once    Blank    143
    [Teardown]    Close Browser

Verify Add New Task_Setting
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Add New Task_Setting
    Task-Setting-139    Task-Setting-139    Settings    Language    Once    Blank    139
    [Teardown]    Close Browser

Verify Task Info In Edit Window
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Task Info In Edit Window
    152-Edit-Default    152-Edit-Default    Reboot    Once    Blank    152
    [Teardown]    Close Browser

Verify Edit Task_Basic
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Edit Task
    153-Edit-Task    153-Edit-Task    Reboot    Once    Blank    153-Edit-Task-New    153-Edit-Task-New
    ...    Upload Logs    Minutes    153
    [Teardown]    Close Browser

Verify Delete Tasks
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Delete Tasks
    156-Delete Task    156-Delete Task    Reboot    Once    Blank    Right Click    156
    156-Delete Task_2    156-Delete Task_2    Reboot    Once    Blank    Delete    156
    [Teardown]    Close Browser

Verify Search Tasks
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Search Tasks
    145-Search Task-Name    145-Search Task    Reboot    Once    Blank    145-Search Task-Name    145
    145-Search Task    145-Search Task-Desc    Reboot    Once    Blank    145-Search Task-Desc    145
    145-Search Task-Action    145-Search Task-Action    Upload Logs    Once    Blank    Upload Logs    145
    [Teardown]    Close Browser

Verify Add Receivers To Task
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Add Receivers To Task
    147-Add Receiver To Task    147-Add Receiver To Task    Reboot    Once    Blank    ${idleReceiver},${busyReceiver}    147
    [Teardown]    Close Browser

Verify Remove Receivers From Task
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Remove Receivers From Task
    158-Remove Receiver From Task    158-Remove Receiver From Task    Reboot    Once    Blank    ${idleReceiver},${busyReceiver}    158
    [Teardown]    Close Browser

Verify Add Duplicate Task
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Add Duplicate Task
    159-Duplicate Task    159-Duplicate Task    Reboot    Once    Blank    159
    [Teardown]    Close Browser

Verify Invalid Task Name
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Invalid Task Name
    Blank    356-Blank Task Name    Reboot    Once    Blank    356
    123    357-Less 3characters Task Name    Reboot    Once    Blank    357
    [Teardown]    Close Browser

Verify Advanced Settings Tab
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Advanced Settings Tab Exists
    ${receiver}    TRUE    499
    [Teardown]    Close Browser

Verify Delete Online Receiver Is Not Available
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Delete Online Receiver Is Not Available
    ${idleReceiver}    Blank
    ${busyReceiver}    Blank
    [Teardown]    Close Browser

Verify Delete Offline Receiver Is Available
    [Setup]    Login    ${sysAdminUser}    ${sysAdminUserPsw}
    [Template]    Verify Delete Offline Receiver Is Available
    ${offlineReceiver}    1    272
    [Teardown]    Close Browser
