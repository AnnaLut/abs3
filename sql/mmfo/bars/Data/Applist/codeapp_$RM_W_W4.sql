SET SERVEROUTPUT ON 

SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_W_W4.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_W_W4 ***
  declare
    l_application_code varchar2(10 char) := '$RM_W_W4';
    l_application_name varchar2(300 char) := '��� "��� � Way4"';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_W_W4 ��������� (��� ���������) ��� ��� "��� � Way4" ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������� �� �������� ������ ������� ********** ');
          --  ��������� ������� ������ ������� �� �������� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������� �� �������� ������ �������',
                                                  p_funcname => '/barsroot/BpkW4/ImportKievCard/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� �� ����� ������ ********** ');
          --  ��������� ������� Way4. ����� �� ����� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� �� ����� ������',
                                                  p_funcname => '/barsroot/Way/InstantCards/InstantCards',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. �������� ��� (��) ********** ');
          --  ��������� ������� Way4. �������� ��� (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. �������� ��� (��)',
                                                  p_funcname => '/barsroot/Way4Bpk/Way4Bpk',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������������� ��������� �����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������������� ��������� �����',
                                                              p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����������� �������� �������',
                                                              p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. �������� ��� (��)********** ');
          --  ��������� ������� Way4. �������� ��� (��)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. �������� ��� (��)',
                                                  p_funcname => '/barsroot/Way4Bpk/Way4Bpk',
                                                  p_rolename => 'OW' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� �������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ �������',
															  p_funcname => '/barsroot/cardkiev/cardkievparams.aspx?\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Way4.productgrp
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4.productgrp',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.productgrp&formname=\S+',
															  p_rolename => 'OW' ,
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

      --  ��������� ������� ������� ����������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
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

      --  ��������� ������� ������� �������� ������� �� ���������� ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �� ���������� ���',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=5&bpkw4nd=\d+&mod=ro',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������� ������� � ������������� ��� ********** ');
          --  ��������� ������� Way4. ������� ������� � ������������� ���
--      l := l +1;
--      l_function_ids.extend(l);      
--      l_function_ids(l)   :=   abs_utils.add_func(
--                                                  p_name     => 'Way4. �������� ���(��)',
--                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio_uo',
--                                                  p_rolename => 'OW' ,    
--                                                  p_frontend => l_application_type_id
--                                                  );


      --  ��������� ������� ������� �������������� ��������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������������� ��������� �����',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���� �������� ********** ');
          --  ��������� ������� Way4. ���� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���� ��������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.print.proect',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �� ���� ������ ��� 2625/22 ********** ');
          --  ��������� ������� ����������� �� ���� ������ ��� 2625/22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �� ���� ������ ��� 2625/22',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_crv2_change_branch',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ϳ����������� ��������� �������������� ������� (��) ********** ');
          --  ��������� ������� Way4. ϳ����������� ��������� �������������� ������� (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ϳ����������� ��������� �������������� ������� (��)',
                                                  p_funcname => '/barsroot/bpkw4/ActivationReservedAccounts/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� �� ���� ********** ');
          --  ��������� ������� ��������� �볺��� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� �� ����',
                                                  p_funcname => '/barsroot/bpkw4/checkdkbo/index',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� �� ����� ������ �� ********** ');
          --  ��������� ������� Way4. ����� �� ����� ������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� �� ����� ������ ��',
                                                  p_funcname => '/barsroot/bpkw4/instantcard/index',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� �������� ********** ');
          --  ��������� ������� �������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� ��������',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=2',
                                                  p_rolename => 'WR_TOBO_ACCOUNTS_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������/�����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������/�����������',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� �� �������',
															  p_funcname => '/barsroot/customerlist/turn4day.aspx',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �������',
															  p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ϳ������ �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ϳ������ �� �������',
															  p_funcname => '/barsroot/customerlist/total_currency.aspx',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������\�����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������\�����������',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+&type=\d+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A. ���� �������� ********** ');
          --  ��������� ������� A. ���� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A. ���� ��������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=print',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� CardMake ********** ');
          --  ��������� ������� Way4. ������ �� CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� CardMake',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CM_REQUEST[NSIFUNCTION]',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������������ %% ������ ********** ');
          --  ��������� ������� Way4. ������������ %% ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������������ %% ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> bars_ow.set_accounts_rate(0)][QST=>�������� ������������ %% ������ �� ��� Way4?][MSG=>��������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���������� ���� �������� ������ ********** ');
          --  ��������� ������� Way4. ���������� ���� �������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���������� ���� �������� ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>SET_BPK_STR(0)][QST=>��������� ��� �������� ������?][MSG=>��������.]',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� CardMake (web) ********** ');
          --  ��������� ������� Way4. ������ �� CardMake (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� CardMake (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CM_ACC_REQUEST&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� ������� (web) ********** ');
          --  ��������� ������� Way4. ����� ������� (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� ������� (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_W4_BALANCE&accessCode=1',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 4.1:���� �������� (tt=PKD) ********** ');
          --  ��������� ������� I����� 4.1:���� �������� (tt=PKD)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 4.1:���� �������� (tt=PKD)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik&config=imp_4_1',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ ������� ����������� ������������ ������ ********** ');
          --  ��������� ������� Way4. ������ ������� ����������� ������������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ ������� ����������� ������������ ������',
                                                  p_funcname => '/barsroot/w4/import_esk_file.aspx',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ ������� �� �������� �������� ��� ********** ');
          --  ��������� ������� Way4. ������ ������� �� �������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ ������� �� �������� �������� ���',
                                                  p_funcname => '/barsroot/w4/import_salary_file.aspx',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );

	DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� �� ��������� ����� ********** ');
          --  ��������� ������� Way4. ����� �� ��������� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� �� ��������� �����',
                                                  p_funcname => '/barsroot/bpkw4/AutoOfficialNote/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. �������� ���(��) ********** ');
          --  ��������� ������� Way4. �������� ���(��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. �������� ���(��)',
                                                  p_funcname => '/barsroot/way4bpk/way4bpk?custtype=2',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� Way4.newdeal_uo
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4.newdeal_uo',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.newdeal_uo&rnk=\d+&proect_id=(\d+|-\d+)&card_code=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Way4.product_uo
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4.product_uo',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.product_uo&formname=\S+&proect_id=(\d+|-\d+)&grp_code=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Way4. rnk_uo
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. rnk_uo',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.rnk_uo&proect_id=(\d+|-\d+)&card_code=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Way4. customer_uo
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. customer_uo',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.customer_uo&proect_id=(\d+|-\d+)&card_code=\S+&rnk=\d*&okpo=\S*&nmk=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_W_W4) - ��� "��� � Way4"  ');
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
umu.add_report2arm(11,'$RM_W_W4');
umu.add_report2arm(110,'$RM_W_W4');
umu.add_report2arm(263,'$RM_W_W4');
umu.add_report2arm(607,'$RM_W_W4');
umu.add_report2arm(678,'$RM_W_W4');
umu.add_report2arm(679,'$RM_W_W4');
umu.add_report2arm(685,'$RM_W_W4');
umu.add_report2arm(708,'$RM_W_W4');
umu.add_report2arm(778,'$RM_W_W4');
umu.add_report2arm(3022,'$RM_W_W4');
umu.add_report2arm(3041,'$RM_W_W4');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_W_W4.sql =========**
PROMPT ===================================================================================== 
