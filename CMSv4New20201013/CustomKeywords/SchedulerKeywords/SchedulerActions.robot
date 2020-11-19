*** Settings ***
Resource          ..\\..\\Elements\\SchedulePaneLocator\\SchedulePaneLocator.robot

*** Keywords ***
Click Add Task
    Click Element    ${addTaskButtonL}

Click General Tab
    Click Element    ${generalTabL}

Click Actions Tab
    Click Element    ${actionsTabL}

Click Trigger Tab
    Click Element    ${triggerTabL}

Enter Task Name
    [Arguments]    ${taskName}
    SeleniumLibrary.Input Text    ${taskNameInputL}    ${taskName}

Enter Task Description
    [Arguments]    ${taskDesc}
    SeleniumLibrary.Input Text    ${taskDescInputL}    ${taskDesc}

Select Task Actions
    [Arguments]    ${action}
    Select From List By Label    ${actionsDropdownListL}    ${action}

Select Recurrence
    [Arguments]    ${recurrence}
    Select From List By Label    ${RecurrenceDropdownListL}    ${recurrence}

Select Date And Time
    [Arguments]    ${date_type}    ${date}    ${time}
    Wait Until Keyword Succeeds    3    1    Click Element    //label[text()="${date_type}"]/following-sibling::div[1]/div[1]/div[1]/input
    # Select Date
    Comment    Click Element    //div[//@aria-label and text()="${date}"]
    # Select Time
    Click Element    //li[text()="${time}"]

Task Should Exist
    [Arguments]    ${taskname}    ${description}    ${action}    ${recurrence}
    Run Keyword If    "${description}" == "Blank"    Page Should Contain Element    //tr[(td[2] //text()="${taskname}") and (td[3] //text()="${recurrence}") and (td[7] //text()="${action}")]
    Run Keyword If    "${description}" != "Blank"    Page Should Contain Element    //tr[(td[2] //text()="${taskname}") and (td[3] //text()="${recurrence}") and (td[7] //text()="${action}") and (td[9] //text()="${description}")]

Click End Date Checkbox
    Click Element    ${endDateCheckboxL}

Select End Date
    [Arguments]    ${day}    ${time}
    Click End Date Checkbox
    Select Date and Time    End Date    ${day}    ${time}

Select Minutes
    [Arguments]    ${min_amount}
    Select From List By Label    ${minuteAmountL}    ${min_amount}

Enter Days Between Runs
    [Arguments]    ${interval}
    SeleniumLibrary.Input Text    ${dayIntervalL}    ${interval}

Select Days Of The Week
    [Arguments]    ${days}
    @{daylist}    Evaluate    "${days}".split(",")
    : FOR    ${day}    IN    @{daylist}
    \    Click Element    //label[@for="checkboxType${day}"]

Enter The Day Of Each Month
    [Arguments]    ${day}
    SeleniumLibrary.Input Text    ${dayOfMonthL}    ${day}

Enter URL
    [Arguments]    ${url}
    SeleniumLibrary.Input Text    ${urlInputL}    ${url}

Click Language Checkbox
    Click Element    ${languageCheckboxL}

Select Tasks
    [Arguments]    ${tasks}
    @{tasksList}    Evaluate    "${tasks}".split(",")
    : FOR    ${taskname}    IN    @{tasksList}
    \    Wait Until Keyword Succeeds    3    1    Click Element    //table[@id="scheduler-table"]/tbody/tr[td[2 and text()="${taskname}"]]
    Comment    Run Keyword If    '${browser}' == 'chrome'    Wait Until Keyword Succeeds    3    1    Click Element
    ...    //table[@id="scheduler-table"]/tbody/tr[td[2 and text()="${taskname}"]]
    Comment    Run Keyword If    '${browser}' == 'firefox'    Wait Until Keyword Succeeds    3    1    Click Element
    ...    //table[@id="scheduler-table"]/tbody/tr[td[2 and text()="${taskname}"]]

Click Edit Task
    Click Element    ${editTaskButtonL}

Right Click On Task
    [Arguments]    ${task}
    Wait Until Keyword Succeeds    3    1    Right Click Element    //td[text()="${task}"]/..

Open Edit Task Window
    [Arguments]    ${task}
    Select Tasks    ${task}
    Log    ------------------------------------Edit Task--------------------
    Sleep    1
    Right Click On Task    ${task}
    Click Edit Task

Get Task Name
    ${taskName}    SeleniumLibrary.Get Value    ${taskNameInputL}
    [Return]    ${taskName}

Get Task Description
    ${taskDesc}    SeleniumLibrary.Get Value    ${taskDescInputL}
    [Return]    ${taskDesc}

