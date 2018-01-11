PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_MAIN.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_MAIN ***
  declare
    l_application_code varchar2(10 char) := '$RM_MAIN';
    l_application_name varchar2(300 char) := '��� ������������ ��� ';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_MAIN ��������� (��� ���������) ��� ��� ������������ ���  ');
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ] ********** ');
          --  ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ����� ������� -> ����� ������������ ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccessToAccounts/accounts',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��`���� ��`���� ������������� ********** ');
          --  ��������� ������� ��`���� ��`���� �������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��`���� ��`���� �������������',
                                                  p_funcname => '/barsroot/Admin/CommunicationObject/Index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� �������� ********** ');
          --  ��������� ������� �������� ��������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� ��������',
                                                  p_funcname => '/barsroot/DocView/Docs/DocumentDateFilter?type=0',
                                                  p_rolename => 'WR_DOCLIST_TOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��� ��������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �������� �� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �������� �� �����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������� �� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������� �� �����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �� �������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=11',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ ���������',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �������� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �������� �� �������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ XSD ���� ����� ������� ��� ********** ');
          --  ��������� ������� ������������ XSD ���� ����� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ XSD ���� ����� ������� ���',
                                                  p_funcname => '/barsroot/DownloadXsdScheme/DownloadXsdScheme/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������, �� �������������� ********** ');
          --  ��������� ������� ����������� �������, �� ��������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������, �� ��������������',
                                                  p_funcname => '/barsroot/SyncTablesEditor/SyncTablesEditor/index',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ������������ ********** ');
          --  ��������� ������� ������������� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ������������',
                                                  p_funcname => '/barsroot/admin/admu/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ����������� ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ����������� ���',
															  p_funcname => '/barsroot/admin/admu/closeuser\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ������ �������',
															  p_funcname => '/barsroot/admin/admu/getbranchlookups\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 13
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '13',
															  p_funcname => '/barsroot/admin/admu/getbranchlist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³���� ����������� ���� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³���� ����������� ���� �����������',
															  p_funcname => '/barsroot/admin/admu/cenceldelegateuserrights\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� ���� ����������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� ���� ����������� ������ �����������',
															  p_funcname => '/barsroot/admin/admu/delegateuserrights\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ������ �����������',
															  p_funcname => '/barsroot/admin/admu/createuser\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����� �� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����� �� �����������',
															  p_funcname => '/barsroot/admin/admu/getuserdata\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 10
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '10',
															  p_funcname => '/barsroot/admin/admu/edituser\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ������ ����� ����������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ������ ����� ����������� �����',
															  p_funcname => '/barsroot/admin/admu/getoraroleslookups\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 19
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '19',
															  p_funcname => '/barsroot/admin/admu/unlockuser\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 18
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '18',
															  p_funcname => '/barsroot/admin/admu/lockuser\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������ ��������� ������ ���������� ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������ ��������� ������ ���������� ���',
															  p_funcname => '/barsroot/admin/admu/changeabsuserpassword\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 2
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '2',
															  p_funcname => '/barsroot/admin/admu/getadmulist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� ������ ����������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ������ ����������� �����',
															  p_funcname => '/barsroot/admin/admu/changeorauserpassword\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 8
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '8',
															  p_funcname => '/barsroot/admin/admu/getuserroles\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ������ �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ������ �����',
															  p_funcname => '/barsroot/admin/admu/getrolelookups\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ���������� ��� ������������ � �� ********** ');
          --  ��������� ������� ����� ���������� ��� ������������ � ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ���������� ��� ������������ � ��',
                                                  p_funcname => '/barsroot/admin/ead_sync_queue.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� ********** ');
          --  ��������� ������� ������������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �������',
                                                  p_funcname => '/barsroot/admin/globaloptions.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������ ������� ��������/�������� ��� ********** ');
          --  ��������� ������� ����������� ������ ������� ��������/�������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������ ������� ��������/�������� ���',
                                                  p_funcname => '/barsroot/admin/listset/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ��� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��� ������� ����',
															  p_funcname => '/barsroot/admin/listset/getlistsetdata\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� ����',
															  p_funcname => '/barsroot/admin/listset/getlistfuncsetdata\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� ��������',
															  p_funcname => '/barsroot/admin/listset/getoperlisthandbookdata\S*',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ����� ����������� ������� ********** ');
          --  ��������� ������� ������������� ����� ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ����� ����������� �������',
                                                  p_funcname => '/barsroot/async/admin/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ ********** ');
          --  ��������� ������� ������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������',
                                                  p_funcname => '/barsroot/async/tasks/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��������� ����������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ����������� �������',
															  p_funcname => '/barsroot/async/tasks/start\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������������ ********** ');
          --  ��������� ������� ����������� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=6304&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��`�� ********** ');
          --  ��������� ������� ����� ��`��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��`��',
                                                  p_funcname => '/barsroot/barsweb/welcome.aspx',
                                                  p_rolename => 'BASIC_INFO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i�i��������� ����� ��`�� ********** ');
          --  ��������� ������� ���i�i��������� ����� ��`��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i�i��������� ����� ��`��',
                                                  p_funcname => '/barsroot/board/admin/',
                                                  p_rolename => 'WR_BOARD' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ��������� ����������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����������� ����� ���������',
															  p_funcname => '/barsroot/board/delete/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ���������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ���������� ����� ���������',
															  p_funcname => '/barsroot/board/admin/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����������� ����� ���������',
															  p_funcname => '/barsroot/board/add/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� ����������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� ����������� ����� ���������',
															  p_funcname => '/barsroot/board/edit/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� ********** ');
          --  ��������� ������� ���� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ����',
                                                  p_funcname => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ����',
															  p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ����',
															  p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �������(�� �������) ********** ');
          --  ��������� ������� ��������� �������(�� �������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �������(�� �������)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=2&t=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ��������� ���������� ********** ');
          --  ��������� ������� ������������� ��������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ��������� ����������',
                                                  p_funcname => '/barsroot/doc/advertising/index/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������������� ��������� ����������(API)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��������� ����������(API)',
															  p_funcname => '/barsroot/api/doc/advertising\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(�������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��������� ����������(�������)',
															  p_funcname => '/barsroot/doc/advertising/index\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(�������� ��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��������� ����������(�������� ��������)',
															  p_funcname => '/barsroot/doc/advertising/image\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(�������� ���.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��������� ����������(�������� ���.)',
															  p_funcname => '/barsroot/doc/advertising/detail\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(������������ ��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��������� ����������(������������ ��������)',
															  p_funcname => '/barsroot/doc/advertising/fileupload\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(�����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��������� ����������(�����������)',
															  p_funcname => '/barsroot/doc/advertising/edit\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(����������� ��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��������� ����������(����������� ��������)',
															  p_funcname => '/barsroot/doc/advertising/imageeditor\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���. �������� - �� ��������� ��������(WEB) ********** ');
          --  ��������� ������� ���������� ���. �������� - �� ��������� ��������(WEB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���. �������� - �� ��������� ��������(WEB)',
                                                  p_funcname => '/barsroot/docinput/editprops.aspx?mode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���������� ���. �������� �� ���.(WEB)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� ���. �������� �� ���.(WEB)',
															  p_funcname => '/barsroot/docinput/editprops.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���� ********** ');
          --  ��������� ������� ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ����',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_MAIN',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ��� 6-7 ����� (����������) ********** ');
          --  ��������� ������� ��������� ��� 6-7 ����� (����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ��� 6-7 ����� (����������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=NEW_REBRANCH[NSIFUNCTION][PROC=>pul.put(''BRO'',:O);pul.put(''BRN'',:N);pul.put(''NZN'',:Z)][PAR=>:O(SEM=�����_old,TYPE=C,REF=BRANCH2),:N(SEM=�����_New,TYPE=C,REF=BRANCH2),:Z(SEM=�������_��,TYPE=C)][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� %% �� ���������(����� ������) ********** ');
          --  ��������� ������� ������� %% �� ���������(����� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� %% �� ���������(����� ������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_PAY_INTEREST_DEPOS&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ������� ********** ');
          --  ��������� ������� ������������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=DOC_SCHEME[NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��� ����� ********** ');
          --  ��������� ������� ����������� ��� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>p_message_for_release(:R)][PAR=>:R(SEM=����� ������ ������ ��������� �����������,TYPE=N)][EXEC=>BEFORE][MSG=>����������� ��������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� ����� ********** ');
          --  ��������� ������� ������ �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=HOLIDAY&accessCode=7&sPar=[NSIFUNCTION][CONDITIONS=>kv=980]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ����������� ��� ********** ');
          --  ��������� ������� ���� ����������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ����������� ���',
                                                  p_funcname => '/barsroot/opencloseday/openclose/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ������������������ ********** ');
          --  ��������� ������� ���� ������������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ������������������',
                                                  p_funcname => '/barsroot/perfom/default.aspx',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ ********** ');
          --  ��������� ������� ������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������',
                                                  p_funcname => '/barsroot/requestsProcessing/requestsProcessing',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �������� ����� ********** ');
          --  ��������� ������� ������ �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �������� �����',
                                                  p_funcname => '/barsroot/sberutls/import_spr_mon.aspx',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ VIP ********** ');
          --  ��������� ������� ������ VIP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ VIP',
                                                  p_funcname => '/barsroot/sberutls/import_vip.aspx',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ DBF-������� ********** ');
          --  ��������� ������� ������������ DBF-�������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ DBF-�������',
                                                  p_funcname => '/barsroot/sberutls/load_dbf.aspx',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���� ��� ********** ');
          --  ��������� ������� ������ ���� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���� ���',
                                                  p_funcname => '/barsroot/security/audit',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ������������ ********** ');
          --  ��������� ������� ������ ��� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ������������',
                                                  p_funcname => '/barsroot/security/usersession',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ��� ����� ********** ');
          --  ��������� ������� ���. ���������� ��� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ��� �����',
                                                  p_funcname => '/barsroot/sep/sepfiles/index?mode=RW',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ��������� ���  ( �� ) ********** ');
          --  ��������� ������� ���. ���������� ��������� ���  ( �� )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ��������� ���  ( �� )',
                                                  p_funcname => '/barsroot/sep/seplockdocs/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���������� ��������� ��� (��� �������� ���) (���������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� ��������� ��� (��� �������� ���) (���������)',
															  p_funcname => '/barsroot/sep/seplockdocs/getseplockdoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� ��������� ��� (��� �������� ���)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� ��������� ��� (��� �������� ���)',
															  p_funcname => '/barsroot/sep/seplockdocs/index\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� ��������� ��� (��� �������� ���)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� ��������� ��� (��� �������� ���)',
															  p_funcname => '/barsroot/sep/seplockdocs/index?DefinedCode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������, �� �������������� ********** ');
          --  ��������� ������� ����������� �������, �� ��������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������, �� ��������������',
                                                  p_funcname => 'barsroot/SyncTablesEditor/SyncTablesEditor/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_MAIN) - ��� ������������ ���   ');
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
umu.add_report2arm(1,'$RM_MAIN');
umu.add_report2arm(2,'$RM_MAIN');
umu.add_report2arm(3,'$RM_MAIN');
umu.add_report2arm(4,'$RM_MAIN');
umu.add_report2arm(5,'$RM_MAIN');
umu.add_report2arm(6,'$RM_MAIN');
umu.add_report2arm(7,'$RM_MAIN');
umu.add_report2arm(8,'$RM_MAIN');
umu.add_report2arm(11,'$RM_MAIN');
umu.add_report2arm(12,'$RM_MAIN');
umu.add_report2arm(14,'$RM_MAIN');
umu.add_report2arm(15,'$RM_MAIN');
umu.add_report2arm(16,'$RM_MAIN');
umu.add_report2arm(17,'$RM_MAIN');
umu.add_report2arm(18,'$RM_MAIN');
umu.add_report2arm(25,'$RM_MAIN');
umu.add_report2arm(27,'$RM_MAIN');
umu.add_report2arm(28,'$RM_MAIN');
umu.add_report2arm(30,'$RM_MAIN');
umu.add_report2arm(31,'$RM_MAIN');
umu.add_report2arm(32,'$RM_MAIN');
umu.add_report2arm(33,'$RM_MAIN');
umu.add_report2arm(34,'$RM_MAIN');
umu.add_report2arm(35,'$RM_MAIN');
umu.add_report2arm(36,'$RM_MAIN');
umu.add_report2arm(37,'$RM_MAIN');
umu.add_report2arm(38,'$RM_MAIN');
umu.add_report2arm(39,'$RM_MAIN');
umu.add_report2arm(41,'$RM_MAIN');
umu.add_report2arm(42,'$RM_MAIN');
umu.add_report2arm(43,'$RM_MAIN');
umu.add_report2arm(45,'$RM_MAIN');
umu.add_report2arm(48,'$RM_MAIN');
umu.add_report2arm(49,'$RM_MAIN');
umu.add_report2arm(50,'$RM_MAIN');
umu.add_report2arm(54,'$RM_MAIN');
umu.add_report2arm(57,'$RM_MAIN');
umu.add_report2arm(58,'$RM_MAIN');
umu.add_report2arm(61,'$RM_MAIN');
umu.add_report2arm(63,'$RM_MAIN');
umu.add_report2arm(66,'$RM_MAIN');
umu.add_report2arm(67,'$RM_MAIN');
umu.add_report2arm(73,'$RM_MAIN');
umu.add_report2arm(88,'$RM_MAIN');
umu.add_report2arm(92,'$RM_MAIN');
umu.add_report2arm(95,'$RM_MAIN');
umu.add_report2arm(107,'$RM_MAIN');
umu.add_report2arm(110,'$RM_MAIN');
umu.add_report2arm(112,'$RM_MAIN');
umu.add_report2arm(116,'$RM_MAIN');
umu.add_report2arm(118,'$RM_MAIN');
umu.add_report2arm(119,'$RM_MAIN');
umu.add_report2arm(120,'$RM_MAIN');
umu.add_report2arm(121,'$RM_MAIN');
umu.add_report2arm(122,'$RM_MAIN');
umu.add_report2arm(125,'$RM_MAIN');
umu.add_report2arm(126,'$RM_MAIN');
umu.add_report2arm(128,'$RM_MAIN');
umu.add_report2arm(130,'$RM_MAIN');
umu.add_report2arm(136,'$RM_MAIN');
umu.add_report2arm(146,'$RM_MAIN');
umu.add_report2arm(155,'$RM_MAIN');
umu.add_report2arm(156,'$RM_MAIN');
umu.add_report2arm(171,'$RM_MAIN');
umu.add_report2arm(172,'$RM_MAIN');
umu.add_report2arm(173,'$RM_MAIN');
umu.add_report2arm(174,'$RM_MAIN');
umu.add_report2arm(179,'$RM_MAIN');
umu.add_report2arm(180,'$RM_MAIN');
umu.add_report2arm(182,'$RM_MAIN');
umu.add_report2arm(184,'$RM_MAIN');
umu.add_report2arm(185,'$RM_MAIN');
umu.add_report2arm(186,'$RM_MAIN');
umu.add_report2arm(187,'$RM_MAIN');
umu.add_report2arm(188,'$RM_MAIN');
umu.add_report2arm(189,'$RM_MAIN');
umu.add_report2arm(190,'$RM_MAIN');
umu.add_report2arm(191,'$RM_MAIN');
umu.add_report2arm(192,'$RM_MAIN');
umu.add_report2arm(193,'$RM_MAIN');
umu.add_report2arm(194,'$RM_MAIN');
umu.add_report2arm(196,'$RM_MAIN');
umu.add_report2arm(197,'$RM_MAIN');
umu.add_report2arm(201,'$RM_MAIN');
umu.add_report2arm(202,'$RM_MAIN');
umu.add_report2arm(205,'$RM_MAIN');
umu.add_report2arm(212,'$RM_MAIN');
umu.add_report2arm(213,'$RM_MAIN');
umu.add_report2arm(216,'$RM_MAIN');
umu.add_report2arm(217,'$RM_MAIN');
umu.add_report2arm(218,'$RM_MAIN');
umu.add_report2arm(220,'$RM_MAIN');
umu.add_report2arm(221,'$RM_MAIN');
umu.add_report2arm(225,'$RM_MAIN');
umu.add_report2arm(226,'$RM_MAIN');
umu.add_report2arm(227,'$RM_MAIN');
umu.add_report2arm(232,'$RM_MAIN');
umu.add_report2arm(233,'$RM_MAIN');
umu.add_report2arm(235,'$RM_MAIN');
umu.add_report2arm(237,'$RM_MAIN');
umu.add_report2arm(238,'$RM_MAIN');
umu.add_report2arm(243,'$RM_MAIN');
umu.add_report2arm(245,'$RM_MAIN');
umu.add_report2arm(246,'$RM_MAIN');
umu.add_report2arm(247,'$RM_MAIN');
umu.add_report2arm(253,'$RM_MAIN');
umu.add_report2arm(254,'$RM_MAIN');
umu.add_report2arm(256,'$RM_MAIN');
umu.add_report2arm(257,'$RM_MAIN');
umu.add_report2arm(259,'$RM_MAIN');
umu.add_report2arm(260,'$RM_MAIN');
umu.add_report2arm(261,'$RM_MAIN');
umu.add_report2arm(262,'$RM_MAIN');
umu.add_report2arm(263,'$RM_MAIN');
umu.add_report2arm(264,'$RM_MAIN');
umu.add_report2arm(265,'$RM_MAIN');
umu.add_report2arm(267,'$RM_MAIN');
umu.add_report2arm(268,'$RM_MAIN');
umu.add_report2arm(269,'$RM_MAIN');
umu.add_report2arm(270,'$RM_MAIN');
umu.add_report2arm(271,'$RM_MAIN');
umu.add_report2arm(272,'$RM_MAIN');
umu.add_report2arm(273,'$RM_MAIN');
umu.add_report2arm(275,'$RM_MAIN');
umu.add_report2arm(276,'$RM_MAIN');
umu.add_report2arm(279,'$RM_MAIN');
umu.add_report2arm(282,'$RM_MAIN');
umu.add_report2arm(283,'$RM_MAIN');
umu.add_report2arm(284,'$RM_MAIN');
umu.add_report2arm(285,'$RM_MAIN');
umu.add_report2arm(286,'$RM_MAIN');
umu.add_report2arm(287,'$RM_MAIN');
umu.add_report2arm(288,'$RM_MAIN');
umu.add_report2arm(291,'$RM_MAIN');
umu.add_report2arm(292,'$RM_MAIN');
umu.add_report2arm(293,'$RM_MAIN');
umu.add_report2arm(294,'$RM_MAIN');
umu.add_report2arm(296,'$RM_MAIN');
umu.add_report2arm(301,'$RM_MAIN');
umu.add_report2arm(302,'$RM_MAIN');
umu.add_report2arm(303,'$RM_MAIN');
umu.add_report2arm(304,'$RM_MAIN');
umu.add_report2arm(306,'$RM_MAIN');
umu.add_report2arm(308,'$RM_MAIN');
umu.add_report2arm(312,'$RM_MAIN');
umu.add_report2arm(314,'$RM_MAIN');
umu.add_report2arm(315,'$RM_MAIN');
umu.add_report2arm(320,'$RM_MAIN');
umu.add_report2arm(323,'$RM_MAIN');
umu.add_report2arm(329,'$RM_MAIN');
umu.add_report2arm(330,'$RM_MAIN');
umu.add_report2arm(331,'$RM_MAIN');
umu.add_report2arm(332,'$RM_MAIN');
umu.add_report2arm(333,'$RM_MAIN');
umu.add_report2arm(334,'$RM_MAIN');
umu.add_report2arm(335,'$RM_MAIN');
umu.add_report2arm(336,'$RM_MAIN');
umu.add_report2arm(340,'$RM_MAIN');
umu.add_report2arm(342,'$RM_MAIN');
umu.add_report2arm(343,'$RM_MAIN');
umu.add_report2arm(344,'$RM_MAIN');
umu.add_report2arm(345,'$RM_MAIN');
umu.add_report2arm(346,'$RM_MAIN');
umu.add_report2arm(347,'$RM_MAIN');
umu.add_report2arm(348,'$RM_MAIN');
umu.add_report2arm(349,'$RM_MAIN');
umu.add_report2arm(350,'$RM_MAIN');
umu.add_report2arm(351,'$RM_MAIN');
umu.add_report2arm(356,'$RM_MAIN');
umu.add_report2arm(358,'$RM_MAIN');
umu.add_report2arm(360,'$RM_MAIN');
umu.add_report2arm(367,'$RM_MAIN');
umu.add_report2arm(370,'$RM_MAIN');
umu.add_report2arm(375,'$RM_MAIN');
umu.add_report2arm(377,'$RM_MAIN');
umu.add_report2arm(380,'$RM_MAIN');
umu.add_report2arm(385,'$RM_MAIN');
umu.add_report2arm(402,'$RM_MAIN');
umu.add_report2arm(403,'$RM_MAIN');
umu.add_report2arm(404,'$RM_MAIN');
umu.add_report2arm(405,'$RM_MAIN');
umu.add_report2arm(406,'$RM_MAIN');
umu.add_report2arm(407,'$RM_MAIN');
umu.add_report2arm(408,'$RM_MAIN');
umu.add_report2arm(409,'$RM_MAIN');
umu.add_report2arm(410,'$RM_MAIN');
umu.add_report2arm(411,'$RM_MAIN');
umu.add_report2arm(412,'$RM_MAIN');
umu.add_report2arm(413,'$RM_MAIN');
umu.add_report2arm(414,'$RM_MAIN');
umu.add_report2arm(415,'$RM_MAIN');
umu.add_report2arm(416,'$RM_MAIN');
umu.add_report2arm(421,'$RM_MAIN');
umu.add_report2arm(423,'$RM_MAIN');
umu.add_report2arm(424,'$RM_MAIN');
umu.add_report2arm(425,'$RM_MAIN');
umu.add_report2arm(426,'$RM_MAIN');
umu.add_report2arm(427,'$RM_MAIN');
umu.add_report2arm(428,'$RM_MAIN');
umu.add_report2arm(429,'$RM_MAIN');
umu.add_report2arm(435,'$RM_MAIN');
umu.add_report2arm(437,'$RM_MAIN');
umu.add_report2arm(438,'$RM_MAIN');
umu.add_report2arm(439,'$RM_MAIN');
umu.add_report2arm(440,'$RM_MAIN');
umu.add_report2arm(441,'$RM_MAIN');
umu.add_report2arm(444,'$RM_MAIN');
umu.add_report2arm(456,'$RM_MAIN');
umu.add_report2arm(457,'$RM_MAIN');
umu.add_report2arm(479,'$RM_MAIN');
umu.add_report2arm(481,'$RM_MAIN');
umu.add_report2arm(494,'$RM_MAIN');
umu.add_report2arm(495,'$RM_MAIN');
umu.add_report2arm(496,'$RM_MAIN');
umu.add_report2arm(497,'$RM_MAIN');
umu.add_report2arm(498,'$RM_MAIN');
umu.add_report2arm(500,'$RM_MAIN');
umu.add_report2arm(501,'$RM_MAIN');
umu.add_report2arm(503,'$RM_MAIN');
umu.add_report2arm(504,'$RM_MAIN');
umu.add_report2arm(514,'$RM_MAIN');
umu.add_report2arm(515,'$RM_MAIN');
umu.add_report2arm(520,'$RM_MAIN');
umu.add_report2arm(521,'$RM_MAIN');
umu.add_report2arm(530,'$RM_MAIN');
umu.add_report2arm(531,'$RM_MAIN');
umu.add_report2arm(542,'$RM_MAIN');
umu.add_report2arm(565,'$RM_MAIN');
umu.add_report2arm(566,'$RM_MAIN');
umu.add_report2arm(579,'$RM_MAIN');
umu.add_report2arm(582,'$RM_MAIN');
umu.add_report2arm(585,'$RM_MAIN');
umu.add_report2arm(586,'$RM_MAIN');
umu.add_report2arm(587,'$RM_MAIN');
umu.add_report2arm(588,'$RM_MAIN');
umu.add_report2arm(589,'$RM_MAIN');
umu.add_report2arm(591,'$RM_MAIN');
umu.add_report2arm(593,'$RM_MAIN');
umu.add_report2arm(594,'$RM_MAIN');
umu.add_report2arm(595,'$RM_MAIN');
umu.add_report2arm(596,'$RM_MAIN');
umu.add_report2arm(597,'$RM_MAIN');
umu.add_report2arm(598,'$RM_MAIN');
umu.add_report2arm(599,'$RM_MAIN');
umu.add_report2arm(600,'$RM_MAIN');
umu.add_report2arm(601,'$RM_MAIN');
umu.add_report2arm(602,'$RM_MAIN');
umu.add_report2arm(670,'$RM_MAIN');
umu.add_report2arm(674,'$RM_MAIN');
umu.add_report2arm(675,'$RM_MAIN');
umu.add_report2arm(678,'$RM_MAIN');
umu.add_report2arm(679,'$RM_MAIN');
umu.add_report2arm(684,'$RM_MAIN');
umu.add_report2arm(687,'$RM_MAIN');
umu.add_report2arm(688,'$RM_MAIN');
umu.add_report2arm(701,'$RM_MAIN');
umu.add_report2arm(702,'$RM_MAIN');
umu.add_report2arm(703,'$RM_MAIN');
umu.add_report2arm(706,'$RM_MAIN');
umu.add_report2arm(707,'$RM_MAIN');
umu.add_report2arm(708,'$RM_MAIN');
umu.add_report2arm(709,'$RM_MAIN');
umu.add_report2arm(764,'$RM_MAIN');
umu.add_report2arm(767,'$RM_MAIN');
umu.add_report2arm(800,'$RM_MAIN');
umu.add_report2arm(801,'$RM_MAIN');
umu.add_report2arm(805,'$RM_MAIN');
umu.add_report2arm(949,'$RM_MAIN');
umu.add_report2arm(951,'$RM_MAIN');
umu.add_report2arm(961,'$RM_MAIN');
umu.add_report2arm(962,'$RM_MAIN');
umu.add_report2arm(963,'$RM_MAIN');
umu.add_report2arm(964,'$RM_MAIN');
umu.add_report2arm(967,'$RM_MAIN');
umu.add_report2arm(999,'$RM_MAIN');
umu.add_report2arm(1000,'$RM_MAIN');
umu.add_report2arm(1001,'$RM_MAIN');
umu.add_report2arm(1002,'$RM_MAIN');
umu.add_report2arm(1315,'$RM_MAIN');
umu.add_report2arm(3100,'$RM_MAIN');
umu.add_report2arm(3101,'$RM_MAIN');
umu.add_report2arm(100233,'$RM_MAIN');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_MAIN.sql =========**
PROMPT ===================================================================================== 
