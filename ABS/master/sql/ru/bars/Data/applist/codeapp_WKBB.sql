SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_WKBB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  WKBB ***
  declare
    l_application_code varchar2(10 char) := 'WKBB';
    l_application_name varchar2(300 char) := '��� ���������� (�볺��-����)';
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
     DBMS_OUTPUT.PUT_LINE(' WKBB ��������� (��� ���������) ��� ��� ���������� (�볺��-����) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� NEW ********** ');
          --  ��������� ������� ���� ���� NEW
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ���� NEW',
                                                  p_funcname => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
                                                  p_rolename => 'WR_CBIREP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���� ���� NEW
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ���� NEW',
															  p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� ���� NEW
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ���� NEW',
															  p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� �� �������(�� ������ ��������) ********** ');
          --  ��������� ������� �������� ������� �� �������(�� ������ ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� �� �������(�� ������ ��������)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=1',
                                                  p_rolename => 'WR_USER_ACCOUNTS_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��� ��������� �������/�����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������/�����������',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
															  p_rolename => '' ,
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

      --  ��������� ������� ������� �������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������\�����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������\�����������',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+&type=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� �볺��� ********** ');
          --  ��������� ������� �������� ��������� �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� �볺���',
                                                  p_funcname => '/barsroot/documentsview/default.aspx?type=2',
                                                  p_rolename => 'WR_DOCLIST_SALDO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��������� ��������� �볺��� �� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �볺��� �� ��������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �� ��������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=11',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=21&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �볺��� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �볺��� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=22&date=\d{2}\.\d{2}\.\d{4}',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (WKBB) - ��� ���������� (�볺��-����)  ');
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
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappWKBB.sql =========*** En
PROMPT ===================================================================================== 
