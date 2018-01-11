PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_KREW.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_KREW ***
  declare
    l_application_code varchar2(10 char) := '$RM_KREW';
    l_application_name varchar2(300 char) := '��� ���������� i���������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_KREW ��������� (��� ���������) ��� ��� ���������� i��������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������. �������������� ��������� �� �� � ������ ********** ');
          --  ��������� ������� �������. �������������� ��������� �� �� � ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������. �������������� ��������� �� �� � ������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_cc_989917',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������� �� ********** ');
          --  ��������� ������� ���������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������� ��',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*frm=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���������� ��������� 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���������� ��������� 351',
															  p_funcname => '/barsroot/credit/fin_nbu/credit_defolt_kons.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� �� print
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� �� print',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_list_conclusions.aspx?rnk=\S*nd=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �볺��� ������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �볺��� ������� ��',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���� ��������� 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���� ��������� 351',
															  p_funcname => '/barsroot/credit/fin_nbu/print_fin.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���������� ��������� 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���������� ��������� 351',
															  p_funcname => '/barsroot/credit/fin_nbu/credit_defolt.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_obu.aspx?okpo=\S*frm=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����2
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����2',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_p\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_k\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���������� ��������� 351 History
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���������� ��������� 351 History',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_list_dat.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� �� �������',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_obu_pawn\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form.aspx?okpo=\S*frm=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Գ����� ���������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Գ����� ���������� ����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_kved.aspx?okpo=\S*rnk=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ���������� ������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ���������� ������� ��',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kontr\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������� ��������� ������ ��������� ������� ********** ');
          --  ��������� ������� ���������� �������� ��������� ������ ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������� ��������� ������ ��������� �������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust_bd',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �볺��� ������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �볺��� ������� ��',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_bd\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*rnk=\S*frm=\S*dat=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ����� 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ����� 351',
															  p_funcname => '/barsroot/credit/fin_nbu/credit_defolt_bud.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������� ��������� ������ �� ********** ');
          --  ��������� ������� ���������� �������� ��������� ������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������� ��������� ������ ��',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust_fl',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ����� 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ����� 351',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_pd_fo.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �볺��� ������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �볺��� ������� ��',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_fl\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*rnk=\S*frm=\S*dat=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������� ��������� ������ ��-��� ********** ');
          --  ��������� ������� ���������� �������� ��������� ������ ��-���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������� ��������� ������ ��-���',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust_spd',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ����� 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ����� 351',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_pd_fo.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �볺��� ������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �볺��� ������� ��',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_fl\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �����',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*rnk=\S*frm=\S*dat=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� *����������� �� ��i�� ���.������ �� ����.��� � 279 �.6.2.�� ********** ');
          --  ��������� ������� *����������� �� ��i�� ���.������ �� ����.��� � 279 �.6.2.��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*����������� �� ��i�� ���.������ �� ����.��� � 279 �.6.2.��',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_s080_fo',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� *����������� �� ��i�� ���.������ �� ����.��� � 279 �.6.2.�� ********** ');
          --  ��������� ������� *����������� �� ��i�� ���.������ �� ����.��� � 279 �.6.2.��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*����������� �� ��i�� ���.������ �� ����.��� � 279 �.6.2.��',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_s080_uo',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ���� �� ������� ********** ');
          --  ��������� ������� ����� ���� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ���� �� �������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_v_cc_komis',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���� ���� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ���� �� �������',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_cc_prod_komis&prod=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� ������ ��� �� ********** ');
          --  ��������� ������� ������ �� ������ ��� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� ������ ��� ��',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2810&mode=ro&force=1',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����i����� ������ �� ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����i����� ������ �� ������',
															  p_funcname => '/barsroot/credit/cck_zay.aspx?prod=\d+&name=\S*&custtype=\d+',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� ������ ��� �� ********** ');
          --  ��������� ������� ������ �� ������ ��� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� ������ ��� ��',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2811&mode=ro&force=1',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����i����� ������ �� ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����i����� ������ �� ������',
															  p_funcname => '/barsroot/credit/cck_zay.aspx?prod=\d+&name=\S*&custtype=\d+',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� �� ********** ');
          --  ��������� ������� �������� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� ��',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������� �� ��������� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �� ��������� ���������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=3&nd=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������� (��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� (��������)',
															  p_funcname => '/barsroot/ins/deals.aspx?fid=mgrf&type=mgr&nd=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� �� ********** ');
          --  ��������� ������� �������� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� ��',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2813&mode=RO&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������� �� ��������� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �� ��������� ���������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=3&nd=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������� (��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� (��������)',
															  p_funcname => '/barsroot/ins/deals.aspx?fid=mgru&type=mgr&nd=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������ ������� ********** ');
          --  ��������� ������� �������� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������ �������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2815&mode=RO&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ³��� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³��� ����� ���������',
															  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i� �i������� �� �� ********** ');
          --  ��������� ������� ���i� �i������� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i� �i������� �� ��',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=4161&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��䳿 �� �� ********** ');
          --  ��������� ������� ��䳿 �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��䳿 �� ��',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=4692&mode=RW&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ��������� ��� �������(���������� ���) ********** ');
          --  ��������� ������� ���������� ��������� ��� �������(���������� ���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ��������� ��� �������(���������� ���)',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=CC_VP_DOSR&mode=RO&force=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���������� ��������� ��� �������/���������� ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� ��������� ��� �������/���������� ���',
															  p_funcname => '/barsroot/credit/repayment_dostr.aspx?ccid=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ���i��� ********** ');
          --  ��������� ������� ������������ ���i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ���i���',
                                                  p_funcname => '/barsroot/credit/info.aspx',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ��������',
															  p_funcname => '/barsroot/credit/search.aspx?stype=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �������� ������� ������������ �� �� �� (WEB) ********** ');
          --  ��������� ������� ������ �������� ������� ������������ �� �� �� (WEB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �������� ������� ������������ �� �� �� (WEB)',
                                                  p_funcname => '/barsroot/credit/overdue_loans.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_KREW) - ��� ���������� i���������  ');
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
umu.add_report2arm(494,'$RM_KREW');
umu.add_report2arm(605,'$RM_KREW');
umu.add_report2arm(799,'$RM_KREW');
umu.add_report2arm(5007,'$RM_KREW');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_KREW.sql =========**
PROMPT ===================================================================================== 
