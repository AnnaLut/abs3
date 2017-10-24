SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_WSKR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  WSKR ***
  declare
    l_application_code varchar2(10 char) := 'WSKR';
    l_application_name varchar2(300 char) := '��� ���������� ����� (WEB)';
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
     DBMS_OUTPUT.PUT_LINE(' WSKR ��������� (��� ���������) ��� ��� ���������� ����� (WEB) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� �������� �������� ********** ');
          --  ��������� ������� �������� �������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� �������� ��������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_SKRYNKA_PORT&mode=RO&force=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� "����" �������� ********** ');
          --  ��������� ������� ³������� "����" ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� "����" ��������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=0',
                                                  p_rolename => 'WR_CHCKINNR_SELF' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � �������  ********** ');
          --  ��������� ������� ��������� �볺��� � ������� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � ������� ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=0',
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �����������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � �������  (��)  ********** ');
          --  ��������� ������� ��������� �볺��� � �������  (��) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � �������  (��) ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=2',
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �����������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � ������� (��-���) ********** ');
          --  ��������� ������� ��������� �볺��� � ������� (��-���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � ������� (��-���)',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=3&spd=1',
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �����������(readonly)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �����������(readonly)',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+&mod=ro',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ********** ');
          --  ��������� ������� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����������',
                                                  p_funcname => '/barsroot/safe-deposit/safeamort.aspx',
                                                  p_rolename => 'DEP_SKRN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���������� ������ ********** ');
          --  ��������� ������� �������� ���������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������� ������',
                                                  p_funcname => '/barsroot/safe-deposit/safeportfolio.aspx',
                                                  p_rolename => 'DEP_SKRN' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� /barsroot/safe-deposit/safedealprint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/safedealprint.aspx',
															  p_funcname => '/barsroot/safe-deposit/safedealprint.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/dialog/safe_opendeal.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/dialog/safe_opendeal.aspx',
															  p_funcname => '/barsroot/safe-deposit/dialog/safe_opendeal.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/safedealdocs.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/safedealdocs.aspx',
															  p_funcname => '/barsroot/safe-deposit/safedealdocs.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/safeportfolio.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/safeportfolio.aspx',
															  p_funcname => '/barsroot/safe-deposit/safeportfolio.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/safevisit.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/safevisit.aspx',
															  p_funcname => '/barsroot/safe-deposit/safevisit.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/dialog/custtype.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/dialog/custtype.aspx',
															  p_funcname => '/barsroot/safe-deposit/dialog/custtype.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/dialog/createsafe.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/dialog/createsafe.aspx',
															  p_funcname => '/barsroot/safe-deposit/dialog/createsafe.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�����������',
															  p_funcname => '/barsroot/safe-deposit/safeamort.aspx',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/safedeposit.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/safedeposit.aspx',
															  p_funcname => '/barsroot/safe-deposit/safedeposit.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/dialog/binddocuments.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/dialog/binddocuments.aspx',
															  p_funcname => '/barsroot/safe-deposit/dialog/binddocuments.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/safedocinput.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/safedocinput.aspx',
															  p_funcname => '/barsroot/safe-deposit/safedocinput.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/safe-deposit/dialog/extraproperties.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/safe-deposit/dialog/extraproperties.aspx',
															  p_funcname => '/barsroot/safe-deposit/dialog/extraproperties.aspx\S*',
															  p_rolename => 'DEP_SKRN' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (WSKR) - ��� ���������� ����� (WEB)  ');
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
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappWSKR.sql =========*** En
PROMPT ===================================================================================== 
