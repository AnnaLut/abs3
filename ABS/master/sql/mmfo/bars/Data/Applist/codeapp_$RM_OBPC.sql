SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_OBPC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_OBPC ***
  declare
    l_application_code varchar2(10 char) := '$RM_OBPC';
    l_application_name varchar2(300 char) := '��� ��������� � ������������ �������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_OBPC ��������� (��� ���������) ��� ��� ��������� � ������������ ������� ');
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 4.1:���� �������� (tt=PKD) ********** ');
          --  ��������� ������� I����� 4.1:���� �������� (tt=PKD)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 4.1:���� �������� (tt=PKD)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik&config=imp_4_1',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 3: �������Ͳ ����� ********** ');
          --  ��������� ������� I����� 3: �������Ͳ �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 3: �������Ͳ �����',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� I����� : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'I����� : ����i� ��������i�',
                                                              p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                              p_rolename => 'WR_XMLIMP' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 3.1: ��������i ����� (tt=PKS,sk=84) ********** ');
          --  ��������� ������� I����� 3.1: ��������i ����� (tt=PKS,sk=84)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 3.1: ��������i ����� (tt=PKS,sk=84)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_3_1',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� I����� : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'I����� : ����i� ��������i�',
                                                              p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                              p_rolename => 'WR_XMLIMP' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 3.2: ����i��i ����� (tt=PKX,sk=87) ********** ');
          --  ��������� ������� I����� 3.2: ����i��i ����� (tt=PKX,sk=87)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 3.2: ����i��i ����� (tt=PKX,sk=87)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_3_2',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� I����� : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'I����� : ����i� ��������i�',
                                                              p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                              p_rolename => 'WR_XMLIMP' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 3.3: I��i ���������� (tt=PKR,sk=88) ********** ');
          --  ��������� ������� I����� 3.3: I��i ���������� (tt=PKR,sk=88)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 3.3: I��i ���������� (tt=PKR,sk=88)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_3_3',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_OBPC) - ��� ��������� � ������������ �������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_OBPC.sql =========**
PROMPT ===================================================================================== 
