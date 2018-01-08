PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_AVVV.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_AVVV ***
  declare
    l_application_code varchar2(10 char) := '$RM_AVVV';
    l_application_name varchar2(300 char) := '��� ³������� �������� �������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_AVVV ��������� (��� ���������) ��� ��� ³������� �������� ������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �������(�� �������) ********** ');
          --  ��������� ������� ��������� �������(�� �������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �������(�� �������)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=2&t=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i���.���.�� �������� �i������� ��� ������ 2,2+,3 �i��� ********** ');
          --  ��������� ������� �����i���.���.�� �������� �i������� ��� ������ 2,2+,3 �i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i���.���.�� �������� �i������� ��� ������ 2,2+,3 �i���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=VALUABLES[NSIFUNCTION][PROC=>PUL.PUT(''BRA'',:BRA)][PAR=>:BRA(SEM=�����,TYPE=S,REF=BRANCH_VAR)][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i���.���.�� ��I� �i���� ��� 1-�� ������ 2,3 �i��� ********** ');
          --  ��������� ������� �����i���.���.�� ��I� �i���� ��� 1-�� ������ 2,3 �i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i���.���.�� ��I� �i���� ��� 1-�� ������ 2,3 �i���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BR_SX(:P)][PAR=>:P(SEM=�����,TYPE=S,REF=BRANCH_OP_BR)][MSG=>OK!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i���.���.�� 1-� �i���� ��� ������ 2,2+,3 �i��� ********** ');
          --  ��������� ������� �����i���.���.�� 1-� �i���� ��� ������ 2,2+,3 �i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i���.���.�� 1-� �i���� ��� ������ 2,2+,3 �i���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BR_SX1(:P1,:P2)][PAR=>:P1(SEM=�����,TYPE=S,REF=BRANCH_VAR),:P2(SEM=�i��i���,TYPE=S,REF=VALUABLES)][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� �� 1-� ������� ��� ������ 2,2+3 ���� (���)  ********** ');
          --  ��������� ������� ������������ ������� �� 1-� ������� ��� ������ 2,2+3 ���� (���) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� �� 1-� ������� ��� ������ 2,2+3 ���� (���) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BR_SXO(:P1,:P2)][PAR=>:P1(SEM=�����,TYPE=S,REF=V_SXO),:P2(SEM=�i��i���,TYPE=S,REF=VALUABLES)][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i���.���.�� ��+��22 ��� ��i� �����i� 2 ********** ');
          --  ��������� ������� �����i���.���.�� ��+��22 ��� ��i� �����i� 2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i���.���.�� ��+��22 ��� ��i� �����i� 2',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BSOBV(0,:V,:A,null,null,null,null)][PAR=>:V(SEM=���,TYPE=N),:A(SEM=������,REF=V_NBSOB22)][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i���.���. �� ��+��22 ��� ������ 2,2+,3 �i��� ********** ');
          --  ��������� ������� �����i���.���. �� ��+��22 ��� ������ 2,2+,3 �i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i���.���. �� ��+��22 ��� ������ 2,2+,3 �i���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BSOBV(1,:V,:A,:B,null,null,null)][PAR=>:V(SEM=���,TYPE=N),:A(SEM=������,REF=V_NBSOB22),:B(SEM=�����,REF=BRANCH_VAR)][MSG=>OK]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� "������" �������� �������� ������� ********** ');
          --  ��������� ������� "������" �������� �������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"������" �������� �������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=ACCOUNTS0[NSIFUNCTION][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������� ������i� ��� ������ ��-3 � MTI ********** ');
          --  ��������� ������� �i������� ������i� ��� ������ ��-3 � MTI
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������� ������i� ��� ������ ��-3 � MTI',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>MONEX_RU.OP_NLS_MTI(:A,:B,:C,:D,:E)][PAR=>:A(SEM=�1,REF=BRANCH3_OB),:B(SEM=�2,REF=BRANCH3_OB),:C(SEM=�3,REF=BRANCH3_OB),:D(SEM=�4,REF=BRANCH3_OB),:E(SEM=�5,REF=BRANCH3_OB)][MSG=>OK]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i���.���. �� ��+��22 ��� �i����� ��(2,2+,3) ********** ');
          --  ��������� ������� �����i���.���. �� ��+��22 ��� �i����� ��(2,2+,3)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i���.���. �� ��+��22 ��� �i����� ��(2,2+,3)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>OP_BSOBV(2,:V,:A,:B,:C,:D,:E)][PAR=>:V(SEM=���,TYPE=N),:A(SEM=������,REF=V_NBSOB22),:B(SEM=�-1,REF=BRANCH_VAR),:C(SEM=�-2,REF=BRANCH_VAR),:D(SEM=�-3,REF=BRANCH_VAR),:E(SEM=�-4,REF=BRANCH_VAR)][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_AVVV) - ��� ³������� �������� �������  ');
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
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_AVVV.sql =========**
PROMPT ===================================================================================== 
