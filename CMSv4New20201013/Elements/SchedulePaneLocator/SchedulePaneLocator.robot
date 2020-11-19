*** Variables ***
${addTaskButtonL}    //button[text()="Schedule Task"]
${firstTaskL}     //table[@id="scheduler-table"]/tbody/tr[1]
${generalTabL}    //li[@class="nav-item "]/div[text()="General"]
${actionsTabL}    //li[@class="nav-item "]/div[text()="Actions"]
${triggerTabL}    //li[@class="nav-item "]/div[text()="Trigger"]
${taskNameInputL}    //input[@id="textInput-Name"]
${taskDescInputL}    //input[@id="textInput-Description"]
${taskNameTipL}    //input[@id="textInput-Name"]/following-sibling::div[1]
${taskDescInputL}    //input[@id="textInput-Description"]
${actionsDropdownListL}    //label[text()="Actions"]/following-sibling::select[1]
${actionsDropdownListTipL}    //label[text()="Actions"]/following-sibling::select[1]/div[1]
${RecurrenceDropdownListL}    //label[text()="Recurrence"]/following-sibling::select[1]
${endDateCheckboxL}    //label[@for="checkboxTypeEndDate"]
${minuteAmountL}    //label[text()="Minutes"]/following-sibling::select
${dayIntervalL}    //input[@id="textInput-DaysInBetweenRuns"]
${dayOfMonthL}    //input[@id="textInput-TheDayOfMonth"]
${urlInputL}      //input[@id="downloadUrl"]
${languageCheckboxL}    //label[@for="LanguageCheckbox"]
${editTaskButtonL}    //div[@class="context-menu-item" and text()="Edit Task"]
${deleteTaskButtonL}    //div[@class="context-menu-item" and text()="Delete Task"]
${addReceiversButtonL}    //div[@class="context-menu-item" and text()="Add Receivers"]
${removeReceiversButtonL}    //div[@class="context-menu-item" and text()="Remove Receivers"]
${languageCheckboxL}    //label[@for="LanguageCheckbox"]
${grayEditTaskButtonL}    //div[@class="context-disabled context-menu-item" and text()="Edit Task"]
${grayDeleteTaskButtonL}    //div[@class="context-disabled context-menu-item" and text()="Delete Task"]
${grayAddReceiversButtonL}    //div[@class="context-disabled context-menu-item" and text()="Add Receivers"]
${grayRemoveReceiversButtonL}    //div[@class="context-disabled context-menu-item" and text()="Remove Receivers"]
${deleteTask2ButtonL}    //div/button[text()="Delete Task"]
${ScheduleTaskWindowAlert}    //div[@class="modal-body"]/p[text()="User must be admin of at least one site to schedule a Task."]
