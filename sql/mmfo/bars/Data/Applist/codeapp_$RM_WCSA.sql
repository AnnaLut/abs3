PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WCSA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WCSA ***
  declare
    l_application_code varchar2(10 char) := '$RM_WCSA';
    l_application_name varchar2(300 char) := '��� �������� ������ �� (WEB)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WCSA ��������� (��� ���������) ��� ��� �������� ������ �� (WEB) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������������� ��������� �� ������ (�������� ������ ��) ********** ');
          --  ��������� ������� ��������������� ��������� �� ������ (�������� ������ ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������������� ��������� �� ������ (�������� ������ ��)',
                                                  p_funcname => '/barsroot/credit/crdsrv/change_user.aspx?srvhr=ca',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ (�������� ������ ��) ********** ');
          --  ��������� ������� ������� ������ (�������� ������ ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������ (�������� ������ ��)',
                                                  p_funcname => '/barsroot/credit/crdsrv/queries.aspx?srvhr=ca',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ������',
															  p_funcname => '/barsroot/credit/crdsrv/bid_card.aspx?srvhr=\S+&bid_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������ (�������� ������ ��) ********** ');
          --  ��������� ������� ����� ������ (�������� ������ ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������ (�������� ������ ��)',
                                                  p_funcname => '/barsroot/credit/crdsrv/queries_arh.aspx?srvhr=ca&type=all',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ������ (�����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ������ (�����)',
															  p_funcname => '/barsroot/credit/crdsrv/bid_card_arh.aspx?bid_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������ ��������(�������� ������ ��) ********** ');
          --  ��������� ������� ����� ������ ��������(�������� ������ ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������ ��������(�������� ������ ��)',
                                                  p_funcname => '/barsroot/credit/crdsrv/queries_arh.aspx?srvhr=ca&type=branch',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ������ (�����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ������ (�����)',
															  p_funcname => '/barsroot/credit/crdsrv/bid_card_arh.aspx?bid_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������ �����������(�������� ������ ��) ********** ');
          --  ��������� ������� ����� ������ �����������(�������� ������ ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������ �����������(�������� ������ ��)',
                                                  p_funcname => '/barsroot/credit/crdsrv/queries_arh.aspx?srvhr=ca&type=user',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ������ (�����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ������ (�����)',
															  p_funcname => '/barsroot/credit/crdsrv/bid_card_arh.aspx?bid_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_WCSA) - ��� �������� ������ �� (WEB)  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;


    DBMS_OUTPUT.PUT_LINE(' B����� ������� ������� ���������� ������������ - ����������� ����������� �� ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WCSA.sql =========**
PROMPT ===================================================================================== 
