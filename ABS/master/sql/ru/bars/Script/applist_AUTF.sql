declare
    l_app_code varchar2(10 char) := 'AUTF';
    l_app_name varchar2(300 char) := 'АРМ Автоматизованих операцій КП ФО (WEB)';
    l_funcname varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK_SBER(3,4)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ФО ?][MSG=>Перенесення виканано !]';
    l_name varchar2(250 Byte) := '#2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш. ФО';
    l_main_oper_code number;
    l_funcname1 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CC_ISG(-11,'||'SPN|SN '||')][QST=>Ви хочете зробити Авто разбір рахунків Кред-ої заборг-ті?][MSG=>Виконано !]';
    l_name1 varchar2(250 Byte) := 'КП F05_3: Авто разбір рах-ів ISG (3600) Кред-ої заборг-ті ФО (SPN,SN)';
    l_main_oper_code1 number;
    l_funcname2 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK.CC_ASP(-11,1)][QST=>Виконати Start/ Авто-просрочка рахунків боргу SS - ФО?][MSG=>Виконано!]';
    l_name2 varchar2(250 Byte) := 'Start/ Авто-просрочка рахунків боргу SS -  ФО';
    l_main_oper_code2 number;
    l_funcname3 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK_ASG_SBER (3)][QST=>Виконати розбір рахунків погашення?][MSG=>Розбір рахункiв виконано !]';
    l_name3 varchar2(250 Byte) := '#4) КП F0_3: Авто-разбiр рахункiв погашення SG ФО';
    l_main_oper_code3 number;
    l_funcname4 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK[NSIFUNCTION][ACCESSCODE=>2][PROC=>p_interest_cck1(11,:E)][PAR=>:E(SEM=Дата по,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]';
    l_name4 varchar2(250 Byte) := 'Нарахування відсотків ФО';
    l_main_oper_code4 number;
    l_funcname5 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>cc_close(3,bankdate)][QST=>Ви бажаєте виконати авто-закриття договорів ФО?][MSG=>Закриття виканано !]';
    l_name5 varchar2(250 Byte) := 'КП S8: Авто закриття договорів ФО';
    l_main_oper_code5 number;
    l_funcname6 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CC_RMANY(-11,bankdate,3)][QST=>Виконати амортизацію дисконту ФО?][MSG=>Готово!]';
    l_name6 varchar2(250 Byte) := 'Амортизація Дисконту/Премії ФО з ЕПС';
    l_main_oper_code6 number;
    l_funcname7 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>cck.CC_9129(bankdate,0,3)][QST=>Виконати "Вирівнювання залишків на 9129 по КП ФО?][MSG=>Виконано !]';
    l_name7 varchar2(250 Byte) := 'Вирівнювання залишків на 9129 по КП ФО';
    l_main_oper_code7 number;
    l_funcname8 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK_SBER('||'3'||','||'5'||')][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ФО ?][MSG=>Перенесення виканано !]';
    l_name8 varchar2(250 Byte) := 'КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ФО (Київ)';
    l_main_oper_code8 number;
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
    
        select count(*) into v_is_exist from operlist where funcname = l_funcname3;
    IF v_is_exist = 0 THEN
        l_main_oper_code3 := abs_utils.add_func(
                              p_name        => l_name3,
                              p_funcname    => l_funcname3,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code3 from operlist where funcname = l_funcname3 and rownum = 1;
        update operlist set funcname = l_funcname3 where codeoper = l_main_oper_code3;
    END IF;
    add_func_app(l_app_code, l_main_oper_code3, 1, 1);
    
        select count(*) into v_is_exist from operlist where funcname = l_funcname4;
    IF v_is_exist = 0 THEN
        l_main_oper_code4 := abs_utils.add_func(
                              p_name        => l_name4,
                              p_funcname    => l_funcname4,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code4 from operlist where funcname = l_funcname4 and rownum = 1;
        update operlist set funcname = l_funcname4 where codeoper = l_main_oper_code4;
    END IF;
    add_func_app(l_app_code, l_main_oper_code4, 1, 1);
    
        select count(*) into v_is_exist from operlist where funcname = l_funcname5;
    IF v_is_exist = 0 THEN
        l_main_oper_code5 := abs_utils.add_func(
                              p_name        => l_name5,
                              p_funcname    => l_funcname5,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code5 from operlist where funcname = l_funcname5 and rownum = 1;
        update operlist set funcname = l_funcname5 where codeoper = l_main_oper_code5;
    END IF;
    add_func_app(l_app_code, l_main_oper_code5, 1, 1);
    
        select count(*) into v_is_exist from operlist where funcname = l_funcname6;
    IF v_is_exist = 0 THEN
        l_main_oper_code6 := abs_utils.add_func(
                              p_name        => l_name6,
                              p_funcname    => l_funcname6,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code6 from operlist where funcname = l_funcname6 and rownum = 1;
        update operlist set funcname = l_funcname6 where codeoper = l_main_oper_code6;
    END IF;
    add_func_app(l_app_code, l_main_oper_code6, 1, 1);
    
        select count(*) into v_is_exist from operlist where funcname = l_funcname7;
    IF v_is_exist = 0 THEN
        l_main_oper_code7 := abs_utils.add_func(
                              p_name        => l_name7,
                              p_funcname    => l_funcname7,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code7 from operlist where funcname = l_funcname7 and rownum = 1;
        update operlist set funcname = l_funcname7 where codeoper = l_main_oper_code7;
    END IF;
    add_func_app(l_app_code, l_main_oper_code7, 1, 1);
    
        select count(*) into v_is_exist from operlist where funcname = l_funcname8;
    IF v_is_exist = 0 THEN
        l_main_oper_code8 := abs_utils.add_func(
                              p_name        => l_name8,
                              p_funcname    => l_funcname8,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code8 from operlist where funcname = l_funcname8 and rownum = 1;
        update operlist set funcname = l_funcname8 where codeoper = l_main_oper_code8;
    END IF;
    add_func_app(l_app_code, l_main_oper_code8, 1, 1);
    
    
    select s.id into l_user_code from staff$base s where  s.logname = 'ABSADM';
    add_usr_app(l_app_code, l_user_code, 1, 1);
    
end;
/
commit;

