PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@ONE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@ONE ***
  declare
    l_application_code varchar2(10 char) := '$RM_@ONE';
    l_application_name varchar2(300 char) := '��� ��i���� �� ����i���� ��������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@ONE ��������� (��� ���������) ��� ��� ��i���� �� ����i���� �������� ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1-2. �������� ��������� ��i�� "��i����" ********** ');
          --  ��������� ������� 1-2. �������� ��������� ��i�� "��i����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1-2. �������� ��������� ��i�� "��i����"',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=MONEXRI[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�_����>,TYPE=S),:E(SEM=��_����>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� 2-1. ��i�������� ���������� � ������������ ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '2-1. ��i�������� ���������� � ������������ ���',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.monexDS(:B,:E,:S)][PAR=>:B(SEM=�_����>,TYPE=D),:E(SEM=��_����>,TYPE=D),:S(SEM=���_������),TYPE=C)][QST=>�������� ��i�������� ����������?][MSG=>OK!]',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� ������',
															  p_funcname => '/barsroot/sto/contract/getdisclaimerlist\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� �� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ��������� �� �������� �����',
															  p_funcname => '/barsroot/w4/addregularpayment.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 1-3. �������� ������������ ���� � ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '1-3. �������� ������������ ���� � ���������',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.DEL_FILE(:D,:N)][PAR=>:D(SEM=�� dd.mm.yyyy>,TYPE=D),:N(SEM=��� �� ���,TYPE=S)][EXEC=>BEFORE][MSG=>��������!]',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1-3. �������� ������������ ���� � ��������� ********** ');
          --  ��������� ������� 1-3. �������� ������������ ���� � ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1-3. �������� ������������ ���� � ���������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.DEL_FILE(:D,:N)][PAR=>:D(SEM=�� dd.mm.yyyy>,TYPE=D),:N(SEM=��� �� ���,TYPE=S)][EXEC=>BEFORE][MSG=>��������!]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2-1. ��i�������� ���������� � ������������ ��� ********** ');
          --  ��������� ������� 2-1. ��i�������� ���������� � ������������ ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2-1. ��i�������� ���������� � ������������ ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.monexDS(:B,:E,:S)][PAR=>:B(SEM=�_����>,TYPE=D),:E(SEM=��_����>,TYPE=D),:S(SEM=���_������),TYPE=C)][QST=>�������� ��i�������� ����������?][MSG=>OK!]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2-2. ��i�������� ���������� � �������� ********** ');
          --  ��������� ������� 2-2. ��i�������� ���������� � ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2-2. ��i�������� ���������� � ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.monex_KL(0)][QST=> �������� ������ � ���][MSG=>OK!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� BRAG-2.������� �³��������� ������� �� � ��� ********** ');
          --  ��������� ������� BRAG-2.������� �³��������� ������� �� � ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BRAG-2.������� �³��������� ������� �� � ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=BRANCH_UO&accessCode=0',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 0.������� �������i�(��), �� �i��� � �� ********** ');
          --  ��������� ������� 0.������� �������i�(��), �� �i��� � ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '0.������� �������i�(��), �� �i��� � ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEX0&accessCode=0',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1-1. �������� ��i�� "��i����" ********** ');
          --  ��������� ������� 1-1. �������� ��i�� "��i����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1-1. �������� ��i�� "��i����"',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEXR&accessCode=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� BRAG-3.��`���� ������ ��� �� �� ������������-�� ********** ');
          --  ��������� ������� BRAG-3.��`���� ������ ��� �� �� ������������-��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BRAG-3.��`���� ������ ��� �� �� ������������-��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEX_MV_UO&accessCode=0',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� BRAG-1.������� ��, �� �������� � ��� ********** ');
          --  ��������� ������� BRAG-1.������� ��, �� �������� � ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BRAG-1.������� ��, �� �������� � ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEX_UO&accessCode=0',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����� ������� ********** ');
          --  ��������� ������� ������ ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����� �������',
                                                  p_funcname => '/barsroot/sberutls/import_transfers.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_@ONE) - ��� ��i���� �� ����i���� ��������  ');
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
umu.add_report2arm(167,'$RM_@ONE');
umu.add_report2arm(3031,'$RM_@ONE');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@ONE.sql =========**
PROMPT ===================================================================================== 
