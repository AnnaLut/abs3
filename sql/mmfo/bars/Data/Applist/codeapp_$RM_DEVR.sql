PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_DEVR.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_DEVR ***
  declare
    l_application_code varchar2(10 char) := '$RM_DEVR';
    l_application_name varchar2(300 char) := '��� ����������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_DEVR ��������� (��� ���������) ��� ��� ���������� ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� ********** ');
          --  ��������� ������� �������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������',
                                                  p_funcname => '/barsroot/DptAdm/DptAdm/DPTAdditional',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���������ײ� ********** ');
          --  ��������� ������� ������������� ���������ײ�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���������ײ�',
                                                  p_funcname => '/barsroot/admin/adminusers.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ϳ����������� ������� ********** ');
          --  ��������� ������� ϳ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ϳ����������� �������',
                                                  p_funcname => '/barsroot/admsecurity/confirm/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ϳ����������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ϳ����������� �������',
															  p_funcname => '/barsroot/admsecurity/confirm/getconfirmtabs\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ϳ����������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ϳ����������� �������',
															  p_funcname => '/barsroot/admsecurity/confirm/getconfirmresources\S*',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� "����" �������� ********** ');
          --  ��������� ������� ³������� "����" ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� "����" ��������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ³������� "����" ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� "����" ��������',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=0&grpid=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� BarsWeb.CheckInner
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.CheckInner',
															  p_funcname => '/barsroot/checkinner/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� �������� ********** ');
          --  ��������� ������� ³������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� ��������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=2',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� BarsWeb.CheckInner
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.CheckInner',
															  p_funcname => '/barsroot/checkinner/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³������� �������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� �������� ��������',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=2&grpid=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � �������  (��) ********** ');
          --  ��������� ������� ��������� �볺��� � �������  (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � �������  (��)',
                                                  p_funcname => '/barsroot/clients/customers/index/?custtype=person',
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �����������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � �������  ********** ');
          --  ��������� ������� ��������� �볺��� � ������� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � ������� ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �����������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���� ����������/����������� ********** ');
          --  ��������� ������� ������������� ���� ����������/�����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���� ����������/�����������',
                                                  p_funcname => '/barsroot/gl/schemebuilder',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� ��������� ********** ');
          --  ��������� ������� �������� ������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� ���������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TMP_SB_FLTR[PROC=>POPULATE_SB_FLTR(:Param0)][PAR=>:Param0(SEM=��i��� ����,TYPE=D,REF=V_VFDAT))][EXEC=>BEFORE][MSG=>��������!][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �� ��������� (��.��. ����. ���.) ********** ');
          --  ��������� ������� ���������� �� ��������� (��.��. ����. ���.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �� ��������� (��.��. ����. ���.)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,77,''PER_INK_N'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i����i��i��� �� �� ����i����� �� �i���� �����i� ********** ');
          --  ��������� ������� ���i����i��i��� �� �� ����i����� �� �i���� �����i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i����i��i��� �� �� ����i����� �� �i���� �����i�',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_NBS_BRANCH',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³���������� ��������� �� ������������ ********** ');
          --  ��������� ������� ³���������� ��������� �� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³���������� ��������� �� ������������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_USER_ZVIT[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=����_�,TYPE=S),:E(SEM=����_��,TYPE=S)][EXEC=>BEFORE][NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� AGG_02. ��������� ����������� ������� �� �i���� ********** ');
          --  ��������� ������� AGG_02. ��������� ����������� ������� �� �i����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'AGG_02. ��������� ����������� ������� �� �i����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>AGG_02(:Param0)][PAR=>:Param0(SEM=��i����_���i�� MM_YY,TYPE=S)][MSG=>��������!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� SNAP-���������� �� ����(�����) ********** ');
          --  ��������� ������� �������� SNAP-���������� �� ����(�����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� SNAP-���������� �� ����(�����)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>DRAPS(:Param0)][PAR=>:Param0(SEM=��i��� ����,TYPE=D)][MSG=>��������!]',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����������� ������� �� �i���� ********** ');
          --  ��������� ������� ��������� ����������� ������� �� �i����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����������� ������� �� �i����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>MDRAPS(:Param0)][PAR=>:Param0(SEM=��i��� ����,TYPE=D)][MSG=>��������!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������������� �������� SNAP �� ���� ********** ');
          --  ��������� ������� �������������� �������� SNAP �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������������� �������� SNAP �� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>draps(gl.bd)][QST=>��������?][MSG=>��!]',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� %% �� ������� �� �������� ********** ');
          --  ��������� ������� ����������� %% �� ������� �� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� %% �� ������� �� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=V_NOTPORTFOLIO_INT_RECKONING&sPar=[PROC=>npi_ui.prepare_portfolio_interest(:p_nbs,:currency,:date_to)][PAR=>:p_nbs(SEM=���������� �������,TYPE=C,REF=V_NOTPORTFOLIO_NBS),:currency(SEM=���_���,TYPE=C),:date_to(SEM=���� ��,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ��������, �� ����������� ������� (�����/Գ��) ********** ');
          --  ��������� ������� ���� ��������, �� ����������� ������� (�����/Գ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ��������, �� ����������� ������� (�����/Գ��)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=3&sPar=TMS_TASK[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SALDO_DSW: ������� �����-����� �� ����-������ ********** ');
          --  ��������� ������� SALDO_DSW: ������� �����-����� �� ����-������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SALDO_DSW: ������� �����-����� �� ����-������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=SALDO_DSW&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� N 3. Գ�.��������� �� ����� �� �������� ���.������������ ********** ');
          --  ��������� ������� N 3. Գ�.��������� �� ����� �� �������� ���.������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'N 3. Գ�.��������� �� ����� �� �������� ���.������������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TMP_ANI34&accessCode=2&sPar=[PROC=>P_ANI34(34,:B,:E,:R)][PAR=>:B(SEM=�_DD.MM.YYYY,TYPE=D),:E(SEM=��_DD.MM.YYYY,TYPE=D),:R(SEM=��_�/0,TYPE=N)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� CardMake (web) ********** ');
          --  ��������� ������� Way4. ������ �� CardMake (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� CardMake (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CM_ACC_REQUEST&accessCode=1&sPar=[NSIFUNCTION]',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ��������� ������ ����� �� S_UCH.DBF ********** ');
          --  ��������� ������� ���. ��������� ������ ����� �� S_UCH.DBF
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ��������� ������ ����� �� S_UCH.DBF',
                                                  p_funcname => '/barsroot/sep/sepimportsuch/',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ������� ********** ');
          --  ��������� ������� ���. ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� �������',
                                                  p_funcname => '/barsroot/sep/septechaccounts/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ������ �������� BIC(XML) ********** ');
          --  ��������� ������� SWIFT. ������ �������� BIC(XML)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ������ �������� BIC(XML)',
                                                  p_funcname => '/barsroot/swi/import_bic.aspx',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Nostro Reconciliation ********** ');
          --  ��������� ������� Nostro Reconciliation
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Nostro Reconciliation',
                                                  p_funcname => '/barsroot/swi/reconsilation.aspx',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� SWIFT
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� SWIFT',
															  p_funcname => '/barsroot/documentview/view_swift.aspx?swref=\d+',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Nostro Reconciliation
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Nostro Reconciliation',
															  p_funcname => '/barsroot/swi/reconsilation_tt.aspx?stmt_ref=\d+&coln=\d+',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Nostro Reconciliation
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Nostro Reconciliation',
															  p_funcname => '/barsroot/swi/reconsilation_link_swt.aspx?stmt_ref=\d+&coln=\d+',
															  p_rolename => 'START1' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_DEVR) - ��� ����������  ');
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
umu.add_report2arm(272,'$RM_DEVR');
umu.add_report2arm(284,'$RM_DEVR');
umu.add_report2arm(285,'$RM_DEVR');
umu.add_report2arm(850,'$RM_DEVR');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_DEVR.sql =========**
PROMPT ===================================================================================== 
