declare
    l_app_code varchar2(10 char) := 'MSFZ';
    l_app_name varchar2(300 char) := 'АРМ-PRVN (WEB)';
    l_funcname varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=V_MSFZ9[NSIFUNCTION][showDialogWindow=>false]';
    l_name varchar2(250 Byte) := 'MSFZ9. КП ЮО. Розподіл складних КД на прості.';
    l_main_oper_code number;
    v_is_exist number;   
    l_user_code number; 
procedure add_func_app(p_app_code varchar2, p_main_oper_code number, p_approve number, p_grantor number) is
begin
     insert into operapp(CODEAPP,CODEOPER,APPROVE,GRANTOR) values
     (p_app_code, p_main_oper_code, p_approve, p_grantor);
exception when DUP_VAL_ON_INDEX then NULL;
end;
procedure add_usr_app(p_app_code varchar2, p_user_code number, p_approve number, p_grantor number) is
begin
     insert into applist_staff(ID,CODEAPP,APPROVE,GRANTOR) values
     (p_user_code, p_app_code,  p_approve, p_grantor);
exception when DUP_VAL_ON_INDEX then NULL;
end;
begin  
   --bc.set_context;
    update applist
    set name = l_app_name,
        frontend = 1
    where codeapp = l_app_code;
     
    if (sql%rowcount = 0) then begin
            insert into applist (codeapp, name, frontend)
            values (l_app_code, l_app_name, 1);
            exception  when dup_val_on_index then    null;
        end;            
    end if;    
    
    
    select count(*) into v_is_exist from operlist where funcname = l_funcname;
    IF v_is_exist = 0 THEN
        l_main_oper_code := abs_utils.add_func(
                              p_name        => l_name,
                              p_funcname    => l_funcname,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code from operlist where funcname = l_funcname and rownum = 1;
        update operlist set funcname = l_funcname where codeoper = l_main_oper_code;
    END IF;
    add_func_app(l_app_code, l_main_oper_code, 1, 1);
       
    
    select s.id into l_user_code from staff$base s where  s.logname = 'ABSADM';
    add_usr_app(l_app_code, l_user_code, 1, 1);
    
end;
/
commit;

