PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_CHIF.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_CHIF ***
  declare
    l_application_code varchar2(10 char) := '$RM_CHIF';
    l_application_name varchar2(300 char) := '��� ����������� �� (�������� ���)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_CHIF ��������� (��� ���������) ��� ��� ����������� �� (�������� ���) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ��������� (DBF, TXT) ********** ');
          --  ��������� ������� ������� ��������� (DBF, TXT)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ��������� (DBF, TXT)',
                                                  p_funcname => '/barsroot/cbirep/export_dbf.aspx',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ��� ��������� ��� �������� DBF
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��� ��������� ��� �������� DBF',
															  p_funcname => '/barsroot/cbirep/export_dbf_var.aspx?kodz=\d+',
															  p_rolename => 'START1' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���� ********** ');
          --  ��������� ������� ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ����',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_CHIF',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� � ����� ��.������ 46 ********** ');
          --  ��������� ������� ���������� ������� � ����� ��.������ 46
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� � ����� ��.������ 46',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(3,:GR,'''',''A'')][PAR=>:GR(SEM=� ��.����������,TYPE=S,REF=PEREKR_G)][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')][DESCR=>� ��.����������]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ��������� ********** ');
          --  ��������� ������� ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DOC_NOT_VISA_REF&accessCode=1',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� ���'�������� ��������� ��� 3720 (���) ********** ');
          --  ��������� ������� ���. ����� ���'�������� ��������� ��� 3720 (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� ���'�������� ��������� ��� 3720 (���)',
                                                  p_funcname => '/barsroot/sep/sep3720/index?mode=hrivna',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� 3720  (������ ���������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720  (������ ���������)',
															  p_funcname => '/barsroot/sep/sep3720/getsep3720list\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720 (��������� ���������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720 (��������� ���������)',
															  p_funcname => '/barsroot/sep/sep3720/deleterecord\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720  (�������� �������������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720  (�������� �������������� �������)',
															  p_funcname => '/barsroot/sep/sep3720/getaltaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720 (��������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720 (��������� �������)',
															  p_funcname => '/barsroot/sep/sep3720/getaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720 (�������� �����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720 (�������� �����)',
															  p_funcname => '/barsroot/sep/sep3720/setrequest\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720  (�� �������������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720  (�� �������������� �������)',
															  p_funcname => '/barsroot/sep/sep3720/toaltaccounts\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� ���'�������� ��������� ��� 3720 (���) ********** ');
          --  ��������� ������� ���. ����� ���'�������� ��������� ��� 3720 (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� ���'�������� ��������� ��� 3720 (���)',
                                                  p_funcname => '/barsroot/sep/sep3720/index?mode=valuta',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� 3720  (������ ���������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720  (������ ���������)',
															  p_funcname => '/barsroot/sep/sep3720/getsep3720list\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720 (��������� ���������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720 (��������� ���������)',
															  p_funcname => '/barsroot/sep/sep3720/deleterecord\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720  (�������� �������������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720  (�������� �������������� �������)',
															  p_funcname => '/barsroot/sep/sep3720/getaltaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720 (��������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720 (��������� �������)',
															  p_funcname => '/barsroot/sep/sep3720/getaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720 (�������� �����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720 (�������� �����)',
															  p_funcname => '/barsroot/sep/sep3720/setrequest\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� 3720  (�� �������������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� 3720  (�� �������������� �������)',
															  p_funcname => '/barsroot/sep/sep3720/toaltaccounts\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� ��������� ********** ');
          --  ��������� ������� ���. ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� ���������',
                                                  p_funcname => '/barsroot/sep/separcdocuments/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���. ����� ��������� (������ ���������) .
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���. ����� ��������� (������ ���������) .',
															  p_funcname => '/barsroot/sep/sepdocuments/getsepfiledocs\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���. ����� ��������� (����������� ��������� �� ������ ����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���. ����� ��������� (����������� ��������� �� ������ ����)',
															  p_funcname => '/barsroot/sep/sepdocuments/getseppaymentstatedocs\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������/������������ �������� ********** ');
          --  ��������� ������� ���. ���������/������������ ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������/������������ ��������',
                                                  p_funcname => '/barsroot/sep/sepdirection/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���������/������������ ������������./�������.
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������/������������ ������������./�������.',
															  p_funcname => '/barsroot/sep/sepdirection/startdirection\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ��������� � ���������� ����� �����������, �� �� ������� ********** ');
          --  ��������� ������� ���. ��������� � ���������� ����� �����������, �� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ��������� � ���������� ����� �����������, �� �� �������',
                                                  p_funcname => '/barsroot/sep/sepfuturedocs/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ��������� � ���������� ����� �����������, �� �� ������� (�����.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� � ���������� ����� �����������, �� �� ������� (�����.)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/removesepfuturedoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� � ���������� ����� �����������, �� �� ������� (�������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� � ���������� ����� �����������, �� �� ������� (�������)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/getsepfuturedocaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� � ���������� ����� �����������, �� �� ������� (�������.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� � ���������� ����� �����������, �� �� ������� (�������.)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/setsepfuturedoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� � ���������� ����� �����������, �� �� ������� (���������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� � ���������� ����� �����������, �� �� ������� (���������)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/getsepfuturedoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���� ������� ********** ');
          --  ��������� ������� ���. ���� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���� �������',
                                                  p_funcname => '/barsroot/sep/seppaymentstate/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���� ������� (����� ������� �� ������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ������� (����� ������� �� ������)',
															  p_funcname => '/barsroot/sep/seppaymentstate/getseppaymentstatelist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³����� ��� ********** ');
          --  ��������� ������� ³����� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³����� ���',
                                                  p_funcname => '/barsroot/sep/seprequestips/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ����� ********** ');
          --  ��������� ������� ���. ���������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� �����',
                                                  p_funcname => '/barsroot/sep/septechflag/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� � �������������� ������������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� � �������������� ������������',
															  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=\d+&mode=\S\S',
															  p_rolename => 'WR_REFREAD' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���. ����������� ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���. ����������� ������',
															  p_funcname => '/barsroot/sep/septz/',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_CHIF) - ��� ����������� �� (�������� ���)  ');
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
umu.add_report2arm(119,'$RM_CHIF');
umu.add_report2arm(351,'$RM_CHIF');
umu.add_report2arm(472,'$RM_CHIF');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_CHIF.sql =========**
PROMPT ===================================================================================== 
