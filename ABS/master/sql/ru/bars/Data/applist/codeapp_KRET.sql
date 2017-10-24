SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KRET.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KRET ***
  declare
    l_application_code varchar2(10 char) := 'KRET';
    l_application_name varchar2(300 char) := '�� ����� (�����������)';
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
     DBMS_OUTPUT.PUT_LINE(' KRET ��������� (��� ���������) ��� �� ����� (�����������) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ���� + ���� + ��� ********** ');
          --  ��������� ������� �� ��: ���� + ���� + ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���� + ���� + ���',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 02, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ���� + ���� + ��� ********** ');
          --  ��������� ������� �� ��: ���� + ���� + ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���� + ���� + ���',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 03, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ��������� ********** ');
          --  ��������� ������� �� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 13, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ��������� ********** ');
          --  ��������� ������� �� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 23, 0, 5)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ��������� ********** ');
          --  ��������� ������� �� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 33, 0, 5)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����������� ********** ');
          --  ��������� ������� �� ��: �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: �����������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 83, 0,77  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����� ********** ');
          --  ��������� ������� �� ��: �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: �����',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 93, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����� ��% ********** ');
          --  ��������� ������� �� ��: ����� ��%
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ����� ��%',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 97, 03, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����� ��� ********** ');
          --  ��������� ������� �� ��: ����� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ����� ���',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 98, 03, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����� (��������) ********** ');
          --  ��������� ������� �� ��: ����� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ����� (��������)',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 99, 00, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ <-> ������ ������ ********** ');
          --  ��������� ������� ������������ <-> ������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ <-> ������ ������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, NUMBER_Null , 0, 0) ',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������  ��  ����� ������� ********** ');
          --  ��������� ������� ��������  ��  ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������  ��  ����� �������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, NUMBER_Null, 298, NUMBER_Null )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� (��� ��������) ********** ');
          --  ��������� ������� ���������� ������� (��� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� (��� ��������)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,101,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������  (� ����������)  ********** ');
          --  ��������� ������� ���������� �������  (� ����������) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������  (� ����������) ',
                                                  p_funcname => 'CC_INKRE(hWndMDI,102,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������-2 ������� (� ����������) ********** ');
          --  ��������� ������� ����������-2 ������� (� ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������-2 ������� (� ����������)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,104,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� - ������ ********** ');
          --  ��������� ������� ���������� ������� - ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� - ������',
                                                  p_funcname => 'CC_INKRE(hWndMDI,106,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� � ���������� ���������� (��) ********** ');
          --  ��������� ������� �������� � ���������� ���������� (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� � ���������� ���������� (��)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,3,297,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F0: ����-����� ������� ��������� SG ********** ');
          --  ��������� ������� �� F0: ����-����� ������� ��������� SG
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F0: ����-����� ������� ��������� SG',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASG ( 0, 1)"  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S. ����-��������� ������� ����� SS -  �� ********** ');
          --  ��������� ������� S. ����-��������� ������� ����� SS -  ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S. ����-��������� ������� ����� SS -  ��',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( -1, 1 ) "  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #1) �� S2: ����-��������� ������� ����� SS ********** ');
          --  ��������� ������� #1) �� S2: ����-��������� ������� ����� SS
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#1) �� S2: ����-��������� ������� ����� SS',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( 0, 1 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F1: ����������� ������� �� 9129 �� �� ********** ');
          --  ��������� ������� �� F1: ����������� ������� �� 9129 �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F1: ����������� ������� �� 9129 �� ��',
                                                  p_funcname => 'F1_Select(12, " cck.CC_9129( DAT, 0, 0 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #0) �� S1: ���������� ���.�� ������� ********** ');
          --  ��������� ������� #0) �� S1: ���������� ���.�� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#0) �� S1: ���������� ���.�� �������',
                                                  p_funcname => 'F1_Select(12, "cck.CC_DAY_LIM ( DAT , 0) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������������ �����. ���� � 9 ���� ********** ');
          --  ��������� ������� ��. ������������ �����. ���� � 9 ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������������ �����. ���� � 9 ����',
                                                  p_funcname => 'F1_Select(12, ''OBPC.PK_OVR(9)'')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S32: ����-��������� ������� �����.% SN �� ********** ');
          --  ��������� ������� �� S32: ����-��������� ������� �����.% SN ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S32: ����-��������� ������� �����.% SN ��',
                                                  p_funcname => 'F1_Select(13,"CCK.CC_ASPN (2, 0, 1 );�� ������ ������� �� ��������� % ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S33: ����-��������� ������� �����.% SN �� ********** ');
          --  ��������� ������� �� S33: ����-��������� ������� �����.% SN ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S33: ����-��������� ������� �����.% SN ��',
                                                  p_funcname => 'F1_Select(13,"CCK.CC_ASPN (3, 0, 1 );�� ������ ������� �� ��������� % ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F4: �������� ����������� ������ ********** ');
          --  ��������� ������� �� F4: �������� ����������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F4: �������� ����������� ������',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY(0,DAT,0);�� ������ ���.������������ ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S7: ����������� ����/���� ********** ');
          --  ��������� ������� �� S7: ����������� ����/����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S7: ����������� ����/����',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY_PET(0,DAT,3);�� ������ ���. ���������� ��������?; ��������!" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S8: ���� �������� �������� �� ********** ');
          --  ��������� ������� �� S8: ���� �������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S8: ���� �������� �������� ��',
                                                  p_funcname => 'F1_Select(13,"cc_close(2,DAT);�� ������ ���. ���� �������� ���. �� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S8: ���� �������� �������� �� ********** ');
          --  ��������� ������� �� S8: ���� �������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S8: ���� �������� �������� ��',
                                                  p_funcname => 'F1_Select(13,"cc_close(3,DAT);�� ������ ���. ���� �������� ���. �� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� �� ********** ');
          --  ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(2,DAT,0);�� ������ ������� �� ��������� ��� ������ ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� �� ********** ');
          --  ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(3,DAT,0);�� ������ ������� �� ��������� ��� ������ ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� "����" ********** ');
          --  ��������� ������� �������� �������� "����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� "����"',
                                                  p_funcname => 'FunNSIEditF("V_CCK_OSBB[PROC=>cck_OSBB_ex(0)][EXEC=>BEFORE]", 2 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� � ��������� � ������� ********** ');
          --  ��������� ������� �������� �� � ��������� � �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� � ��������� � �������',
                                                  p_funcname => 'FunNSIEditF("V_CC_SDI" ,1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� � �����.�� ********** ');
          --  ��������� ������� ���������� � �����.��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� � �����.��',
                                                  p_funcname => 'FunNSIEditF("V_CC_START",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F12: ���i����� ����������� %% �� ��� ���. � �� �� ********** ');
          --  ��������� ������� �� F12: ���i����� ����������� %% �� ��� ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F12: ���i����� ����������� %% �� ��� ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (1,2,3))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #5) �� F13: ���i����� ����������� %% �� ��� ���. � �� �� ********** ');
          --  ��������� ������� #5) �� F13: ���i����� ����������� %% �� ��� ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#5) �� F13: ���i����� ����������� %% �� ��� ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (11,12,13))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S52: ����������� %%  �� ������������ ���. � �� �� ********** ');
          --  ��������� ������� �� S52: ����������� %%  �� ������������ ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S52: ����������� %%  �� ������������ ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SP '') and i.acra is not null and i.acrb is not null",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S42: ����������� %%  �� �������� �����. ����� � �� �� ********** ');
          --  ��������� ������� �� S42: ����������� %%  �� �������� �����. ����� � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S42: ����������� %%  �� �������� �����. ����� � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SS '',''SP '') and i.acra is not null and i.acrb is not null and exists (select 1 from cc_lim where acc=s.accc and fdat=gl.bd  and sumo>0 and not_sn is null)",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S53: ����������� %%  �� ������������ ���. � �� �� ********** ');
          --  ��������� ������� �� S53: ����������� %%  �� ������������ ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S53: ����������� %%  �� ������������ ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''22%'' and s.tip in (''SP '') and i.acra is not null and i.acrb is not null",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #3) �� S42: ����������� %% �� ��. ����� � �� �� (��ӯ���) ********** ');
          --  ��������� ������� #3) �� S42: ����������� %% �� ��. ����� � �� �� (��ӯ���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#3) �� S42: ����������� %% �� ��. ����� � �� �� (��ӯ���)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.tip in(''SS '',''SP '')  and s.acc in (select N.acc from nd_acc n, cc_v d  where d.GPK=4 and n.nd=d.nd and d.vidd=1  and cck.PAY_GPK(gl.bd,D.ND,null)=1)","SAN")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #3) �� S43: ����������� %% �� ��. ����� � �� �� (��ӯ���) ********** ');
          --  ��������� ������� #3) �� S43: ����������� %% �� ��. ����� � �� �� (��ӯ���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#3) �� S43: ����������� %% �� ��. ����� � �� �� (��ӯ���)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.tip in(''SS '',''SP '')  and s.acc in (select N.acc from nd_acc n, cc_v d  where d.GPK=4 and n.nd=d.nd and d.vidd=11  and cck.PAY_GPK(gl.bd,D.ND,null)=1)","SAN")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F23: ���i����� ����������� ���񳿿 �� ��. ********** ');
          --  ��������� ������� �� F23: ���i����� ����������� ���񳿿 �� ��.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F23: ���i����� ����������� ���񳿿 �� ��.',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=2 and i.metr in (95,96,97,98) and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc nn,cc_deal dd where nn.nd=dd.nd and dd.vidd in (11,12,13) and nn.acc=s.acc) ",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���񳿿 �� �� ********** ');
          --  ��������� ������� ����������� ���񳿿 �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���񳿿 �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.METR>90 and i.acra is not null and i.acrb is not null","SA")',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S62: ����������� ���i  � �� �� ********** ');
          --  ��������� ������� �� S62: ����������� ���i  � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S62: ����������� ���i  � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''20%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs2 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S63: ����������� ���i  � �� �� ********** ');
          --  ��������� ������� �� S63: ����������� ���i  � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S63: ����������� ���i  � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''22%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs1 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� �� ������� ********** ');
          --  ��������� ������� ��������� ������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� �� �������',
                                                  p_funcname => 'Sel025( hWndMDI,297, 0, "CCK", "KK2" )',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ �����.% �� ��.%-��� ������ �� �� ********** ');
          --  ��������� ������� ������������ �����.% �� ��.%-��� ������ �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �����.% �� ��.%-��� ������ �� ��',
                                                  p_funcname => 'SqlPrepareAndExecute(hSql(),"declare r_ int; BEGIN cck.cc_irr(''IRR'',0,bankdate-1, r_);COMMIT;END;")',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������. ����������� �������� �������� ********** ');
          --  ��������� ������� �������. ����������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������. ����������� �������� ��������',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''KD%''  or id like ''CCK%''")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (KRET) - �� ����� (�����������)  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;


    DBMS_OUTPUT.PUT_LINE(' B����� ������� ������� ���������� ������������ - ����������� ����������� �� ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKRET.sql =========*** En
PROMPT ===================================================================================== 
