SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_BIRZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  BIRZ ***
  declare
    l_application_code varchar2(10 char) := 'BIRZ';
    l_application_name varchar2(300 char) := '��� ������ ��������(���������)';
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
     DBMS_OUTPUT.PUT_LINE(' BIRZ ��������� (��� ���������) ��� ��� ������ ��������(���������) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAYO. �������� ���������� ���� ���������� ********** ');
          --  ��������� ������� ZAYO. �������� ���������� ���� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAYO. �������� ���������� ���� ����������',
                                                  p_funcname => 'F1_Select(13,"bars_zay.set_currency_income(DAT);�������� �������� ����� ��� ����������� � ��?;��������!")',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAYR. ���������� �� ����������� ���������� ********** ');
          --  ��������� ������� ZAYR. ���������� �� ����������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAYR. ���������� �� ����������� ����������',
                                                  p_funcname => 'FunNSIEditF("zay_currency_income[PROC=>p_zay_currency_income(:Par0,:Par1)][PAR=>:Par0(SEM=����,TYPE=D),:Par1(SEM=�������������?���->1/�i->0,TYPE=N)][EXEC=>BEFORE][MSG=>��]",2)',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY8. �������� ������ �� ��������(CORP2) ********** ');
          --  ��������� ������� ZAY8. �������� ������ �� ��������(CORP2)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY8. �������� ������ �� ��������(CORP2)',
                                                  p_funcname => 'ZAYAVKA(hWndMDI,8)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY21. ���: ����������� ������ �� ������� ������ ********** ');
          --  ��������� ������� ZAY21. ���: ����������� ������ �� ������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY21. ���: ����������� ������ �� ������� ������',
                                                  p_funcname => 'ZAYf(hWndMDI,3321)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY22. ���: ����������� ������ �� ������� ������ ********** ');
          --  ��������� ������� ZAY22. ���: ����������� ������ �� ������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY22. ���: ����������� ������ �� ������� ������',
                                                  p_funcname => 'ZAYf(hWndMDI,3322)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY95. ������������ ������� ������ ********** ');
          --  ��������� ������� ZAY95. ������������ ������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY95. ������������ ������� ������',
                                                  p_funcname => 'ZAYf(hWndMDI,34)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY3.  ���: ������������ ����������� ������ ********** ');
          --  ��������� ������� ZAY3.  ���: ������������ ����������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY3.  ���: ������������ ����������� ������',
                                                  p_funcname => 'ZAYf(hWndMDI,36)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY9.  ���: �������� � �������������� ������ �� �������-������� ������ ********** ');
          --  ��������� ������� ZAY9.  ���: �������� � �������������� ������ �� �������-������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY9.  ���: �������� � �������������� ������ �� �������-������� ������',
                                                  p_funcname => 'ZAYf(hWndMDI,999)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (BIRZ) - ��� ������ ��������(���������)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappBIRZ.sql =========*** En
PROMPT ===================================================================================== 
