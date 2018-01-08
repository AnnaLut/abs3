SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_DROB.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_DROB ***
  declare
    l_application_code varchar2(10 char) := '$RM_DROB';
    l_application_name varchar2(300 char) := '��� ����� �����������i�';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_DROB ��������� (��� ���������) ��� ��� ����� �����������i� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3. ������/�i����i�i �� ��� ********** ');
          --  ��������� ������� 3. ������/�i����i�i �� ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3. ������/�i����i�i �� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=V_DEBREG_QUERY_C',
                                                  p_rolename => 'DEB_REG' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4. ��i �i����i�i � ��� ********** ');
          --  ��������� ������� 4. ��i �i����i�i � ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4. ��i �i����i�i � ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_DEBREG_RES',
                                                  p_rolename => 'DEB_REG' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5. ����� �������i� (i��.��� �����) ********** ');
          --  ��������� ������� 5. ����� �������i� (i��.��� �����)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. ����� �������i� (i��.��� �����)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_ZAG_PF[NSIFUNCTION]',
                                                  p_rolename => 'DEB_REG' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6. ����������i ��i���� (�� ������ PF) ********** ');
          --  ��������� ������� 6. ����������i ��i���� (�� ������ PF)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6. ����������i ��i���� (�� ������ PF)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=6&sPar=DEBREG_BLK',
                                                  p_rolename => 'DEB_REG' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2. �������� ������ ********** ');
          --  ��������� ������� 2. �������� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2. �������� ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DEBREG_RES_S&accessCode=1&sPar=[NSIFUNCTION][PROC=>dr_ch.pop_v_debreg_res_s(:id)][PAR=>:id(SEM=������� ��� �볺���,TYPE=C,REF=DEBREG_CUSTTYPE)][EXEC=>BEFORE][CONDITIONS=>CUSTTYPE in (select id from  debreg_custtype_tmp)]',
                                                  p_rolename => 'DEB_REG' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 7. ����� �������� ���������� � ��� ********** ');
          --  ��������� ������� 7. ����� �������� ���������� � ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7. ����� �������� ���������� � ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DEB_REG_MAN&accessCode=0&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'DEB_REG' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1. ���i������/�������� i�������i� � ��� ********** ');
          --  ��������� ������� 1. ���i������/�������� i�������i� � ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1. ���i������/�������� i�������i� � ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DEB_REG_TMP&accessCode=6&sPar=[NSIFUNCTION][PROC=>dr_ch.pop_v_debreg_res_s(:id)][PAR=>:id(SEM=������� ��� �볺���,TYPE=C,REF=DEBREG_CUSTTYPE)][EXEC=>BEFORE][CONDITIONS=>CUSTTYPE in (select id from  debreg_custtype_tmp)]',
                                                  p_rolename => 'DEB_REG' ,    
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_DROB) - ��� ����� �����������i�  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_DROB.sql =========**
PROMPT ===================================================================================== 
