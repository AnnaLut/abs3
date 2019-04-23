declare
l_max int;
begin 
  select max(id) into l_max from meta_call_settings;
         insert into meta_call_settings (ID, CODE, CALL_FROM, WEB_FORM_NAME, TABID, FUNCID, ACCESSCODE, SHOW_DIALOG, LINK_TYPE, INSERT_AFTER, EDIT_MODE, SUMM_VISIBLE, CONDITIONS, EXCEL_OPT, ADD_WITH_WINDOW, SWITCH_OF_DEPS, SHOW_COUNT, SAVE_COLUMN, CODEAPP, BASE_OPTIONS,CUSTOM_OPTIONS)
                                        values (l_max+1, 'V1_OVRN', 'FREE', 'V1_OVRN[CONDITIONS=>V1_OVRN.ND=:ND][showDialogWindow=>false]', null, null, null, null, null, 0, 'ROW_EDIT', 0, null, null, 0, 0, 0, null, null, null,null);
         exception when others then 
                        if sqlcode=-00001 then null;
                        end if;
commit;
end;
/