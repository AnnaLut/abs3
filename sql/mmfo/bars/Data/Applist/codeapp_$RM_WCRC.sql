PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WCRC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WCRC ***
  declare
    l_application_code varchar2(10 char) := '$RM_WCRC';
    l_application_name varchar2(300 char) := '��� ����������� �볺���(���)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WCRC ��������� (��� ���������) ��� ��� ����������� �볺���(���) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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

      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
													p_name      =>  '������������� ������������� �볺���(NEW)',          
													p_funcname  =>  '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=V_OB_CORP_L1[CONDITIONS=>V_OB_CORP_L1.PARENT_ID IS NULL][NSIFUNCTION][showDialogWindow=>false]',     
													p_rolename => '' ,
                                                    p_frontend  =>   l_application_type_id );
													

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_WCRC) - ��� ����������� �볺���(���)  ');
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
umu.add_reference2arm_bytabname('OB_CORP_DICT_OKPO', '$RM_WCRC', 2, 1);
umu.add_reference2arm_bytabname('OB_CORP_REP_NBS', '$RM_WCRC', 2, 1);
umu.add_reference2arm_bytabname('OB_CORP_DICT_NBS', '$RM_WCRC', 2, 1);
umu.add_reference2arm_bytabname('OB_CORP_DICT_REP', '$RM_WCRC', 2, 1);
umu.add_reference2arm_bytabname('TYPNLS_CORP', '$RM_WCRC', 2, 1);
umu.add_report2arm(75,'$RM_WCRC');
umu.add_report2arm(5014,'$RM_WCRC');
umu.add_report2arm(5015,'$RM_WCRC');
umu.add_report2arm(5016,'$RM_WCRC');
umu.add_report2arm(5017,'$RM_WCRC');
umu.add_report2arm(5018,'$RM_WCRC');
umu.add_report2arm(5019,'$RM_WCRC');
umu.add_report2arm(5020,'$RM_WCRC');
umu.add_report2arm(5021,'$RM_WCRC');
umu.add_report2arm(5022,'$RM_WCRC');
umu.add_report2arm(5023,'$RM_WCRC');
umu.add_report2arm(5026,'$RM_WCRC');
umu.add_report2arm(5030,'$RM_WCRC');
umu.add_report2arm(5032,'$RM_WCRC');
umu.add_report2arm(5033,'$RM_WCRC');
umu.add_report2arm(5036,'$RM_WCRC');
umu.add_report2arm(5037,'$RM_WCRC');
umu.add_report2arm(5038,'$RM_WCRC');
umu.add_report2arm(5039,'$RM_WCRC');
umu.add_report2arm(5040,'$RM_WCRC');
umu.add_report2arm(5041,'$RM_WCRC');
umu.add_report2arm(5042,'$RM_WCRC');
umu.add_report2arm(5043,'$RM_WCRC');
umu.add_report2arm(5044,'$RM_WCRC');
umu.add_report2arm(5045,'$RM_WCRC');
umu.add_report2arm(5046,'$RM_WCRC');
umu.add_report2arm(5047,'$RM_WCRC');
umu.add_report2arm(5048,'$RM_WCRC');
umu.add_report2arm(5050,'$RM_WCRC');
umu.add_report2arm(5053,'$RM_WCRC');
umu.add_report2arm(5054,'$RM_WCRC');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WCRC.sql =========**
PROMPT ===================================================================================== 
