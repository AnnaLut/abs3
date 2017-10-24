SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_AUDI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  AUDI ***
  declare
    l_application_code varchar2(10 char) := 'AUDI';
    l_application_name varchar2(300 char) := '������-����� �� ��';
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
     DBMS_OUTPUT.PUT_LINE(' AUDI ��������� (��� ���������) ��� ������-����� �� �� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Export-4. ��������-�������� �i���i��� ********** ');
          --  ��������� ������� Export-4. ��������-�������� �i���i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-4. ��������-�������� �i���i���',
                                                  p_funcname => 'ExportCatQuery(4586,"",7,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Export-1. ��i ��������i� ********** ');
          --  ��������� ������� Export-1. ��i ��������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-1. ��i ��������i�',
                                                  p_funcname => 'ExportCatQuery(4587,"",7,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Export-3. ���i���� ����������i� ********** ');
          --  ��������� ������� Export-3. ���i���� ����������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-3. ���i���� ����������i�',
                                                  p_funcname => 'ExportCatQuery(4588,"",7,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Export-2. ���� ������i� ********** ');
          --  ��������� ������� Export-2. ���� ������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-2. ���� ������i�',
                                                  p_funcname => 'ExportCatQuery(4589,"",7,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Export-6. ����� F_22. ********** ');
          --  ��������� ������� Export-6. ����� F_22.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-6. ����� F_22.',
                                                  p_funcname => 'ExportCatQuery(4746,"",7,"",TRUE)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.������� �������� Test_Del1 ********** ');
          --  ��������� ������� 1.������� �������� Test_Del1
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.������� �������� Test_Del1',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(1,:Par1,:Par2)][PAR=>:Par1(SEM= ���.���� dd.mm.yyyy>,TYPE=S),:Par2(SEM= �i�.���� dd.mm.yyyy>,TYPE=S)]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.���� ������i� Test_Del2 ********** ');
          --  ��������� ������� 2.���� ������i� Test_Del2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.���� ������i� Test_Del2',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(2,:Par1,:Par2)][PAR=>:Par1(SEM= ���.���� dd.mm.yyyy>,TYPE=S),:Par2(SEM= �i�.���� dd.mm.yyyy>,TYPE=S)]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3.���i���� ����������i� Test_Del3 ********** ');
          --  ��������� ������� 3.���i���� ����������i� Test_Del3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.���i���� ����������i� Test_Del3',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(3,'''','''')]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.������� ��-����� �i���i��� Test_Del4 ********** ');
          --  ��������� ������� 4.������� ��-����� �i���i��� Test_Del4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.������� ��-����� �i���i��� Test_Del4',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(4,:Par1,:Par2)][PAR=>:Par1(SEM= ���.���� dd.mm.yyyy>,TYPE=S),:Par2(SEM= �i�.���� dd.mm.yyyy>,TYPE=S)]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5.���������� �i����i ������i� � ���.Test_Del4 ********** ');
          --  ��������� ������� 5.���������� �i����i ������i� � ���.Test_Del4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5.���������� �i����i ������i� � ���.Test_Del4',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(5,'''','''')]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6.����� F_22. Test_Del6 ********** ');
          --  ��������� ������� 6.����� F_22. Test_Del6
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.����� F_22. Test_Del6',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(6,:Par1,:Par1)][PAR=>:Par1(SEM= ��i��� ���� dd.mm.yyyy>,TYPE=S)]")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� View + Export-6. ����� F_22. ********** ');
          --  ��������� ������� View + Export-6. ����� F_22.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'View + Export-6. ����� F_22.',
                                                  p_funcname => 'FunNSIEditF("TEST_DEL6",1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5�.�������� �i����i ������i� � ���.Test_Del4 ********** ');
          --  ��������� ������� 5�.�������� �i����i ������i� � ���.Test_Del4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5�.�������� �i����i ������i� � ���.Test_Del4',
                                                  p_funcname => 'FunNSIEditFFiltered("TEST_DEL4",1,"(DEL_KN<>0 or DEL_DN<>0)")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (AUDI) - ������-����� �� ��  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappAUDI.sql =========*** En
PROMPT ===================================================================================== 
