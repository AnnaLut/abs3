SET ESCAPE ON;
declare
    l_app_code varchar2(10 char) := 'OPFU';
    l_funcname varchar2(250 Byte);
    l_name varchar2(250 Byte);
    l_main_oper_code number;
    v_is_exist number;  
begin 
           
      /*Пункт меню Портфель ЕПП"*/
    l_funcname  := '/barsroot/pfu/pfu/registersandrecords';
    l_name  := 'ПФУ. Зміна статусів інформаційних рядків та реєстрів';
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
    begin
          insert into operapp(codeapp,codeoper,approve,grantor)
          values (l_app_code, l_main_oper_code, 1, 1);
    exception  when dup_val_on_index then
         null;         
    end;
                                          
end;
/

commit;
