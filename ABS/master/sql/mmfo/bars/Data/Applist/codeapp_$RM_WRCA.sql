SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WRCA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WRCA ***
  declare
    l_application_code varchar2(10 char) := '$RM_WRCA';
    l_application_name varchar2(300 char) := '��� ��������� �볺��� �� �������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WRCA ��������� (��� ���������) ��� ��� ��������� �볺��� �� ������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� ********** ');
          --  ��������� ������� ������������ �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �������',
                                                  p_funcname => '/barsroot/acct/reservedaccounts/index/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��'������� �볺��� ********** ');
          --  ��������� ������� ��'������� �볺���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��'������� �볺���',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_rnk2rnk',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ��� �������� ����� �� ��� �볺��� ********** ');
          --  ��������� ������� ���� ��� �������� ����� �� ��� �볺���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ��� �������� ����� �� ��� �볺���',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=REPLACEMENT_RNK_INK&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'START1' ,    
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � �������  (��) ********** ');
          --  ��������� ������� ��������� �볺��� � �������  (��)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � �������  (��)',
                                                  p_funcname => '/barsroot/clients/customers/index/?custtype=person',
                                                  p_rolename => 'WR_CUSTLIST' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ �����������',
                                                              p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
                                                              p_rolename => 'WR_CUSTREG' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ������� �����������',
                                                              p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
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
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ �����������',
                                                              p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
                                                              p_rolename => 'WR_CUSTREG' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ������� �����������',
                                                              p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � ������� (�����)  ********** ');
          --  ��������� ������� ��������� �볺��� � ������� (�����) 
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � ������� (�����) ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=1',
                                                  p_rolename => 'WR_CUSTLIST' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ �����������',
                                                              p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
                                                              p_rolename => 'WR_CUSTREG' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ������� �����������',
                                                              p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � ������� (��)  ********** ');
          --  ��������� ������� ��������� �볺��� � ������� (��) 
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � ������� (��) ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=2',
                                                  p_rolename => 'WR_CUSTLIST' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ �����������',
                                                              p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
                                                              p_rolename => 'WR_CUSTREG' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ������� �����������',
                                                              p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
                                                              p_rolename => '' ,    
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
     

      --  ��������� ������� ������� �������� ������� �����������(readonly)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ������� �����������(readonly)',
                                                              p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+&mod=ro',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �볺��� ********** ');
          --  ��������� ������� �볺���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�볺���',
                                                  p_funcname => '/barsroot/customers/index/all/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� �볺���(������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�볺���(������)',
                                                              p_funcname => '/barsroot/customers/item/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �볺���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�볺���',
                                                              p_funcname => '/barsroot/customers/index/all\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� �������� ������� ********** ');
          --  ��������� ������� ������ �� �������� �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� �������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>RNK2RNK(:R1,:R2)][PAR=>:R1(SEM=��_�����������_���,TYPE=N,REF=CUSTOMER),:R2(SEM=ĳ����_���,TYPE=N,REF=CUSTOMER)][MSG=>��������!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ϳ����������� ��� �� ********** ');
          --  ��������� ������� ϳ����������� ��� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ϳ����������� ��� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CUSTOMER&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>req_type in (0,1)]',
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_WRCA) - ��� ��������� �볺��� �� �������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WRCA.sql =========**
PROMPT ===================================================================================== 
