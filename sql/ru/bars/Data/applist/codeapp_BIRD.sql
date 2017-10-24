SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_BIRD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  BIRD ***
  declare
    l_application_code varchar2(10 char) := 'BIRD';
    l_application_name varchar2(300 char) := '��� ������ ��������(Ĳ���)';
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
     DBMS_OUTPUT.PUT_LINE(' BIRD ��������� (��� ���������) ��� ��� ������ ��������(Ĳ���) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY0. �������� �����䳿 ********** ');
          --  ��������� ������� ZAY0. �������� �����䳿
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY0. �������� �����䳿',
                                                  p_funcname => 'FunNSIEditF(''V_ZAY_DATA_TRANSFER'', 2 | 0x0010)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY0. �������� �����䳿 ********** ');
          --  ��������� ������� ZAY0. �������� �����䳿
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY0. �������� �����䳿',
                                                  p_funcname => 'FunNSIEditF(''V_ZAY_DATA_TRANSFER'', 2 | 0x0010)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY0. �������� �����䳿 ********** ');
          --  ��������� ������� ZAY0. �������� �����䳿
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY0. �������� �����䳿',
                                                  p_funcname => 'FunNSIEditF(''V_ZAY_DATA_TRANSFER'', 2 | 0x0010)',
                                                  p_rolename => 'ZAY' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY1.  ���: ���� ������ �� �������-������� ������ ********** ');
          --  ��������� ������� ZAY1.  ���: ���� ������ �� �������-������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY1.  ���: ���� ������ �� �������-������� ������',
                                                  p_funcname => 'ZAYAVKA(hWndMDI,31)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY7.  ���: �������� ������ �� �������-������� ������ ********** ');
          --  ��������� ������� ZAY7.  ���: �������� ������ �� �������-������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY7.  ���: �������� ������ �� �������-������� ������',
                                                  p_funcname => 'ZAYAVKA(hWndMDI,311)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY42. �����: �������������� ������ �� �������-������� ������ (�����.) ********** ');
          --  ��������� ������� ZAY42. �����: �������������� ������ �� �������-������� ������ (�����.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY42. �����: �������������� ������ �� �������-������� ������ (�����.)',
                                                  p_funcname => 'ZAYAVKA(hWndMDI,51)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY52. �����: ����������� ����.������ (�����.) ********** ');
          --  ��������� ������� ZAY52. �����: ����������� ����.������ (�����.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY52. �����: ����������� ����.������ (�����.)',
                                                  p_funcname => 'ZAYAVKA(hWndMDI,52)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (BIRD) - ��� ������ ��������(Ĳ���)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappBIRD.sql =========*** En
PROMPT ===================================================================================== 
