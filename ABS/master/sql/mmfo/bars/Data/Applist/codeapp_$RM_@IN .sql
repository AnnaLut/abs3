PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@IN .sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@IN  ***
  declare
    l_application_code varchar2(10 char) := '$RM_@IN ';
    l_application_name varchar2(300 char) := '��� CIN �������i������ i������i�';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@IN  ��������� (��� ���������) ��� ��� CIN �������i������ i������i� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� ����� �� ������� ������� ********** ');
          --  ��������� ������� ³������� �������� ����� �� ������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� ����� �� ������� �������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=4',
                                                  p_rolename => 'WR_CHCKINNR_SUBTOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ³������� �������� ����� �� ������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� �������� ����� �� ������� �������',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=4&grpid=\w+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F3 ��������� �������� �� ����������� ���� ********** ');
          --  ��������� ������� F3 ��������� �������� �� ����������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F3 ��������� �������� �� ����������� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CIN.KOM_GOU(3)][QST=>�������� - ����������� ?][MSG=>������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F4 ��������� �������� �� ����Ҳ ���� ********** ');
          --  ��������� ������� F4 ��������� �������� �� ����Ҳ ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F4 ��������� �������� �� ����Ҳ ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CIN.KOM_GOU(37)][QST=>��������  - ������ ?][MSG=>������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��� ���-�������i� ��� ���������� CIN ********** ');
          --  ��������� ������� ³��� ���-�������i� ��� ���������� CIN
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��� ���-�������i� ��� ���������� CIN',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CIN.PREV_DOK(:D1,:D2)][PAR=>:D1(SEM=���� ''�'',TYPE=D),:D2(SEM=���� ''��'',TYPE=D)][MSG=>��������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F1 Գ���-���������� + ��������-����������� �������� ********** ');
          --  ��������� ������� F1 Գ���-���������� + ��������-����������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F1 Գ���-���������� + ��������-����������� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=CIN_TKR[PROC=>CIN.KOM_ALL(1,:B,:E,:R)][PAR=>:B(SEM=���� ''�'',TYPE=C),:E(SEM=���� ''��'',TYPE=C),:R(SEM=���_��,TYPE=N,REF=V_CUSTRNK)][EXEC=>BEFORE][CONDITIONS=> CIN.R in (0,CIN_TKR.RNK) and CIN_TKR.dat1>=CIN.B and CIN_TKR.dat2<=CIN.E][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� Way4. ����������� ��������� (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. ����������� ��������� (web)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ����� ����� �볺��� ********** ');
          --  ��������� ������� �������� �������� ����� ����� �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ����� ����� �볺���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_CUST&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������-��������� (�� ��+TK+���) ********** ');
          --  ��������� ������� �������� �������-��������� (�� ��+TK+���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������-��������� (�� ��+TK+���)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_KOM0&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������-��������� (�� ��+TK) ********** ');
          --  ��������� ������� �������� �������-��������� (�� ��+TK)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������-��������� (�� ��+TK)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_KOM1&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������-��������� (�� ��) ********** ');
          --  ��������� ������� �������� �������-��������� (�� ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������-��������� (�� ��)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_KOM2&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������-���������� + �������� ���.(�� ��) ********** ');
          --  ��������� ������� �������-���������� + �������� ���.(�� ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������-���������� + �������� ���.(�� ��)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_KOM2&accessCode=1&sPar=[PROC=>CIN.KOM_ALL(0,:B,:E,:R)][PAR=>:B(SEM=���� ''�'',TYPE=C),:E(SEM=���� ''��'',TYPE=C),:R(SEM=���_��,TYPE=N,REF=CIN_CUST)][EXEC=>BEFORE][CONDITIONS=> CIN.R in (0,CIN_KOM2.RNK) and CIN_KOM2.dat1>=CIN.B and CIN_KOM2.dat2<=CIN.E]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F2.��������/����������� ���������� ��������� ********** ');
          --  ��������� ������� F2.��������/����������� ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F2.��������/����������� ���������� ���������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_TKR&accessCode=2&sPar=[PROC=>CIN.KOM_ALL(3,:B,:E,:R)][PAR=>:B(SEM=���� ''�'',TYPE=C),:E(SEM=���� ''��'',TYPE=C),:R(SEM=���_��,TYPE=N,REF=V_CUSTRNK)][EXEC=>BEFORE][CONDITIONS=> CIN.R in (0,CIN_TKR.RNK) and CIN_TKR.dat1>=CIN.B and CIN_TKR.dat2<=CIN.E]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� Way4. ����������� ��������� (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. ����������� ��������� (web)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_@IN ) - ��� CIN �������i������ i������i�  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@IN .sql =========**
PROMPT ===================================================================================== 
