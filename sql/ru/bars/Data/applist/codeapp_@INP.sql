SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_@INP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  @INP ***
  declare
    l_application_code varchar2(10 char) := '@INP';
    l_application_name varchar2(300 char) := '��� ֳ�� ������';
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
     DBMS_OUTPUT.PUT_LINE(' @INP ��������� (��� ���������) ��� ��� ֳ�� ������ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����� �� ��������� Y/H/Q/M/D ********** ');
          --  ��������� ������� ��: ����� �� ��������� Y/H/Q/M/D
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����� �� ��������� Y/H/Q/M/D',
                                                  p_funcname => 'FunNSIEditF("CP_HIERARCHY_REPORT[PROC=>p_cp_hierarchy_report(0,:B,:E,:Z,:P)][PAR=>:B(SEM=�,TYPE=D),:E(SEM=��,TYPE=D),:Z(SEM=��������� ���/� =1/0,TYPE=N),:P(SEM=Y/H/Q/M/D,TYPE=C)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����� ��� ��������� ����������� ������������� ********** ');
          --  ��������� ������� ��: ����� ��� ��������� ����������� �������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����� ��� ��������� ����������� �������������',
                                                  p_funcname => 'FunNSIEditF("V_CPDEAL_EXPPAY", 2)',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: �������������� ����� KALENDAR ********** ');
          --  ��������� ������� ��: �������������� ����� KALENDAR
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: �������������� ����� KALENDAR',
                                                  p_funcname => 'FunNSIEditF("V_CP_KALENDAR[PROC=>CP_KALENDAR(0,:B,:E,:Z,:F,:P)][PAR=>:B(SEM=���� � <dd.mm.yyyy>,TYPE=D),:E(SEM=���� �� <dd.mm.yyyy>,TYPE=D),:Z(SEM=���� ���/�_ 1/0,TYPE=N),:F(SEM=�����=KLB/KLS,TYPE=C),:P(SEM=���_��=Y/H/Q/M/D,TYPE=C)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����� KALENDAR �� �� (���������) ********** ');
          --  ��������� ������� ��: ����� KALENDAR �� �� (���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����� KALENDAR �� �� (���������)',
                                                  p_funcname => 'FunNSIEditFFiltered("V_CP_KALENDAR_BUY",0,"frm=''KLB'' " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����� KALENDAR �� �� (������/���������) ********** ');
          --  ��������� ������� ��: ����� KALENDAR �� �� (������/���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����� KALENDAR �� �� (������/���������)',
                                                  p_funcname => 'FunNSIEditFFiltered("V_CP_KALENDAR_SALE",0,"frm=''KLS'' " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: �������� ���� ********** ');
          --  ��������� ������� ����: �������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: �������� ����',
                                                  p_funcname => 'Sel008( hWndMDI, 0, 1 ,"", "vidd in (1622, 1522)" ) ',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ��������� ********** ');
          --  ��������� ������� ��- �������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ���������',
                                                  p_funcname => 'Sel008( hWndMDI, 20, 22, " 37392555, 35413555, 36412555, ", " " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ��������� ********** ');
          --  ��������� ������� ��- �������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ���������',
                                                  p_funcname => 'Sel008( hWndMDI, 20, 8, " 354190701, 3541603001, 364120703, ", " " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: �������� ���� + ������i ********** ');
          --  ��������� ������� ����: �������� ���� + ������i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: �������� ���� + ������i',
                                                  p_funcname => 'Sel008( hWndMDI, 2001, 0 ,"#vidd in (1622, 1522)", "100" )',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: �������� ���� + ������i ********** ');
          --  ��������� ������� ����: �������� ���� + ������i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: �������� ���� + ������i',
                                                  p_funcname => 'Sel008( hWndMDI, 2001, 0 ,"#vidd in (1622, 1522)", "100" )',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: �������� ���� + ������i ********** ');
          --  ��������� ������� ����: �������� ���� + ������i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: �������� ���� + ������i',
                                                  p_funcname => 'Sel008( hWndMDI, 2001, 0 ,"#vidd in (1622, 1522)", "100" )',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- ���i� ���� ��� ********** ');
          --  ��������� ������� ��- ���i� ���� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- ���i� ���� ���',
                                                  p_funcname => 'Sel008( hWndMDI, 21, 0, " ", " and KV!=980 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- ���i� ���� ��� ********** ');
          --  ��������� ������� ��- ���i� ���� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- ���i� ���� ���',
                                                  p_funcname => 'Sel008( hWndMDI, 21, 0, " ", " and KV=980 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� / �������� ********** ');
          --  ��������� ������� ��- �������� / ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� / ��������',
                                                  p_funcname => 'Sel008( hWndMDI, 22, 0 ,"", "" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- ³������� ���� � ������� ********** ');
          --  ��������� ������� ��- ³������� ���� � �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- ³������� ���� � �������',
                                                  p_funcname => 'Sel008( hWndMDI, 24, 12 ,"", "" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- ³������� ���� � ������� ********** ');
          --  ��������� ������� ��- ³������� ���� � �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- ³������� ���� � �������',
                                                  p_funcname => 'Sel008( hWndMDI, 24, 16 ,"", "" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ����� ������� ��� ********** ');
          --  ��������� ������� ��- �������� ����� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ����� ������� ���',
                                                  p_funcname => 'Sel008( hWndMDI, 25, 22, " 37392555, 35413555, 36412555, ", " and KV<>980 and TIP=1" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��*- �������� ����� ������� ��� (2 ����_��_�� +���) ********** ');
          --  ��������� ������� ��*- �������� ����� ������� ��� (2 ����_��_�� +���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��*- �������� ����� ������� ��� (2 ����_��_�� +���)',
                                                  p_funcname => 'Sel008( hWndMDI, 25, 22, " 37392555, 35413555, 36412555, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ����� ������� ��� ********** ');
          --  ��������� ������� ��- �������� ����� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ����� ������� ���',
                                                  p_funcname => 'Sel008( hWndMDI, 25, 8, " 354190701, 3541603001, 364120703, ", " and KV<>980 and TIP=1" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��*- �������� ����� ������� ��� (2 ����_��_�� +���) ********** ');
          --  ��������� ������� ��*- �������� ����� ������� ��� (2 ����_��_�� +���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��*- �������� ����� ������� ��� (2 ����_��_�� +���)',
                                                  p_funcname => 'Sel008( hWndMDI, 25, 8, " 354190701, 3541603001, 364120703, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ������ ����  ��� ********** ');
          --  ��������� ������� ��- �������� ������ ����  ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ������ ����  ���',
                                                  p_funcname => 'Sel008( hWndMDI, 26, 22, " 37392555, 35413555, 36412555, ", " and KV<>980 and TIP=2" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ������ ���� ���  ********** ');
          --  ��������� ������� ��- �������� ������ ���� ��� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ������ ���� ��� ',
                                                  p_funcname => 'Sel008( hWndMDI, 26, 22, " 37392555, 35413555, 36412555, ", " and KV=980 and TIP=2" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ������ ����  ��� ********** ');
          --  ��������� ������� ��- �������� ������ ����  ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ������ ����  ���',
                                                  p_funcname => 'Sel008( hWndMDI, 26, 8, " 354190701, 3541603001, 364120703, ", " and KV<>980 and TIP=2" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ������ ���� ���  ********** ');
          --  ��������� ������� ��- �������� ������ ���� ��� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ������ ���� ��� ',
                                                  p_funcname => 'Sel008( hWndMDI, 26, 8, " 354190701, 3541603001, 364120703, ", " and KV=980 and TIP=2" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- ��������� ��� (��������� �����) ********** ');
          --  ��������� ������� ��- ��������� ��� (��������� �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- ��������� ��� (��������� �����)',
                                                  p_funcname => 'Sel008( hWndMDI, 28, 1 ,"", "  " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- ��������� ��� (��������� �����) ********** ');
          --  ��������� ������� ��- ��������� ��� (��������� �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- ��������� ��� (��������� �����)',
                                                  p_funcname => 'Sel008( hWndMDI, 28, 2 ,"", "  " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ����� ������� ��� (3 ����_��_��) ********** ');
          --  ��������� ������� ��- �������� ����� ������� ��� (3 ����_��_��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ����� ������� ��� (3 ����_��_��)',
                                                  p_funcname => 'Sel008( hWndMDI,35, 22, " 37392555, 35413555, 36412555, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ����� ������� ��� (3 ����_��_��) ********** ');
          --  ��������� ������� ��- �������� ����� ������� ��� (3 ����_��_��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ����� ������� ��� (3 ����_��_��)',
                                                  p_funcname => 'Sel008( hWndMDI,35, 8, " 354190701, 3541603001, 364120703, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ����� ������� ��� (4 ���������) ********** ');
          --  ��������� ������� ��- �������� ����� ������� ��� (4 ���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ����� ������� ��� (4 ���������)',
                                                  p_funcname => 'Sel008( hWndMDI,45, 22, " 37392555, 35413555, 36412555, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��- �������� ����� ������� ��� (4 ���������) ********** ');
          --  ��������� ������� ��- �������� ����� ������� ��� (4 ���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��- �������� ����� ������� ��� (4 ���������)',
                                                  p_funcname => 'Sel008( hWndMDI,45, 8, " 354190701, 3541603001, 364120703, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (@INP) - ��� ֳ�� ������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp@INP.sql =========*** En
PROMPT ===================================================================================== 
