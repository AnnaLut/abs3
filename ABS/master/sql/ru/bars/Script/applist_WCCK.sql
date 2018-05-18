declare
    l_app_code varchar2(10 char) := 'WCCK';
    l_app_name varchar2(300 char) := 'ÀÐÌ Êðåäèòè ÔÎ (WEB)';
    l_funcname varchar2(4000) := '/barsroot/CreditUi/NewCredit/?custtype=3';
    l_name varchar2(250 Byte) := '1) Ââåäåííÿ íîâîãî ÊÄ ÔÎ';
    l_main_oper_code number;
    l_funcname1 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_NF'||'&'||'accessCode=1'||'&'||'sPar=[NSIFUNCTION][showDialogWindow=>false]';
    l_name1 varchar2(250 Byte) := '2) Ïîðòôåëü ÍÎÂÈÕ êðåäèò³â ÔÎ';
    l_main_oper_code1 number;
    l_funcname2 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_RF'||'&'||'accessCode=1'||'&'||'sPar=[NSIFUNCTION]';
    l_name2 varchar2(250 Byte) := '3) Ïîðòôåëü ÐÎÁÎ×ÈÕ êðåäèò³â ÔÎ';
    l_main_oper_code2 number;
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
    
    select count(*) into v_is_exist from operlist where funcname = l_funcname1;
    IF v_is_exist = 0 THEN
        l_main_oper_code1 := abs_utils.add_func(
                              p_name        => l_name1,
                              p_funcname    => l_funcname1,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code1 from operlist where funcname = l_funcname1 and rownum = 1;
        update operlist set funcname = l_funcname1 where codeoper = l_main_oper_code1;
    END IF;
    add_func_app(l_app_code, l_main_oper_code1, 1, 1);
    
        select count(*) into v_is_exist from operlist where funcname = l_funcname2;
    IF v_is_exist = 0 THEN
        l_main_oper_code2 := abs_utils.add_func(
                              p_name        => l_name2,
                              p_funcname    => l_funcname2,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code2 from operlist where funcname = l_funcname2 and rownum = 1;
        update operlist set funcname = l_funcname2 where codeoper = l_main_oper_code2;
    END IF;
    add_func_app(l_app_code, l_main_oper_code2, 1, 1);
     
    
    select s.id into l_user_code from staff$base s where  s.logname = 'ABSADM';
    add_usr_app(l_app_code, l_user_code, 1, 1);
    
end;
/
commit;

