SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_TKLB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  TKLB ***
  declare
    l_application_code varchar2(10 char) := 'TKLB';
    l_application_name varchar2(300 char) := '��� ��������� �볺��-����';
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
     DBMS_OUTPUT.PUT_LINE(' TKLB ��������� (��� ���������) ��� ��� ��������� �볺��-���� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ���������� ������-���� ********** ');
          --  ��������� ������� ������� ���������� ������-����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ���������� ������-����',
                                                  p_funcname => 'FunNSIEditF(''KLPEOM'',1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��� ���������� (��������) ������� (E) ��������� ��� (SBB) ********** ');
          --  ��������� ������� ³��� ���������� (��������) ������� (E) ��������� ��� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��� ���������� (��������) ������� (E) ��������� ��� (SBB)',
                                                  p_funcname => 'KliTex(1,hWndMDI,"")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F/³��� ������� "�����������" �볺���� ********** ');
          --  ��������� ������� F/³��� ������� "�����������" �볺����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/³��� ������� "�����������" �볺����',
                                                  p_funcname => 'KliTex(2, hWndMDI, "")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��� ����. ������� ��������� ��� (SBB) ********** ');
          --  ��������� ������� ³��� ����. ������� ��������� ��� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��� ����. ������� ��������� ��� (SBB)',
                                                  p_funcname => 'KliTex(4,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��� ����. ������� ��������� ��� + ����� (SBB) ********** ');
          --  ��������� ������� ³��� ����. ������� ��������� ��� + ����� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��� ����. ������� ��������� ��� + ����� (SBB)',
                                                  p_funcname => 'KliTex(5,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� � ������� ���������� ������������� �� ������-���� ********** ');
          --  ��������� ������� �������� � ������� ���������� ������������� �� ������-����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� � ������� ���������� ������������� �� ������-����',
                                                  p_funcname => 'Sel000(hWndMDI,10,0,"","")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� "�����������" �������� ********** ');
          --  ��������� ������� ���������� ������� "�����������" ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� "�����������" ��������',
                                                  p_funcname => 'Sel000(hWndMDI,33,0,"","")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������������� ��������� �� �� ********** ');
          --  ��������� ������� �������������� ��������� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������������� ��������� �� ��',
                                                  p_funcname => 'Sel000(hWndMDI,37,0,"","")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ (���������) �������� �˲���-���� ********** ');
          --  ��������� ������� ������ (���������) �������� �˲���-����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ (���������) �������� �˲���-����',
                                                  p_funcname => 'Sel000(hWndMDI,7,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S/������� CUSTCOUNT ��� �˲���-���� (SBB) ********** ');
          --  ��������� ������� S/������� CUSTCOUNT ��� �˲���-���� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/������� CUSTCOUNT ��� �˲���-���� (SBB)',
                                                  p_funcname => 'Sel000(hWndMDI,8,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (TKLB) - ��� ��������� �볺��-����  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappTKLB.sql =========*** En
PROMPT ===================================================================================== 
