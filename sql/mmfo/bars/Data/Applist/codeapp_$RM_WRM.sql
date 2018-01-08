PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WRM.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WRM ***
  declare
    l_application_code varchar2(10 char) := '$RM_WRM';
    l_application_name varchar2(300 char) := '��� ������������ ������� �����';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WRM ��������� (��� ���������) ��� ��� ������������ ������� ����� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ������� -> ����� ������� ] ********** ');
          --  ��������� ������� ������������ ������� [ ������� -> ����� ������� ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ������� -> ����� ������� ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccGroups/AccGroups',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� [ ����� ������������ -> ���,�����������,�������] ********** ');
          --  ��������� ������� �������� ������� [ ����� ������������ -> ���,�����������,�������]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� [ ����� ������������ -> ���,�����������,�������]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccessRoleGroups/AccessGroups',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ] ********** ');
          --  ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ����� ������� -> ����� ������������ ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccessToAccounts/Accounts',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ����� ������������ -> ����� ������� ] ********** ');
          --  ��������� ������� ������������ ������� [ ����� ������������ -> ����� ������� ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ����� ������������ -> ����� ������� ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccessToAccountsUsers/Users',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��̳� ********** ');
          --  ��������� ������� ����������� ��̳�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��̳�',
                                                  p_funcname => '/barsroot/admin/adm/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� 8
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '8',
															  p_funcname => '/barsroot/admin/adm/editadm\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 6
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '6',
															  p_funcname => '/barsroot/admin/adm/createadm\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������ ������ ������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������ ������ ������� �� �������',
															  p_funcname => '/barsroot/admin/adm/setadmresourceaccessmode\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 2
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '2',
															  p_funcname => '/barsroot/admin/adm/getadmlist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������� ********** ');
          --  ��������� ������� ����������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������',
                                                  p_funcname => '/barsroot/admin/oper/index',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ����� ********** ');
          --  ��������� ������� ������������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� �����',
                                                  p_funcname => '/barsroot/admin/roles/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���������� ��� ������������ ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� ��� ������������ ���',
															  p_funcname => '/barsroot/admin/roles/lockrole\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������ ������ ������� �� ������� ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������ ������ ������� �� ������� ���',
															  p_funcname => '/barsroot/admin/roles/setresourceaccessmode\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ��� ������������ ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ��� ������������ ���',
															  p_funcname => '/barsroot/admin/roles/createrole\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��� ������������ ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��� ������������ ���',
															  p_funcname => '/barsroot/admin/roles/unlockrole\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� ��� ������������ ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� ��� ������������ ���',
															  p_funcname => '/barsroot/admin/roles/editrole\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ********** ');
          --  ��������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������',
                                                  p_funcname => '/barsroot/barsweb/references/reflist.aspx',
                                                  p_rolename => 'WR_REFREAD' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �� ����������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �� ����������� ��������',
															  p_funcname => '/barsroot/barsweb/references/refbook.aspx?(tabname=\S)|(tabid=\d+)&mode=\S\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� �����²� ����˲/����� �������� ********** ');
          --  ��������� ������� �������� �� �����²� ����˲/����� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� �����²� ����˲/����� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=M_ROLE[NSIFUNCTION][BASE_OPTIONS=>ACCESSCODE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������-"ó��� �������" �� �����²� ����˲ ********** ');
          --  ��������� ������� ��������-"ó��� �������" �� �����²� ����˲
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������-"ó��� �������" �� �����²� ����˲',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=6&sPar=M_ROLE_TYPV[NSIFUNCTION][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� NEW ********** ');
          --  ��������� ������� �������� NEW
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� NEW',
                                                  p_funcname => '/barsroot/referencebook/referencelist/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_WRM) - ��� ������������ ������� �����  ');
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
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WRM.sql =========***
PROMPT ===================================================================================== 
