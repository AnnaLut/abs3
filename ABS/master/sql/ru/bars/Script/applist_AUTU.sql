declare
    l_app_code varchar2(10 char) := 'AUTU';
    l_app_name varchar2(300 char) := '��� ��������������� �������� �� �� (WEB)';
    l_funcname varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK_SBER(2,4,:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]';
    l_name varchar2(250 Byte) := '�������-�� �� �����. %% ����� ��� � ���� ����� ��';
    l_main_oper_code number;
    l_funcname1 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCT.StartI(0)][QST=>�� ������ �������� ��������� �� ����������(�� �����)?][MSG=>�������� !]';
    l_name1 varchar2(250 Byte) := '������� �� �� - ������ �� ����������(�� �����)';
    l_main_oper_code1 number;
    l_funcname2 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCT.StartI(0)][QST=>�� ������ �������� ��������� �� ����������(�� �����)?][MSG=>�������� !]';
    l_name2 varchar2(250 Byte) := '������� �� �� - ������ �� ����������(�� �����)';
    l_main_oper_code2 number;
    l_funcname3 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK'||'&'||'accessCode=1'||'&'||'sPar=[PROC=>p_interest_cck(null,4,:E)][PAR=>:E(SEM=���� ��,TYPE=D)][showDialogWindow=>false][DESCR=>��: �����.%%][EXEC=>BEFORE][NSIFUNCTION]';
    l_name3 varchar2(250 Byte) := '�� S55: ����������� %%  �� �� � ��������� �� ���. ��������� ��';
    l_main_oper_code3 number;
    l_funcname4 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK'||'&'||'accessCode=1'||'&'||'sPar=[PROC=>p_interest_cck(null,1,:E)][PAR=>:E(SEM=���� ��,TYPE=D)][showDialogWindow=>false][DESCR=>��: �����.%%][EXEC=>BEFORE][NSIFUNCTION]';
    l_name4 varchar2(250 Byte) := '�� S42: ����������� %%  �� �������� �����. ����� � �� ��';
    l_main_oper_code4 number;
    l_funcname5 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CC_RMANY_PET(-1,gl.bd,3)][QST=>�� ������ ���. ���������� �������� ��?][MSG=> �������� !]';
    l_name5 varchar2(250 Byte) := '�� S7: ����������� ��������/���쳿 �� � ���';
    l_main_oper_code5 number;
    l_funcname6 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK.CC_ASPN(2,0,1)][QST=>�� ������ �������� ��������� �� ���������� �������� �볺���?][MSG=>�������� !]';
    l_name6 varchar2(250 Byte) := '�� S32: ����-��������� ������� �����.% SN ��';
    l_main_oper_code6 number;
    l_funcname7 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CC_ISG(-1,'||'SPN|SN '||')][QST=>�� ������ ������� ���� ����� ������� ����-� ������-�?][MSG=>�������� !]';
    l_name7 varchar2(250 Byte) := '�� F05_3: ���� ����� ���-�� ISG (3600) ����-� ������-� �� (SPN,SN)';
    l_main_oper_code7 number;
    l_funcname8 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>cck.cc_wdate(2,gl.bd,0)][QST=>�� ������ ������� �� ���������� �� ������ �볺���?][MSG=>�������� !]';
    l_name8 varchar2(250 Byte) := '�� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��';
    l_main_oper_code8 number;
    l_funcname9 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CC_ISG(0,'||'SPN|SN '||')][QST=>�� ������ ������� ���� ����� ������� ����-� ������-�?][MSG=>�������� !]';
    l_name9 varchar2(250 Byte) := '�� F05: ���� ����� ������� ISG (3600) ����-� ������-� �� (SPN,SN)';
    l_main_oper_code9 number;
    l_funcname10 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>cc_close(2,bankdate)][QST=>�� ������ �������� ����-�������� �������� ��?][MSG=>�������� �������� !]';
    l_name10 varchar2(250 Byte) := '�� S8: ���� �������� �������� ��';
    l_main_oper_code10 number;
    l_funcname11 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=> CCK.CC_ASP ( -1,1)][QST=>�������� Start/ ����-��������� ������� ����� SS - ��?][MSG=>��������!]';
    l_name11 varchar2(250 Byte) := 'Start/ ����-��������� ������� ����� SS - ��';
    l_main_oper_code11 number;
    l_funcname12 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>CCK_SBER(2,5,:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]';
    l_name12 varchar2(250 Byte) := '�� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��';
    l_main_oper_code12 number;
    l_funcname13 varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||'&'||'sPar=[PROC=>cck.update_obs(gl.bd,-2)][QST=>�� ������ �������� ������������ ����� �����?][MSG=> ��������!]';
    l_name13 varchar2(250 Byte) := '�� S9: ���� ����� ���.����� (��)';
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

