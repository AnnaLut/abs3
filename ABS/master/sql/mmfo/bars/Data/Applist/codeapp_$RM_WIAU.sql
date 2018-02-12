PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WIAU.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WIAU ***
  declare
    l_application_code varchar2(10 char) := '$RM_WIAU';
    l_application_name varchar2(300 char) := '��� ����������� �� (�����������)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WIAU ��������� (��� ���������) ��� ��� ����������� �� (�����������) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� �� ���� �� �� ********** ');
          --  ��������� ������� �������� �� �� ���� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� �� ���� �� ��',
                                                  p_funcname => '/barsroot/ins/partner_type_attrs.aspx?custtype=2',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������',
                                                              p_funcname => '/barsroot/ins/attrs.aspx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �� � ��������� ********** ');
          --  ��������� ������� ���������� �� � ���������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �� � ���������',
                                                  p_funcname => '/barsroot/ins/partner_type_branches.aspx?custtype=2',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����`���� �������� �� �� �� ���� ********** ');
          --  ��������� ������� ����`���� �������� �� �� �� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����`���� �������� �� �� �� ����',
                                                  p_funcname => '/barsroot/ins/partner_type_scans.aspx?custtype=2',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������ﳿ
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ﳿ',
                                                              p_funcname => '/barsroot/ins/scans.aspx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �� ********** ');
          --  ��������� ������� ����������� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��',
                                                  p_funcname => '/barsroot/ins/partners.aspx?custtype=2',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ��������� �� ������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� �� ������',
                                                              p_funcname => '/barsroot/ins/tariffs.aspx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��� �� � ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��� �� � ���������',
                                                              p_funcname => '/barsroot/ins/branch_rnk.aspx?partner_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ˳���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '˳���',
                                                              p_funcname => '/barsroot/ins/limits.aspx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����',
                                                              p_funcname => '/barsroot/ins/fees.aspx',
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_WIAU) - ��� ����������� �� (�����������)  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;
    
	DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ������ �������� �� ������ ���� ($RM_WIAU) - ��� ����������� �� (�����������)  ');
	
	UMU.ADD_REFERENCE2ARM_BYTABNAME ('INS_TYPES',    '$RM_WIAU', 2, 1);
    UMU.ADD_REFERENCE2ARM_BYTABNAME ('INS_EWA_TYPES','$RM_WIAU', 2, 1);
    umu.add_reference2arm_bytabname('INS_EWA_PURP_MVAL',l_application_code,2,1);
    umu.add_reference2arm_bytabname('INS_EWA_PURP_M',l_application_code,2,1);
    umu.add_reference2arm_bytabname('INS_EWA_PURP_MASK',l_application_code,1,1);
    umu.add_reference2arm_bytabname('INS_EWA_PURP',l_application_code,2,1);
    umu.add_reference2arm_bytabname('INS_EWA_PART_OKPO',l_application_code,2,1);
    umu.add_reference2arm_bytabname('INS_EWA_PROD_PACK',l_application_code,2,1);
	umu.add_reference2arm_bytabname('INS_EWA_DOCUMENT_TYPES',l_application_code,2,1); 
     
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WIAU.sql =========**
PROMPT ===================================================================================== 
