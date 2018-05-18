declare
    l_app_code varchar2(10 char) := 'AUTU';
    l_app_name varchar2(300 char) := 'АРМ Автоматизованих операцій КП ЮО (WEB)';
    l_funcname varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK_SBER(2,4,:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ЮО ?][MSG=>Перенесення виканано !]';
    l_name varchar2(250 Byte) := 'Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО';
    l_main_oper_code number;
    l_funcname1 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCT.StartI(0)][QST=>Ви бажаєте виконати винесення на прострочку(на фініші)?][MSG=>Виконано !]';
    l_name1 varchar2(250 Byte) := 'Обробка КП ЮО - виноси на прострочку(на фініші)';
    l_main_oper_code1 number;
    l_funcname2 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCT.StartI(0)][QST=>Ви бажаєте виконати винесення на прострочку(на старті)?][MSG=>Виконано !]';
    l_name2 varchar2(250 Byte) := 'Обробка КП ЮО - виноси на прострочку(на старті)';
    l_main_oper_code2 number;
    l_funcname3 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK'||'&'||'accessCode=1'||'&'||'sPar=[PROC=>p_interest_cck(null,4,:E)][PAR=>:E(SEM=Дата по,TYPE=D)][showDialogWindow=>false][DESCR=>КД: Нарах.%%][EXEC=>BEFORE][NSIFUNCTION]';
    l_name3 varchar2(250 Byte) := 'КП S55: Нарахування %%  по КД з залишками на рах. погашення ЮО';
    l_main_oper_code3 number;
    l_funcname4 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK'||'&'||'accessCode=1'||'&'||'sPar=[PROC=>p_interest_cck(null,1,:E)][PAR=>:E(SEM=Дата по,TYPE=D)][showDialogWindow=>false][DESCR=>КД: Нарах.%%][EXEC=>BEFORE][NSIFUNCTION]';
    l_name4 varchar2(250 Byte) := 'КП S42: Нарахування %%  по поточних платіж. датах у КП ЮО';
    l_main_oper_code4 number;
    l_funcname5 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CC_RMANY_PET(-1,gl.bd,3)][QST=>Ви хочете вик. Амортізацію Дисконту ЮО?][MSG=> Виконано !]';
    l_name5 varchar2(250 Byte) := 'КП S7: Амортизація Дисконту/Премії ЮО з ЕПС';
    l_main_oper_code5 number;
    l_funcname6 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK.CC_ASPN(2,0,1)][QST=>Ви бажаєте виконати винесення на прострочку процентів клієнта?][MSG=>Виконано !]';
    l_name6 varchar2(250 Byte) := 'КП S32: Авто-просрочка рахунків нарах.% SN ЮО';
    l_main_oper_code6 number;
    l_funcname7 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CC_ISG(-1,'||'SPN|SN '||')][QST=>Ви хочете зробити Авто разбір рахунків Кред-ої заборг-ті?][MSG=>Виконано !]';
    l_name7 varchar2(250 Byte) := 'КП F05_3: Авто разбір рах-ів ISG (3600) Кред-ої заборг-ті ЮО (SPN,SN)';
    l_main_oper_code7 number;
    l_funcname8 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>cck.cc_wdate(2,gl.bd,0)][QST=>Ви хочете винести на прострочку всі активи клієнта?][MSG=>Виконано !]';
    l_name8 varchar2(250 Byte) := 'КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО';
    l_main_oper_code8 number;
    l_funcname9 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CC_ISG(0,'||'SPN|SN '||')][QST=>Ви хочете зробити Авто разбір рахунків Кред-ої заборг-ті?][MSG=>Виконано !]';
    l_name9 varchar2(250 Byte) := 'КП F05: Авто разбір рахунків ISG (3600) Кред-ої заборг-ті на (SPN,SN)';
    l_main_oper_code9 number;
    l_funcname10 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>cc_close(2,bankdate)][QST=>Ви бажаєте виконати авто-закриття договорів ЮО?][MSG=>Закриття виканано !]';
    l_name10 varchar2(250 Byte) := 'КП S8: Авто закриття договорів ЮО';
    l_main_oper_code10 number;
    l_funcname11 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=> CCK.CC_ASP ( -1,1)][QST=>Виконати Start/ Авто-просрочка рахунків боргу SS - ЮО?][MSG=>Виконано!]';
    l_name11 varchar2(250 Byte) := 'Start/ Авто-просрочка рахунків боргу SS - ЮО';
    l_main_oper_code11 number;
    l_funcname12 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK_SBER(2,5,:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ЮО ?][MSG=>Перенесення виканано !]';
    l_name12 varchar2(250 Byte) := 'КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ЮО';
    l_main_oper_code12 number;
    l_funcname13 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>cck.update_obs(gl.bd,-2)][QST=>Ви бажаєте виконати призупинення обслю боргу?][MSG=> Виконано!]';
    l_name13 varchar2(250 Byte) := 'КП S9: Зміна парам ОБС.БОРГУ (ЮО)';
    l_main_oper_code13 number;
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
    
         select count(*) into v_is_exist from operlist where funcname = l_funcname9;
    IF v_is_exist = 0 THEN
        l_main_oper_code9 := abs_utils.add_func(
                              p_name        => l_name9,
                              p_funcname    => l_funcname9,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code9 from operlist where funcname = l_funcname9 and rownum = 1;
        update operlist set funcname = l_funcname9 where codeoper = l_main_oper_code9;
    END IF;
    add_func_app(l_app_code, l_main_oper_code9, 1, 1);
    
         select count(*) into v_is_exist from operlist where funcname = l_funcname10;
    IF v_is_exist = 0 THEN
        l_main_oper_code10 := abs_utils.add_func(
                              p_name        => l_name10,
                              p_funcname    => l_funcname10,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code10 from operlist where funcname = l_funcname10 and rownum = 1;
        update operlist set funcname = l_funcname10 where codeoper = l_main_oper_code10;
    END IF;
    add_func_app(l_app_code, l_main_oper_code10, 1, 1);
    
         select count(*) into v_is_exist from operlist where funcname = l_funcname11;
    IF v_is_exist = 0 THEN
        l_main_oper_code11 := abs_utils.add_func(
                              p_name        => l_name11,
                              p_funcname    => l_funcname11,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code11 from operlist where funcname = l_funcname11 and rownum = 1;
        update operlist set funcname = l_funcname11 where codeoper = l_main_oper_code11;
    END IF;
    add_func_app(l_app_code, l_main_oper_code11, 1, 1);
    
         select count(*) into v_is_exist from operlist where funcname = l_funcname12;
    IF v_is_exist = 0 THEN
        l_main_oper_code12 := abs_utils.add_func(
                              p_name        => l_name12,
                              p_funcname    => l_funcname12,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code12 from operlist where funcname = l_funcname12 and rownum = 1;
        update operlist set funcname = l_funcname12 where codeoper = l_main_oper_code12;
    END IF;
    add_func_app(l_app_code, l_main_oper_code12, 1, 1);
    
         select count(*) into v_is_exist from operlist where funcname = l_funcname13;
    IF v_is_exist = 0 THEN
        l_main_oper_code13 := abs_utils.add_func(
                              p_name        => l_name13,
                              p_funcname    => l_funcname13,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             );  
    ELSE
        select codeoper into l_main_oper_code13 from operlist where funcname = l_funcname13 and rownum = 1;
        update operlist set funcname = l_funcname13 where codeoper = l_main_oper_code13;
    END IF;
    add_func_app(l_app_code, l_main_oper_code13, 1, 1);
    
    
    select s.id into l_user_code from staff$base s where  s.logname = 'ABSADM';
    add_usr_app(l_app_code, l_user_code, 1, 1);
    
end;
/
commit;

