SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_DPTA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  DPTA ***
  declare
    l_application_code varchar2(10 char) := 'DPTA';
    l_application_name varchar2(300 char) := '��� ������������ ��������� ������� ��';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_CENTURA;
    l_function_ids number_list := number_list();
    l_function_codeoper     OPERLIST.CODEOPER%type;
    l_function_deps         OPERLIST.CODEOPER%type;
    l_application_id integer;
    l_role_resource_type_id integer := resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE);
    l_arm_resource_type_id  integer := resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_application_type_id));
    l_func_resource_type_id integer := resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_application_type_id));
    l integer := 0;
	d integer := 0;
begin
     DBMS_OUTPUT.PUT_LINE(' DPTA ��������� (��� ���������) ��� ��� ������������ ��������� ������� �� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT. ��������� ��������� ��������� ������������ �������� ********** ');
          --  ��������� ������� DPT. ��������� ��������� ��������� ������������ ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. ��������� ��������� ��������� ������������ ��������',
                                                  p_funcname => 'F1_Select(12, "DPT_UTILS.TRANSFER_LOG2ARCHIVE(0)")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT ��������� ������� ������ �� ����� �������� �� ********** ');
          --  ��������� ������� DPT ��������� ������� ������ �� ����� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT ��������� ������� ������ �� ����� �������� ��',
                                                  p_funcname => 'F1_Select(12,"DPT_START_BRATES(''DPT'')")',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� 15% �� ���������� ������ �� ********** ');
          --  ��������� ������� ��������� ������� 15% �� ���������� ������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� 15% �� ���������� ������ ��',
                                                  p_funcname => 'F1_Select(13, "BARS.INT15(DAT);�������� <��������� ������� 15% �� ���������� ������ ��>?;��������!")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ % ������ �� ���������� ��������� ********** ');
          --  ��������� ������� ������������ % ������ �� ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ % ������ �� ���������� ���������',
                                                  p_funcname => 'F1_Select(13, "SET_RATES_MIGR_DPT( STRING_Null );�������� <����������� % ������ �� ���������� ���������? >;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� B. ��������� �������� "������������������ ������" ********** ');
          --  ��������� ������� B. ��������� �������� "������������������ ������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'B. ��������� �������� "������������������ ������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_EXTN'',NUMBER_Null);�������� <������������������ ������>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5. ��������� �������� "������������� ������ �� %% � ���� ������ 䳿" ********** ');
          --  ��������� ������� 5. ��������� �������� "������������� ������ �� %% � ���� ������ 䳿"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. ��������� �������� "������������� ������ �� %% � ���� ������ 䳿"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_MATU'',NUMBER_Null);�������� <������������� ������ �� %% � ���� ������ 䳿>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT. ���������� �������� �������� ������-������ �� ����.���.-���.� ********** ');
          --  ��������� ������� DPT. ���������� �������� �������� ������-������ �� ����.���.-���.�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. ���������� �������� �������� ������-������ �� ����.���.-���.�',
                                                  p_funcname => 'FunNSIEdit("[PROC=>DPT_PROCDR(''DPT'',:Param1,:Param2)][PAR=>:Param1(SEM=� ��������� �������� {1-���/0-�},TYPE=N),:Param2(SEM=³������ ������� {1-���/0-�},TYPE=N)][MSG=>��������!]")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� 15% �� ���������� ������ �� (�� �������� ��) ********** ');
          --  ��������� ������� ��������� ������� 15% �� ���������� ������ �� (�� �������� ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� 15% �� ���������� ������ �� (�� �������� ��)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>INT15_dailycheck(:sPar1)][PAR=>:sPar1(SEM=���� ��,TYPE=D)][MSG=>��������!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT5 ���������� ��i�� ��� �� "���,�� ���� �� �����.����i�����" ********** ');
          --  ��������� ������� DPT5 ���������� ��i�� ��� �� "���,�� ���� �� �����.����i�����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT5 ���������� ��i�� ��� �� "���,�� ���� �� �����.����i�����"',
                                                  p_funcname => 'FunNSIEdit("[PROC=>PF_NOT_PAY(:Param0,:Param1)][PAR=>:Param0(SEM=��i��� ����,TYPE=D),:Param1(SEM=��i���� ���i��/�i�,TYPE=N)][MSG=>��������!]")',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �����.������ �� ������ �� �����.��.����.��� � 159 ********** ');
          --  ��������� ������� ����������� �����.������ �� ������ �� �����.��.����.��� � 159
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �����.������ �� ������ �� �����.��.����.��� � 159',
                                                  p_funcname => 'FunNSIEditF("V_DPT_159[PROC=>dpt_159(:DPTID,:Param0)][PAR=>:Param0(SEM=��������,TYPE=C,DEF=���,REF=TTS)][QST=>�������� ����������� ��������� ������ �� ������ �� ���������?][MSG=>��������!]", 1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT6 ������ ���i ��� ���� ���i�������� ********** ');
          --  ��������� ������� DPT6 ������ ���i ��� ���� ���i��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT6 ������ ���i ��� ���� ���i��������',
                                                  p_funcname => 'FunNSIEditF("V_DPT_AGR_DAT",2|0x0010)',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������� ���������� ������ ********** ');
          --  ��������� ������� ������� ������� ���������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������� ���������� ������',
                                                  p_funcname => 'GeneralImpExp(hWndMDI, 3, 2, ''dpt_brates_export(0, sFileName)'', '''')',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ������� % ������ ********** ');
          --  ��������� ������� ������ ��� ������� % ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ������� % ������',
                                                  p_funcname => 'Sel010(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT2 ���������� �������� �������� ��� ********** ');
          --  ��������� ������� DPT2 ���������� �������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT2 ���������� �������� �������� ���',
                                                  p_funcname => 'Sel016f(hWndMDI,0,0,""," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ���� �� ����� ���������� �������� ********** ');
          --  ��������� ������� ������� ���� �� ����� ���������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ���� �� ����� ���������� ��������',
                                                  p_funcname => 'Sel016f(hWndMDI,13,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT0 ���� �������� �������� ��� ********** ');
          --  ��������� ������� DPT0 ���� �������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 ���� �������� �������� ���',
                                                  p_funcname => 'Sel016f(hWndMDI,2,1,""," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT ������ ��� ������� ������ �� ����� �������� �� ********** ');
          --  ��������� ������� DPT ������ ��� ������� ������ �� ����� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT ������ ��� ������� ������ �� ����� �������� ��',
                                                  p_funcname => 'Sel016f(hWndMDI,20,0,"DPT","")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT1 ����� �������� �������� ��� ********** ');
          --  ��������� ������� DPT1 ����� �������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT1 ����� �������� �������� ���',
                                                  p_funcname => 'Sel016f(hWndMDI,6,0,"v_dpt_s"," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT. ����������� ������� ��� ********** ');
          --  ��������� ������� DPT. ����������� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. ����������� ������� ���',
                                                  p_funcname => 'Sel016f(hWndMDI,7,1,"DPT","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT0 ��������� ������ ������ ********** ');
          --  ��������� ������� DPT0 ��������� ������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 ��������� ������ ������',
                                                  p_funcname => 'Sel016f(hWndMDI,8,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� ********** ');
          --  ��������� ������� ���� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ����',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -1)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ********** ');
          --  ��������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������',
                                                  p_funcname => 'ShowRefList(hWndMDI)',
                                                  p_rolename => 'REF0000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT0 ����������� ������� ���������� �������� ���.��� ********** ');
          --  ��������� ������� DPT0 ����������� ������� ���������� �������� ���.���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 ����������� ������� ���������� �������� ���.���',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''DPT%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (DPTA) - ��� ������������ ��������� ������� ��  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;


    DBMS_OUTPUT.PUT_LINE(' B���� ������� ������� ���������� ������������ - ����������� ����������� �� ');
    for i in (select a.id
              from   adm_resource_activity a
              where  a.grantee_type_id = l_arm_resource_type_id and
                     a.resource_type_id = l_func_resource_type_id and
                     a.grantee_id = l_application_id and
                     a.resource_id in (select column_value from table(l_function_ids))  and
                     a.access_mode_id = 1 and
                     a.resolution_time is null) loop
        resource_utl.approve_resource_access(i.id, '����������� ������������ ���� �� ������� ��� ����');
    end loop;
     DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappDPTA.sql =========*** En
PROMPT ===================================================================================== 
