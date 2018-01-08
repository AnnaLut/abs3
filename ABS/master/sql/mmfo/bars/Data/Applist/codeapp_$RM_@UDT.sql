PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@UDT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@UDT ***
  declare
    l_application_code varchar2(10 char) := '$RM_@UDT';
    l_application_name varchar2(300 char) := '��� ������������ ����������� ������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@UDT ��������� (��� ���������) ��� ��� ������������ ����������� ������ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ������� % ������ ********** ');
          --  ��������� ������� ������ ��� ������� % ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ������� % ������',
                                                  p_funcname => '/barsroot/BaseRates/BaseRates/interestrate',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ���� �������� �� ********** ');
          --  ��������� �������  ���� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ���� �������� ��',
                                                  p_funcname => '/barsroot/DptAdm/DptAdm/DPTViddGrid',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: �������� ���� ********** ');
          --  ��������� ������� ����: �������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: �������� ����',
                                                  p_funcname => '/barsroot/Mbdk/Deal/Index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� ������� 9760 ********** ');
          --  ��������� ������� �������� ���� ������� 9760
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� ������� 9760',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=3791&mode=ro&force=1',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���.������� �� 3800/16 ********** ');
          --  ��������� ������� ���� ���.������� �� 3800/16
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ���.������� �� 3800/16',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=4052&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ���� �������� �����i��i ********** ');
          --  ��������� �������  ���� �������� �����i��i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ���� �������� �����i��i',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=KOD_DZ',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����.�����i��i � ����������� ********** ');
          --  ��������� ������� �������� ����.�����i��i � �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����.�����i��i � �����������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=KOD_DZR[PROC=>BARS.P_KODDZ(:Par0)][PAR=>:Par0(SEM=0-�������� 1-������� �i�,TYPE=N)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����.��������� ������� �� �� (��������) ********** ');
          --  ��������� ������� ��: ����.��������� ������� �� �� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����.��������� ������� �� �� (��������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=SPECPARAM_CP_V',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ���������� ������ ********** ');
          --  ��������� ������� ����� ���������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ���������� ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CENTR_KUBM_2013',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. ���� ���������� �������� �� ********** ');
          --  ��������� ������� DPU. ���� ���������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. ���� ���������� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_DPU_VIDD[NSIFUNCTION]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� DPU. ����� ��� �������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'DPU. ����� ��� �������� ��',
															  p_funcname => '/barsroot/udeposit_admin/dpuvidddetails.aspx?mode=1',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� DPU. �������� ��������� ���� �������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'DPU. �������� ��������� ���� �������� ��',
															  p_funcname => '/barsroot/udeposit_admin/dpuvidddetails.aspx?mode=\d&vidd=\d+\S*',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5. ����� �������i� (i��.��� �����) ********** ');
          --  ��������� ������� 5. ����� �������i� (i��.��� �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. ����� �������i� (i��.��� �����)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_ZAG_PF[NSIFUNCTION]',
                                                  p_rolename => 'DEB_REG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� � ����� �����������, �� �������, ��� �� ������� �� ����� ********** ');
          --  ��������� ������� ��������� � ����� �����������, �� �������, ��� �� ������� �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� � ����� �����������, �� �������, ��� �� ������� �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_DOCS_NOT_PAYD_IN_START',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��������� �볺��� �� "������ �������� ��������" (��������) ********** ');
          --  ��������� ������� ����� ��������� �볺��� �� "������ �������� ��������" (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������� �볺��� �� "������ �������� ��������" (��������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=AUD_CUSTW_UUDV&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ���� �� ������ ********** ');
          --  ��������� ������� ��������� ���� �� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ���� �� ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=BAZA_PR&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����i� ��i� ������� %% ������ (��������) ********** ');
          --  ��������� ������� I����i� ��i� ������� %% ������ (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����i� ��i� ������� %% ������ (��������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=BR_NORMAL_VIEW&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������, �� ����� ���������� �� ������� ���� ********** ');
          --  ��������� ������� �������, �� ����� ���������� �� ������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������, �� ����� ���������� �� ������� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_PROBL&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����� ������� �� ********** ');
          --  ��������� ������� �������� ����� ������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����� ������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_V_0&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ����� ����� �볺��� ********** ');
          --  ��������� ������� �������� �������� ����� ����� �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ����� ����� �볺���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_CUST&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� �� ��. ������� (��������) ********** ');
          --  ��������� ������� �������� ���� �� ��. ������� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� �� ��. ������� (��������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=E_DEAL_META&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����������i� �� �� - �����i�����i ��� - 23 ���� ********** ');
          --  ��������� ������� I�����������i� �� �� - �����i�����i ��� - 23 ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����������i� �� �� - �����i�����i ��� - 23 ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_BPK_23&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����������i� �� �� - 23 ���� ********** ');
          --  ��������� ������� I�����������i� �� �� - 23 ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����������i� �� �� - 23 ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_FL_23&accessCode=1&sPar=[PROC=>P_INV_CCK_FL_23 (:Param0,1)][PAR=>:Param0(SEM=����,TYPE=D)][QST=>������������� �������������� ��?][EXEC=>BEFORE][CONDITIONS=>INV_FL_23.G00=TO_DATE(pul.get_mas_ini_val(''sFdat1''),''dd.mm.yyyy'')]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����������i� �� �� - I��i - 23 ���� ********** ');
          --  ��������� ������� I�����������i� �� �� - I��i - 23 ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����������i� �� �� - I��i - 23 ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_INSHI_23&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1-1. �������� ��i�� "��i����" ********** ');
          --  ��������� ������� 1-1. �������� ��i�� "��i����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1-1. �������� ��i�� "��i����"',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEXR&accessCode=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������ ������ ����.: <PO1> �� ������i 30 ��i� ********** ');
          --  ��������� ������� �������� ������ ������ ����.: <PO1> �� ������i 30 ��i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������ ������ ����.: <PO1> �� ������i 30 ��i�',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=PROVNU_PO1&accessCode=2',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������ ������������:<PO3+����i> �� ������i 5 ��i� ********** ');
          --  ��������� ������� �������� ������ ������������:<PO3+����i> �� ������i 5 ��i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������ ������������:<PO3+����i> �� ������i 5 ��i�',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=PROVNU_PO3&accessCode=2',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� 3800+3801 ********** ');
          --  ��������� ������� �������� ���� 3800+3801
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� 3800+3801',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V3800T&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2) �������� ����� ������� �� ********** ');
          --  ��������� ������� 2) �������� ����� ������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2) �������� ����� ������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_NU&accessCode=1&sPar=[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-��� �i���i��� �� ���i�� �� �� �� ********** ');
          --  ��������� ������� ��-��� �i���i��� �� ���i�� �� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-��� �i���i��� �� ���i�� �� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_SAL2&accessCode=1&sPar=[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM=��� ���� ���i��� dd_mm_yyyy>,TYPE=S),:Par2(SEM=�i� ���� ���i��� dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����������  ��������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������  ��������� ������� ����',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,324,''PER_KRM'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������, ������������� ���� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������, ������������� ���� �� �������',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_PDFO[NSIFUNCTION][PROC=>PUL.PUT(''WDAT'',to_char(:P,''dd.mm.yyyy''))][PAR=>:P(SEM=����,TYPE=D)][EXEC=>BEFORE]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� �� ��������� (��.��. ����. ���.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� �� ��������� (��.��. ����. ���.)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,77,''PER_INK_N'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������-�� �� �����. %% ����� ��� � ���� ����� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������-�� �� �����. %% ����� ��� � ���� ����� ��',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �������� ������i� �����������i� �� �� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �������� ������i� �����������i� �� �� ��',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_PAY1&accessCode=1&sPar=[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM= dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� �� ������������ �������� �� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� �� ������������ �������� �� ��',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_REP&accessCode=1&sPar=[PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=���� �������,TYPE=N,REF=V_CCK_REP_LIST_YL)][NSIFUNCTION][EXEC=>BEFORE][MSG=>��������!]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-��� �i���i��� �� ���i�� �� �� �� ********** ');
          --  ��������� ������� ��-��� �i���i��� �� ���i�� �� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-��� �i���i��� �� ���i�� �� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_SAL3&accessCode=1&sPar=[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM=��� ���� ���i��� dd_mm_yyyy>,TYPE=S),:Par2(SEM=�i� ���� ���i��� dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����������  ��������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������  ��������� ������� ����',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,324,''PER_KRM'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������, ������������� ���� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������, ������������� ���� �� �������',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_PDFO[NSIFUNCTION][PROC=>PUL.PUT(''WDAT'',to_char(:P,''dd.mm.yyyy''))][PAR=>:P(SEM=����,TYPE=D)][EXEC=>BEFORE]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� �� ��������� (��.��. ����. ���.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� �� ��������� (��.��. ����. ���.)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,77,''PER_INK_N'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������-�� �� �����. %% ����� ��� � ���� ����� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������-�� �� �����. %% ����� ��� � ���� ����� ��',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �������� ������i� �����������i� �� �� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �������� ������i� �����������i� �� �� ��',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_PAY1&accessCode=1&sPar=[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM= dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� �� ������������ �������� �� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� �� ������������ �������� �� ��',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_REP&accessCode=1&sPar=[PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=���� �������,TYPE=N,REF=V_CCK_REP_LIST_YL)][NSIFUNCTION][EXEC=>BEFORE][MSG=>��������!]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� - ����� ���� ��� ********** ');
          --  ��������� ������� �� - ����� ���� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� - ����� ���� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_ARCH_META&accessCode=1&sPar=[CONDITIONS=> kv != 980]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� - ����� ���� ��� ********** ');
          --  ��������� ������� �� - ����� ���� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� - ����� ���� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_ARCH_META&accessCode=1&sPar=[CONDITIONS=> kv = 980]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� ��������� ������� ********** ');
          --  ��������� ������� �������� ���� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� ��������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CRSOUR_PORTFOLIO&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT. ������ ��� ������� ������ �� ����� �������� �� ********** ');
          --  ��������� ������� DPT. ������ ��� ������� ������ �� ����� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. ������ ��� ������� ������ �� ����� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPT_BRATES_ARC&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. ����� �������� �� ********** ');
          --  ��������� ������� DPU. ����� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. ����� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPU_ARCHIVE&accessCode=1&sPar=[PAR=>:A(SEM=����,TYPE=D),:B(SEM=��� ��������,TYPE=N,REF=DPU_VIDD),:C(SEM=��� ��������,TYPE=�,REF=OUR_BRANCH)][PROC=>DPU_RPT_UTIL.SET_ARCHV_CD(:A,:B,:C)][EXEC=>BEFORE][CONDITIONS=> VIDD_ID = nvl(DPU_RPT_UTIL.GET_VIDD_CD, VIDD_ID ) and BRANCH = nvl(DPU_RPT_UTIL.GET_BRANCH_CD, BRANCH)]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����: �������i ������ � ������i ********** ');
          --  ��������� ������� �������� ����: �������i ������ � ������i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����: �������i ������ � ������i',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_ICCK&accessCode=2&sPar=[PROC=>ICCK(2)][EXEC=>BEFORE][MSG=>OK!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ������� ����� ������ ������� ********** ');
          --  ��������� ������� SWIFT. ������� ����� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ������� ����� ������ �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_SW_FORECAST_NOSTRO&accessCode=1',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ����� ���������� ********** ');
          --  ��������� ������� SWIFT. ����� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ����� ����������',
                                                  p_funcname => '/barsroot/swi/archive.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� SWIFT. ����� ����������(�������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'SWIFT. ����� ����������(�������)',
															  p_funcname => '/barsroot/swi/pickup_doc.aspx?swref=/d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������� �� ********** ');
          --  ��������� ������� ���������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������� ��',
                                                  p_funcname => '/barsroot/udeposit/default.aspx?mode=0&flt=null&v1.0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���� ����������� �������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ����������� �������� ��',
															  p_funcname => '/barsroot/udeposit/dptdealstate.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+\S*',
															  p_rolename => '' ,
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

      --  ��������� ������� ������� �������� ��������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ��������� ��������',
															  p_funcname => '/barsroot/udeposit/dptcreateagreement.aspx?mode=\d&dpu_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³������� ����������� �������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� ����������� �������� ��',
															  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&vidd=\d+&vidname=\S*&type=\d&dpu_gen=\d*\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �� ���������� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �� ���������� ���������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=4&rnk=\d+&acc=\d+\,\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ��������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ��������� ��������',
															  p_funcname => '/barsroot/udeposit/dptswiftdetails.aspx?mode=\d&dpu_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����������� �������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����������� �������� ��',
															  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+&dpu_ad=\d*\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���-������ /barsroot/udeposit/dptuservice.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���-������ /barsroot/udeposit/dptuservice.asmx',
															  p_funcname => '/barsroot/udeposit/dptuservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³��� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³��� ����� ���������',
															  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ��������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ��������� ��������',
															  p_funcname => '/barsroot/udeposit/dptadditionaloptions.aspx?mode=\d&dpu_id=\d+&rnk=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� �������� ��������� ********** ');
          --  ��������� ������� �� �������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� �������� ���������',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=1&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_@UDT) - ��� ������������ ����������� ������  ');
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
umu.add_report2arm(11,'$RM_@UDT');
umu.add_report2arm(35,'$RM_@UDT');
umu.add_report2arm(38,'$RM_@UDT');
umu.add_report2arm(39,'$RM_@UDT');
umu.add_report2arm(41,'$RM_@UDT');
umu.add_report2arm(43,'$RM_@UDT');
umu.add_report2arm(48,'$RM_@UDT');
umu.add_report2arm(119,'$RM_@UDT');
umu.add_report2arm(125,'$RM_@UDT');
umu.add_report2arm(126,'$RM_@UDT');
umu.add_report2arm(132,'$RM_@UDT');
umu.add_report2arm(171,'$RM_@UDT');
umu.add_report2arm(185,'$RM_@UDT');
umu.add_report2arm(238,'$RM_@UDT');
umu.add_report2arm(261,'$RM_@UDT');
umu.add_report2arm(262,'$RM_@UDT');
umu.add_report2arm(263,'$RM_@UDT');
umu.add_report2arm(264,'$RM_@UDT');
umu.add_report2arm(283,'$RM_@UDT');
umu.add_report2arm(375,'$RM_@UDT');
umu.add_report2arm(1000,'$RM_@UDT');
umu.add_report2arm(1006,'$RM_@UDT');
umu.add_report2arm(1007,'$RM_@UDT');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@UDT.sql =========**
PROMPT ===================================================================================== 
