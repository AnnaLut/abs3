SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WDPT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WDPT ***
  declare
    l_application_code varchar2(10 char) := '$RM_WDPT';
    l_application_name varchar2(300 char) := '��� �������� �������� (WEB)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WDPT ��������� (��� ���������) ��� ��� �������� �������� (WEB) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ��������� � ����� �������� ������������ ********** ');
          --  ��������� ������� �������� �������� ��������� � ����� �������� ������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ��������� � ����� �������� ������������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_dep_broken_in_period_view',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� �������� ������� � ����� �������� ������������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ������� � ����� �������� ������������',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_dep_broken_period_serch',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� � ����� �������� ������������ ********** ');
          --  ��������� ������� �������� ������� � ����� �������� ������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� � ����� �������� ������������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_dep_broken_period_serch',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� �������� ���������� �������� � ���. ����. ������.
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ���������� �������� � ���. ����. ������.',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_dep_broken_period_old_view&dep_num=\S*&dep_date=\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���i ��� ���� ���i�������� ********** ');
          --  ��������� ������� ������ ���i ��� ���� ���i��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���i ��� ���� ���i��������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=3347&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'DPT_ROLE' ,    
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������� � ������� ********** ');
          --  ��������� ������� ����������� �������� � �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������� � �������',
                                                  p_funcname => '/barsroot/deposit/depositapplicantstoimmobile.aspx',
                                                  p_rolename => 'DPT_ROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1. ³������� ������ ������ ********** ');
          --  ��������� ������� 1. ³������� ������ ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1. ³������� ������ ������',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 7. ���������� ��� ��������� ********** ');
          --  ��������� ������� 7. ���������� ��� ���������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7. ���������� ��� ���������',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx?customer=1',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2. ��������� ���������� ���� ********** ');
          --  ��������� ������� 2. ��������� ���������� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2. ��������� ���������� ����',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=agreement&extended=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5. ���������� ������������ ********** ');
          --  ��������� ������� 5. ���������� ������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. ���������� ������������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=close&extended=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3. ������� ������ ********** ');
          --  ��������� ������� 3. ������� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3. ������� ������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=deposit&extended=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4. ������� ������� ********** ');
          --  ��������� ������� 4. ������� �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4. ������� �������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=percent&extended=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A. ���� �������� ********** ');
          --  ��������� ������� A. ���� ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A. ���� ��������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=print',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6. ����������� ������ ********** ');
          --  ��������� ������� 6. ����������� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6. ����������� ������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=prolongation',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 9. ����� �������� ********** ');
          --  ��������� ������� 9. ����� ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '9. ����� ��������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=show',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 8. ��������� ������� ��� ����� �� ������ ********** ');
          --  ��������� ������� 8. ��������� ������� ��� ����� �� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '8. ��������� ������� ��� ����� �� ������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=testament',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���Ѳ� �� ������ ********** ');
          --  ��������� ������� ����������� ���Ѳ� �� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���Ѳ� �� ������',
                                                  p_funcname => '/barsroot/docinput/pay_pfu.aspx',
                                                  p_rolename => 'PYOD001' ,    
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_WDPT) - ��� �������� �������� (WEB)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WDPT.sql =========**
PROMPT ===================================================================================== 
