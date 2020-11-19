*** Keywords ***
Add New Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}
    Sleep    2
    ${action}    Set Variable If    "${action}" == "Reset To Default"    Reset    ${action}
    Task Should Exist    ${taskName}    ${taskDesc}    ${action}    ${recurrence}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Add New Task_2
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${minOrDay}    ${endDate}
    ...    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Task_2    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${minOrDay}    ${endDate}
    Sleep    2
    ${action}    Set Variable If    "${action}" == "Reset To Default"    Reset    ${action}
    Task Should Exist    ${taskName}    ${taskDesc}    ${action}    ${recurrence}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Add New Task_3
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${url}    ${recurrence}    ${endDate}
    ...    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Task_3    ${taskName}    ${taskDesc}    ${action}    ${url}    ${recurrence}    ${endDate}
    Sleep    2
    ${action}    Set Variable If    "${action}" == "Set Screen Saver"    Set Screensaver    ${action}
    Task Should Exist    ${taskName}    ${taskDesc}    ${action}    ${recurrence}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Add New Task_Setting
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${items}    ${recurrence}    ${endDate}
    ...    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Task_Setting    ${taskName}    ${taskDesc}    ${action}    ${items}    ${recurrence}    ${endDate}
    Sleep    2
    Task Should Exist    ${taskName}    ${taskDesc}    ${action}    ${recurrence}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Task Info In Edit Window
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Task And Open Edit Window    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}
    Sleep    2
    Task Should Be Equal    ${taskName}    ${taskDesc}    ${action}    ${recurrence}
    Click Close Button
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Edit Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${taskNameNew}
    ...    ${taskDescNew}    ${actionNew}    ${recurrenceNew}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add And Edit Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${taskNameNew}
    ...    ${taskDescNew}    ${actionNew}    ${recurrenceNew}
    Sleep    2
    Task Should Not Exist    ${taskName}    ${taskDesc}    ${action}    ${recurrence}
    Task Should Exist    ${taskNameNew}    ${taskDescNew}    ${actionNew}    ${recurrenceNew}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Delete Tasks
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${deleteTaskButton}
    ...    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add And Delete Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    Blank    ${deleteTaskButton}
    Sleep    2
    Task Should Not Exist    ${taskName}    ${taskDesc}    ${action}    ${recurrence}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Search Tasks
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${searchText}
    ...    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add And Search Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    Blank    ${searchText}
    Sleep    2
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Add Receivers To Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${receivers}
    ...    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Receivers To Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${receivers}
    Sleep    2
    Task Should Contain Receivers    ${receivers}
    Comment    Diselect Receivers and Tasks
    Select Receivers    ${receivers}
    Select Tasks    ${taskName}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Remove Receivers From Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${receivers}
    ...    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Remove Receivers From Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${receivers}
    Sleep    5
    Task Should Not Contain Receivers    ${receivers}
    Comment    Diselect Tasks
    Select Tasks    ${taskName}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Add Duplicate Task
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Add Duplicate Task    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}
    Sleep    2
    Get Right Corner Alert    The record with '${taskName}' of 'Name' already exist
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Invalid Task Name
    [Arguments]    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Invalidate Task Name    ${taskName}    ${taskDesc}    ${action}    ${recurrence}    ${endDate}
    Sleep    2
    Click Close Button
    Sleep    2
    Task Should Not Exist    ${taskName}    ${taskDesc}    ${action}    ${recurrence}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Add Task Is Not Available
    [Arguments]    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Open Add Schedule Task Window
    Sleep    2
    Should Contain Schedule Task Window Alert
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Delete Task Is Not Available
    [Arguments]    ${taskName}    ${deleteTaskButton}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Click Scheduler Panel
    Sleep    2
    Select Tasks    ${taskName}
    Sleep    2
    Run Keyword If    "${deleteTaskButton}" == "Right Click"    Right Click Delete Task Should Be Grayed Out    ${taskName}
    Run Keyword If    "${deleteTaskButton}" != "Right Click"    Click Delete Task
    Sleep    1
    Run Keyword If    "${deleteTaskButton}" != "Right Click"    Get Right Corner Alert    Please select one or more task(s)
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Edit Task Is Not Available
    [Arguments]    ${taskName}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Click Scheduler Panel
    Sleep    2
    Select Tasks    ${taskName}
    Sleep    2
    Right Click Edit Task Should Be Grayed Out    ${taskName}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Add Receivers To Task Is Not Available
    [Arguments]    ${taskName}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Click Scheduler Panel
    Sleep    2
    Select Tasks    ${taskName}
    Sleep    2
    Right Click Add Receivers Should Be Grayed Out    ${taskName}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1

Verify Remove Receivers From Task Is Not Available
    [Arguments]    ${taskName}    ${caseid}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Running case-${caseid}
    Click Scheduler Panel
    Sleep    2
    Select Tasks    ${taskName}
    Sleep    2
    Right Click Remove Receivers Should Be Grayed Out    ${taskName}
    Run Keyword If    '${caseid}' != 'Blank'    Log    Done-${caseid}
    Sleep    1
