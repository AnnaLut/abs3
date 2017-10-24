SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_AVTO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  AVTO ***
  declare
    l_application_code varchar2(10 char) := 'AVTO';
    l_application_name varchar2(300 char) := '��� ��������� ������������ ��������';
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
     DBMS_OUTPUT.PUT_LINE(' AVTO ��������� (��� ���������) ��� ��� ��������� ������������ �������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �볺��� ����������� ********** ');
          --  ��������� ������� ������ �볺��� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �볺��� �����������',
                                                  p_funcname => '/barsroot/credit/constructor/wcssubproductsurvey.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F1. DA<FFFF>.dbf ��� ��� �� ����.����������� �� �����-2 ********** ');
          --  ��������� ������� F1. DA<FFFF>.dbf ��� ��� �� ����.����������� �� �����-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F1. DA<FFFF>.dbf ��� ��� �� ����.����������� �� �����-2',
                                                  p_funcname => 'ExportCatQuery(4932,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F0.��������� DBF-���� ��� ��� �� ����.���������i� ********** ');
          --  ��������� ������� F0.��������� DBF-���� ��� ��� �� ����.���������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F0.��������� DBF-���� ��� ��� �� ����.���������i�',
                                                  p_funcname => 'ExportCatQuery(4934,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F3. DA<FFFFFF>.dbf ��� ��� �� ����.������. �� �����-3 ********** ');
          --  ��������� ������� F3. DA<FFFFFF>.dbf ��� ��� �� ����.������. �� �����-3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F3. DA<FFFFFF>.dbf ��� ��� �� ����.������. �� �����-3',
                                                  p_funcname => 'ExportCatQuery(4952,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F3. DA<FFFFFF>.dbf ��� ��� �� ����.������. �� �����-3 ********** ');
          --  ��������� ������� F3. DA<FFFFFF>.dbf ��� ��� �� ����.������. �� �����-3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F3. DA<FFFFFF>.dbf ��� ��� �� ����.������. �� �����-3',
                                                  p_funcname => 'ExportCatQuery(4967,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT. �������� "���������" ������ ********** ');
          --  ��������� ������� DPT. �������� "���������" ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. �������� "���������" ������',
                                                  p_funcname => 'F1_Select(12, "DPT_PF.NO_TRANSFER_PF(1)" )',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. ����������� ���������� �������� �� ********** ');
          --  ��������� ������� DPU. ����������� ���������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. ����������� ���������� �������� ��',
                                                  p_funcname => 'F1_Select(12,"DPU.AUTO_EXTENSION(DAT)")',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. ����������� �� ������� %% �� ��������� ********** ');
          --  ��������� ������� DPU. ����������� �� ������� %% �� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. ����������� �� ������� %% �� ���������',
                                                  p_funcname => 'F1_Select(12,"DPU.AUTO_MAKE_INT_FINALLY(DAT)")',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� "DPU �������� ���.���.�� �� ��������� ������ 䳿" ********** ');
          --  ��������� ������� "DPU �������� ���.���.�� �� ��������� ������ 䳿"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"DPU �������� ���.���.�� �� ��������� ������ 䳿"',
                                                  p_funcname => 'F1_Select(12,"DPU.AUTO_MOVE2ARCHIVE( DAT )")',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. �������� ���.���.�� �� ��������� ������ 䳿 ********** ');
          --  ��������� ������� DPU. �������� ���.���.�� �� ��������� ������ 䳿
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. �������� ���.���.�� �� ��������� ������ 䳿',
                                                  p_funcname => 'F1_Select(12,"DPU.AUTO_MOVE2ARCHIVE(DAT)")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����������� �������� ********** ');
          --  ��������� ������� ��������� ����������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����������� ��������',
                                                  p_funcname => 'F1_Select(13, "BARS.dpt_finally_amort(DAT);�������� <��������� ����������� ��������>?;��������!")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Z. ���������� ����������� ������� � ���� ���� ********** ');
          --  ��������� ������� Z. ���������� ����������� ������� � ���� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Z. ���������� ����������� ������� � ���� ����',
                                                  p_funcname => 'F1_Select(13, "DPT_COMPROC_END_YEAR( DAT );�������� <���������� ����������� %% �� ���������? >;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������������ ������� ���������� � �� ********** ');
          --  ��������� ������� ������ ������������ ������� ���������� � ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������������ ������� ���������� � ��',
                                                  p_funcname => 'F1_Select(13, "DPT_WEB.AUTO_PAY_TAX( DAT );�������� <������ ������������ ������� ���������� � ��? >;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1. ��������� �������� "�������� ������������ ������" ********** ');
          --  ��������� ������� 1. ��������� �������� "�������� ������������ ������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1. ��������� �������� "�������� ������������ ������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_BLNK'',NUMBER_Null);�������� <�������� ������������ ������?>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2. ��������� �������� "�������� ������ ���� ��������� ������ 䳿" ********** ');
          --  ��������� ������� 2. ��������� �������� "�������� ������ ���� ��������� ������ 䳿"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2. ��������� �������� "�������� ������ ���� ��������� ������ 䳿"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_CLOS'',NUMBER_Null);�������� <�������� ������ ���� ��������� ������ 䳿>?;��������!")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4. ��������� �������� "��������� ����������� �������" ********** ');
          --  ��������� ������� 4. ��������� �������� "��������� ����������� �������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4. ��������� �������� "��������� ����������� �������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_INTF'',NUMBER_Null);�������� <��������� ����������� �������>?;��������!")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6. ��������� �������� "����������� ������� � ���� �����" ********** ');
          --  ��������� ������� 6. ��������� �������� "����������� ������� � ���� �����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6. ��������� �������� "����������� ������� � ���� �����"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_MINT'',0);�������� <����������� %% �� ������� � ������� ���� ��>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 7. ��������� �������� "�����������/������� %% �� ������� (���.������)" ********** ');
          --  ��������� ������� 7. ��������� �������� "�����������/������� %% �� ������� (���.������)"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7. ��������� �������� "�����������/������� %% �� ������� (���.������)"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_PIPL'',NUMBER_Null);�������� <����������� � ������� %% �� ���.�������>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����I�.������� 2909/66->2620/29 ********** ');
          --  ��������� ������� �����I�.������� 2909/66->2620/29
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����I�.������� 2909/66->2620/29',
                                                  p_funcname => 'F1_Select(13,"for_2620_29_ALL(''NLR'');�������� �����I�.������� 2909/66->2620/29?; �� ��������� ����� !" )',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������-2012.������� 2906/16->2625/22 ********** ');
          --  ��������� ������� �������-2012.������� 2906/16->2625/22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������-2012.������� 2906/16->2625/22',
                                                  p_funcname => 'F1_Select(13,"for_2625_22(''NLA'',''2625'',''22'');�������� �������-2012.������� 2906/16->2625/22?; �� !" )',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ��� ����������� �� �� �� ������� ��� ********** ');
          --  ��������� ������� ��� ��� ����������� �� �� �� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ��� ����������� �� �� �� ������� ���',
                                                  p_funcname => 'FunNSIEditF("V_KF3800[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=����_�,TYPE=S),:E(SEM=����_��,TYPE=S)][EXEC=>BEFORE]", 1 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������, ������������� ����+�� �� ������� ********** ');
          --  ��������� ������� ����������, ������������� ����+�� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������, ������������� ����+�� �� �������',
                                                  p_funcname => 'FunNSIEditF("V_PDFO[NSIFUNCTION][PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��i��� ���� 01/��/��)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ��� ����������� �� �� �� ������� ��� ********** ');
          --  ��������� ������� ��� ��� ����������� �� �� �� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ��� ����������� �� �� �� ������� ���',
                                                  p_funcname => 'FunNSIEditF("V_RF3800[PROC=>Bank_PF (0,:B,:E)][PAR=>:B(SEM=����_�,TYPE=D),:E(SEM=����_��,TYPE=D)][EXEC=>BEFORE]", 1 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������ �� ����������� �� ������ ������� ********** ');
          --  ��������� ������� ����� ������ �� ����������� �� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������ �� ����������� �� ������ �������',
                                                  p_funcname => 'FunNSIEditF(''V_DPT_INTPAYPRETENDERS'', 1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A���������� ���  �������� �� ���������� ********** ');
          --  ��������� ������� A���������� ���  �������� �� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A���������� ���  �������� �� ����������',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and s.NBS=''2636'' and i.metr=4 ", "SA" )',
                                                  p_rolename => 'START1' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (AVTO) - ��� ��������� ������������ ��������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappAVTO.sql =========*** En
PROMPT ===================================================================================== 
