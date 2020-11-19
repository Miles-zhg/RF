*** Keywords ***
Add Task_Com
    [Arguments]    ${taskName}    ${taskDesc}
    Click Scheduler Panel
    Click Add Task
    Sleep    1
    Get CMS Window    Schedule Task
    Click General Tab
    Run Keyword If    "${taskName}" != "Blank"    Enter Task Name    ${taskName}
    Run Keyword If    "${taskDesc}" != "Blank"    Enter Task Description    ${taskDesc}

Add Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}
    Add Task_Com    ${taskName}    ${taskDesc}
    Sleep    2
    Click Actions Tab
    Select Task Actions    ${action}
    Sleep    2
    Click Trigger Tab
    Select Recurrence    ${recurrence}
    ${day}    ${time}    ${end_time}    Get Date And Time
    Select Date and Time    Start Date    ${day}    ${time}
    Sleep    2
    Run Keyword If    '${endDate}' != 'Blank'    Select End Date    ${day}    ${end_time}
    Click Proceed

Add Task_2
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${minOrDay}    ${endDate}
    Add Task_Com    ${taskName}    ${taskDesc}
    Sleep    2
    Click Actions Tab
    Select Task Actions    ${action}
    Sleep    2
    Click Trigger Tab
    Select Recurrence    ${recurrence}
    ${day}    ${time}    ${end_time}    Get Date And Time
    Select Date and Time    Start Date    ${day}    ${time}
    Sleep    2
    Run Keyword If    "${recurrence}" == "Minutes" and "${minOrDay}" != "Blank"    Select Minutes    ${minOrDay}
    Run Keyword If    "${recurrence}" == "Daily" and "${minOrDay}" != "Blank"    Enter Days Between Runs    ${minOrDay}
    Run Keyword If    "${recurrence}" == "Weekly" and "${minOrDay}" != "Blank"    Select Days Of The Week    ${minOrDay}
    Run Keyword If    "${recurrence}" == "Monthly" and "${minOrDay}" != "Blank"    Enter The Day Of Each Month    ${minOrDay}
    Run Keyword If    '${endDate}' != 'Blank'    Select End Date    ${day}    ${end_time}
    Click Proceed

Add Task_3
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${url}    ${recurrence}    ${endDate}
    Add Task_Com    ${taskName}    ${taskDesc}
    Sleep    2
    Click Actions Tab
    Select Task Actions    ${action}
    Sleep    2
    Run Keyword If    "${action}" == "Update Firmware" or "${action}" == "Set Screen Saver" or "${action}" == "Set Background"    Enter URL    ${url}
    Sleep    2
    Click Trigger Tab
    Select Recurrence    ${recurrence}
    ${day}    ${time}    ${end_time}    Get Date And Time
    Select Date and Time    Start Date    ${day}    ${time}
    Sleep    2
    Run Keyword If    '${endDate}' != 'Blank'    Select End Date    ${day}    ${end_time}
    Click Proceed

Add Task_Setting
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${items}    ${recurrence}    ${endDate}
    Add Task_Com    ${taskName}    ${taskDesc}
    Sleep    2
    Click Actions Tab
    Select Task Actions    ${action}
    Sleep    2
    Run Keyword If    "${action}" == "Settings"    Click ${items} Checkbox
    Sleep    2
    Click Trigger Tab
    Select Recurrence    ${recurrence}
    ${day}    ${time}    ${end_time}    Get Date And Time
    Select Date and Time    Start Date    ${day}    ${time}
    Sleep    2
    Run Keyword If    '${endDate}' != 'Blank'    Select End Date    ${day}    ${end_time}
    Click Proceed

Add Task And Open Edit Window
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}
    Add Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    Blank
    Sleep    2
    Open Edit Task Window    ${taskName}

