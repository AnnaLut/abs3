PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_BVBB.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_BVBB ***
  declare
    l_application_code varchar2(10 char) := '$RM_BVBB';
    l_application_name varchar2(300 char) := '��� ���-�����';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_BVBB ��������� (��� ���������) ��� ��� ���-����� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� ********** ');
          --  ��������� ������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �������',
                                                  p_funcname => '/barsroot/AccountRestore/AccountRestore/index',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-�������� ********** ');
          --  ��������� ������� ������-�������-��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-��������',
                                                  p_funcname => '/barsroot/balansaccdoc/balans.aspx?par=9',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������-�������-�������� (�������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������-�������-�������� (�������)',
															  p_funcname => '/barsroot/balansaccdoc/balansacc.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� �� �������',
															  p_funcname => '/barsroot/customerlist/accextract.aspx?type=\d+&acc=\d+&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������-�������-�������� (����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������-�������-�������� (����������)',
															  p_funcname => '/barsroot/balansaccdoc/balansisp.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �������',
															  p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������-�������-�������� (������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������-�������-�������� (������)',
															  p_funcname => '/barsroot/balansaccdoc/balansval.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������. �������������� ��������� �� �� � ������ ********** ');
          --  ��������� ������� �������. �������������� ��������� �� �� � ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������. �������������� ��������� �� �� � ������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_cc_989917',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������������� ��������� ********** ');
          --  ��������� ������� �������� ������������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������������� ���������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_docum_inf',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� ����� �� ������� ������� ********** ');
          --  ��������� ������� ³������� �������� ����� �� ������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� ����� �� ������� �������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=4',
                                                  p_rolename => 'WR_CHCKINNR_SUBTOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ³������� �������� ����� �� ������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� �������� ����� �� ������� �������',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=4&grpid=\w+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������.�������������� ����� �� ������i� ********** ');
          --  ��������� ������� �������.�������������� ����� �� ������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������.�������������� ����� �� ������i�',
                                                  p_funcname => '/barsroot/coin/coin_invoice.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������ �� ������ ********** ');
          --  ��������� ������� ����� ������ �� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������ �� ������',
                                                  p_funcname => '/barsroot/deposit/deloitte/dptrequestarchive.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /deposit/deloitte/DptDefault.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/deloitte/DptDefault.aspx',
															  p_funcname => '/barsroot/deposit/deloitte/dptdefault.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ �� ������ ********** ');
          --  ��������� ������� ������� ������ �� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������ �� ������',
                                                  p_funcname => '/barsroot/deposit/deloitte/dptrequestprocessing.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /deposit/deloitte/DptDefault.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/deloitte/DptDefault.aspx',
															  p_funcname => '/barsroot/deposit/deloitte/dptdefault.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� B. �������� ����� ********** ');
          --  ��������� ������� B. �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'B. �������� �����',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=history&extended=0',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� � ���������� ********** ');
          --  ��������� ������� �������� � ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� � ����������',
                                                  p_funcname => '/barsroot/docinput/depository.aspx',
                                                  p_rolename => 'WR_DOC_INPUT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ********** ');
          --  ��������� ������� �������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������',
                                                  p_funcname => '/barsroot/docinput/ttsinput.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ³��� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³��� ����� ���������',
															  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������������� �� ������ ********** ');
          --  ��������� ������� ��������� ������������� �� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������������� �� ������',
                                                  p_funcname => '/barsroot/dynamicLayout/static_layout.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� Way4. ����������� ��������� (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. ����������� ��������� (web)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� � ����������� ������� ********** ');
          --  ��������� ������� ���������� � ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� � ����������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=BRANCH_OPELOT',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �������� 2900/05 840 ��� �������� ********** ');
          --  ��������� ������� ������� �������� 2900/05 840 ��� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �������� 2900/05 840 ��� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,200,01,''S'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �������� 2900/05 978 ��� �������� ********** ');
          --  ��������� ������� ������� �������� 2900/05 978 ��� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �������� 2900/05 978 ��� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,201,01,''S'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� CardMake ********** ');
          --  ��������� ������� Way4. ������ �� CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� CardMake',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CM_REQUEST[NSIFUNCTION]',
                                                  p_rolename => 'OW' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ���-������i� � ���������� �� ********** ');
          --  ��������� ������� ��������� ���-������i� � ���������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ���-������i� � ���������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>P_KRYM_SEP(0,:R,''373960203017'',980)][PAR=>:R(SEM=REF1_���_�����,TYPE=N)][QST=>�������� �����������i� ?][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ - ������������ - ������� ********** ');
          --  ��������� ������� ������ - ������������ - �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ - ������������ - �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_PAWN_DP&accessCode=2',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 2: ���������I ������I ********** ');
          --  ��������� ������� I����� 2: ���������I ������I
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 2: ���������I ������I',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=kp',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� I����� : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I����� : ����i� ��������i�',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� : ����i� ��������i� ********** ');
          --  ��������� ������� I����� : ����i� ��������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� : ����i� ��������i�',
                                                  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� I����� : ����������� i������������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I����� : ����������� i������������ ���������',
															  p_funcname => '/barsroot/sberutls/importproced.aspx\S*',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� I����� : ����������� i������������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I����� : ����������� i������������ ���������',
															  p_funcname => '/barsroot/sberutls/importproced.aspx',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ "��������"-XML ********** ');
          --  ��������� ������� ������ "��������"-XML
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ "��������"-XML',
                                                  p_funcname => '/barsroot/sberutls/importsalary.aspx',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� �������� �� ���� ********** ');
          --  ��������� ������� ����� �������� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� �������� �� ����',
                                                  p_funcname => '/barsroot/tools/operation_list.aspx',
                                                  p_rolename => 'BASIC_INFO' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_BVBB) - ��� ���-�����  ');
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
umu.add_report2arm(1,'$RM_BVBB');
umu.add_report2arm(2,'$RM_BVBB');
umu.add_report2arm(3,'$RM_BVBB');
umu.add_report2arm(4,'$RM_BVBB');
umu.add_report2arm(5,'$RM_BVBB');
umu.add_report2arm(6,'$RM_BVBB');
umu.add_report2arm(7,'$RM_BVBB');
umu.add_report2arm(11,'$RM_BVBB');
umu.add_report2arm(16,'$RM_BVBB');
umu.add_report2arm(17,'$RM_BVBB');
umu.add_report2arm(31,'$RM_BVBB');
umu.add_report2arm(32,'$RM_BVBB');
umu.add_report2arm(35,'$RM_BVBB');
umu.add_report2arm(43,'$RM_BVBB');
umu.add_report2arm(61,'$RM_BVBB');
umu.add_report2arm(63,'$RM_BVBB');
umu.add_report2arm(66,'$RM_BVBB');
umu.add_report2arm(67,'$RM_BVBB');
umu.add_report2arm(73,'$RM_BVBB');
umu.add_report2arm(107,'$RM_BVBB');
umu.add_report2arm(125,'$RM_BVBB');
umu.add_report2arm(126,'$RM_BVBB');
umu.add_report2arm(130,'$RM_BVBB');
umu.add_report2arm(147,'$RM_BVBB');
umu.add_report2arm(171,'$RM_BVBB');
umu.add_report2arm(184,'$RM_BVBB');
umu.add_report2arm(185,'$RM_BVBB');
umu.add_report2arm(187,'$RM_BVBB');
umu.add_report2arm(213,'$RM_BVBB');
umu.add_report2arm(237,'$RM_BVBB');
umu.add_report2arm(243,'$RM_BVBB');
umu.add_report2arm(245,'$RM_BVBB');
umu.add_report2arm(257,'$RM_BVBB');
umu.add_report2arm(261,'$RM_BVBB');
umu.add_report2arm(262,'$RM_BVBB');
umu.add_report2arm(263,'$RM_BVBB');
umu.add_report2arm(264,'$RM_BVBB');
umu.add_report2arm(265,'$RM_BVBB');
umu.add_report2arm(267,'$RM_BVBB');
umu.add_report2arm(268,'$RM_BVBB');
umu.add_report2arm(269,'$RM_BVBB');
umu.add_report2arm(270,'$RM_BVBB');
umu.add_report2arm(276,'$RM_BVBB');
umu.add_report2arm(283,'$RM_BVBB');
umu.add_report2arm(287,'$RM_BVBB');
umu.add_report2arm(320,'$RM_BVBB');
umu.add_report2arm(323,'$RM_BVBB');
umu.add_report2arm(331,'$RM_BVBB');
umu.add_report2arm(332,'$RM_BVBB');
umu.add_report2arm(333,'$RM_BVBB');
umu.add_report2arm(335,'$RM_BVBB');
umu.add_report2arm(340,'$RM_BVBB');
umu.add_report2arm(342,'$RM_BVBB');
umu.add_report2arm(343,'$RM_BVBB');
umu.add_report2arm(344,'$RM_BVBB');
umu.add_report2arm(345,'$RM_BVBB');
umu.add_report2arm(346,'$RM_BVBB');
umu.add_report2arm(347,'$RM_BVBB');
umu.add_report2arm(348,'$RM_BVBB');
umu.add_report2arm(370,'$RM_BVBB');
umu.add_report2arm(375,'$RM_BVBB');
umu.add_report2arm(376,'$RM_BVBB');
umu.add_report2arm(377,'$RM_BVBB');
umu.add_report2arm(379,'$RM_BVBB');
umu.add_report2arm(380,'$RM_BVBB');
umu.add_report2arm(412,'$RM_BVBB');
umu.add_report2arm(438,'$RM_BVBB');
umu.add_report2arm(449,'$RM_BVBB');
umu.add_report2arm(450,'$RM_BVBB');
umu.add_report2arm(481,'$RM_BVBB');
umu.add_report2arm(543,'$RM_BVBB');
umu.add_report2arm(566,'$RM_BVBB');
umu.add_report2arm(579,'$RM_BVBB');
umu.add_report2arm(684,'$RM_BVBB');
umu.add_report2arm(687,'$RM_BVBB');
umu.add_report2arm(688,'$RM_BVBB');
umu.add_report2arm(701,'$RM_BVBB');
umu.add_report2arm(702,'$RM_BVBB');
umu.add_report2arm(703,'$RM_BVBB');
umu.add_report2arm(764,'$RM_BVBB');
umu.add_report2arm(766,'$RM_BVBB');
umu.add_report2arm(767,'$RM_BVBB');
umu.add_report2arm(771,'$RM_BVBB');
umu.add_report2arm(781,'$RM_BVBB');
umu.add_report2arm(782,'$RM_BVBB');
umu.add_report2arm(871,'$RM_BVBB');
umu.add_report2arm(872,'$RM_BVBB');
umu.add_report2arm(881,'$RM_BVBB');
umu.add_report2arm(999,'$RM_BVBB');
umu.add_report2arm(1000,'$RM_BVBB');
umu.add_report2arm(1001,'$RM_BVBB');
umu.add_report2arm(1002,'$RM_BVBB');
umu.add_report2arm(1010,'$RM_BVBB');
umu.add_report2arm(1102,'$RM_BVBB');
umu.add_report2arm(3012,'$RM_BVBB');
umu.add_report2arm(3121,'$RM_BVBB');
umu.add_report2arm(4000,'$RM_BVBB');
umu.add_report2arm(4001,'$RM_BVBB');
umu.add_report2arm(5701,'$RM_BVBB');
umu.add_report2arm(5702,'$RM_BVBB');
umu.add_report2arm(5703,'$RM_BVBB');
umu.add_report2arm(5706,'$RM_BVBB');
umu.add_report2arm(5707,'$RM_BVBB');
umu.add_report2arm(5709,'$RM_BVBB');
umu.add_report2arm(100240,'$RM_BVBB');
umu.add_report2arm(100241,'$RM_BVBB');
umu.add_report2arm(100260,'$RM_BVBB');
umu.add_report2arm(100566,'$RM_BVBB');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_BVBB.sql =========**
PROMPT ===================================================================================== 
