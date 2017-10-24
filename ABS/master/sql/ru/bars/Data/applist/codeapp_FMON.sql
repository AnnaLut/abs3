SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_FMON.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  FMON ***
  declare
    l_application_code varchar2(10 char) := 'FMON';
    l_application_name varchar2(300 char) := '��� ������������ ����� Գ��������� ����������';
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
     DBMS_OUTPUT.PUT_LINE(' FMON ��������� (��� ���������) ��� ��� ������������ ����� Գ��������� ���������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� XLS - ��������-�������� �i���i��� �i�i� (���i �.#02) - ����� ��� ********** ');
          --  ��������� ������� XLS - ��������-�������� �i���i��� �i�i� (���i �.#02) - ����� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'XLS - ��������-�������� �i���i��� �i�i� (���i �.#02) - ����� ���',
                                                  p_funcname => 'ExportCatQuery(4789,"", 8,"",TRUE)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �������� �볺��� ********** ');
          --  ��������� ������� ��. �������� �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �������� �볺���',
                                                  p_funcname => 'F1_Select(13, ''klient_is_reft(DAT);�������� �������� ��� �볺��� �����?;�������� ���������. �������� ������� �������� �볺���!'')',
                                                  p_rolename => 'FINMON01' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������ ���� - �������� ��������� �볺��� �� �������� ����� ********** ');
          --  ��������� ������� ��. ������ ���� - �������� ��������� �볺��� �� �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������ ���� - �������� ��������� �볺��� �� �������� �����',
                                                  p_funcname => 'FunNSIEdit("[PROC=>finmon_check_public(0)][QST=>�������� �������� ��� �볺��� �����?][MSG=>��������!]")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ϳ����������� ���� ������ �볺��� ********** ');
          --  ��������� ������� ϳ����������� ���� ������ �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ϳ����������� ���� ������ �볺���',
                                                  p_funcname => 'FunNSIEditF("V_CUSTOMER_RIZIK[NSIFUNCTION]",1)',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���� ������ �볺��� ********** ');
          --  ��������� ������� ����������� ���� ������ �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���� ������ �볺���',
                                                  p_funcname => 'FunNSIEditF("V_CUST_R",1)',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �볺��� � ������ ����� ********** ');
          --  ��������� ������� ��. �볺��� � ������ �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �볺��� � ������ �����',
                                                  p_funcname => 'FunNSIEditF(''FINMON_PUBLIC_CUSTOMERS'', 1)',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ϳ����� �볺��� ********** ');
          --  ��������� ������� ��. ϳ����� �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ϳ����� �볺���',
                                                  p_funcname => 'FunNSIEditF(''V_FM_KLIENT'', 1)',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ����� �� �� ��������� ��� �������� ������� ********** ');
          --  ��������� ������� ���� ����� �� �� ��������� ��� �������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ����� �� �� ��������� ��� �������� �������',
                                                  p_funcname => 'FunNSIEditFFiltered("V_OPER_FM",1|0x0010,"PDAT >= SYSDATE-30")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������ ����� �������� ����� ********** ');
          --  ��������� ������� ��. ������ ����� �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������ ����� �������� �����',
                                                  p_funcname => 'GeneralImpExp(hWndMDI, 3, 1, ''finmon_import_files(1, sFileName)'', '''')',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �i��i� ��������i� ��� �i�. ���i���i��� [��I ���������] ********** ');
          --  ��������� ������� ��. �i��i� ��������i� ��� �i�. ���i���i��� [��I ���������]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �i��i� ��������i� ��� �i�. ���i���i��� [��I ���������]',
                                                  p_funcname => 'Sel005(hWndMDI,0,1,''NIBS7UT'','''')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������ ����� ��������� ********** ');
          --  ��������� ������� ��. ������ ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������ ����� ���������',
                                                  p_funcname => 'Sel005(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'FINMON01' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (FMON) - ��� ������������ ����� Գ��������� ����������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappFMON.sql =========*** En
PROMPT ===================================================================================== 
