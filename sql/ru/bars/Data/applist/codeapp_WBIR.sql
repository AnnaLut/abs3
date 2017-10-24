SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_WBIR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  WBIR ***
  declare
    l_application_code varchar2(10 char) := 'WBIR';
    l_application_name varchar2(300 char) := '��� ������ ��������-������� ������ (WEB)';
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
     DBMS_OUTPUT.PUT_LINE(' WBIR ��������� (��� ���������) ��� ��� ������ ��������-������� ������ (WEB) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY11.�������� ������ �� ��ϲ��� ������ ********** ');
          --  ��������� ������� ZAY11.�������� ������ �� ��ϲ��� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY11.�������� ������ �� ��ϲ��� ������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_buy_add',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������� ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� ������',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_statuses\S*',
															  p_rolename => 'ZAY' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY114.��������� ������ �� ������ ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY114.��������� ������ �� ������ ������',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_buy_add_edit&p_id=\S+',
															  p_rolename => 'ZAY' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY112.��������� �볺���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY112.��������� �볺���',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_cust_zay\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY111.���������� ��� ����� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY111.���������� ��� ����� �����',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm.ref.zay_kv_kurs',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������ �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������ �����',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_buy_arch',
															  p_rolename => 'ZAY' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY8.�������� ������ �� ������Ѳ� ����� (CORP2) ********** ');
          --  ��������� ������� ZAY8.�������� ������ �� ������Ѳ� ����� (CORP2)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY8.�������� ������ �� ������Ѳ� ����� (CORP2)',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_conversion',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY12.�������� ������ �� ������ ������ ********** ');
          --  ��������� ������� ZAY12.�������� ������ �� ������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY12.�������� ������ �� ������ ������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_sal_add',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������� ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� ������',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_statuses\S*',
															  p_rolename => 'ZAY' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY114.��������� ������ �� ������ ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY114.��������� ������ �� ������ ������',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_sal_add_edit&p_id=\S+',
															  p_rolename => 'ZAY' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY112.��������� �볺���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY112.��������� �볺���',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_cust_zay\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������ �������',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_sal_arch',
															  p_rolename => 'ZAY' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY111.���������� ��� ����� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY111.���������� ��� ����� �����',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm.ref.zay_kv_kurs',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� NEW ********** ');
          --  ��������� ������� ���� ���� NEW
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ���� NEW',
                                                  p_funcname => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
                                                  p_rolename => 'WR_CBIREP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���� ���� NEW
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ���� NEW',
															  p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� ���� NEW
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ���� NEW',
															  p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ZAY95. ����'������� ������ ������ ********** ');
          --  ��������� ������� ZAY95. ����'������� ������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY95. ����'������� ������ ������',
                                                  p_funcname => '/barsroot/zay/MandatorySale/Index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ZAY95. ����'������� ������ ������ (������� ����� ��� ������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. ����'������� ������ ������ (������� ����� ��� ������� �������)',
															  p_funcname => '/barsroot/zay/mandatorysale/getmandatorycurrsalelist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY95. ����'������� ������ ������ (������� �� �����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. ����'������� ������ ������ (������� �� �����������)',
															  p_funcname => '/barsroot/zay/mandatorysale/linkeddocs\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY95. ����'������� ������ ������ (������ ������ � ��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. ����'������� ������ ������ (������ ������ � ��������)',
															  p_funcname => '/barsroot/zay/mandatorysale/delitem\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY95. ����'������� ������ ������ (������ ���'������ ���������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. ����'������� ������ ������ (������ ���'������ ���������)',
															  p_funcname => '/barsroot/zay/mandatorysale/getzaylinkeddocs\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY95. ����'������� ������ ������ (��������� #D27)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. ����'������� ������ ������ (��������� #D27)',
															  p_funcname => '/barsroot/zay/mandatorysale/getd27params\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY95. ����'������� ������ ������ (������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. ����'������� ������ ������ (������� �������)',
															  p_funcname => '/barsroot/zay/mandatorysale/index\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ZAY95. ����'������� ������ ������(������ �� ����. ������ ������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. ����'������� ������ ������(������ �� ����. ������ ������)',
															  p_funcname => '/barsroot/zay/mandatorysale/createbid\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (WBIR) - ��� ������ ��������-������� ������ (WEB)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappWBIR.sql =========*** En
PROMPT ===================================================================================== 
