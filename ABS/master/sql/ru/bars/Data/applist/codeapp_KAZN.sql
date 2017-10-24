SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KAZN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KAZN ***
  declare
    l_application_code varchar2(10 char) := 'KAZN';
    l_application_name varchar2(300 char) := '��� ����������� ������������';
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
     DBMS_OUTPUT.PUT_LINE(' KAZN ��������� (��� ���������) ��� ��� ����������� ������������ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���� ������� ********** ');
          --  ��������� ������� ���. ���� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���� �������',
                                                  p_funcname => 'DOC_PROC(TRUE)',
                                                  p_rolename => 'BARS014' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ˳�� �� "���" ���������� - 980 ********** ');
          --  ��������� ������� ˳�� �� "���" ���������� - 980
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '˳�� �� "���" ���������� - 980',
                                                  p_funcname => 'FunNSIEditF("LIM_LKL_RRP_980",0)',
                                                  p_rolename => 'TECH002' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� % �� ������� 3902,3903 ********** ');
          --  ��������� ������� ������������� % �� ������� 3902,3903
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� % �� ������� 3902,3903',
                                                  p_funcname => 'Sel010( hWndMDI, 1, 1,  " and s.NBS in (''3902'',''3903'') and i.NLSB is not null ", "1" ) ',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� % �� �������  3902,3903 ********** ');
          --  ��������� ������� ����������� % �� �������  3902,3903
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� % �� �������  3902,3903',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and  s.NBS in (''3902'', ''3903'')  ", ''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. �������� ��������� ��� (��������) ********** ');
          --  ��������� ������� ���. �������� ��������� ��� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. �������� ��������� ��� (��������)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"00",'''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� �볺��� � ������ �������  (��������) ********** ');
          --  ��������� ������� �������� �������� �볺��� � ������ �������  (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� �볺��� � ������ �������  (��������)',
                                                  p_funcname => 'ShowCustomers(ACCESS_READONLY, 3)',
                                                  p_rolename => 'CUST001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ������� ********** ');
          --  ��������� ������� ���. ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� �������',
                                                  p_funcname => 'ShowTechAccountsEx(0)',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (KAZN) - ��� ����������� ������������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKAZN.sql =========*** En
PROMPT ===================================================================================== 
