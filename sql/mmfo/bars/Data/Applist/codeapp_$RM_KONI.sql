PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_KONI.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_KONI ***
  declare
    l_application_code varchar2(10 char) := '$RM_KONI';
    l_application_name varchar2(300 char) := '��� ��������� ���������� i������i�';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_KONI ��������� (��� ���������) ��� ��� ��������� ���������� i������i� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� GRP101-������. ��������� �� �����. �����. ��. ��. ������. (WEB) ********** ');
          --  ��������� ������� GRP101-������. ��������� �� �����. �����. ��. ��. ������. (WEB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'GRP101-������. ��������� �� �����. �����. ��. ��. ������. (WEB)',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ink_web&grp=101&mode=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �� ��������� ��.17(��.��. ����. ���.) ********** ');
          --  ��������� ������� ���������� �� ��������� ��.17(��.��. ����. ���.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �� ��������� ��.17(��.��. ����. ���.)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,17,''PER_INK_N'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� DPU. �������� ��������� ���� �������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'DPU. �������� ��������� ���� �������� ��',
															  p_funcname => '/barsroot/udeposit_admin/dpuvidddetails.aspx?mode=\d&vidd=\d+\S*',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �� ��������� (��.��. ����. ���.) ********** ');
          --  ��������� ������� ���������� �� ��������� (��.��. ����. ���.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �� ��������� (��.��. ����. ���.)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,77,''PER_INK_N'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_KONI) - ��� ��������� ���������� i������i�  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;


    DBMS_OUTPUT.PUT_LINE(' B����� ������� ������� ���������� ������������ - ����������� ����������� �� ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_KONI.sql =========**
PROMPT ===================================================================================== 