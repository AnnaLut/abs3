SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_WCSC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  WCSC ***
  declare
    l_application_code varchar2(10 char) := 'WCSC';
    l_application_name varchar2(300 char) := '��� ������������ ��������� �������� (WEB)';
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
     DBMS_OUTPUT.PUT_LINE(' WCSC ��������� (��� ���������) ��� ��� ������������ ��������� �������� (WEB) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������ ********** ');
          --  ��������� ������� ���������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������',
                                                  p_funcname => '/barsroot/credit/admin/queries_arh.aspx?type=all',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ������ (�����)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ������ (�����)',
															  p_funcname => '/barsroot/credit/admin/bid_card.aspx?bid_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ����������� ********** ');
          --  ��������� ������� ����� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� �����������',
                                                  p_funcname => '/barsroot/credit/constructor/wcsauths.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ********** ');
          --  ��������� ������� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������',
                                                  p_funcname => '/barsroot/credit/constructor/wcsgarantees.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������ ********** ');
          --  ��������� ������� ����������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������',
                                                  p_funcname => '/barsroot/credit/constructor/wcsinfoqueries.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ********** ');
          --  ��������� ������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������',
                                                  p_funcname => '/barsroot/credit/constructor/wcsinsurances.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ********** ');
          --  ��������� ������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����',
                                                  p_funcname => '/barsroot/credit/constructor/wcsmacs.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ********** ');
          --  ��������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������',
                                                  p_funcname => '/barsroot/credit/constructor/wcsproducts.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�����������',
															  p_funcname => '/barsroot/credit/constructor/wcssubproducts.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� �������� ********** ');
          --  ��������� ������� ����� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������',
                                                  p_funcname => '/barsroot/credit/constructor/wcsscancopies.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� ������ﳿ
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� ������ﳿ',
															  p_funcname => '/barsroot/credit/constructor/wcsavailablescancopyquestions.aspx?scopy_id=\S*&rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����� (Գ�. ����.) ********** ');
          --  ��������� ������� ��������� ����� (Գ�. ����.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����� (Գ�. ����.)',
                                                  p_funcname => '/barsroot/credit/constructor/wcsscorings.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ��������� ���� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ���� �� �������',
															  p_funcname => '/barsroot/credit/constructor/wcsscoringballs.aspx?scoring_id=\S*&question_id=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������������������ ********** ');
          --  ��������� ������� ����� ������������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������������������',
                                                  p_funcname => '/barsroot/credit/constructor/wcssolvencies.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-�������/������� ********** ');
          --  ��������� ������� ����-�������/�������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-�������/�������',
                                                  p_funcname => '/barsroot/credit/constructor/wcsstops.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ********** ');
          --  ��������� ������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������',
                                                  p_funcname => '/barsroot/credit/constructor/wcssurveys.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� ����� ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� ����� ������',
															  p_funcname => '/barsroot/credit/constructor/wcssurveygroupquestions.aspx?survey_id=\S*&group_id=\S*&rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ����� ��� ����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ����� ��� ����������',
															  p_funcname => '/barsroot/credit/constructor/dialogs/wcsavlbsurveygroups.aspx?survey_id=\S*&rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ��������� ********** ');
          --  ��������� ������� ������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ���������',
                                                  p_funcname => '/barsroot/credit/constructor/wcstemplates.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��ʳ� � ����� ********** ');
          --  ��������� ������� ������ ��ʳ� � �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��ʳ� � �����',
                                                  p_funcname => '/barsroot/credit/sync/import_macs.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (WCSC) - ��� ������������ ��������� �������� (WEB)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappWCSC.sql =========*** En
PROMPT ===================================================================================== 
