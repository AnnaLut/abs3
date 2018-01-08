PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_NBUR.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_NBUR ***
  declare
    l_application_code varchar2(10 char) := '$RM_NBUR';
    l_application_name varchar2(300 char) := '��� ������� (�����)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_NBUR ��������� (��� ���������) ��� ��� ������� (�����) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���. �������� �� �� �� ��� ����� 70,D3,C9,E2,2C,2D ********** ');
          --  ��������� ������� ���������� ���. �������� �� �� �� ��� ����� 70,D3,C9,E2,2C,2D
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���. �������� �� �� �� ��� ����� 70,D3,C9,E2,2C,2D',
                                                  p_funcname => '/barsroot/Doc/AdditionalReqv/Index',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������������� ��� ��� �� ********** ');
          --  ��������� ������� ��������� ������������� ��� ��� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������������� ��� ��� ��',
                                                  p_funcname => '/barsroot/admin/assignmentspecparams/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �� �� 35 ��� ********** ');
          --  ��������� ������� ����������� �� �� 35 ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �� �� 35 ���',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=OPER_SK&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ �7 ********** ');
          --  ��������� ������� ������������ �7
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �7',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=[PROC=>BARSUPL.BARS_UPLOAD_USR.DELETE_JOBINFO(p_bankdate => :date_to, p_groupid => 18); BARSUPL.BARS_UPLOAD_USR.create_interface_job(p_group_id => 18, p_enabled =>1,p_sheduled => 0, p_bankdate=> :date_to)][PAR=>:date_to(SEM=�� ����,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false][CONDITIONS=>KF=sys_context(''bars_context'',''user_mfo'')]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 503(6�).��� ��� ��������� �� �������������� ������� ********** ');
          --  ��������� ������� 503(6�).��� ��� ��������� �� �������������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '503(6�).��� ��� ��������� �� �������������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&tableName=CIM_F503&sPar=[PROC=>cim_reports.prepare_f503_change(:date_to)][PAR=>:date_to(SEM=�� ����,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][showDialogWindow=>false][CONDITIONS=> KF = sys_context(''bars_context'',''user_mfo'')]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 504(35).������� �������� � ��������� �� �������������� ������� ********** ');
          --  ��������� ������� 504(35).������� �������� � ��������� �� �������������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '504(35).������� �������� � ��������� �� �������������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&tableName=CIM_F504&sPar=[PROC=>cim_reports.prepare_f504_change(:date_to)][PAR=>:date_to(SEM=�� ����,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][showDialogWindow=>false][CONDITIONS=> KF = sys_context(''bars_context'',''user_mfo'')]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ********** ');
          --  ��������� ������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=PAR_PROVODKI[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������������� ������� �������� (����� � ����������) ********** ');
          --  ��������� ������� ���������� �������������� ������� �������� (����� � ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������������� ������� �������� (����� � ����������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=OTCN_F13_ZBSK&accessCode=0&sPar=[NSIFUNCTION][PROC=>P_POP_F13ZB(:Param1,:Param2,0)][PAR=>:Param1(SEM=���� ''�'',TYPE=D),:Param2(SEM=���� ''��'',TYPE=D)][EXEC=>BEFORE][MSG=>OK!][CONDITIONS=>fdat>=:Param1 and fdat<=:Param2][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������������� ������� �������� (����� ������������) ********** ');
          --  ��������� ������� ���������� �������������� ������� �������� (����� ������������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������������� ������� �������� (����� ������������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=OTCN_F13_ZBSK&accessCode=0&sPar=[NSIFUNCTION][PROC=>P_POP_F13ZB(:Param1,:Param2,1)][PAR=>:Param1(SEM=���� ''�'',TYPE=D),:Param2(SEM=���� ''��'',TYPE=D)][EXEC=>BEFORE][MSG=>OK!][CONDITIONS=>fdat>=:Param1 and fdat<=:Param2][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������������� ������� �������� (�������� �� �����������)  ********** ');
          --  ��������� ������� ���������� �������������� ������� �������� (�������� �� �����������) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������������� ������� �������� (�������� �� �����������) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=OTCN_F13_ZBSK&accessCode=0&sPar=[NSIFUNCTION][PROC=>P_POP_F13ZB(:Param1,:Param2,2)][PAR=>:Param1(SEM=���� ''�'',TYPE=D),:Param2(SEM=���� ''��'',TYPE=D)][EXEC=>BEFORE][MSG=>OK!][CONDITIONS=>fdat>=:Param1 and fdat<=:Param2][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������ ���������� ����� ������� ********** ');
          --  ��������� ������� ������������ ������ ���������� ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������ ���������� ����� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_FILE_SCHEDULE&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������ ����������� ����� ********** ');
          --  ��������� ������� �������� ������ ����������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������ ����������� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_FORM_FINISHED_USER&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������ �����, �� �� ������������ ����� ������� ********** ');
          --  ��������� ������� �������� ������ �����, �� �� ������������ ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������ �����, �� �� ������������ ����� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_LIST_FORM_ERROR&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����� ���������� ����� ********** ');
          --  ��������� ������� �������� ����� ���������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����� ���������� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_QUEUE_FORM_ALL&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���������� ����� ������� ********** ');
          --  ��������� ������� �������� ���������� ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������� ����� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_REF_CALENDAR&accessCode=1',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� (�� ��� �� ��������) ********** ');
          --  ��������� ������� ������� (�� ��� �� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� (�� ��� �� ��������)',
                                                  p_funcname => '/barsroot/reporting/nbu/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_NBUR) - ��� ������� (�����)  ');
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
umu.add_report2arm(88,'$RM_NBUR');
umu.add_report2arm(95,'$RM_NBUR');
umu.add_report2arm(128,'$RM_NBUR');
umu.add_report2arm(155,'$RM_NBUR');
umu.add_report2arm(156,'$RM_NBUR');
umu.add_report2arm(167,'$RM_NBUR');
umu.add_report2arm(172,'$RM_NBUR');
umu.add_report2arm(173,'$RM_NBUR');
umu.add_report2arm(179,'$RM_NBUR');
umu.add_report2arm(180,'$RM_NBUR');
umu.add_report2arm(182,'$RM_NBUR');
umu.add_report2arm(188,'$RM_NBUR');
umu.add_report2arm(189,'$RM_NBUR');
umu.add_report2arm(190,'$RM_NBUR');
umu.add_report2arm(191,'$RM_NBUR');
umu.add_report2arm(192,'$RM_NBUR');
umu.add_report2arm(193,'$RM_NBUR');
umu.add_report2arm(194,'$RM_NBUR');
umu.add_report2arm(196,'$RM_NBUR');
umu.add_report2arm(197,'$RM_NBUR');
umu.add_report2arm(217,'$RM_NBUR');
umu.add_report2arm(218,'$RM_NBUR');
umu.add_report2arm(220,'$RM_NBUR');
umu.add_report2arm(221,'$RM_NBUR');
umu.add_report2arm(589,'$RM_NBUR');
umu.add_report2arm(593,'$RM_NBUR');
umu.add_report2arm(594,'$RM_NBUR');
umu.add_report2arm(595,'$RM_NBUR');
umu.add_report2arm(596,'$RM_NBUR');
umu.add_report2arm(597,'$RM_NBUR');
umu.add_report2arm(598,'$RM_NBUR');
umu.add_report2arm(599,'$RM_NBUR');
umu.add_report2arm(600,'$RM_NBUR');
umu.add_report2arm(601,'$RM_NBUR');
umu.add_report2arm(602,'$RM_NBUR');
umu.add_report2arm(1008,'$RM_NBUR');
umu.add_report2arm(5502,'$RM_NBUR');
umu.add_report2arm(100233,'$RM_NBUR');
umu.add_report2arm(100676,'$RM_NBUR');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_NBUR.sql =========**
PROMPT ===================================================================================== 
