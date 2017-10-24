SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_MAIN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  MAIN ***
  declare
    l_application_code varchar2(10 char) := 'MAIN';
    l_application_name varchar2(300 char) := '��� ������������ ���';
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
     DBMS_OUTPUT.PUT_LINE(' MAIN ��������� (��� ���������) ��� ��� ������������ ��� ');
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �����(���������) ********** ');
          --  ��������� ������� ������ �����(���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����(���������)',
                                                  p_funcname => 'F1_Select(101,'''')',
                                                  p_rolename => 'TASK_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �����(�����������) ********** ');
          --  ��������� ������� ������ �����(�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����(�����������)',
                                                  p_funcname => 'F1_Select(102,'''')',
                                                  p_rolename => 'TASK_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ VIP ********** ');
          --  ��������� ������� ������ VIP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ VIP',
                                                  p_funcname => 'F1_Select(307,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �'������� � �������� ����������� ********** ');
          --  ��������� ������� �������� �'������� � �������� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �'������� � �������� �����������',
                                                  p_funcname => 'F1_Select(840,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� ������� ��� ³������/������� ��� ********** ');
          --  ��������� ������� ����������� ������� ������� ��� ³������/������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� ������� ��� ³������/������� ���',
                                                  p_funcname => 'FListEdit(hWndMDI,0)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SMS: ��������� ���/���� sms-����.��� ��� �����.�� ********** ');
          --  ��������� ������� SMS: ��������� ���/���� sms-����.��� ��� �����.��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SMS: ��������� ���/���� sms-����.��� ��� �����.��',
                                                  p_funcname => 'FunNSIEdit("V_SMS_CONFIRM_ADM")',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-2 �� �� "�������" ********** ');
          --  ��������� ������� ������-2 �� �� "�������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-2 �� �� "�������"',
                                                  p_funcname => 'FunNSIEditF("CASH_SXO_B[NSIFUNCTION]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� D8.����������������� ��������� ��� D8 ********** ');
          --  ��������� ������� D8.����������������� ��������� ��� D8
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'D8.����������������� ��������� ��� D8',
                                                  p_funcname => 'FunNSIEditF("D8_CUST_LINK_GROUPS[PROC=>P_D8_041(:RNK)][PAR=>:RNK(SEM=���,TYPE=S,DEF=%)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SMS: �������� ������� ���/���� sms-����. �.���. ��� �����. �� ********** ');
          --  ��������� ������� SMS: �������� ������� ���/���� sms-����. �.���. ��� �����. ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SMS: �������� ������� ���/���� sms-����. �.���. ��� �����. ��',
                                                  p_funcname => 'FunNSIEditF("SMS_CONFIRM_AUDIT", 1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��������� ������������� ��  ********** ');
          --  ��������� ������� ����� ��������� ������������� �� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������� ������������� �� ',
                                                  p_funcname => 'FunNSIEditF("SPEC1_INT",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������.��������� ����� ������� ���� � ����� �������� ���� ********** ');
          --  ��������� ������� �������.��������� ����� ������� ���� � ����� �������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������.��������� ����� ������� ���� � ����� �������� ����',
                                                  p_funcname => 'FunNSIEditF("TEST_DPT_ERR_OB22" ,2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��������� ������ ********** ');
          --  ��������� ������� ³��������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��������� ������',
                                                  p_funcname => 'FunNSIEditF('''',20)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��'���� �����������<=>����� ����������� ********** ');
          --  ��������� ������� ��'���� �����������<=>����� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��'���� �����������<=>����� �����������',
                                                  p_funcname => 'FunNSIEditF(''V_STAFF_TIPS'',1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���� ������������ ********** ');
          --  ��������� ������� ����������� ���� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���� ������������',
                                                  p_funcname => 'MakeSubstitutes()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��i���� ���� ��� ������� ********** ');
          --  ��������� ������� ����������� ��i���� ���� ��� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��i���� ���� ��� �������',
                                                  p_funcname => 'Otcn(hWndMDI, 2, 0, 0, '''','''')',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������������ ********** ');
          --  ��������� ������� ������ ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������������',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, 3)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ������� ������������ ********** ');
          --  ��������� ������� ������������� ������� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ������� ������������',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, 5)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���������ײ� ********** ');
          --  ��������� ������� ������������� ���������ײ�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���������ײ�',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���-�� ********** ');
          --  ��������� ������� ����������� ���-��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���-��',
                                                  p_funcname => 'Run_Arms( hWndMDI, 0 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��'���� ��'���� ������������� ********** ');
          --  ��������� ������� ��'���� ��'���� �������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��'���� ��'���� �������������',
                                                  p_funcname => 'Run_Arms(hWndMDI,77)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������� �������� ********** ');
          --  ��������� ������� ����������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������� ��������',
                                                  p_funcname => 'Sel028(hWndMDI, 0, 1, "/", "")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� �� ������� ( 3 ������) ********** ');
          --  ��������� ������� ������������ ������� �� ������� ( 3 ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� �� ������� ( 3 ������)',
                                                  p_funcname => 'ShowGroups(hWndMDI,1)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� �� �������  ********** ');
          --  ��������� ������� ������������ ������� �� ������� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� �� ������� ',
                                                  p_funcname => 'ShowGroups(hWndMDI,3)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ����� ������������ -> ����� ������� ] ********** ');
          --  ��������� ������� ������������ ������� [ ����� ������������ -> ����� ������� ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ����� ������������ -> ����� ������� ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,4)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ] ********** ');
          --  ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ����� ������� -> ����� ������������ ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,5)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ������� -> ����� ������� ] ********** ');
          --  ��������� ������� ������������ ������� [ ������� -> ����� ������� ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ������� -> ����� ������� ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,6)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���.�����i�(����) ********** ');
          --  ��������� ������� ����������� ���.�����i�(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���.�����i�(����)',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 0 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������, �� �������������� ********** ');
          --  ��������� ������� ����������� �������, �� ��������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������, �� ��������������',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 1 )',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���� � ��� ********** ');
          --  ��������� ������� ������ ���� � ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���� � ���',
                                                  p_funcname => 'ShowSecurity()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => 'Show_USERS(hWndMDI ,TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => 'Show_USERS(hWndMDI ,TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� VEGA - ����������� ********** ');
          --  ��������� ������� VEGA - �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'VEGA - �����������',
                                                  p_funcname => 'VEGA_Sel(hWndMDI,0,0,0,'''','''')',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (MAIN) - ��� ������������ ���  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappMAIN.sql =========*** En
PROMPT ===================================================================================== 
