SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_BUHG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  BUHG ***
  declare
    l_application_code varchar2(10 char) := 'BUHG';
    l_application_name varchar2(300 char) := '��� �������� ���������';
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
     DBMS_OUTPUT.PUT_LINE(' BUHG ��������� (��� ���������) ��� ��� �������� ��������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� ��������� ********** ');
          --  ��������� ������� ���. ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� ���������',
                                                  p_funcname => 'DocViewListArc(hWndMDI,'''', '''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-������:NL9/2909/56 -> �.2620 �� SWIFT ********** ');
          --  ��������� ������� ����-������:NL9/2909/56 -> �.2620 �� SWIFT
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-������:NL9/2909/56 -> �.2620 �� SWIFT',
                                                  p_funcname => 'F1_Select(13,"NLK_AUTO(''NL9'',''2909'',''56'');�� ������ ���."����-������:�.NL9/2909/56 -�/2620" ?; ��������� !" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-������:NL9/2909/56 -> �.2620 �� SWIFT ********** ');
          --  ��������� ������� ����-������:NL9/2909/56 -> �.2620 �� SWIFT
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-������:NL9/2909/56 -> �.2620 �� SWIFT',
                                                  p_funcname => 'F1_Select(13,"NLK_AUTO(''NL9'',''2909'',''56'');�� ������ ���.<����-������:�.NL9/2909/56 -�/2620> ?; ��������� !" )',
                                                  p_rolename => 'PYOD001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� (���� ����) ********** ');
          --  ��������� ������� ³������� �������� (���� ����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� (���� ����)',
                                                  p_funcname => 'FunCheckDocuments()',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� (����� ��������) ********** ');
          --  ��������� ������� ³������� �������� (����� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� (����� ��������)',
                                                  p_funcname => 'FunCheckDocumentsEx(hWndMDI, " a.TOBO = tobopack.GetTobo ")',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������� ������i� ��� ������ ��-3 � MTI ********** ');
          --  ��������� ������� �i������� ������i� ��� ������ ��-3 � MTI
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������� ������i� ��� ������ ��-3 � MTI',
                                                  p_funcname => 'FunNSIEdit("[PROC=>MONEX_RU.OP_NLS_MTI(:B1,:B2,:B3,:B4,:B5)][PAR=>:B1(SEM=�1,REF=BRANCH3),:B2(SEM=�2,REF=BRANCH3),:B3(SEM=�3,REF=BRANCH3),:B4(SEM=�4,REF=BRANCH3),:B5(SEM=�5,REF=BRANCH3)][MSG=>OK]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ������� ��� ������������ ����������. ********** ');
          --  ��������� ������� ³������� ������� ��� ������������ ����������.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ������� ��� ������������ ����������.',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BR_CP(:A,:B)][PAR=>:A(SEM=���.���.,REF=V_CP_RETEIL),:B(SEM=�����,REF=BRANCH3)][MSG=>OK]")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-�i���.���. �� ��I� �i���� ��� 1-�� ������ 2,3 �i��� ********** ');
          --  ��������� ������� ����-�i���.���. �� ��I� �i���� ��� 1-�� ������ 2,3 �i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-�i���.���. �� ��I� �i���� ��� 1-�� ������ 2,3 �i���',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BR_SX(:sPar1)][PAR=>:sPar1(SEM=�����,TYPE=S,REF=BRANCH)][MSG=>OK OP_BR_SX !]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-�i���.���. �� 1-� �i���� ��� ������ 2,2+,3 �i��� ********** ');
          --  ��������� ������� ����-�i���.���. �� 1-� �i���� ��� ������ 2,2+,3 �i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-�i���.���. �� 1-� �i���� ��� ������ 2,2+,3 �i���',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BR_SX1(:sPar1,:sPar2)][PAR=>:sPar1(SEM=�����,TYPE=S,REF=BRANCH_VAR),:sPar2(SEM=�i��i���,TYPE=S,REF=VALUABLES)][MSG=>OK OP_BR_SX1 !]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-�i���.���. �� ��+��22 ��� ��i� �����i� 2 ********** ');
          --  ��������� ������� ����-�i���.���. �� ��+��22 ��� ��i� �����i� 2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-�i���.���. �� ��+��22 ��� ��i� �����i� 2',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BSOBV(0,:V,:A,'''','''','''','''')][PAR=>:V(SEM=���,TYPE=N),:A(SEM=������,REF=V_NBSOB22)][MSG=>OK]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-�i���.���. �� ��+��22 ��� ������ 2,2+,3 �i��� ********** ');
          --  ��������� ������� ����-�i���.���. �� ��+��22 ��� ������ 2,2+,3 �i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-�i���.���. �� ��+��22 ��� ������ 2,2+,3 �i���',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BSOBV(1,:V,:A,:B,'''','''',''''  )][PAR=>:V(SEM=���,TYPE=N),:A(SEM=������,REF=V_NBSOB22),:B(SEM=�����,REF=BRANCH_VAR)][MSG=>OK]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-�i���.���. �� ��+��22 ��� �i����� ��(2,2+,3) ********** ');
          --  ��������� ������� ����-�i���.���. �� ��+��22 ��� �i����� ��(2,2+,3)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-�i���.���. �� ��+��22 ��� �i����� ��(2,2+,3)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BSOBV(2,:V,:A,:B,:C,:D,:E)][PAR=>:V(SEM=���,TYPE=N),:A(SEM=������,REF=V_NBSOB22),:B(SEM=�-1,REF=BRANCH_VAR),:C(SEM=�-2,REF=BRANCH_VAR),:D(SEM=�-3,REF=BRANCH_VAR),:E(SEM=�-4,REF=BRANCH_VAR)][MSG=>OK]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� � 3800 ��������������� 6204 ********** ');
          --  ��������� ������� ��������� � 3800 ��������������� 6204
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� � 3800 ��������������� 6204',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_3800_6204(1)][MSG=>OK P_3800_6204 !]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-���� = ��� (���� ��� ������) ********** ');
          --  ��������� ������� ����-���� = ��� (���� ��� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-���� = ��� (���� ��� ������)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_3800_6204(2)][MSG=>OK P_3800_6204/2 !]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� HE_���i���.���. �� �i�������(2.�i���.+��������) ********** ');
          --  ��������� ������� HE_���i���.���. �� �i�������(2.�i���.+��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'HE_���i���.���. �� �i�������(2.�i���.+��������)',
                                                  p_funcname => 'FunNSIEditF(  "NOT_NLS98[PROC=>OP_BR_SXN(1)][EXEC=>BEFORE][MSG=>OK!]",2)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� HE_���i���.���. �� �i�������(1.�i���� ��������) ********** ');
          --  ��������� ������� HE_���i���.���. �� �i�������(1.�i���� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'HE_���i���.���. �� �i�������(1.�i���� ��������)',
                                                  p_funcname => 'FunNSIEditF( "NOT_NLS98" , 1 )',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ <-> ������������ <-> ������� ********** ');
          --  ��������� ������� ������ <-> ������������ <-> �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ <-> ������������ <-> �������',
                                                  p_funcname => 'FunNSIEditF("CC_PAWN_DP",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I��������i� ��i� ���.����i� ����� ********** ');
          --  ��������� ������� I��������i� ��i� ���.����i� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I��������i� ��i� ���.����i� �����',
                                                  p_funcname => 'FunNSIEditF("CUR_RATE_KOM_UPD",1 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� � ������i� 2625/22(����.2012) ********** ');
          --  ��������� ������� ������� � ������i� 2625/22(����.2012)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� � ������i� 2625/22(����.2012)',
                                                  p_funcname => 'FunNSIEditF("VDEB_2625_22[PROC=>PUL_DAT(:Par0,:Par1)][PAR=>:Par0(SEM=� dd.mm.yyyy>,TYPE=S),:Par1(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����: �������i ������ � ������i ********** ');
          --  ��������� ������� �������� ����: �������i ������ � ������i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����: �������i ������ � ������i',
                                                  p_funcname => 'FunNSIEditF("V_ICCK[PROC=>ICCK(2)][EXEC=>BEFORE][MSG=>OK!]",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� �� ����������� ��� �999990 ********** ');
          --  ��������� ������� �������� �������� �� ����������� ��� �999990
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� �� ����������� ��� �999990',
                                                  p_funcname => 'FunNSIEditF(''TMP_9760_2013'',2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����   : ����� ��� ���������� ��������� ********** ');
          --  ��������� ������� I�����   : ����� ��� ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����   : ����� ��� ���������� ���������',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 3, '''','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ********** ');
          --  ��������� ������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������',
                                                  p_funcname => 'Sel002(hWndMDI,14,0," "," ")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������i� ���i�i� ��� �� ���-������i ********** ');
          --  ��������� ������� ����������i� ���i�i� ��� �� ���-������i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������i� ���i�i� ��� �� ���-������i',
                                                  p_funcname => 'Sel002(hWndMDI,18,1,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������������� �� ������ ********** ');
          --  ��������� ������� ��������� ������������� �� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������������� �� ������',
                                                  p_funcname => 'Sel002(hWndMDI,19,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i���� �����-2 ********** ');
          --  ��������� ������� �����i���� �����-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i���� �����-2',
                                                  p_funcname => 'Sel002(hWndMDI,29,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i���� �����-3 ********** ');
          --  ��������� ������� �����i���� �����-3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i���� �����-3',
                                                  p_funcname => 'Sel002(hWndMDI,29,1,"","")',
                                                  p_rolename => 'PYOD001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� � ������.�� �� �� ********** ');
          --  ��������� ������� ���������� � ������.�� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� � ������.�� �� ��',
                                                  p_funcname => 'Sel023(hWndMDI,391,NUMBER_Null,"KAZ_ZOBT,KAZ_ZOBP(0)","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ��� 6-7 ����� (����������) ********** ');
          --  ��������� ������� ��������� ��� 6-7 ����� (����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ��� 6-7 ����� (����������)',
                                                  p_funcname => 'Sel023(hWndMDI,7,10,"PER_REBRANCH","")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����� ��ϲ�˲-������� USD, EUR, RUB � ���� ********** ');
          --  ��������� ������� ��������� ����� ��ϲ�˲-������� USD, EUR, RUB � ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����� ��ϲ�˲-������� USD, EUR, RUB � ����',
                                                  p_funcname => 'Sel025( hWndMDI,96, 0, " ", "0" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����� ��ϲ�˲-������� USD, EUR, RUB � ���� ********** ');
          --  ��������� ������� �������� ����� ��ϲ�˲-������� USD, EUR, RUB � ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����� ��ϲ�˲-������� USD, EUR, RUB � ����',
                                                  p_funcname => 'Sel025( hWndMDI,96, 1, " ", "0" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ �������� ����� �����/������� ����� �������� ����� ********** ');
          --  ��������� ������� ������������ �������� ����� �����/������� ����� �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �������� ����� �����/������� ����� �������� �����',
                                                  p_funcname => 'Sel028(hWndMDI,1,1,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���������� ����.�����. OB22 ********** ');
          --  ��������� ������� �������� ���������� ����.�����. OB22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������� ����.�����. OB22',
                                                  p_funcname => 'Sel040( hWndMDI, 22, 0 , "" ,"" )',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� ********** ');
          --  ��������� ������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �������',
                                                  p_funcname => 'ShowAccList(0, AVIEW_USER, AVIEW_Linked | AVIEW_Limit | AVIEW_Financial | AVIEW_Interest | AVIEW_Access | AVIEW_Special, '''')',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i ���., �� ��������� � ��������� ����� 15 ��. ********** ');
          --  ��������� ������� �����i ���., �� ��������� � ��������� ����� 15 ��.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i ���., �� ��������� � ��������� ����� 15 ��.',
                                                  p_funcname => 'ShowAllDocs(hWndMDI,1,0," (a.nlsa like ''100%'' or a.nlsb like ''100%'') and exists (select 1 from oper_visa where ref=a.ref and status=2 and (dat-a.pdat)>1/96)", "�����i ���., �� ��������� � ��������� ����� 15 ��.")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� � ����������� ����� ********** ');
          --  ��������� ������� ���� ���� � ����������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ���� � ����������� �����',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -2)',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (BUHG) - ��� �������� ���������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappBUHG.sql =========*** En
PROMPT ===================================================================================== 
