SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_BRON.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  BRON ***
  declare
    l_application_code varchar2(10 char) := 'BRON';
    l_application_name varchar2(300 char) := '��� ���������� ����� �� �������� ��';
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
     DBMS_OUTPUT.PUT_LINE(' BRON ��������� (��� ���������) ��� ��� ���������� ����� �� �������� �� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� *BRO  :����������� �����-������� � ���.���� ����� ********** ');
          --  ��������� ������� *BRO  :����������� �����-������� � ���.���� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*BRO  :����������� �����-������� � ���.���� �����',
                                                  p_funcname => 'F1_Select(12,''bro.INT_BRO_LAST_DAY(DAT)'')',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� *BROF: ����-�������� ���������� ���� ���������� ����� ********** ');
          --  ��������� ������� *BROF: ����-�������� ���������� ���� ���������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*BROF: ����-�������� ���������� ���� ���������� �����',
                                                  p_funcname => 'F1_Select(13,"BRO.CLOS_ALL(DAT);�������� ����-�������� ���������� ���� ���������� ����� ?;��������!")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� *BRO%: ����������� �����-������� ********** ');
          --  ��������� ������� *BRO%: ����������� �����-�������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*BRO%: ����������� �����-�������',
                                                  p_funcname => 'FunNSIEdit("[PROC=>BRO.INT_BRO(:D)][PAR=>:D(SEM=�� ���� �������,TYPE=D)][MSG=>�������� !]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� "������������� �������"(cen) ********** ');
          --  ��������� ������� "������������� �������"(cen)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"������������� �������"(cen)',
                                                  p_funcname => 'FunNSIEditF("V1_BRO",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� "������������� �������" ********** ');
          --  ��������� ������� "������������� �������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"������������� �������"',
                                                  p_funcname => 'FunNSIEditF("V1_BRO[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�����_�),:E(SEM=�����_��)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� BR1: ����.����� �� ���.��: ���� ********** ');
          --  ��������� ������� BR1: ����.����� �� ���.��: ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BR1: ����.����� �� ���.��: ����',
                                                  p_funcname => 'Sel027(hWndMDI,26,1," "," ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� BR3: ����.����� �� ���.��: ��������� ********** ');
          --  ��������� ������� BR3: ����.����� �� ���.��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BR3: ����.����� �� ���.��: ���������',
                                                  p_funcname => 'Sel027(hWndMDI,26,3," "," ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� BR4: ����.����� �� ���.��: ������� �������� ********** ');
          --  ��������� ������� BR4: ����.����� �� ���.��: ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BR4: ����.����� �� ���.��: ������� ��������',
                                                  p_funcname => 'Sel027(hWndMDI,26,4," "," ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� BR9: ����.����� �� ���.��: �������� �� ����� ********** ');
          --  ��������� ������� BR9: ����.����� �� ���.��: �������� �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BR9: ����.����� �� ���.��: �������� �� �����',
                                                  p_funcname => 'Sel027(hWndMDI,26,9," "," ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (BRON) - ��� ���������� ����� �� �������� ��  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappBRON.sql =========*** En
PROMPT ===================================================================================== 
