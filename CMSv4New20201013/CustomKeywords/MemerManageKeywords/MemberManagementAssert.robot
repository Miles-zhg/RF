*** Settings ***
Resource          ..\\..\\Elements\\Common\\MemberManagementLocator.robot

*** Keywords ***
Add Member Success
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Add New Member    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    Sleep    1
    Get Right Corner Alert    Added user successfully.
    Sleep    5
    New User Exists    //table[@id="user-table"]/tbody/tr[td[1][text()="${firstname}"] and td[2][text()="${lastname}"] and td[3][text()="${username}"] and td[4][text()="${email}"] and td[5]/select/option[@selected and text()="CMS SysAdmin"]]
    Comment    New User Exists    ${newUserL}
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1

Add Member And Invalidate Input
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${flag}    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Add New Member    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    Sleep    1
    Run Keyword If    "${flag}" == "FirstName" or "${firstname}" == "Blank"    Invalidate FirstName
    Run Keyword If    "${flag}" == "LastName" or "${lastname}" == "Blank"    Invalidate LastName
    Run Keyword If    "${flag}" == "UserName" or "${username}" == "Blank"    Invalidate UserName
    Run Keyword If    "${flag}" == "Email" or "${email}" == "Blank"    Invalidate Email
    Run Keyword If    "${flag}" == "Password" or "${password}" == "Blank"    Invalidate Password
    Run Keyword If    "${flag}" == "RePassword" or "${repassword}" == "Blank"    Invalidate Retype Password
    Run Keyword If    "${caseid}" != "Blank"    Log    Done case-${caseid}
    Click Close Button

Add Member And Verify Duplicate
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Add Member Success    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    Blank
    Sleep    1
    Add New Member    ${firstname}cp    ${lastname}cp    ${username}    ${email}cp    ${password}    ${repassword}
    Sleep    1
    Get Right Corner Alert    The record with '${username}' of 'Username' already exist
    Sleep    1
    New User Not Exist    //table[@id="user-table"]/tbody/tr[td[1][text()="${firstname}-cp"] and td[2][text()="${lastname}-cp"] and td[3][text()="${username}"] and td[4][text()="${email}-cp"] and td[5]/select/option[@selected and text()="CMS SysAdmin"]]
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1

Add Member And Cancel
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Cancel Adding New Member    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    Sleep    1
    New User Not Exist    //table[@id="user-table"]/tbody/tr[td[1][text()="${firstname}"] and td[2][text()="${lastname}"] and td[3][text()="${username}"] and td[4][text()="${email}"] and td[5]/select/option[@selected and text()="CMS SysAdmin"]]
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1

Delete Member And Verify
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Add Member Success    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    Blank
    Delete Member    ${username}
    Sleep    1
    Get Right Corner Alert    ${username} was deleted successfully
    New User Not Exist    //table[@id="user-table"]/tbody/tr[td[1][text()="${firstname}"] and td[2][text()="${lastname}"] and td[3][text()="${username}"] and td[4][text()="${email}"] and td[5]/select/option[@selected and text()="CMS SysAdmin"]]
    Close Browser
    Login Fail    ${username}    ${password}    Blank
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1

Delete Current Login User
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Add Member Success    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    Blank
    Close Browser
    Sleep    1
    Login    ${username}    ${password}
    Click Member Management Panel
    Sleep    1
    Page Should Not Contain Element    //td[3 and text()="${username}"]/following-sibling::td[3]/i[text()="delete"]
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1

Update User Infor
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    ${firstnameTmp}    ${lastnameTmp}    ${emailTmp}    Update Member    ${firstname}    ${lastname}    ${username}
    ...    ${email}    ${password}    ${repassword}
    Sleep    1
    Get Right Corner Alert    Updated user successfully.
    New User Not Exist    //table[@id="user-table"]/tbody/tr[td[1][text()="${firstname}"] and td[2][text()="${lastname}"] and td[3][text()="${username}"] and td[4][text()="${email}"] and td[5]/select/option[@selected and text()="CMS SysAdmin"]]
    New User Exists    //table[@id="user-table"]/tbody/tr[td[1][text()="${firstnameTmp}"] and td[2][text()="${lastnameTmp}"] and td[3][text()="${username}"] and td[4][text()="${emailTmp}"] and td[5]/select/option[@selected and text()="CMS SysAdmin"]]
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1

Update User Password
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${newPassword}    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Sleep    1
    Change User Password    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${newPassword}
    Sleep    1
    Get Right Corner Alert    Updated user successfully.
    Close Browser
    Login Success    ${username}    ${newPassword}    Blank
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1

Update User Role
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${newrole}    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Sleep    1
    Change User Role    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${newrole}
    Sleep    1
    Get Right Corner Alert    Successfully Updated User Admin Role
    Comment    ${roleTmp}    Get Current Role    ${username}
    Comment    Should Be Equal    ${roleTmp}    ${newrole}
    List Selection Should Be    //td[3 and text()="${username}"]/following-sibling::td[2]/select    ${newrole}
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1

Verify Search User
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${searchText}    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Search User    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${searchText}
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1

Verify Change Root Password
    [Arguments]    ${userName}    ${password}    ${caseid}
    Run Keyword If    "${caseid}" != "Blank"    Log    Running case-${caseid}
    Change Root Password    ${password}
    Sleep    2
    Login Success    ${userName}    ${password}    Blank
    Run Keyword If    "${caseid}" != "Blank"    Log    Done-${caseid}
    Sleep    1
