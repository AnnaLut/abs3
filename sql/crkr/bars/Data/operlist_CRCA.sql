set define off
begin
    execute immediate 'insert into APPLIST(CODEAPP,
                    NAME,
                    HOTKEY,
                    FRONTEND)
values (''CRCA'',
''АРМ «Адміністратор ЦРКР»'',
null,
1
)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Адміністрування користувачів',
        p_funcname =>  '/barsroot/admin/admu/index/',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCA', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/

declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Підтвердження виконання операцій',
        p_funcname =>  '/barsroot/admin/confirm/index',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCA', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/
