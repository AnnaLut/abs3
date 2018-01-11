PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_RISK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_RISK ***
  declare
    l_application_code varchar2(10 char) := '$RM_RISK';
    l_application_name varchar2(300 char) := '��� ���������� ���������� ������ (351)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_RISK ��������� (��� ���������) ��� ��� ���������� ���������� ������ (351) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���� ********** ');
          --  ��������� ������� ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ����',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_RISK',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 9.0 ! �������� ���������� ������� �� ���-23 (��ղ�) ********** ');
          --  ��������� ������� 9.0 ! �������� ���������� ������� �� ���-23 (��ղ�)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '9.0 ! �������� ���������� ������� �� ���-23 (��ղ�)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=NBU23_REZ_ARC[PROC=>p_NBU23_ARC(:A)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 7.0. ����������� ������ ���������� ������,����� �� ��������� PD,LGD ********** ');
          --  ��������� ������� 7.0. ����������� ������ ���������� ������,����� �� ��������� PD,LGD
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7.0. ����������� ������ ���������� ������,����� �� ��������� PD,LGD',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=REZ_ND_PD_LGD[NSIFUNCTION][PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��_���� 01/��/����,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.5. ��������/���������� ��������i� �� 9200, 9300 ... ********** ');
          --  ��������� ������� 4.5. ��������/���������� ��������i� �� 9200, 9300 ...
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.5. ��������/���������� ��������i� �� 9200, 9300 ...',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=V_9200[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.0. �������� ���������� ������� �� ���-351+FINEVARE ********** ');
          --  ��������� ������� 2.0. �������� ���������� ������� �� ���-351+FINEVARE
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.0. �������� ���������� ������� �� ���-351+FINEVARE',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=NBU23_REZ_P[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3.1. �������� ��������� ������� ********** ');
          --  ��������� ������� 3.1. �������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.1. �������� ��������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=REZ_NBU23_DELTA[PROC=>z23.P_DELTA(:A,:B)][PAR=>:A(SEM=��_����_�_01-��-����,TYPE=D),:B(SEM=��_����_��_01-��-����,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.2. ��������(��� ����.) ���������� ������ �� �������� 351(��������) ********** ');
          --  ��������� ������� 2.2. ��������(��� ����.) ���������� ������ �� �������� 351(��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.2. ��������(��� ����.) ���������� ������ �� �������� 351(��������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_351_FDAT[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.1. ���������� ���������� ������ �� �������� 351 (��������) ********** ');
          --  ��������� ������� 1.1. ���������� ���������� ������ �� �������� 351 (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.1. ���������� ���������� ������ �� �������� 351 (��������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_351_FDAT[PROC=>REZ_351_BLOCK(:A,1)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.3. �������� ���������� ������ (������� ��.��� + Գ�.���) ********** ');
          --  ��������� ������� 2.3. �������� ���������� ������ (������� ��.��� + Գ�.���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.3. �������� ���������� ������ (������� ��.��� + Գ�.���)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CCK_351[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.6. �������� ���������� ������ (ֳ�� ������) ********** ');
          --  ��������� ������� 2.6. �������� ���������� ������ (ֳ�� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.6. �������� ���������� ������ (ֳ�� ������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_351[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.5. �������� ���������� ������ (���������� �������������) ********** ');
          --  ��������� ������� 2.5. �������� ���������� ������ (���������� �������������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.5. �������� ���������� ������ (���������� �������������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_DEB_351[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.4. �������� ���������� ������ (����� + ����������) ********** ');
          --  ��������� ������� 2.4. �������� ���������� ������ (����� + ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.4. �������� ���������� ������ (����� + ����������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_MBDK_351[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.1. �������� ���������23+���������351 ********** ');
          --  ��������� ������� 2.1. �������� ���������23+���������351
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.1. �������� ���������23+���������351',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_NBU23_351[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6.1. ������ �� ���.���.�������������� (�������) ********** ');
          --  ��������� ������� 6.1. ������ �� ���.���.�������������� (�������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.1. ������ �� ���.���.�������������� (�������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=DEB_FIN[PROC=>P_DEB_FIN(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6.2. ������ �� ����.���.�������������� (�������) ********** ');
          --  ��������� ������� 6.2. ������ �� ����.���.�������������� (�������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.2. ������ �� ����.���.�������������� (�������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=DEB_HOZ[PROC=>P_DEB_HOZ(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.2. ��������/���������� ��������i� ���� �� �� ********** ');
          --  ��������� ������� 4.2. ��������/���������� ��������i� ���� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.2. ��������/���������� ��������i� ���� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CCK_FL[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.1. ��������/���������� ��������i� ���� �� �� ********** ');
          --  ��������� ������� 4.1. ��������/���������� ��������i� ���� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.1. ��������/���������� ��������i� ���� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CCK_UL[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3.2. �������� ��������� ������� ���������� ������� ********** ');
          --  ��������� ������� 3.2. �������� ��������� ������� ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.2. �������� ��������� ������� ���������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=REZ_LOG',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5.1. ����� ���������� ������� ********** ');
          --  ��������� ������� 5.1. ����� ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5.1. ����� ���������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=TEST_FINREZ[PROC=>finrez_SB(:A)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE][ACCESSCODE=>1]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->00.������� ���.����� �� ����� �� ������� ********** ');
          --  ��������� ������� ->00.������� ���.����� �� ����� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->00.������� ���.����� �� ����� �� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_351_BLOCK(:A,2)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][EXEC=>BEFORE][MSG=>OK]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->01.���������� ������������ ********** ');
          --  ��������� ������� ->01.���������� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->01.���������� ������������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_351_BLOCK(:A,3)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][MSG=>OK]',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_RISK) - ��� ���������� ���������� ������ (351)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_RISK.sql =========**
PROMPT ===================================================================================== 
