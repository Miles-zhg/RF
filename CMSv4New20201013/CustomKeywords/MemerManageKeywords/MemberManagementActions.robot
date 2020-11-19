*** Settings ***
Resource          ..\\..\\Elements\\Common\\MemberManagementLocator.robot

*** Keywords ***
Click Add New Member
    Click Element    ${addMemberButtonL}

Enter FirstName
    [Arguments]    ${firstname}
    Run Keyword If    "${firstname}" != "Blank"    SeleniumLibrary.Input Text    ${firstNameTextboxL}    ${firstname}

Enter LastName
    [Arguments]    ${lastname}
    Run Keyword If    "${lastname}" != "Blank"    SeleniumLibrary.Input Text    ${lastNameTextboxL}    ${lastname}

Enter UserName
    [Arguments]    ${username}
    Run Keyword If    "${username}" != "Blank"    SeleniumLibrary.Input Text    ${userNameTextboxL}    ${username}

Enter Email
    [Arguments]    ${email}
    Run Keyword If    "${email}" != "Blank"    SeleniumLibrary.Input Text    ${emailTextboxL}    ${email}

Enter Password
    [Arguments]    ${password}
    Run Keyword If    "${password}" != "Blank"    SeleniumLibrary.Input Text    ${passwordTextboxL}    ${password}

Enter Re-Password
    [Arguments]    ${re-password}
    Run Keyword If    "${re-password}" != "Blank"    SeleniumLibrary.Input Text    ${retypePasswordTextboxL}    ${re-password}

Enter UserInfo
    [Arguments]    ${firstname}    ${lastname}    ${username}    ${emial}    ${password}    ${repassword}
    Enter FirstName    ${firstname}
    Enter LastName    ${lastname}
    Enter Username    ${username}
    Enter Email    ${emial}
    Enter Password    ${password}
    Enter Re-Password    ${repassword}

New User Exists
    [Arguments]    ${newUserL}
    Comment    ${newUserL}    Get WebElement    ${newUserL}
    Comment    Wait Until Page Contains Element    ${newUserL}
    Page Should Contain Element    ${newUserL}

Get FirstName Context Help
    ${contexthelp}    SeleniumLibrary.Get Text    ${firstNameContextHelpL}
    [Return]    ${contexthelp}

Get LastName Context Help
    ${contexthelp}    SeleniumLibrary.Get Text    ${lastNameContextHelpL}
    [Return]    ${contexthelp}

Get UserName Context Help
    ${contexthelp}    SeleniumLibrary.Get Text    ${userNameContextHelpL}
    [Return]    ${contexthelp}

Get Email Context Help
    ${contexthelp}    SeleniumLibrary.Get Text    ${emailContextHelpL}
    [Return]    ${contexthelp}

Get Password Context Help
    ${contexthelp}    SeleniumLibrary.Get Text    ${passwordContextHelpL}
    [Return]    ${contexthelp}

Get RePassword Context Help
    ${contexthelp}    SeleniumLibrary.Get Text    ${retypePasswordContextHelpL}
    [Return]    ${contexthelp}

New User Not Exist
    [Arguments]    ${newUserL}
    Page Should Not Contain Element    ${newUserL}

Click Edit Icon
    [Arguments]    ${username}
    Click Element    //td[3 and text()="${username}"]/following-sibling::td[3]/i[text()="edit"]

Get FirstName Textbox
    ${text}    SeleniumLibrary.Get Value    ${firstNameTextboxL}
    [Return]    ${text}

Get LastName Textbox
    ${text}    SeleniumLibrary.Get Value    ${lastNameTextboxL}
    [Return]    ${text}

Get UserName Textbox
    ${text}    SeleniumLibrary.Get Value    ${userNameTextboxL}
    [Return]    ${text}

Get Email Textbox
    ${text}    SeleniumLibrary.Get Value    ${emailTextboxL}
    [Return]    ${text}

Get Original UserInfo
    [Arguments]    ${username}
    ${firstname}    SeleniumLibrary.Get Text    //td[3][text()="${username}"]/preceding-sibling::td[2]
    ${lastname}    SeleniumLibrary.Get Text    //td[3][text()="${username}"]/preceding-sibling::td[1]
    ${email}    SeleniumLibrary.Get Text    //td[3][text()="${username}"]/following-sibling::td[1]
    [Return]    ${firstname}    ${lastname}    ${email}

Click Password Checkbox
    Click Element    ${passwordCheckboxL}

Set To SysAdmin
    [Arguments]    ${username}
    Wait Until Page Contains Element    //td[3 and text()="${username}"]/following-sibling::td[2]/select
    Select From List By Value    //td[3 and text()="${username}"]/following-sibling::td[2]/select    CMSSystemAdmin

Set To CMSuser
    [Arguments]    ${username}
    Wait Until Page Contains Element    //td[3 and text()="${username}"]/following-sibling::td[2]/select
    Select From List By Value    //td[3 and text()="${username}"]/following-sibling::td[2]/select    NonCMSSystemAdmin
