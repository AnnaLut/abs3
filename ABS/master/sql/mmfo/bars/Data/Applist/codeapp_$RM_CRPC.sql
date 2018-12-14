PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_CRPC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_CRPC ***
  declare
    l_application_code varchar2(10 char) := '$RM_CRPC';
    l_application_name varchar2(300 char) := '��� ����������� �볺���';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_CRPC ��������� (��� ���������) ��� ��� ����������� �볺��� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������� �� ********** ');
          --  ��������� ������� ���������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������� ��',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*frm=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���������� ��������� 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���������� ��������� 351',
															  p_funcname => '/barsroot/credit/fin_nbu/credit_defolt_kons.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� �� print
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� �� print',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_list_conclusions.aspx?rnk=\S*nd=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �볺��� ������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �볺��� ������� ��',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���� ��������� 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���� ��������� 351',
															  p_funcname => '/barsroot/credit/fin_nbu/print_fin.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���������� ��������� 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���������� ��������� 351',
															  p_funcname => '/barsroot/credit/fin_nbu/credit_defolt.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_obu.aspx?okpo=\S*frm=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����2
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����2',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_p\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_k\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���������� ��������� 351 History
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���������� ��������� 351 History',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_list_dat.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� �� �������',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_obu_pawn\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form.aspx?okpo=\S*frm=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���������� ����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_kved.aspx?okpo=\S*rnk=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ���������� ������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ���������� ������� ��',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kontr\S*',
															  p_rolename => 'START1' ,
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
												  
	  l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
												  p_name      =>     '�������� ����� � ����� �������(NEW)',          
                                                  p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_OB_CORP_SALDO[CONDITIONS=>IS_LAST = 1][showDialogWindow=>false]',     
                                                  p_rolename => '' ,
                                                  p_frontend  =>      l_application_type_id ); 
                    
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
												  p_name      =>     '�������� ����� � ����� ��������(NEW)',          
												  p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_OB_CORP_SALDO_DOCS[CONDITIONS=>IS_LAST = 1]',     
												  p_rolename => '' ,
                                                  p_frontend  =>      l_application_type_id ); 
												  
	  l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
												  p_name      =>     '�������� ������ �����(NEW)',          
												  p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_OB_CORP_SESS[NSIFUNCTION][showDialogWindow=>false]',     
												  p_rolename => '' ,
                                                  p_frontend  =>      l_application_type_id );
	
	l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
												  p_name      =>     '������� ������������� �볺���(NEW)',          
												  p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=V_CORP_ACCOUNTS_WEB[EDIT_MODE=>MULTI_EDIT][NSIFUNCTION][showDialogWindow=>false]',     
												  p_rolename => '' ,
                                                  p_frontend  =>      l_application_type_id ); 
												  


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����''���� �볺��� �� ���������� ********** ');
          --  ��������� ������� ����'���� �볺��� �� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����''���� �볺��� �� ����������(NEW)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=V_CUSTOMER_CORP[showDialogWindow=>false]',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� ���''�������� ��������� ��� 3720 (���) ********** ');
          --  ��������� ������� ���. ����� ���''�������� ��������� ��� 3720 (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� ���''�������� ��������� ��� 3720 (���)',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� ���''�������� ��������� ��� 3720 (���) ********** ');
          --  ��������� ������� ���. ����� ���'�������� ��������� ��� 3720 (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� ���''�������� ��������� ��� 3720 (���)',
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

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_CRPC) - ��� ����������� �볺���  ');
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
umu.add_reference2arm_bytabname('OB_CORP_REP_NBS', '$RM_CRPC', 2, 1);
umu.add_reference2arm_bytabname('OB_CORP_DICT_NBS', '$RM_CRPC', 1, 1);
umu.add_reference2arm_bytabname('OB_CORP_DICT_REP', '$RM_CRPC', 1, 1);
umu.add_report2arm(412,'$RM_CRPC');
umu.add_report2arm(490,'$RM_CRPC');
umu.add_report2arm(491,'$RM_CRPC');
umu.add_report2arm(544,'$RM_CRPC');
umu.add_report2arm(5014,'$RM_CRPC');
umu.add_report2arm(5015,'$RM_CRPC');
umu.add_report2arm(5016,'$RM_CRPC');
umu.add_report2arm(5017,'$RM_CRPC');
umu.add_report2arm(5018,'$RM_CRPC');
umu.add_report2arm(5019,'$RM_CRPC');
umu.add_report2arm(5020,'$RM_CRPC');
umu.add_report2arm(5021,'$RM_CRPC');
umu.add_report2arm(5022,'$RM_CRPC');
umu.add_report2arm(5023,'$RM_CRPC');
umu.add_report2arm(5026,'$RM_CRPC');
umu.add_report2arm(5030,'$RM_CRPC');
umu.add_report2arm(5032,'$RM_CRPC');
umu.add_report2arm(5033,'$RM_CRPC');
umu.add_report2arm(5036,'$RM_CRPC');
umu.add_report2arm(5037,'$RM_CRPC');
umu.add_report2arm(5038,'$RM_CRPC');
umu.add_report2arm(5039,'$RM_CRPC');
umu.add_report2arm(5040,'$RM_CRPC');
umu.add_report2arm(5041,'$RM_CRPC');
umu.add_report2arm(5042,'$RM_CRPC');
umu.add_report2arm(5043,'$RM_CRPC');
umu.add_report2arm(5044,'$RM_CRPC');
umu.add_report2arm(5045,'$RM_CRPC');
umu.add_report2arm(5046,'$RM_CRPC');
umu.add_report2arm(5047,'$RM_CRPC');
umu.add_report2arm(5048,'$RM_CRPC');
umu.add_report2arm(5050,'$RM_CRPC');
umu.add_report2arm(5053,'$RM_CRPC');
umu.add_report2arm(5054,'$RM_CRPC');
umu.add_report2arm(5702,'$RM_CRPC');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_CRPC.sql =========**
PROMPT ===================================================================================== 