Add And Edit Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${taskNameNew}
    ...    ${taskDescNew}    ${actionNew}    ${recurrenceNew}
    Add Task And Open Edit Window    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    Blank
    Sleep    2
    Click General Tab
    Run Keyword If    "${taskNameNew}" != "Blank"    Enter Task Name    ${taskNameNew}
    Run Keyword If    "${taskDescNew}" != "Blank"    Enter Task Description    ${taskDescNew}
    Sleep    2
    Click Actions Tab
    Select Task Actions    ${actionNew}
    Sleep    2
    Click Trigger Tab
    Select Recurrence    ${recurrenceNew}
    ${day}    ${time}    ${end_time}    Get Date And Time
    Select Date and Time    Start Date    ${day}    ${time}
    Click Proceed

Delete Task via Right Click Menu
    [Arguments]    ${taskName}
    Select Tasks    ${taskName}
    Sleep    2
    Right Click On Task    ${taskName}
    Sleep    2
    Click Delete Task In The Menu
    Sleep    1
    Get CMS Window    Delete Task
    Click Proceed
    Sleep    1
    Get Right Corner Alert    Successfully deleted task(s).

Add And Delete Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${deleteTaskButton}
    Add New Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    Blank    Blank
    Delete Task    ${taskName}    ${deleteTaskButton}

Delete Task
    [Arguments]    ${taskName}    ${deleteTaskButton}
    Select Tasks    ${taskName}
    Sleep    2
    Run Keyword If    "${deleteTaskButton}" == "Right Click"    Right Click Delete Task    ${taskName}
    Run Keyword If    "${deleteTaskButton}" != "Right Click"    Click Delete Task
    Sleep    1
    Get CMS Window    Delete Task
    Click Proceed
    Sleep    1
    Get Right Corner Alert    Successfully deleted task(s).

Add And Search Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${searchText}
    Add New Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    Blank    Blank
    SearCh Task    ${searchText}

Add Receivers To Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${receivers}
    Add New Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    Blank    Blank
    Comment    Click Site    All Receivers
    Sleep    2
    Select Receivers    ${receivers}
    Sleep    2
    Select Task And Add Receivers    ${taskName}

Remove Receivers From Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${receivers}
    Verify Add Receivers To Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${receivers}
    ...    Blank
    Sleep    5
    Select Receivers    ${receivers}
    Sleep    2
    Select Task And Remove Receivers    ${taskName}

Add Duplicate Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}
    Add New Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    Blank
    Sleep    2
    Add Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}

Invalidate Task Name
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}
    Add Task_Com    ${taskName}    ${taskDesc}
    Sleep    2
    Click Actions Tab
    Select Task Actions    ${action}
    Sleep    2
    Click Trigger Tab
    Select Recurrence    ${recurrence}
    ${day}    ${time}    ${end_time}    Get Date And Time
    Select Date and Time    Start Date    ${day}    ${time}
    Sleep    2
    Run Keyword If    '${endDate}' != 'Blank'    Select End Date    ${day}    ${end_time}
    Click Proceed

Edit Task
    [Arguments]    ${taskName}    ${taskNameNew}    ${taskDescNew}    ${actionNew}    ${recurrenceNew}
    Click Scheduler Panel
    Sleep    2
    Select Tasks    ${taskName}
    Open Edit Task Window    ${taskName}
    Sleep    2
    Click General Tab
    Run Keyword If    "${taskNameNew}" != "Blank"    Enter Task Name    ${taskNameNew}
    Run Keyword If    "${taskDescNew}" != "Blank"    Enter Task Description    ${taskDescNew}
    Sleep    2
    Click Actions Tab
    Select Task Actions    ${actionNew}
    Sleep    2
    Click Trigger Tab
    Select Recurrence    ${recurrenceNew}
    ${day}    ${time}    ${end_time}    Get Date And Time
    Select Date and Time    Start Date    ${day}    ${time}
    Click Proceed

Open Add Schedule Task Window
    Click Scheduler Panel
    Click Add Task
    Sleep    1
    Get CMS Window    Schedule Task

Clear Schedule List
    Click Scheduler Panel
    Sleep    2
    ${taskNum}    Get Table Length    scheduler-table
    :FOR    ${rowNum}    IN RANGE    ${taskNum}
    \    ${rowNumTmp}    Evaluate    ${rowNum} + 1
    \    ${taskText}    Get Text    ${firstTaskL}/td[1]
    \    Run Keyword If    "${taskText}" != "No data available in table"    Delete The First Task
    \    Sleep    1