Get Task Action
    ${action}    Get Selected List Label    ${actionsDropdownListL}
    [Return]    ${action}

Get Task Recurrence
    ${recurrence}    Get Selected List Label    ${RecurrenceDropdownListL}
    [Return]    ${recurrence}

Task Should Be Equal
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}
    Click General Tab
    ${taskNameTmp}    Get Task Name
    Should Be Equal    ${taskName}    ${taskNameTmp}
    ${taskDescTmp}    Get Task Description
    Should Be Equal    ${taskDesc}    ${taskDescTmp}
    Click Actions Tab
    Sleep    2
    ${actionTmp}    Get Task Action
    Should Be Equal    ${action}    ${actionTmp}
    Click Trigger Tab
    Sleep    2
    ${recurrenceTmp}    Get Task Recurrence
    Should Be Equal    ${recurrence}    ${recurrenceTmp}
    [Return]    ${recurrence}

Task Should Not Exist
    [Arguments]    ${taskname}    ${description}    ${action}    ${recurrence}
    Run Keyword If    "${description}" == "Blank"    Page Should Not Contain Element    //tr[(td[2] //text()="${taskname}") and (td[3] //text()="${recurrence}") and (td[7] //text()="${action}")]
    Run Keyword If    "${description}" != "Blank"    Page Should Not Contain Element    //tr[(td[2] //text()="${taskname}") and (td[3] //text()="${recurrence}") and (td[7] //text()="${action}") and (td[9] //text()="${description}")]

Click Delete Task In The Menu
    Click Element    ${deleteTaskButtonL}

Click Add Receivers
    Click Element    ${addReceiversButtonL}

Click Remove Receivers
    Click Element    ${removeReceiversButtonL}

Click Delete Task
    Click Element    ${deleteTask2ButtonL}

Right Click Delete Task
    [Arguments]    ${taskName}
    Right Click On Task    ${taskName}
    Sleep    2
    Click Delete Task In The Menu

Search Task
    [Arguments]    ${searchText}
    Enter Search Box    ${searchText}
    Sleep    5
    Verify Search Result    ${searchText}    scheduler-table
    Sleep    1
    Clear Search Box

Select Task And Add Receivers
    [Arguments]    ${taskName}
    Select Tasks    ${taskName}
    Right Click On Task    ${taskName}
    Sleep    2
    Click Add Receivers
    Sleep    1
    Get Right Corner Alert    Successfully joined receiver(s) to Task.

Task Should Contain Receivers
    [Arguments]    ${receivers}
    @{receiverList}    Evaluate    "${receivers}".split(",")
    : FOR    ${receiver}    IN    @{receiverList}
    \    Page Should Contain Element    //table[@id="receiver-table"]/tbody/tr[td[1][text()="${receiver}"]]

Task Should Not Contain Receivers
    [Arguments]    ${receivers}
    @{receiverList}    Evaluate    "${receivers}".split(",")
    : FOR    ${receiver}    IN    @{receiverList}
    \    Page Should Not Contain Element    //table[@id="receiver-table"]/tbody/tr[td[1][text()="${receiver}"]]

Select Task And Remove Receivers
    [Arguments]    ${taskName}
    Select Tasks    ${taskName}
    Right Click On Task    ${taskName}
    Sleep    2
    Click Remove Receivers
    Sleep    1
    Get Right Corner Alert    Successfully released selected receiver(s) from Task.

Get Task Name Tip
    ${taskNameTip}    SeleniumLibrary.Get Value    ${taskNameTipL}
    Should Be Equal    ${taskNameTip}    Name must be at least 4 characters.
    [Return]    ${taskNameTip}

Should Contain Schedule Task Window Alert
    Page Should Contain Element    ${ScheduleTaskWindowAlert}

Right Click Delete Task Should Be Grayed Out
    [Arguments]    ${taskName}
    Right Click On Task    ${taskName}
    Sleep    2
    Page Should Contain Element    ${grayDeleteTaskButtonL}

Right Click Edit Task Should Be Grayed Out
    [Arguments]    ${taskName}
    Right Click On Task    ${taskName}
    Sleep    2
    Page Should Contain Element    ${grayEditTaskButtonL}

Right Click Add Receivers Should Be Grayed Out
    [Arguments]    ${taskName}
    Right Click On Task    ${taskName}
    Sleep    2
    Page Should Contain Element    ${grayAddReceiversButtonL}

Right Click Remove Receivers Should Be Grayed Out
    [Arguments]    ${taskName}
    Right Click On Task    ${taskName}
    Sleep    2
    Page Should Contain Element    ${grayRemoveReceiversButtonL}

Delete The First Task
    Click Element    ${firstTaskL}
    Sleep    1
    Click Proceed
