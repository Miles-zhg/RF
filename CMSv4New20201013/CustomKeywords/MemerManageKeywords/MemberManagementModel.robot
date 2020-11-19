*** Keywords ***
Add New Member
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    Comment    Login    ${loginName}    ${loginPassword}
    Comment    Sleep    1
    Click Member Management Panel
    Sleep    1
    Click Add New Member
    Enter User info    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    Click Proceed

Invalidate FirstName
    ${contexthelp}    Get FirstName Context Help
    Should Be Equal    ${contexthelp}    Your First Name must be 2-20 characters, must contain only letters and numbers

Invalidate LastName
    ${contexthelp}    Get LastName Context Help
    Should Be Equal    ${contexthelp}    Your Last Name must be 2-20 characters, must contain only letters and numbers

Invalidate UserName
    ${contexthelp}    Get UserName Context Help
    Should Be Equal    ${contexthelp}    Your username must be 4-20 characters, must contain only letters and numbers

Invalidate Email
    ${contexthelp}    Get Email Context Help
    Should Be Equal    ${contexthelp}    Please enter a valid email.Your email must not longer than 128 characters

Invalidate Password
    ${contexthelp}    Get Password Context Help
    Should Be Equal    ${contexthelp}    Please provide a password that contains at least upper case letter, a lower case letter, a number, and one of the symbols '!', '@', '#', '$', '%', '^', '&', '*'

Invalidate Retype Password
    ${contexthelp}    Get RePassword Context Help
    Should Be Equal    ${contexthelp}    Please retype the same password

Cancel Adding New Member
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    Comment    Login    ${loginName}    ${loginPassword}
    Comment    Sleep    1
    Click Member Management Panel
    Sleep    1
    Click Add New Member
    Enter User info    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    Click Cancel

Delete Member
    [Arguments]    ${username}
    Click Delete Icon    ${username}
    Sleep    1
    Get CMS Window    Delete user
    Click Proceed

Update Member
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    Add Member Success    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    Blank
    Sleep    1
    ${original_firstname}    ${original_lastname}    ${original_email}    Get Original UserInfo    ${username}
    Click Edit Icon    ${username}
    sleep    1
    Get CMS Window    Edit User
    ${in_firstname}    Get Firstname Textbox
    ${in_lastname}    Get Lastname Textbox
    ${in_username}    Get Username Textbox
    ${in_email}    Get Email Textbox
    Should Be Equal    ${in_firstname}    ${original_firstname}
    Should Be Equal    ${in_lastname}    ${original_lastname}
    Should Be Equal    ${in_username}    ${username}
    Should Be Equal    ${in_email}    ${original_email}
    ${firstnameTmp}    ${lastnameTmp}    ${emailTmp}    Set Variable    ${firstname}Update    ${lastname}Update    ${email}Update
    Enter Firstname    ${firstnameTmp}
    Enter Lastname    ${lastnameTmp}
    Enter Email    ${emailTmp}
    Click Proceed
    [Return]    ${firstnameTmp}    ${lastnameTmp}    ${emailTmp}

Change User Password
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${newpassword}
    Add Member Success    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    Blank
    Sleep    1
    Click Edit Icon    ${username}
    sleep    1
    Get CMS Window    Edit User
    Click Password Checkbox
    Enter Password    ${newpassword}
    Enter Re-Password    ${newpassword}
    Click Proceed

Change User Role
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${role}
    Add Member Success    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    Blank
    Sleep    5
    ${roleTmp}    Get Current Role    ${username}
    Run Keyword If    "${role}" == "CMS User" or "${roleTmp}" == "CMSSystemAdmin"    Set To CMSuser    ${username}
    Sleep    1
    Run Keyword If    "${role}" == "CMS SysAdmin"    Set To SysAdmin    ${username}

Search User
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    ${searchText}
    Add Member Success    ${firstname}    ${lastname}    ${username}    ${email}    ${password}    ${repassword}
    ...    Blank
    Sleep    1
    Enter Search Box    ${searchText}
    Sleep    5
    Verify Search Result    ${searchText}    user-table
    Sleep    1
    Clear Search Box

Change Root Password
    [Arguments]    ${newPassword}
    Click Change Root Password Panel
    Sleep    2
    Get CMS Window    Edit User
    Sleep    2
    Enter Password    ${newPassword}
    Enter Re-Password    ${newPassword}
    Click Proceed
