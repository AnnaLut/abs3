begin
Insert into BARS.operapp
   (CODEAPP, CODEOPER, APPROVE, REVOKED, GRANTOR)
 Values
   ('$RM_F601', 3381, 1, 0, 1);
COMMIT;
exception when others then null;
end;
/

declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_F601';
    l_name     operlist.name%type := 'Формування звітів';
    l_funcname operlist.funcname%type := '/barsroot/dwh/report/index?moduleId='||l_codearm;

begin 

    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

end;
/


begin
Insert into BARS.DWH_REPORT_LINKS
   (REPORT_ID, MODULE_ID)
 Values
   (6005, '$RM_F601');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.DWH_REPORT_LINKS
   (REPORT_ID, MODULE_ID)
 Values
   (6006, '$RM_F601');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.DWH_REPORT_LINKS
   (REPORT_ID, MODULE_ID)
 Values
   (6007, '$RM_F601');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.DWH_REPORT_LINKS
   (REPORT_ID, MODULE_ID)
 Values
   (6009, '$RM_F601');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.DWH_REPORT_LINKS
   (REPORT_ID, MODULE_ID)
 Values
   (6010, '$RM_F601');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.DWH_REPORT_LINKS
   (REPORT_ID, MODULE_ID)
 Values
   (6011, '$RM_F601');
COMMIT;
exception when others then null;
end;
/