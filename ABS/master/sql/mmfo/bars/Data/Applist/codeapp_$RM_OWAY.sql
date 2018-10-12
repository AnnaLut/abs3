PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_OWAY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_OWAY ***
  declare
    l_application_code varchar2(10 char) := '$RM_OWAY';
    l_application_name varchar2(300 char) := '��� ��������� � OpenWay';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_OWAY ��������� (��� ���������) ��� ��� ��������� � OpenWay ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� �� ����� ������ ********** ');
          --  ��������� ������� Way4. ����� �� ����� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� �� ����� ������',
                                                  p_funcname => '/barsroot/Way/InstantCards/InstantCards',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. �������� ��� (��) ********** ');
          --  ��������� ������� Way4. �������� ��� (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. �������� ��� (��)',
                                                  p_funcname => '/barsroot/Way4Bpk/Way4Bpk',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ �������',
															  p_funcname => '/barsroot/cardkiev/cardkievparams.aspx?\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Way4.productgrp
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4.productgrp',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.productgrp&formname=\S+',
															  p_rolename => 'OW' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� �� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��������� �� �������� �����',
															  p_funcname => '/barsroot/w4/addregularpayment.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
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

      --  ��������� ������� ������� �������� ������� �� ���������� ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �� ���������� ���',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=5&bpkw4nd=\d+&mod=ro',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������� ������� � ������������� ��� ********** ');
          --  ��������� ������� Way4. ������� ������� � ������������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������� ������� � ������������� ���',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.debtacc',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������������� ��������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������������� ��������� �����',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������� ��������������� ********** ');
          --  ��������� ������� Way4. ������� ���������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������� ���������������',
                                                  p_funcname => '/barsroot/bpkw4/batchbranching/index',
                                                  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2924*07*�������� � ��� ********** ');
          --  ��������� ������� 2924*07*�������� � ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924*07*�������� � ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_ATMREF07[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2924*08*������� � ��� ********** ');
          --  ��������� ������� 2924*08*������� � ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924*08*������� � ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_ATMREF08[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2924.����� ����������� ********** ');
          --  ��������� ������� 2924.����� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924.����� �����������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_KWT_RA_2924[NSIFUNCTION][showDialogWindow=>false][PROC=>PUL_DAT(:B,null)][PAR=>:B(SEM=�����_����,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� �������(new) ********** ');
          --  ��������� ������� Way4. ����� �������(new)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� �������(new)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_W4_BALANCE_TXT',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������������ %% ������ ********** ');
          --  ��������� ������� Way4. ������������ %% ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������������ %% ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> bars_ow.set_accounts_rate(0)][QST=>�������� ������������ %% ������ �� ��� Way4?][MSG=>��������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OW. ̳������ ���������� ********** ');
          --  ��������� ������� OW. ̳������ ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OW. ̳������ ����������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>BARS_OW.CLIRING(0)][QST=>�������� ��������������� � ��?][MSG=>�������� ��������������� � ��.]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���� �������� �� �/� �������� ********** ');
          --  ��������� ������� Way4. ���� �������� �� �/� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���� �������� �� �/� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>P_W4_CHANGE_BRANCH(:P,:B)][PAR=>:P(SEM=�� ������,REF=V_W4_PROECT_SAL),:B(SEM=³�������,REF=BRANCH)][MSG=>����� ������.]',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������������ �/� ������� CardMake (web) ********** ');
          --  ��������� ������� Way4. ������������ �/� ������� CardMake (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������������ �/� ������� CardMake (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>bars_ow.cm_salary_sync(0)][QST=>�������� ������������  �/� ������� CardMake?][MSG=>������������ �/� ������� CardMake ���������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������������ �/� ������� CardMake ********** ');
          --  ��������� ������� Way4. ������������ �/� ������� CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������������ �/� ������� CardMake',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>bars_ow.cm_salary_sync(0)][QST=>�������� ������������ �/� �������?][MSG=>�������� !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �������� �������� OW6 ********** ');
          --  ��������� ������� ������� �������� �������� OW6
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �������� �������� OW6',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>visa_batch_ow6(97,100)][QST=>�������� �������� �������� �� ������ ���������?][MSG=>��������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2924:�������� �������� ********** ');
          --  ��������� ������� 2924:�������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924:�������� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=D_KWT_2924[NSIFUNCTION][PROC=>KWT_2924.MAX_DAT][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2924 � ��������. �������� �� ��� ********** ');
          --  ��������� ������� 2924 � ��������. �������� �� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924 � ��������. �������� �� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_KWT_2924[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2924.�������� �������� ********** ');
          --  ��������� ������� 2924.�������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924.�������� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_KWT_D_2924[NSIFUNCTION][PROC=>KWT_2924.MAX_DAT][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������� ��� ������� ����� �� �� ���� ������ ���. (web) ********** ');
          --  ��������� ������� Way4. ������� ��� ������� ����� �� �� ���� ������ ���. (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������� ��� ������� ����� �� �� ���� ������ ���. (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=OW_CL_INFO_DATA_ERROR&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. �������� �������� ������� �� ��� (web) ********** ');
          --  ��������� ������� Way4. �������� �������� ������� �� ��� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. �������� �������� ������� �� ��� (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_BPK_CREDIT_DEAL&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� �������� �����',
															  p_funcname => 'ShowFilesInt(hWndMDI)',
															  p_rolename => 'RPBN002' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ��������� ������� - ������ (web) ********** ');
          --  ��������� ������� Way4. ��������� ������� - ������ (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ��������� ������� - ������ (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_ACCHISTORY&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ��������� ������� �� �������� (web) ********** ');
          --  ��������� ������� Way4. ��������� ������� �� �������� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ��������� ������� �� �������� (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_ACCQUE&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>sos=0]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ��������� �������, �� ������� �������� (web) ********** ');
          --  ��������� ������� Way4. ��������� �������, �� ������� �������� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ��������� �������, �� ������� �������� (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_ACCQUE&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>sos=1]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. A���� ��������� IIC (web) ********** ');
          --  ��������� ������� Way4. A���� ��������� IIC (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. A���� ��������� IIC (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_IICFILES&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���������, �� ������� �� ������ ��볺�� ���� (web) ********** ');
          --  ��������� ������� Way4. ���������, �� ������� �� ������ ��볺�� ���� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���������, �� ������� �� ������ ��볺�� ���� (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_KLBAD&accessCode=2',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� ����� OIC_LOCPAYREV (web) ********** ');
          --  ��������� ������� Way4. ����� ����� OIC_LOCPAYREV (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� ����� OIC_LOCPAYREV (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_OICREVFILES&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ��������� �� �������� (web) ********** ');
          --  ��������� ������� Way4. ��������� �� �������� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ��������� �� �������� (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 0]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����������� ��������� (web) ********** ');
          --  ��������� ������� Way4. ����������� ��������� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����������� ��������� (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� Way4. �������� ������� ����� �� �� (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. �������� ������� ����� �� �� (web)',
															  p_funcname => '/barsroot/way/wayapp/index?type=protokol',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Way4. ���������, �� ������� �� ������ ��볺�� ���� (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. ���������, �� ������� �� ������ ��볺�� ���� (web)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_KLBAD&accessCode=2',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� SWIFT. �������/������� ��������� ����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'SWIFT. �������/������� ��������� ����������',
															  p_funcname => '/barsroot/swift/swift?strPar02=&sUserF=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� �������  �������� �� �� ��22 (�����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => ' �������� �� �� ��22 (�����)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NU_OB22_FUNU&accessCode=6&sPar=[NSIFUNCTION][PAR=>:Dat(SEM=����,TYPE=D)][PROC=> pack_nu.P_OB22NU_WEB(:Dat, :Dat)][EXEC=>BEFORE]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����� - 3
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����� - 3',
															  p_funcname => '/barsroot/dynamicLayout/dynamic_layout.aspx?type=3',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����� - 2
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����� - 2',
															  p_funcname => '/barsroot/dynamicLayout/dynamic_layout.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY21. ³������� �������� ���� (�������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY21. ³������� �������� ���� (�������)',
															  p_funcname => '/barsroot/zay/currencybuysighting/index',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Way4. ������������ %% ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. ������������ %% ������',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> bars_ow.set_accounts_rate(0)][QST=>�������� ������������ %% ������ �� ��� Way4?][MSG=>��������!]',
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

      --  ��������� ������� ������� ����������� ������� ����������� ������ ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� ������� ����������� ������ ��',
															  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=0&mod_cod="DPT"',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� ����������� ������ ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� ����������� ������ ��',
															  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=1&mod_cod="DPT"',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� SWIFT. ���� ������ �� 191992, 3720, 1600, 2906
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'SWIFT. ���� ������ �� 191992, 3720, 1600, 2906',
															  p_funcname => '/barsroot/sep/seplockdocs/index?swt=swt',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������',
															  p_funcname => '/barsroot/DptAdm/DptAdm/DPTAdditional',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��: ����������� ���� ������ �볺���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��: ����������� ���� ������ �볺���',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CUST_R&accessCode=1&sPar=[NSIFUNCTION]',
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

      --  ��������� ������� ������� �������� ������� ����������� ������ ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� ����������� ������ ��',
															  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=1&mod_cod="DPU"',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� ������� ����������� ������ ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� ������� ����������� ������ ��',
															  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=0&mod_cod="DPU"',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� ������� (web) ********** ');
          --  ��������� ������� Way4. ����� ������� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� ������� (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_W4_BALANCE&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������� ����� (web) ********** ');
          --  ��������� ������� Way4. ������� ����� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������� ����� (web)',
                                                  p_funcname => '/barsroot/pc/pc/index',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ ������� �� �������� �������� ��� ********** ');
          --  ��������� ������� Way4. ������ ������� �� �������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ ������� �� �������� �������� ���',
                                                  p_funcname => '/barsroot/w4/import_salary_file.aspx',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� ������� ����� *.xml ********** ');
          --  ��������� ������� Way4. ������ �� ������� ����� *.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� ������� ����� *.xml',
                                                  p_funcname => '/barsroot/way/wayapp/index?type=import',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. �������� ������� ����� �� �� (web) ********** ');
          --  ��������� ������� Way4. �������� ������� ����� �� �� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. �������� ������� ����� �� �� (web)',
                                                  p_funcname => '/barsroot/way/wayapp/index?type=protokol',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


	 DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ������ �������������� ������ ������� 2600, 2650 ********** ');
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �������������� ������ ������� 2600, 2650',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_TRANSFORM_LE_REPORT',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                               );

	 --  ��������� ������� ���
	 DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ����. �������� ����� ������� ���. ��� �� ��� ��� ��������� ������ ********** ');
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����. �������� ����� ������� ���. ��� �� ��� ��� ��������� ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_TRANSFORM_FORECAST[CONDITIONS=>NBS=''2625''][NSIFUNCTION][EXCEL=>DISABLE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                               );

	 --  ��������� ������� ���
	 DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ����. �������� ����� ������� ��. ��� �� ��� ��� ��������� ������ ********** ');
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����. �������� ����� ������� ��. ��� �� ��� ��� ��������� ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_TRANSFORM_FORECAST_LE[NSIFUNCTION][EXCEL=>DISABLE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                               );

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_OWAY) - ��� ��������� � OpenWay  ');
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
umu.add_report2arm(107,'$RM_OWAY');
umu.add_report2arm(678,'$RM_OWAY');
umu.add_report2arm(679,'$RM_OWAY');
umu.add_report2arm(764,'$RM_OWAY');
umu.add_report2arm(850,'$RM_OWAY');
umu.add_report2arm(2924,'$RM_OWAY');
umu.add_report2arm(3016,'$RM_OWAY');
umu.add_report2arm(3017,'$RM_OWAY');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_OWAY.sql =========**
PROMPT ===================================================================================== 
