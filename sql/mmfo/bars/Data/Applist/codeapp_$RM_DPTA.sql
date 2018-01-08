PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_DPTA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_DPTA ***
  declare
    l_application_code varchar2(10 char) := '$RM_DPTA';
    l_application_name varchar2(300 char) := '��� ������������ ��������� ������� ��';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_DPTA ��������� (��� ���������) ��� ��� ������������ ��������� ������� �� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ������� % ������ ********** ');
          --  ��������� ������� ������ ��� ������� % ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ������� % ������',
                                                  p_funcname => '/barsroot/BaseRates/BaseRates/interestrate',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� ********** ');
          --  ��������� ������� �������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������',
                                                  p_funcname => '/barsroot/DptAdm/DptAdm/DPTAdditional',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������� �������� ��� ********** ');
          --  ��������� ������� ���������� �������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������� �������� ���',
                                                  p_funcname => '/barsroot/DptAdm/DptAdm/DPTAutoOperations',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ���� �������� �� ********** ');
          --  ��������� �������  ���� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ���� �������� ��',
                                                  p_funcname => '/barsroot/DptAdm/DptAdm/DPTViddGrid',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� ����������� ������ �� ********** ');
          --  ��������� ������� ����������� ������� ����������� ������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� ����������� ������ ��',
                                                  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=0&mod_cod="DPT"',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� ����������� ������ �� ********** ');
          --  ��������� ������� ����������� ������� ����������� ������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� ����������� ������ ��',
                                                  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=0&mod_cod="DPU"',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� ����������� ������ �� ********** ');
          --  ��������� ������� �������� ������� ����������� ������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� ����������� ������ ��',
                                                  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=1&mod_cod="DPT"',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� ����������� ������ �� ********** ');
          --  ��������� ������� �������� ������� ����������� ������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� ����������� ������ ��',
                                                  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=1&mod_cod="DPU"',
                                                  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������������ �/� ������� CardMake ********** ');
          --  ��������� ������� Way4. ������������ �/� ������� CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������������ �/� ������� CardMake',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>bars_ow.cm_salary_sync(0)][QST=>�������� ������������ �/� �������?][MSG=>�������� !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT.���������� �������� �������� ������-������ �� ����.���.-���.� ********** ');
          --  ��������� ������� DPT.���������� �������� �������� ������-������ �� ����.���.-���.�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT.���������� �������� �������� ������-������ �� ����.���.-���.�',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>DPT_PROCDR(''DPT'',:Param1,:Param2)][PAR=>:Param1(SEM=� ��������� �������� {1=���/0=�},TYPE=N,DEF=0,REF=V_YESNO),:Param2(SEM=³������ ������� {1=���/0=�},TYPE=N,DEF=1,REF=V_YESNO)][MSG=>��������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT. ϳ��'���� ������� �� ���� ********** ');
          --  ��������� ������� DPT. ϳ��'���� ������� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. ϳ��'���� ������� �� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=DPT_VIDD_SCHEME&accessCode=0',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT. ������ ���i ��� ���� ���i��������  ********** ');
          --  ��������� ������� DPT. ������ ���i ��� ���� ���i�������� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. ������ ���i ��� ���� ���i�������� ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPT_AGR_DAT_WEB&accessCode=0&sPar=[NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT. ����� �������� �� ********** ');
          --  ��������� ������� DPT. ����� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. ����� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPT_ARCHIVE&accessCode=1&sPar=[PAR=>
:A(SEM=����,TYPE=D),
:B(SEM=��� ��������-�����-��,TYPE=N,REF=DPT_VIDD),
:C(SEM=��� ��������-�����-��,TYPE=�,REF=OUR_BRANCH)]
[PROC=>DPT_RPT_UTIL.SET_ARCHV_CD(:A,:B,:C)][EXEC=>BEFORE]
[CONDITIONS=> RPT_DT = nvl(DPT_RPT_UTIL.GET_FINISH_DT, RPT_DT)
              and VIDD_ID = nvl(DPT_RPT_UTIL.GET_VIDD_CD, VIDD_ID )
              and BRANCH = nvl(DPT_RPT_UTIL.GET_BRANCH_CD, BRANCH)]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT. ������ ��� ������� ������ �� ����� �������� �� ********** ');
          --  ��������� ������� DPT. ������ ��� ������� ������ �� ����� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. ������ ��� ������� ������ �� ����� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPT_BRATES_ARC&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_DPTA) - ��� ������������ ��������� ������� ��  ');
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
umu.add_report2arm(8,'$RM_DPTA');
umu.add_report2arm(171,'$RM_DPTA');
umu.add_report2arm(185,'$RM_DPTA');
umu.add_report2arm(187,'$RM_DPTA');
umu.add_report2arm(212,'$RM_DPTA');
umu.add_report2arm(247,'$RM_DPTA');
umu.add_report2arm(256,'$RM_DPTA');
umu.add_report2arm(259,'$RM_DPTA');
umu.add_report2arm(260,'$RM_DPTA');
umu.add_report2arm(271,'$RM_DPTA');
umu.add_report2arm(296,'$RM_DPTA');
umu.add_report2arm(304,'$RM_DPTA');
umu.add_report2arm(314,'$RM_DPTA');
umu.add_report2arm(329,'$RM_DPTA');
umu.add_report2arm(342,'$RM_DPTA');
umu.add_report2arm(343,'$RM_DPTA');
umu.add_report2arm(370,'$RM_DPTA');
umu.add_report2arm(413,'$RM_DPTA');
umu.add_report2arm(414,'$RM_DPTA');
umu.add_report2arm(423,'$RM_DPTA');
umu.add_report2arm(424,'$RM_DPTA');
umu.add_report2arm(435,'$RM_DPTA');
umu.add_report2arm(800,'$RM_DPTA');
umu.add_report2arm(949,'$RM_DPTA');
umu.add_report2arm(1001,'$RM_DPTA');
umu.add_report2arm(1002,'$RM_DPTA');
umu.add_report2arm(1008,'$RM_DPTA');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_DPTA.sql =========**
PROMPT ===================================================================================== 
