SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_ANI1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  ANI1 ***
  declare
    l_application_code varchar2(10 char) := 'ANI1';
    l_application_name varchar2(300 char) := '��� �������� �������';
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
     DBMS_OUTPUT.PUT_LINE(' ANI1 ��������� (��� ���������) ��� ��� �������� ������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ��=2620,2625,2630,2635; ���=980,840,978 ********** ');
          --  ��������� ������� ������� ��=2620,2625,2630,2635; ���=980,840,978
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ��=2620,2625,2630,2635; ���=980,840,978',
                                                  p_funcname => 'ExportCatQuery(4356,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ���.���. 6*, 7* �� �����-2 ********** ');
          --  ��������� ������� ������� ���.���. 6*, 7* �� �����-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ���.���. 6*, 7* �� �����-2',
                                                  p_funcname => 'ExportCatQuery(4357,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ���.���. 6*, 7* �� �����-2 (� ����) ********** ');
          --  ��������� ������� ������� ���.���. 6*, 7* �� �����-2 (� ����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ���.���. 6*, 7* �� �����-2 (� ����)',
                                                  p_funcname => 'ExportCatQuery(4648,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �Ѳ� ������������ ********** ');
          --  ��������� ������� ��������� �Ѳ� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �Ѳ� ������������',
                                                  p_funcname => 'F_Ctrl_D(TRUE)',
                                                  p_rolename => 'CHCK002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �����-3 ��� �i�.��� ********** ');
          --  ��������� ������� ��������� �����-3 ��� �i�.���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �����-3 ��� �i�.���',
                                                  p_funcname => 'FunNSIEdit("V_FINREZ[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=� dd.mm.yyyy),:E(SEM=�� dd.mm.yyyy)][EXEC=>BEFORE],2")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������.�i� ������ (�� �������) ����+����� ********** ');
          --  ��������� ������� �������.�i� ������ (�� �������) ����+�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������.�i� ������ (�� �������) ����+�����',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_PMZ",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������i� ������ (�� �������) ����+��+���+����� ********** ');
          --  ��������� ������� ��������i� ������ (�� �������) ����+��+���+�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������i� ������ (�� �������) ����+��+���+�����',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_PRO",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������i� ������ (�� �������) ����+����� ********** ');
          --  ��������� ������� ��������i� ������ (�� �������) ����+�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������i� ������ (�� �������) ����+�����',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_PRZ",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������ (�� �������) ����+��+���+����� ********** ');
          --  ��������� ������� �������� ������ (�� �������) ����+��+���+�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������ (�� �������) ����+��+���+�����',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_TEK",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������ (�� �������) ����+����� ********** ');
          --  ��������� ������� �������� ������ (�� �������) ����+�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������ (�� �������) ����+�����',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_TEZ",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����������i �i������ �� ���. ********** ');
          --  ��������� ������� �����������i �i������ �� ���.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����������i �i������ �� ���.',
                                                  p_funcname => 'FunNSIEditF("CCK_SUM_POG[PROC=>PLAY_INTA(:D1,:D2,:BR,:NB,:KV,:AP)][PAR=>:D1(SEM=���_1,TYPE=D),:D2(SEM=���_2,TYPE=D),:BR(SEM=�����,TYPE=S),:NB(SEM=���/�,TYPE=S),:KV(SEM=���,TYPE=N),:AP(SEM=0_�/1_�,TYPE=N)][EXEC=>BEFORE][MSG=>OK!]",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3900/980 ����i� ������� ��� ********** ');
          --  ��������� ������� 3900/980 ����i� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 ����i� ������� ���',
                                                  p_funcname => 'FunNSIEditF("N00_DON1[PROC=>PUL_DAT(:Par0,STRING_Null)][PAR=>:Par0(SEM=dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3902/04, 3903/04 ���� �� ���i�� (������) ********** ');
          --  ��������� ������� 3902/04, 3903/04 ���� �� ���i�� (������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3902/04, 3903/04 ���� �� ���i�� (������)',
                                                  p_funcname => 'FunNSIEditF("N00_DON2[PROC=>PUL_DAT(:Par0,:Par1)][PAR=>:Par0(SEM=� dd.mm.yyyy>,TYPE=S),:Par1(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3901, 3902/04, 3903/04 ���� �� ���i�� (�� ����) ********** ');
          --  ��������� ������� 3901, 3902/04, 3903/04 ���� �� ���i�� (�� ����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3901, 3902/04, 3903/04 ���� �� ���i�� (�� ����)',
                                                  p_funcname => 'FunNSIEditF("N00_DON3[PROC=>PUL_DAT(:Par0,:Par1)][PAR=>:Par0(SEM=� dd.mm.yyyy>,TYPE=S),:Par1(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3900/980 ������ ������i� � ����i�i ���� �������� ********** ');
          --  ��������� ������� 3900/980 ������ ������i� � ����i�i ���� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 ������ ������i� � ����i�i ���� ��������',
                                                  p_funcname => 'FunNSIEditF("N00_HH[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3900/980 ������ ������i� � ����i�i ����+�� ********** ');
          --  ��������� ������� 3900/980 ������ ������i� � ����i�i ����+��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 ������ ������i� � ����i�i ����+��',
                                                  p_funcname => 'FunNSIEditF("N00_HH_NBS[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3900/980 ������ ������i� � ����i�i ��� ********** ');
          --  ��������� ������� 3900/980 ������ ������i� � ����i�i ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 ������ ������i� � ����i�i ���',
                                                  p_funcname => 'FunNSIEditF("N00_MFO[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3900/980 ������ ������i� � ����i�i �� ********** ');
          --  ��������� ������� 3900/980 ������ ������i� � ����i�i ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 ������ ������i� � ����i�i ��',
                                                  p_funcname => 'FunNSIEditF("N00_NBS[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�.���. (����+��+���+�����) ********** ');
          --  ��������� ������� �i�.���. (����+��+���+�����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�.���. (����+��+���+�����)',
                                                  p_funcname => 'FunNSIEditF("TMP_FIN_REZ[PROC=>P_FIN_REZ_ALL(:U,:L,:V,:O,:B,:E)][PAR=>:U(SEM=��a��>1 2 3),:L(SEM=���>1=Y 0=N),:V(SEM=���>1-Y 0-N),:O(SEM=��22=1-Y 0-N),:B(SEM=���.���� dd.mm.yyyy),:E(SEM=�i�.���� dd.mm.yyyy)][MSG=>��][EXEC=>BEFORE]",2|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� ������� 9760 ********** ');
          --  ��������� ������� �������� ���� ������� 9760
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� ������� 9760',
                                                  p_funcname => 'FunNSIEditF("V9760",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������i i��."��� �i���i��� ��." �� ��.3 ********** ');
          --  ��������� ������� �������� ��������i i��."��� �i���i��� ��." �� ��.3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������i i��."��� �i���i��� ��." �� ��.3',
                                                  p_funcname => 'FunNSIEditF("V_ACC0000[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM= � ����,TYPE=S),:Par2(SEM= �� ����,TYPE=S)][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������i ���������� �� ������� ********** ');
          --  ��������� ������� �i������i ���������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������i ���������� �� �������',
                                                  p_funcname => 'FunNSIEditF("V_FIN_REZ_BRANCH[PROC=>P_FIN_REZ_BRANCH (10,:Par1,:Par2)][PAR=>:Par1(SEM= ���.���� dd.mm.yyyy>,TYPE=S),:Par2(SEM= �i�.���� dd.mm.yyyy>,TYPE=S)][MSG=>OK p_FIN_REZ_branch !][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������i ���������� �� �� �� ********** ');
          --  ��������� ������� �i������i ���������� �� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������i ���������� �� �� ��',
                                                  p_funcname => 'FunNSIEditF("V_FIN_REZ_CCK[PROC=>P_FIN_REZ_CCK(2,0,:B,:E)][PAR=>:B(SEM=����_�,TYPE=D),:E(SEM=����_��,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������i ���������� �� ������������ ********** ');
          --  ��������� ������� �i������i ���������� �� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������i ���������� �� ������������',
                                                  p_funcname => 'FunNSIEditF("V_FIN_REZ_RNK[PROC=>P_FIN_REZ_RNK(0,:B,:E,0)][PAR=>:B(SEM=����_�,TYPE=D),:E(SEM=����_��,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i���� �����i� �� ��  ���i� ********** ');
          --  ��������� ������� ���i���� �����i� �� ��  ���i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i���� �����i� �� ��  ���i�',
                                                  p_funcname => 'FunNSIEditF(''V_BRANCH_TIP'', 2 | 0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-1s.�i�������i �� ���������i GAP ********** ');
          --  ��������� ������� ANI-1s.�i�������i �� ���������i GAP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-1s.�i�������i �� ���������i GAP',
                                                  p_funcname => 'Sel030(hWndMDI,0,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-1. ����� �i����i�����i ���-��� ********** ');
          --  ��������� ������� ANI-1. ����� �i����i�����i ���-���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-1. ����� �i����i�����i ���-���',
                                                  p_funcname => 'Sel030(hWndMDI,1,700,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-10. ����� �i����i�����i ����.���-��� ********** ');
          --  ��������� ������� ANI-10. ����� �i����i�����i ����.���-���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-10. ����� �i����i�����i ����.���-���',
                                                  p_funcname => 'Sel030(hWndMDI,1,800,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-������ � �������i ��������i� ********** ');
          --  ��������� ������� ��-������ � �������i ��������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-������ � �������i ��������i�',
                                                  p_funcname => 'Sel030(hWndMDI,11,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������i ����� �� �������. ********** ');
          --  ��������� ������� ���������i ����� �� �������.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������i ����� �� �������.',
                                                  p_funcname => 'Sel030(hWndMDI,14,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����i� ������� �� ���i�� ********** ');
          --  ��������� ������� ����i� ������� �� ���i��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����i� ������� �� ���i��',
                                                  p_funcname => 'Sel030(hWndMDI,22,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-32. ��������i��� ����.���-��� �� ���. �� ������. �i�i ********** ');
          --  ��������� ������� ANI-32. ��������i��� ����.���-��� �� ���. �� ������. �i�i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32. ��������i��� ����.���-��� �� ���. �� ������. �i�i',
                                                  p_funcname => 'Sel030(hWndMDI,32,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-32n. ��������i��� ����.���-��� �� ���. �� ������. �i�i ********** ');
          --  ��������� ������� ANI-32n. ��������i��� ����.���-��� �� ���. �� ������. �i�i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32n. ��������i��� ����.���-��� �� ���. �� ������. �i�i',
                                                  p_funcname => 'Sel030(hWndMDI,32,1,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-������ � �������i ��������i� (�/� 6-7 ��) ********** ');
          --  ��������� ������� ��-������ � �������i ��������i� (�/� 6-7 ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-������ � �������i ��������i� (�/� 6-7 ��)',
                                                  p_funcname => 'Sel030(hWndMDI,4,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-5. ����������i� ������i� (SNAP) ********** ');
          --  ��������� ������� ANI-5. ����������i� ������i� (SNAP)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-5. ����������i� ������i� (SNAP)',
                                                  p_funcname => 'Sel030(hWndMDI,5,7,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-6.Var-����i� ********** ');
          --  ��������� ������� ANI-6.Var-����i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-6.Var-����i�',
                                                  p_funcname => 'Sel030(hWndMDI,6,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��������� �������  (����� - ������) ********** ');
          --  ��������� ������� ����� ��������� �������  (����� - ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������� �������  (����� - ������)',
                                                  p_funcname => 'ShowBal(hWndMDI, 1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������� ����� � ������� ********** ');
          --  ��������� ������� ����� ������� ����� � �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������� ����� � �������',
                                                  p_funcname => 'ShowDin(hWndMDI)',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� �������� �� ������� �� ���-3900 ********** ');
          --  ��������� ������� �������� ���� �������� �� ������� �� ���-3900
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� �������� �� ������� �� ���-3900',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI, 3 )',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-�������� �� ������� ********** ');
          --  ��������� ������� ������-�������-�������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-�������� �� �������',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,189)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-�������� �������� BRANCH ********** ');
          --  ��������� ������� ������-�������-�������� �������� BRANCH
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-�������� �������� BRANCH',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,91893)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (ANI1) - ��� �������� �������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappANI1.sql =========*** En
PROMPT ===================================================================================== 
