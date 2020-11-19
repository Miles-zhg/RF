*** Settings ***
Resource          ..\\Elements\\Common\\CommonVariables.txt
Resource          ..\\Elements\\Common\\GlobalLocator.robot

*** Keywords ***
Open Url
    [Arguments]    ${url}=${url}    ${browser}=chrome
    Open Browser    ${url}    ${browser}    options=add_argument("--disable-popup-blocking"); add_argument("--ignore-certificate-errors")
    Maximize Browser Window

Click Proceed
    Wait Until Keyword Succeeds    3    1    Click Element    ${proceedButton}

Get Right Corner Alert
    [Arguments]    ${message}
    Wait Until Page Contains Element    ${rightCornerAlertL}
    ${alert}    SeleniumLibrary.Get Text    ${rightCornerAlertL}
    Should Contain    ${alert}    ${message}

Click Close Button
    Click Element    ${closeButtonL}

Click Cancel
    Click Element    ${cancelButtonL}

Click Delete Icon
    [Arguments]    ${username}
    Click Element    //td[3 and text()="${username}"]/following-sibling::td[3]/i[text()="delete"]

Get CMS Window
    [Arguments]    ${windowName}
    Page Should Contain Element    //div[@role="dialog"]/div/h5[@class="modal-title" and text()="${windowName}"]

Get Current Role
    [Arguments]    ${username}
    ${role}    SeleniumLibrary.Get Value    //td[3 and text()="${username}"]/following-sibling::td[2]/select
    [Return]    ${role}

Enter Search Box
    [Arguments]    ${search_text}
    SeleniumLibrary.Input Text    ${searchBoxL}    ${search_text}

Verify Search Result
    [Arguments]    ${search_text}    ${table_name}
    ${rowlength}    Execute Javascript    return document.querySelector("#${table_name} > tbody").rows.length
    : FOR    ${row}    IN RANGE    ${rowlength}
    \    ${row_n}    Evaluate    1 + ${row}
    \    Comment    Element Should Contain    //*[@id="user-table"]/tbody/tr[${row_n}]    ${search_text}    ignore_case=True
    \    Element Should Contain    //*[@id="${table_name}"]/tbody/tr[${row_n}]    ${search_text}    ignore_case=True

Clear Search Box
    Comment    SeleniumLibrary.Clear Element Text    ${searchBoxL}
    ${searchValue}    Get Search Box
    ${length}    Evaluate    len("${searchValue}")
    Repeat Keyword    ${length} times    Press Keys    ${searchBoxL}    \ue003

Get Search Box
    ${searchValue}    SeleniumLibrary.Get Value    ${searchBoxL}
    [Return]    ${searchValue}

Get Date And Time
    ${day}    ${hour}    ${min} =    Get Time    day,hour,min
    ${day}    Evaluate    "${day}".lstrip("0")
    ${min}    Evaluate    "${min}".lstrip("0")
    ${hour}    Evaluate    "${hour}".lstrip("0")
    ${min_tmp}    Evaluate    (${min} + 10) // 5 * 5
    ${min}    Set Variable If    ${min_tmp} >= 60    00    ${min_tmp}
    ${hour_tmp}    Run Keyword If    ${min_tmp} >= 60    Evaluate    ${hour} + 1
    ${hour}    Set Variable If    ${min_tmp} >= 60    ${hour_tmp}    ${hour}
    ${hour}    Set Variable If    ${hour_tmp} == 24    12    ${hour}
    ${end_min_tmp}    Evaluate    ${min} + 10
    ${end_min}    Set Variable If    ${end_min_tmp} > 59    00    ${end_min_tmp}
    ${hour_12} =    Set Variable    0
    ${hour_12}    Run Keyword If    ${hour} >=13    Evaluate    ${hour} - 12
    ${time}    Set Variable If    ${hour} < 13    ${hour}:${min} AM    ${hour_12}:${min} PM
    ${end_time}    Set Variable If    ${hour} < 13    ${hour}:${end_min} AM    ${hour_12}:${end_min} PM
    [Return]    ${day}    ${time}    ${end_time}    # Return current day and the first or second available start and end time

Select Receivers
    [Arguments]    ${receivers}
    @{receiverList}    Evaluate    "${receivers}".split(",")
    : FOR    ${receiver}    IN    @{receiverList}
    \    Wait Until Page Contains Element    //table[@id="receiver-table"]/tbody/tr[td[1 and text()="${receiver}"]]
    \    Click Element    //table[@id="receiver-table"]/tbody/tr[td[1 and text()="${receiver}"]]    CTRL

Should Not Contain CMS Window
    [Arguments]    ${windowName}
    Page Should Not Contain Element    //div[@role="dialog"]/div/h5[@class="modal-title" and text()="${windowName}"]

Should Contain Exported File
    [Arguments]    ${fileName}
    ${userprofile}    Run    echo %USERPROFILE%
    ${userprofile}    Evaluate    "${userprofile}".strip()
    File Should Exist    ${userprofile}\\Downloads\\${fileName}

Clear All Exported File
    ${userprofile}    Run    echo %USERPROFILE%
    ${userprofile}    Evaluate    "${userprofile}".strip()
    Run    del /q ${userprofile}\\Downloads\\ReceiverTable*.csv ReceiverLogsTable*.csv chedulerLogsTable*.csv

Get Table Length
    [Arguments]    ${tableName}
    ${tableLength}    Execute Javascript    return document.querySelector("#${table_name} > tbody").rows.length
    [Return]    ${tableLength}

Click The First Delete Icon
    Click Element    //td/i[text()="delete"]
    Click Proceed
