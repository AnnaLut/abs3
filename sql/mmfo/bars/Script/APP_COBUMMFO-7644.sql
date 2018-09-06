exec bc.subst_branch('/');
declare
    l_app_code varchar2(10 char) := '$RM_F601';
    l_app_name varchar2(300 char) := 'ÀÐÌ "ÔÎÐÌÀ 601"';
    l_appid number(5);
    l_funcname1 varchar2(250 Byte) := '/barsroot/F601/F601Delta/Index';
    l_name1 varchar2(250 Byte) := 'Äåëüòà äàíèõ';
    l_main_oper_code1 number;
    v_is_exist number;  
begin  
   bc.set_context;
    update applist
    set name = l_app_name,
        frontend = 1
    where codeapp = l_app_code;
     
    if (sql%rowcount = 0) then 
            begin
            insert into applist(codeapp, name, frontend) values (l_app_code, l_app_name, 1);
            commit;
            end;
    end if;    
    
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
    
    begin
          insert into operapp(codeapp,codeoper,approve,grantor)
          values (l_app_code, l_main_oper_code1, 1, 1);
    exception  when dup_val_on_index then
         null;          
    end;
    
end;
/
commit;
/