begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/kfiles/kfiles/index');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/kfiles/kfiles/adminca');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/kfiles/kfiles/AccountCorp');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_OB_CORP_L1[CONDITIONS=>V_OB_CORP_L1.PARENT_ID IS NULL][showDialogWindow=>false]');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=V_OB_CORP[CONDITIONS=>PARENT_ID IS NULL][NSIFUNCTION][showDialogWindow=>false]');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=5'||chr(38)||'sPar=OB_CORPORATION_NBS_REPORT_GRC');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=5'||chr(38)||'sPar=OB_CORPORATION_NBS_REPORT');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>kfile_pack.KFILE_SEND(:Param0,:Param1)][PAR=>:Param0(SEM=Дата(ДДММГГГГ),TYPE=C),:Param1(SEM=Код корпоррації(%-всі),TYPE=C)][QST=>Виконати?][MSG=>ОК!]');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>kfile_pack.kfile_get_dict][QST=>Виконати?][MSG=>Довідник оновлено.]');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=V_CUSTOMER_CORPORATIONS');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=RNKP_KOD[showDialogWindow=>false]');
end;
/
begin
USER_MENU_UTL.REMOVE_FUNCTION('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_OB_CORP_SALDO_DOCS[CONDITIONS=>IS_LAST = 1][showDialogWindow=>false]');
end;
/
begin
USER_MENU_UTL.REMOVE_REF_FROM_ARM_BYTABNAME('V_ROOT_CORPORATION', '$RM_CRPC', 1);
end;
/
begin
USER_MENU_UTL.REMOVE_REF_FROM_ARM_BYTABNAME('V_ROOT_CORPORATION', '$RM_WCRC', 1);
end;
/
commit;
/
