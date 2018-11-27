prompt ... 


begin
    execute immediate 'Insert into BARS.META_CALL_SETTINGS
   (ID, CODE, CALL_FROM, WEB_FORM_NAME, INSERT_AFTER, 
    EDIT_MODE, SUMM_VISIBLE, ADD_WITH_WINDOW, SWITCH_OF_DEPS, SHOW_COUNT)
 Values
   (12, ''UPLOAD_EXCEL_NBUR_OVDP_6EX'', ''FREE'', ''[CUSTOM_OPTIONS_TO_CLASS=>CallFunctionMetaInfo]'', 0, 
    ''ROW_EDIT'', 0, 0, 0, 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;
