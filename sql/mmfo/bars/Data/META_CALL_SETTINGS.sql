prompt ... 


begin
    execute immediate 'Insert into BARS.META_CALL_SETTINGS
   (ID, CODE, INSERT_AFTER, EDIT_MODE, SUMM_VISIBLE, 
    ADD_WITH_WINDOW, SWITCH_OF_DEPS, SHOW_COUNT, SAVE_COLUMN, CODEAPP)
 Values
   (2, ''$RM_W_CP_SaveColumns2'', 0, ''ROW_EDIT'', 0, 
    0, 0, 0, ''BY_DEFAULT'', ''$RM_W_CP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

