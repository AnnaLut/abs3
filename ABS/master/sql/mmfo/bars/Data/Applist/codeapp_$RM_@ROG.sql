PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@ROG.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@ROG ***
  declare
    l_application_code varchar2(10 char) := '$RM_@ROG';
    l_application_name varchar2(300 char) := '��� �������������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@ROG ��������� (��� ���������) ��� ��� ������������� ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� �볺��� �� ������� (�� �������) ********** ');
          --  ��������� ������� �������� �������� �볺��� �� ������� (�� �������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� �볺��� �� ������� (�� �������)',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=0&accessmode=0&restriction=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ���������� �������� ********** ');
          --  ��������� ������� ��������� ���������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ���������� ��������',
                                                  p_funcname => '/barsroot/docview/docs/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����������� *.html
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� *.html',
															  p_funcname => '/barsroot/docview/docs/loadhtml\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� �����',
															  p_funcname => '/barsroot/docview/docs/getticketfilename\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� *.txt
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� *.txt',
															  p_funcname => '/barsroot/docview/docs/loadtxt\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� � ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� � ������',
															  p_funcname => '/barsroot/docview/docs/exporttoexcel\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������',
															  p_funcname => '/barsroot/docview/docs/storno\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� �������',
															  p_funcname => '/barsroot/docview/docs/grid\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����',
															  p_funcname => '/barsroot/docview/docs/getfileforprint\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������(�������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������(�������)',
															  p_funcname => '/barsroot/docview/docs/reasonshandbook\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����',
															  p_funcname => '/barsroot/docview/docs/documentdatefilter\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����� HTML
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����� HTML',
															  p_funcname => '/barsroot/docview/docs/gettickethtml\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����',
															  p_funcname => '/barsroot/docview/docs/getticketfile\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ ���������',
															  p_funcname => '/barsroot/docview/docs/item\S*',
															  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� � ����� ��.������ 46 ********** ');
          --  ��������� ������� ���������� ������� � ����� ��.������ 46
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� � ����� ��.������ 46',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(3,:GR,'''',''A'')][PAR=>:GR(SEM=� ��.����������,TYPE=N,REF=PEREKR_G)][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')][DESCR=>� ��.����������]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ���������� ������� �� ������� ���. ********** ');
          --  ��������� ������� SWIFT. ���������� ������� �� ������� ���.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ���������� ������� �� ������� ���.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>BARS_SWIFT.SheduleStatementMessages][QST=>�������� ���������� �������?][MSG=>��������!]',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 7.FOREX: ����� ���� ********** ');
          --  ��������� ������� 7.FOREX: ����� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7.FOREX: ����� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_FXS_ARCHIVE&sPar=[NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6.FOREX: ����� ����(�����) ********** ');
          --  ��������� ������� 6.FOREX: ����� ����(�����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.FOREX: ����� ����(�����)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_FXS_ARCHIVE&sPar=[NSIFUNCTION][CONDITIONS=>dat>=gl.bd or dat_a>=gl.bd or dat_b>=gl.bd]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5.FOREX: Netting �i� ������� ********** ');
          --  ��������� ������� 5.FOREX: Netting �i� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5.FOREX: Netting �i� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_FOREX_NETTING[NSIFUNCTION][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ����� �������� ********** ');
          --  ��������� ������� SWIFT. ����� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ����� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=SW_BANKS&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������� ��, ���, ��� ********** ');
          --  ��������� ������� ������� ������� ��, ���, ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������� ��, ���, ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TABVAL&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ��������� - 2  ********** ');
          --  ��������� ������� ���������� ��������� - 2 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ��������� - 2 ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DOC_NOT_VISA&accessCode=1',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� FOREX Netting - ��������I� ********** ');
          --  ��������� ������� FOREX Netting - ��������I�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FOREX Netting - ��������I�',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FOR_NET_PRO&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����� ��ϲ�˲-������� USD, EUR, RUB ********** ');
          --  ��������� ������� �������� ����� ��ϲ�˲-������� USD, EUR, RUB
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����� ��ϲ�˲-������� USD, EUR, RUB',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_KPK&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ���������� ����������� ��� �������������� ********** ');
          --  ��������� ������� SWIFT. ���������� ����������� ��� ��������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ���������� ����������� ��� ��������������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_SW_AUTH_MESSAGES&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>DATE_IN>=sysdate-30]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����������� ��� ********** ');
          --  ��������� ������� �������� ����������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����������� ���',
                                                  p_funcname => '/barsroot/opencloseday/closeday/index',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ����������� ��� ********** ');
          --  ��������� ������� ³������� ����������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ����������� ���',
                                                  p_funcname => '/barsroot/opencloseday/openday/index',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ��� ����� (��������) ********** ');
          --  ��������� ������� ���. ���������� ��� ����� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ��� ����� (��������)',
                                                  p_funcname => '/barsroot/sep/sepfiles/index?mode=RW&onlyRead=true',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ��������� ��� (��������) ********** ');
          --  ��������� ������� ���. ���������� ��������� ��� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ��������� ��� (��������)',
                                                  p_funcname => '/barsroot/sep/seplockdocs/lockdocsRO?swt=swt',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ������������ ���� ������ ��������� ********** ');
          --  ��������� ������� ���. ������������ ���� ������ ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ������������ ���� ������ ���������',
                                                  p_funcname => '/barsroot/sep/sepsetlimitsdirectparticipants',
                                                  p_rolename => 'START1' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����������� ������ ********** ');
          --  ��������� ������� ���. ����������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����������� ������',
                                                  p_funcname => '/barsroot/sep/septz/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ �� ����.����.�� ����.� ���.³���.� �����. (�����. �����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �� ����.����.�� ����.� ���.³���.� �����. (�����. �����)',
															  p_funcname => '/barsroot/sep/septz/getreport\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �� ����.����.�� ����.� ���.³���.� �����. (�����. �����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �� ����.����.�� ����.� ���.³���.� �����. (�����. �����)',
															  p_funcname => '/barsroot/sep/septz/deleterow\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �� ����.����.�� �������� ������ ����� (���.���.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �� ����.����.�� �������� ������ ����� (���.���.)',
															  p_funcname => '/barsroot/sep/septz/getrowref\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �� ����.����.�� ����.� ���.³���.� �����. (����. ����.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �� ����.����.�� ����.� ���.³���.� �����. (����. ����.)',
															  p_funcname => '/barsroot/sep/septz/rowreply\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �� ����.����.�� ����.� ���.³���.� �����. (������ ���-��)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �� ����.����.�� ����.� ���.³���.� �����. (������ ���-��)',
															  p_funcname => '/barsroot/sep/septz/getseptzlist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �� ����.����.�� ����.� ���.³���.� �����.
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �� ����.����.�� ����.� ���.³���.� �����.',
															  p_funcname => '/barsroot/sep/septz/getzaga\S*',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ********** ');
          --  ��������� ������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������',
                                                  p_funcname => '/barsroot/swift/positioner',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���������� child
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� child',
															  p_funcname => '/barsroot/swi/positioner_mt.aspx?acc=\d+&ref=\d+',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ������� ��������� ���������� ********** ');
          --  ��������� ������� SWIFT. ������� ��������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ������� ��������� ����������',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. �������/������� ��������� ���������� ********** ');
          --  ��������� ������� SWIFT. �������/������� ��������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. �������/������� ��������� ����������',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=&sUserF=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_@ROG) - ��� �������������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@ROG.sql =========**
PROMPT ===================================================================================== 
