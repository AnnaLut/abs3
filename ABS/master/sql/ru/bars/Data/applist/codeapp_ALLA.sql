SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_ALLA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  ALLA ***
  declare
    l_application_code varchar2(10 char) := 'ALLA';
    l_application_name varchar2(300 char) := '�� �������';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_CENTURA;
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
     DBMS_OUTPUT.PUT_LINE(' ALLA ��������� (��� ���������) ��� �� ������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/DocumentPrint.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/DocumentPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/DocumentPrint.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/AddSum.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ������� �������� ********** ');
          --  ��������� ������� �������� �������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ������� ��������',
                                                  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������  /BarsWeb.TechAccounts/DocumentPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  /BarsWeb.TechAccounts/DocumentPrint.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/DocumentPrint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/DepositCoowner.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/DepositCoowner.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/DepositCoowner.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/DocumentPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/DocumentPrint.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/AddSum.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/DepositTechAcc.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/DepositTechAcc.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/DepositTechAcc.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/Transfer.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/Transfer.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/Transfer.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/DocumentForm.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/DocumentForm.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/DocumentForm.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ��������� ������� ********** ');
          --  ��������� ������� ���������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ��������� �������',
                                                  p_funcname => '/BarsWeb.TechAccounts/Default.aspx?action=add',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� ������� ��������',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ������� ********** ');
          --  ��������� ������� �������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� �������',
                                                  p_funcname => '/BarsWeb.TechAccounts/Default.aspx?action=close',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� ������� ��������',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ����� � ��������� ������� ********** ');
          --  ��������� ������� ������������� ����� � ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ����� � ��������� �������',
                                                  p_funcname => '/BarsWeb.TechAccounts/Default.aspx?action=pay',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� ������� ��������',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/DepositCoowner.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/DepositCoowner.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/DepositCoowner.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/DepositCoowner.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ��������� ������� ********** ');
          --  ��������� ������� ³������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ��������� �������',
                                                  p_funcname => '/BarsWeb.TechAccounts/DepositSearch.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� ������� ��������',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/DepositTechAcc.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/DepositTechAcc.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/DepositTechAcc.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/DepositTechAcc.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/DocumentForm.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/DocumentForm.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/DocumentForm.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/DocumentForm.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  /BarsWeb.TechAccounts/DocumentPrint.aspx ********** ');
          --  ��������� ������� �������  /BarsWeb.TechAccounts/DocumentPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  /BarsWeb.TechAccounts/DocumentPrint.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/DocumentPrint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ��������� ������� ���������� ********** ');
          --  ��������� ������� ���������� ��������� ������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ��������� ������� ����������',
                                                  p_funcname => '/BarsWeb.TechAccounts/GroupCommission.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� ������� ��������',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/Transfer.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/Transfer.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/Transfer.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/Transfer.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i���� �������� ��� �������� (�����������) ********** ');
          --  ��������� ������� �i���� �������� ��� �������� (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i���� �������� ��� �������� (�����������)',
                                                  p_funcname => '/DocInput/DocExport.aspx?type=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���������ײ� ********** ');
          --  ��������� ������� ������������� ���������ײ�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���������ײ�',
                                                  p_funcname => '/barsroot/admin/adminusers.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������� ���� ********** ');
          --  ��������� ������� �i������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������� ����',
                                                  p_funcname => '/barsroot/admin/cash_open.aspx',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� ********** ');
          --  ��������� ������� ������������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �������',
                                                  p_funcname => '/barsroot/admin/globaloptions.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-�������� ********** ');
          --  ��������� ������� ������-�������-��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-��������',
                                                  p_funcname => '/barsroot/balansaccdoc/balans.aspx?par=9',
                                                  p_rolename => 'WEB_BALANS' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �������',
															  p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������-�������-��������(������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������-�������-��������(������)',
															  p_funcname => '/barsroot/balansaccdoc/balansval.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������-�������-��������(����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������-�������-��������(����������)',
															  p_funcname => '/barsroot/balansaccdoc/balansisp.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� �� �������',
															  p_funcname => '/barsroot/customerlist/accextract.aspx?type=\d+&acc=\d+&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������-�������-��������(�������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������-�������-��������(�������)',
															  p_funcname => '/barsroot/balansaccdoc/balansacc.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-��������(�������) ********** ');
          --  ��������� ������� ������-�������-��������(�������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-��������(�������)',
                                                  p_funcname => '/barsroot/balansaccdoc/balansacc.aspx?\S+',
                                                  p_rolename => 'WEB_BALANS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-��������(����������) ********** ');
          --  ��������� ������� ������-�������-��������(����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-��������(����������)',
                                                  p_funcname => '/barsroot/balansaccdoc/balansisp.aspx?\S+',
                                                  p_rolename => 'WEB_BALANS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-��������(������) ********** ');
          --  ��������� ������� ������-�������-��������(������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-��������(������)',
                                                  p_funcname => '/barsroot/balansaccdoc/balansval.aspx?\S+',
                                                  p_rolename => 'WEB_BALANS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��������� �� ������������� ��������� ********** ');
          --  ��������� ������� ����������� ��������� �� ������������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������� �� ������������� ���������',
                                                  p_funcname => '/barsroot/barsweb/dynamic.aspx?title=none&proc=ret_pay&p1type=n&p1=ref',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��� ********** ');
          --  ��������� ������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpk.frm.portfolio',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���. ��������� ���� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���. ��������� ���� �����',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpk.frm.newdeal',
															  p_rolename => 'WR_CREDIT' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� ����������� �������� ********** ');
          --  ��������� ������� �������� �� ����������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� ����������� ��������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?(tabname=\S)|(tabid=\d+)&mode=\S\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� "���������" ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� "���������" ��������',
															  p_funcname => '/barsroot/barsweb/references/refbook.aspx?(tabname=\S)|(tabid=\d+)&mode=ro&force=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� "���������" �������� ********** ');
          --  ��������� ������� �������� "���������" ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� "���������" ��������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?(tabname=\S)|(tabid=\d+)&mode=ro&force=\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ϳ�������� �� ��� ������������ ********** ');
          --  ��������� ������� ϳ�������� �� ��� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ϳ�������� �� ��� ������������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2101&mode=w&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<��������������/������ ��������  �� ��������>> ********** ');
          --  ��������� ������� <<��������������/������ ��������  �� ��������>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<��������������/������ ��������  �� ��������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2481&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<��:���i�i� �� �������>> ********** ');
          --  ��������� ������� <<��:���i�i� �� �������>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<��:���i�i� �� �������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2482&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<������-������ �� �� ������������� �����>> ********** ');
          --  ��������� ������� <<������-������ �� �� ������������� �����>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<������-������ �� �� ������������� �����>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2483&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ��,���,���,���,����� + ��+����� ********** ');
          --  ��������� ������� ������� ��,���,���,���,����� + ��+�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ��,���,���,���,����� + ��+�����',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2484&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<������>> ********** ');
          --  ��������� ������� <<������>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2485&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������, �� ����� ���������� �� ������� ���� ********** ');
          --  ��������� ������� �������, �� ����� ���������� �� ������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������, �� ����� ���������� �� ������� ����',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2545&mode=ro&force=1',
                                                  p_rolename => 'WR_REFREAD' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<���������i�>> ********** ');
          --  ��������� ������� <<���������i�>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<���������i�>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2686&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<�������i>> ********** ');
          --  ��������� ������� <<�������i>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<�������i>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2787&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


      --  ��������� ������� ������� �������� �������� (��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� (��������)',
															  p_funcname => '/barsroot/ins/deals.aspx?fid=mgru&type=mgr&nd=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �� ��������� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �� ��������� ���������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=3&nd=\d+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� ���i���� ����� ���� ********** ');
          --  ��������� ������� ��������� ������� ���i���� ����� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� ���i���� ����� ����',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2814&mode=ro&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ��������� ������� ���?����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ������� ���?����',
															  p_funcname => '/barsroot/credit/repayment.aspx?ccid=\S+&dat1=\d+',
															  p_rolename => 'WR_CREDIT' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� ���.������i ********** ');
          --  ��������� ������� �������� �� ���.������i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� ���.������i',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=3267&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� /barsroot/tools/sto/sto_calendar.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/tools/sto/sto_calendar.aspx',
															  p_funcname => '/barsroot/tools/sto/sto_calendar.aspx\S*',
															  p_rolename => 'PYOD001' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���i ��� ���� ���i�������� ********** ');
          --  ��������� ������� ������ ���i ��� ���� ���i��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���i ��� ���� ���i��������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=3329&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��`�� ********** ');
          --  ��������� ������� ����� ��`��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��`��',
                                                  p_funcname => '/barsroot/barsweb/welcome.aspx',
                                                  p_rolename => 'BASIC_INFO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����������  ������� (�) ********** ');
          --  ��������� ������� �����������  ������� (�)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����������  ������� (�)',
                                                  p_funcname => '/barsroot/basicfunctions/acrint.aspx?par=k&flt=null',
                                                  p_rolename => 'WR_ACRINT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���� ���� ��� ����������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ���� ��� ����������� �������',
															  p_funcname => '/barsroot/basicfunctions/reports/printreport.aspx?key=\d+',
															  p_rolename => 'WR_ACRINT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���-����� /BarsWeb.BasicFunctions/BasicService.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���-����� /BarsWeb.BasicFunctions/BasicService.asmx',
															  p_funcname => '/barsroot/basicfunctions/basicservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³�������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³�������� ������ �������',
															  p_funcname => '/barsroot/basicfunctions/procaccounts.aspx?acc=\d+',
															  p_rolename => 'WR_ACRINT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����������  ������� (S) ********** ');
          --  ��������� ������� �����������  ������� (S)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����������  ������� (S)',
                                                  p_funcname => '/barsroot/basicfunctions/acrint.aspx?par=s&flt=null',
                                                  p_rolename => 'WR_ACRINT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���� ���� ��� ����������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ���� ��� ����������� �������',
															  p_funcname => '/barsroot/basicfunctions/reports/printreport.aspx?key=\d+',
															  p_rolename => 'WR_ACRINT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���-����� /BarsWeb.BasicFunctions/BasicService.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���-����� /BarsWeb.BasicFunctions/BasicService.asmx',
															  p_funcname => '/barsroot/basicfunctions/basicservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³�������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³�������� ������ �������',
															  p_funcname => '/barsroot/basicfunctions/procaccounts.aspx?acc=\d+',
															  p_rolename => 'WR_ACRINT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-����� /BarsWeb.BasicFunctions/BasicService.asmx ********** ');
          --  ��������� ������� ���-����� /BarsWeb.BasicFunctions/BasicService.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-����� /BarsWeb.BasicFunctions/BasicService.asmx',
                                                  p_funcname => '/barsroot/basicfunctions/basicservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³�������� ������ ������� ********** ');
          --  ��������� ������� ³�������� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³�������� ������ �������',
                                                  p_funcname => '/barsroot/basicfunctions/procaccounts.aspx?acc=\d+',
                                                  p_rolename => 'WR_ACRINT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� ��� ����������� ������� ********** ');
          --  ��������� ������� ���� ���� ��� ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ���� ��� ����������� �������',
                                                  p_funcname => '/barsroot/basicfunctions/reports/printreport.aspx?key=\d+',
                                                  p_rolename => 'WR_ACRINT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ��������i ��� �����i ********** ');
          --  ��������� ������� ��������� ��������i ��� �����i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ��������i ��� �����i',
                                                  p_funcname => '/barsroot/blkdocs/default.aspx',
                                                  p_rolename => 'WR_BLKDOCS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i�i��������� ����� ��`�� ********** ');
          --  ��������� ������� ���i�i��������� ����� ��`��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i�i��������� ����� ��`��',
                                                  p_funcname => '/barsroot/board/admin/',
                                                  p_rolename => 'WR_BOARD' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ��������� ����������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����������� ����� ���������',
															  p_funcname => '/barsroot/board/delete/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ���������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������� ���������� ����� ���������',
															  p_funcname => '/barsroot/board/admin/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� ����������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� ����������� ����� ���������',
															  p_funcname => '/barsroot/board/edit/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����������� ����� ���������',
															  p_funcname => '/barsroot/board/add/\S*',
															  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� NEW ********** ');
          --  ��������� ������� ���� ���� NEW
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ���� NEW',
                                                  p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� NEW ********** ');
          --  ��������� ������� ���� ���� NEW
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ���� NEW',
                                                  p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� TextBoxRefer - ����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'TextBoxRefer - ����������',
															  p_funcname => '/barsroot/credit/usercontrols/dialogs/textboxrefer_show.aspx?refdatasid=\S+&rnd=\S*',
															  p_rolename => 'WR_REFREAD' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositContract.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositContractInfo.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositContractInfo.aspx',
															  p_funcname => '/barsroot/deposit/depositcontractinfo.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� "����" �������� ********** ');
          --  ��������� ������� ³������� "����" ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� "����" ��������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=0',
                                                  p_rolename => 'WR_CHCKINNR_SELF' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� �������� ********** ');
          --  ��������� ������� ³������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� ��������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=2',
                                                  p_rolename => 'WR_CHCKINNR_TOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ³������� �������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� �������� ��������',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=2&grpid=\w+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ����� ********** ');
          --  ��������� ������� ����������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �����',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=3',
                                                  p_rolename => 'WR_VERIFDOC' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� ����������� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� ����������� �����',
															  p_funcname => '/barsroot/checkinner/verifdoc.aspx?grpid=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ������� �������� ********** ');
          --  ��������� ������� ³������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ������� ��������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=5',
                                                  p_rolename => 'WR_CHCKINNR_CASH' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ³������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� ������� ��������',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=5&grpid=\w+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� "����" �������� ********** ');
          --  ��������� ������� ³������� "����" ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� "����" ��������',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=0&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� /BarsWeb.CheckInner/Documents.aspx ********** ');
          --  ��������� ������� /BarsWeb.CheckInner/Documents.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '/BarsWeb.CheckInner/Documents.aspx',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=1&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� �������� ********** ');
          --  ��������� ������� ³������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� ��������',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=2&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� ����� �� ������� ������� ********** ');
          --  ��������� ������� ³������� �������� ����� �� ������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� ����� �� ������� �������',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=4&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ������� �������� ********** ');
          --  ��������� ������� ³������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ������� ��������',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=5&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������� BarsWeb.CheckInner ********** ');
          --  ��������� ������� ����� ������� BarsWeb.CheckInner
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������� BarsWeb.CheckInner',
                                                  p_funcname => '/barsroot/checkinner/service.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� /BarsWeb.CheckInner/StornoReason.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/BarsWeb.CheckInner/StornoReason.aspx',
															  p_funcname => '/barsroot/checkinner/stornoreason.aspx?type=\d',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ ���������',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� /BarsWeb.CheckInner/StornoReason.aspx ********** ');
          --  ��������� ������� /BarsWeb.CheckInner/StornoReason.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '/BarsWeb.CheckInner/StornoReason.aspx',
                                                  p_funcname => '/barsroot/checkinner/stornoreason.aspx?type=\d',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ����������� ����� ********** ');
          --  ��������� ������� ������� ����������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ����������� �����',
                                                  p_funcname => '/barsroot/checkinner/verifdoc.aspx?grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
                                                  p_rolename => 'WR_CUSTREG' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/defaultwebservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/dialogs/dialogfulladr.aspx?pars=\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/organdoclist.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/picturefile.aspx?id=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/tab_dop_inf.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/tab_linked_custs.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �볺���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �볺���',
															  p_funcname => '/barsroot/clientregister/tab_custs_segments.aspx?rnk=\d*&client=\w*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/tab_main_rekv.aspx?rezid=\d*&spd=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/tab_ek_norm.aspx?spd=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/tab_client_rekv_corp.aspx?rnk=\d*&readonly=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �볺���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �볺���',
															  p_funcname => '/barsroot/clientregister/tab_custs_segments_capacity.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/tab_rekv_nalogoplat.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/tab_client_rekv_person.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/defaultwebservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/tab_client_rekv_bank.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/organdoclist.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/tab_dop_rekv.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/picturefile.aspx?id=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_client_rekv_bank.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_client_rekv_corp.aspx?rnk=\d*&readonly=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_client_rekv_person.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_dop_inf.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_dop_rekv.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_ek_norm.aspx?spd=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_linked_custs.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_linked_custs_seal_img.aspx?mode=\S*&id=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_main_rekv.aspx?rezid=\d*&spd=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/dialogs/dialogfulladr.aspx?pars=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => '/barsroot/clientregister/tab_rekv_nalogoplat.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � �������  (��) ********** ');
          --  ��������� ������� ��������� �볺��� � �������  (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � �������  (��)',
                                                  p_funcname => '/barsroot/clients/customers/index/?custtype=corp',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �����������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����������� ������� ********** ');
          --  ��������� ������� �������� ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����������� �������',
                                                  p_funcname => '/barsroot/communalpayment/default.aspx',
                                                  p_rolename => 'WR_KP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� CommunalPayment/Tab_Single.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� CommunalPayment/Tab_Single.aspx',
															  p_funcname => '/barsroot/communalpayment/tab_single.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� CommunalPayment/Service.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� CommunalPayment/Service.asmx',
															  p_funcname => '/barsroot/communalpayment/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� CommunalPayment/Tab_Groups.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� CommunalPayment/Tab_Groups.aspx',
															  p_funcname => '/barsroot/communalpayment/tab_groups.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� CommunalPayment/Tab_Main.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� CommunalPayment/Tab_Main.aspx',
															  p_funcname => '/barsroot/communalpayment/tab_main.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� CommunalPayment/Tab_Contracts.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� CommunalPayment/Tab_Contracts.aspx',
															  p_funcname => '/barsroot/communalpayment/tab_contracts.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ����������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ����������� �������',
															  p_funcname => '/barsroot/communalpayment/folder.aspx\S*',
															  p_rolename => 'WR_KP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ����������� ������� ********** ');
          --  ��������� ������� ����� ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ����������� �������',
                                                  p_funcname => '/barsroot/communalpayment/folder.aspx\S*',
                                                  p_rolename => 'WR_KP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� CommunalPayment/Service.asmx ********** ');
          --  ��������� ������� ������� CommunalPayment/Service.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� CommunalPayment/Service.asmx',
                                                  p_funcname => '/barsroot/communalpayment/service.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� CommunalPayment/Tab_Contracts.aspx ********** ');
          --  ��������� ������� ������� CommunalPayment/Tab_Contracts.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� CommunalPayment/Tab_Contracts.aspx',
                                                  p_funcname => '/barsroot/communalpayment/tab_contracts.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� CommunalPayment/Tab_Groups.aspx ********** ');
          --  ��������� ������� ������� CommunalPayment/Tab_Groups.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� CommunalPayment/Tab_Groups.aspx',
                                                  p_funcname => '/barsroot/communalpayment/tab_groups.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� CommunalPayment/Tab_Main.aspx ********** ');
          --  ��������� ������� ������� CommunalPayment/Tab_Main.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� CommunalPayment/Tab_Main.aspx',
                                                  p_funcname => '/barsroot/communalpayment/tab_main.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� CommunalPayment/Tab_Single.aspx ********** ');
          --  ��������� ������� ������� CommunalPayment/Tab_Single.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� CommunalPayment/Tab_Single.aspx',
                                                  p_funcname => '/barsroot/communalpayment/tab_single.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����i����� ������ �� ������ ********** ');
          --  ��������� ������� ����i����� ������ �� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����i����� ������ �� ������',
                                                  p_funcname => '/barsroot/credit/cck_zay.aspx?prod=\d+&name=\S*&custtype=\d+',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�������i��� ������ (�������) ********** ');
          --  ��������� ������� I�������i��� ������ (�������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�������i��� ������ (�������)',
                                                  p_funcname => '/barsroot/credit/info.aspx?keep=\d+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������ ������� ********** ');
          --  ��������� ������� ��������� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������ �������',
                                                  p_funcname => '/barsroot/credit/new.aspx',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������������ ���i���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������ ���i���',
															  p_funcname => '/barsroot/credit/info.aspx',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� I�������i��� ������ (�������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I�������i��� ������ (�������)',
															  p_funcname => '/barsroot/credit/info.aspx?keep=\d+',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� ������� ��������',
															  p_funcname => '/barsroot/credit/salarydetail.aspx?sid=\d*',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� ������� ��������',
															  p_funcname => '/barsroot/credit/salarydetail.aspx?sid=\d*&rand=\S*',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� ������� � �.�. 2620 ********** ');
          --  ��������� ������� ��������� ������� ������� � �.�. 2620
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� ������� � �.�. 2620',
                                                  p_funcname => '/barsroot/credit/repayment.aspx',
                                                  p_rolename => 'WR_CREDIT' ,
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

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ ���������',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� �������� ********** ');
          --  ��������� ������� ���������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� ��������',
                                                  p_funcname => '/barsroot/credit/salarydetail.aspx?sid=\d*',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� �������� ********** ');
          --  ��������� ������� ���������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� ��������',
                                                  p_funcname => '/barsroot/credit/salarydetail.aspx?sid=\d*&rand=\S*',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� �������� ********** ');
          --  ��������� ������� ����� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������',
                                                  p_funcname => '/barsroot/credit/search.aspx?stype=\S+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� TextBoxRefer - ���������� ********** ');
          --  ��������� ������� TextBoxRefer - ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'TextBoxRefer - ����������',
                                                  p_funcname => '/barsroot/credit/usercontrols/dialogs/textboxrefer_show.aspx?refdatasid=\S+&rnd=\S*',
                                                  p_rolename => 'WR_REFREAD' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �� ������� ********** ');
          --  ��������� ������� ������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �� �������',
                                                  p_funcname => '/barsroot/customerlist/accextract.aspx?type=\d+&acc=\d+&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ ���������',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� ����������� ********** ');
          --  ��������� ������� �������� ������� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� �����������',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
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

      --  ��������� ������� ������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �������',
															  p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� �������� �������(���������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� �������� �������(���������)',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=2',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� �� �������(�� ������ ��������) ********** ');
          --  ��������� ������� �������� ������� �� �������(�� ������ ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� �� �������(�� ������ ��������)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=1',
                                                  p_rolename => 'WR_USER_ACCOUNTS_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��� ��������� �������/�����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������/�����������',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
															  p_rolename => '' ,
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

      --  ��������� ������� ������� �������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
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


      --  ��������� ������� ������� ������ ��� ��������� �������/�����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������/�����������',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
															  p_rolename => '' ,
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

      --  ��������� ������� ������� �������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� �� ��������� ��������� ********** ');
          --  ��������� ������� �������� ������� �� ��������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� �� ��������� ���������',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=3&nd=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��� ��������� �������/�����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������/�����������',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
															  p_rolename => '' ,
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

      --  ��������� ������� ������� �������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������  �� ����������� �������� ********** ');
          --  ��������� ������� �������� �������  �� ����������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������  �� ����������� ��������',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=4&acc=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� �� ���������� ��������� ********** ');
          --  ��������� ������� �������� ������� �� ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� �� ���������� ���������',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=4&rnk=\d+&acc=\d+\,\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��� ��������� �������/�����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������/�����������',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
															  p_rolename => '' ,
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

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ��������� �������/����������� ********** ');
          --  ��������� ������� ������ ��� ��������� �������/�����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ��������� �������/�����������',
                                                  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
                                                  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ��������� �������\����������� ********** ');
          --  ��������� ������� ������ ��� ��������� �������\�����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ��������� �������\�����������',
                                                  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+&type=\d+',
                                                  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������� CustomerList ********** ');
          --  ��������� ������� ����� ������� CustomerList
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������� CustomerList',
                                                  p_funcname => '/barsroot/customerlist/custservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���������� �������� ��� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� �������� ��� �������� �������',
															  p_funcname => '/barsroot/tools/int_statement.aspx\S*',
															  p_rolename => 'BASIC_INFO' ,
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
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �����������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � �������  (�����)  ********** ');
          --  ��������� ������� ��������� �볺��� � �������  (�����) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � �������  (�����) ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=1',
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� ������� �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �����������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����������',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������� ********** ');
          --  ��������� ������� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �������',
                                                  p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� �� �������',
															  p_funcname => '/barsroot/customerlist/accextract.aspx?type=\d+&acc=\d+&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/Ask.aspx ********** ');
          --  ��������� ������� �������  deposit/Ask.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/Ask.aspx',
                                                  p_funcname => '/barsroot/deposit/ask.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/cmd.aspx ********** ');
          --  ��������� ������� ������� deposit/cmd.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/cmd.aspx',
                                                  p_funcname => '/barsroot/deposit/cmd.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/Default.aspx ********** ');
          --  ��������� ������� �������  deposit/Default.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/Default.aspx',
                                                  p_funcname => '/barsroot/deposit/default.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� �������� �������',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/Ask.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/Ask.aspx',
															  p_funcname => '/barsroot/deposit/ask.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositAgreementBeneficiary.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositAgreementBeneficiary.aspx',
															  p_funcname => '/barsroot/deposit/depositagreementbeneficiary.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositEditComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositEditComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositeditcomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositSelectTrustee.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositSelectTrustee.aspx',
															  p_funcname => '/barsroot/deposit/depositselecttrustee.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /barsroot/deposit/depositpartial.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /barsroot/deposit/depositpartial.aspx',
															  p_funcname => '/barsroot/deposit/depositpartial.aspx\S*',
															  p_rolename => '' ,
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

      --  ��������� ������� ������� �������  deposit/DepositAgreement.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositAgreement.aspx',
															  p_funcname => '/barsroot/deposit/depositagreement.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositCancelAgreement.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositCancelAgreement.aspx',
															  p_funcname => '/barsroot/deposit/depositcancelagreement.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositLettersPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositLettersPrint.aspx',
															  p_funcname => '/barsroot/deposit/depositlettersprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositPrintContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositPrintContract.aspx',
															  p_funcname => '/barsroot/deposit/depositprintcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositSearch.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositSearch.aspx',
															  p_funcname => '/barsroot/deposit/depositsearch.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositTermRateEdit.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositTermRateEdit.aspx',
															  p_funcname => '/barsroot/deposit/deposittermrateedit.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /deposit/dialog/DepositContractSelect.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/dialog/DepositContractSelect.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositcontractselect.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /deposit/dialog/DptField.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/dialog/DptField.aspx',
															  p_funcname => '/barsroot/deposit/dialog/dptfield.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/deposit/dialog/depositwornoutbills.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/deposit/dialog/depositwornoutbills.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositwornoutbills.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� /barsroot/deposit/transfer.aspx\S*
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/deposit/transfer.aspx\S*',
															  p_funcname => '/barsroot/deposit/transfer.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositAddSum.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositAddSum.aspx',
															  p_funcname => '/barsroot/deposit/depositaddsum.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositLetters.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositLetters.aspx',
															  p_funcname => '/barsroot/deposit/depositletters.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositPrint.aspx',
															  p_funcname => '/barsroot/deposit/depositprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositReturn.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositReturn.aspx',
															  p_funcname => '/barsroot/deposit/depositreturn.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /deposit/dialog/DepositSignDialog.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/dialog/DepositSignDialog.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositsigndialog.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositChangeFrequency
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositChangeFrequency',
															  p_funcname => '/barsroot/deposit/depositchangefrequency.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³��� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³��� ����� ���������',
															  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/cmd.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/cmd.aspx',
															  p_funcname => '/barsroot/deposit/cmd.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositAccount.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositAccount.aspx',
															  p_funcname => '/barsroot/deposit/depositaccount.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositCloseComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositCloseComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositclosecomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositSelectTT.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositSelectTT.aspx',
															  p_funcname => '/barsroot/deposit/depositselecttt.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/SearchResults.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/SearchResults.aspx',
															  p_funcname => '/barsroot/deposit/searchresults.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/SelectCountry.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/SelectCountry.aspx',
															  p_funcname => '/barsroot/deposit/selectcountry.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.Survey/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.Survey/Default.aspx',
															  p_funcname => '/barsroot/survey/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositAgreementPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositAgreementPrint.aspx',
															  p_funcname => '/barsroot/deposit/depositagreementprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositAgreementTemplate.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositAgreementTemplate.aspx',
															  p_funcname => '/barsroot/deposit/depositagreementtemplate.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositContract.aspx',
															  p_funcname => '/barsroot/deposit/depositcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /deposit/DepositFile.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/DepositFile.aspx',
															  p_funcname => '/barsroot/deposit/depositfile.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositHistory.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositHistory.aspx',
															  p_funcname => '/barsroot/deposit/deposithistory.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositPercentPay.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositPercentPay.aspx',
															  p_funcname => '/barsroot/deposit/depositpercentpay.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositPercentPayComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositPercentPayComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositpercentpaycomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositProlongation.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositProlongation.aspx',
															  p_funcname => '/barsroot/deposit/depositprolongation.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /deposit/DepositRateEdit.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/DepositRateEdit.aspx',
															  p_funcname => '/barsroot/deposit/depositrateedit.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� deposit/depositcommissionquest.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� deposit/depositcommissionquest.aspx',
															  p_funcname => '/barsroot/deposit/depositcommissionquest.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositAddSumComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositAddSumComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositaddsumcomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositClosePayIt.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositClosePayIt.aspx',
															  p_funcname => '/barsroot/deposit/depositclosepayit.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositDelete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositDelete.aspx',
															  p_funcname => '/barsroot/deposit/depositdelete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositEditAccount.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositEditAccount.aspx',
															  p_funcname => '/barsroot/deposit/depositeditaccount.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositReturnComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositReturnComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositreturncomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /deposit/dialog/DepositContractTemplate.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/dialog/DepositContractTemplate.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositcontracttemplate.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /barsroot/deposit/depositfile_ext.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /barsroot/deposit/depositfile_ext.aspx',
															  p_funcname => '/barsroot/deposit/depositfile_ext.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
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

      --  ��������� ������� ������� �������  deposit/DepositCardAcc.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositCardAcc.aspx',
															  p_funcname => '/barsroot/deposit/depositcardacc.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositClient.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositClient.aspx',
															  p_funcname => '/barsroot/deposit/depositclient.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������  deposit/DepositContractInfo.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������  deposit/DepositContractInfo.aspx',
															  p_funcname => '/barsroot/deposit/depositcontractinfo.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /deposit/DepositFileShow.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/DepositFileShow.aspx',
															  p_funcname => '/barsroot/deposit/depositfileshow.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/DepositShowClients.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/DepositShowClients.aspx',
															  p_funcname => '/barsroot/deposit/depositshowclients.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /deposit/dialog/DepositBFRowCorrection.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /deposit/dialog/DepositBFRowCorrection.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositbfrowcorrection.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� deposit/depositbonus.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� deposit/depositbonus.aspx',
															  p_funcname => '/barsroot/deposit/depositbonus.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositAccount.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositAccount.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositAccount.aspx',
                                                  p_funcname => '/barsroot/deposit/depositaccount.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositAddSum.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositAddSum.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositAddSum.aspx',
                                                  p_funcname => '/barsroot/deposit/depositaddsum.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositAddSumComplete.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositAddSumComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositAddSumComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositaddsumcomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositAgreement.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositAgreement.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositAgreement.aspx',
                                                  p_funcname => '/barsroot/deposit/depositagreement.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositAgreementBeneficiary.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositAgreementBeneficiary.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositAgreementBeneficiary.aspx',
                                                  p_funcname => '/barsroot/deposit/depositagreementbeneficiary.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositAgreementPrint.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositAgreementPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositAgreementPrint.aspx',
                                                  p_funcname => '/barsroot/deposit/depositagreementprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositAgreementTemplate.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositAgreementTemplate.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositAgreementTemplate.aspx',
                                                  p_funcname => '/barsroot/deposit/depositagreementtemplate.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/depositbonus.aspx ********** ');
          --  ��������� ������� ������� deposit/depositbonus.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/depositbonus.aspx',
                                                  p_funcname => '/barsroot/deposit/depositbonus.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositCancelAgreement.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositCancelAgreement.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositCancelAgreement.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcancelagreement.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositCardAcc.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositCardAcc.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositCardAcc.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcardacc.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1. ³������� ������ ������ ********** ');
          --  ��������� ������� 1. ³������� ������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1. ³������� ������ ������',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 7. ���������� ��� ��������� ********** ');
          --  ��������� ������� 7. ���������� ��� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7. ���������� ��� ���������',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx?customer=1',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ������ ������ (� ��������� ����������) ********** ');
          --  ��������� ������� ³������� ������ ������ (� ��������� ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ������ ������ (� ��������� ����������)',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx?simplify=true',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositClient.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositClient.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositClient.aspx',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositCloseComplete.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositCloseComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositCloseComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositclosecomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositClosePayIt.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositClosePayIt.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositClosePayIt.aspx',
                                                  p_funcname => '/barsroot/deposit/depositclosepayit.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� deposit/depositcommissionquest.aspx ********** ');
          --  ��������� ������� �������� deposit/depositcommissionquest.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� deposit/depositcommissionquest.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcommissionquest.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositContract.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositContract.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositContract.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcontract.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������  deposit/DepositContractInfo.aspx ********** ');
          --  ��������� ������� �������  deposit/DepositContractInfo.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������  deposit/DepositContractInfo.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcontractinfo.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositDelete.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositDelete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositDelete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositdelete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositEditAccount.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositEditAccount.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositEditAccount.aspx',
                                                  p_funcname => '/barsroot/deposit/depositeditaccount.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositEditComplete.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositEditComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositEditComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositeditcomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /deposit/DepositFile.aspx ********** ');
          --  ��������� ������� ������� /deposit/DepositFile.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /deposit/DepositFile.aspx',
                                                  p_funcname => '/barsroot/deposit/depositfile.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /barsroot/deposit/depositfile_ext.aspx ********** ');
          --  ��������� ������� ������� /barsroot/deposit/depositfile_ext.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /barsroot/deposit/depositfile_ext.aspx',
                                                  p_funcname => '/barsroot/deposit/depositfile_ext.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� ������� ����� ���������� ********** ');
          --  ��������� ������� ������ �� ������� ����� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� ������� ����� ����������',
                                                  p_funcname => '/barsroot/deposit/depositfileshow.aspx',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /deposit/DepositFileShow.aspx ********** ');
          --  ��������� ������� ������� /deposit/DepositFileShow.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /deposit/DepositFileShow.aspx',
                                                  p_funcname => '/barsroot/deposit/depositfileshow.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� ������� ����� ���������� (����� ������) ********** ');
          --  ��������� ������� ������ �� ������� ����� ���������� (����� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� ������� ����� ���������� (����� ������)',
                                                  p_funcname => '/barsroot/deposit/depositfileshow_ext.aspx',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����� ���������� (����� ������) ********** ');
          --  ��������� ������� ��������� ����� ���������� (����� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����� ���������� (����� ������)',
                                                  p_funcname => '/barsroot/deposit/depositfileshow_ext.aspx?delete=enable',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� ������� ����� ���������� (����� ������) - �������� ���� ********** ');
          --  ��������� ������� ������ �� ������� ����� ���������� (����� ������) - �������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� ������� ����� ���������� (����� ������) - �������� ����',
                                                  p_funcname => '/barsroot/deposit/depositfileshow_ext.aspx?gb=true',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositHistory.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositHistory.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositHistory.aspx',
                                                  p_funcname => '/barsroot/deposit/deposithistory.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� C. ����� �� ����������� ********** ');
          --  ��������� ������� C. ����� �� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'C. ����� �� �����������',
                                                  p_funcname => '/barsroot/deposit/depositletters.aspx',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositLetters.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositLetters.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositLetters.aspx',
                                                  p_funcname => '/barsroot/deposit/depositletters.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositLettersPrint.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositLettersPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositLettersPrint.aspx',
                                                  p_funcname => '/barsroot/deposit/depositlettersprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /barsroot/deposit/depositpartial.aspx ********** ');
          --  ��������� ������� ������� /barsroot/deposit/depositpartial.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /barsroot/deposit/depositpartial.aspx',
                                                  p_funcname => '/barsroot/deposit/depositpartial.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositPercentPay.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositPercentPay.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositPercentPay.aspx',
                                                  p_funcname => '/barsroot/deposit/depositpercentpay.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositPercentPayComplete.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositPercentPayComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositPercentPayComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositpercentpaycomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositPrint.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositPrint.aspx',
                                                  p_funcname => '/barsroot/deposit/depositprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositPrintContract.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositPrintContract.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositPrintContract.aspx',
                                                  p_funcname => '/barsroot/deposit/depositprintcontract.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositProlongation.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositProlongation.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositProlongation.aspx',
                                                  p_funcname => '/barsroot/deposit/depositprolongation.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /deposit/DepositRateEdit.aspx ********** ');
          --  ��������� ������� ������� /deposit/DepositRateEdit.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /deposit/DepositRateEdit.aspx',
                                                  p_funcname => '/barsroot/deposit/depositrateedit.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositReturn.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositReturn.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositReturn.aspx',
                                                  p_funcname => '/barsroot/deposit/depositreturn.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositReturnComplete.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositReturnComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositReturnComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositreturncomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2. ��������� ���������� ���� ********** ');
          --  ��������� ������� 2. ��������� ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2. ��������� ���������� ����',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=agreement&extended=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5. ���������� ������������ ********** ');
          --  ��������� ������� 5. ���������� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. ���������� ������������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=close&extended=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3. ������� ������ ********** ');
          --  ��������� ������� 3. ������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3. ������� ������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=deposit&extended=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� B. �������� ����� ********** ');
          --  ��������� ������� B. �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'B. �������� �����',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=history&extended=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4. ������� ������� ********** ');
          --  ��������� ������� 4. ������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4. ������� �������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=percent&extended=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6. ����������� ������ ********** ');
          --  ��������� ������� 6. ����������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6. ����������� ������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=prolongation',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 9. ����� �������� ********** ');
          --  ��������� ������� 9. ����� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '9. ����� ��������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=show',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 8. ��������� ������� ��� ����� �� ������ ********** ');
          --  ��������� ������� 8. ��������� ������� ��� ����� �� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '8. ��������� ������� ��� ����� �� ������',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=testament',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositSearch.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositSearch.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositSearch.aspx',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositSelectTrustee.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositSelectTrustee.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositSelectTrustee.aspx',
                                                  p_funcname => '/barsroot/deposit/depositselecttrustee.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositSelectTT.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositSelectTT.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositSelectTT.aspx',
                                                  p_funcname => '/barsroot/deposit/depositselecttt.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositShowClients.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositShowClients.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositShowClients.aspx',
                                                  p_funcname => '/barsroot/deposit/depositshowclients.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/DepositTermRateEdit.aspx ********** ');
          --  ��������� ������� ������� deposit/DepositTermRateEdit.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/DepositTermRateEdit.aspx',
                                                  p_funcname => '/barsroot/deposit/deposittermrateedit.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /deposit/dialog/DepositBFRowCorrection.aspx ********** ');
          --  ��������� ������� ������� /deposit/dialog/DepositBFRowCorrection.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /deposit/dialog/DepositBFRowCorrection.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositbfrowcorrection.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx ********** ');
          --  ��������� ������� ������� /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /deposit/dialog/DepositContractSelect.aspx ********** ');
          --  ��������� ������� ������� /deposit/dialog/DepositContractSelect.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /deposit/dialog/DepositContractSelect.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositcontractselect.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /deposit/dialog/DepositContractTemplate.aspx ********** ');
          --  ��������� ������� ������� /deposit/dialog/DepositContractTemplate.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /deposit/dialog/DepositContractTemplate.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositcontracttemplate.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /deposit/dialog/DepositSignDialog.aspx ********** ');
          --  ��������� ������� ������� /deposit/dialog/DepositSignDialog.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /deposit/dialog/DepositSignDialog.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositsigndialog.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� /barsroot/deposit/dialog/depositwornoutbills.aspx ********** ');
          --  ��������� ������� /barsroot/deposit/dialog/depositwornoutbills.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '/barsroot/deposit/dialog/depositwornoutbills.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositwornoutbills.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /deposit/dialog/DptField.aspx ********** ');
          --  ��������� ������� ������� /deposit/dialog/DptField.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /deposit/dialog/DptField.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/dptfield.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/SearchResults.aspx ********** ');
          --  ��������� ������� ������� deposit/SearchResults.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/SearchResults.aspx',
                                                  p_funcname => '/barsroot/deposit/searchresults.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� deposit/SelectCountry.aspx ********** ');
          --  ��������� ������� ������� deposit/SelectCountry.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� deposit/SelectCountry.aspx',
                                                  p_funcname => '/barsroot/deposit/selectcountry.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� /barsroot/deposit/transfer.aspx\S* ********** ');
          --  ��������� ������� /barsroot/deposit/transfer.aspx\S*
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '/barsroot/deposit/transfer.aspx\S*',
                                                  p_funcname => '/barsroot/deposit/transfer.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� � ���������� ********** ');
          --  ��������� ������� �������� � ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� � ����������',
                                                  p_funcname => '/barsroot/docinput/depository.aspx',
                                                  p_rolename => 'WR_DOC_INPUT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �� ������.���.(����) ********** ');
          --  ��������� ������� ����������� �� ������.���.(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �� ������.���.(����)',
                                                  p_funcname => '/barsroot/docinput/doc_alt.aspx',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i���� �������� ��� �������� (�����������) ********** ');
          --  ��������� ������� �i���� �������� ��� �������� (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i���� �������� ��� �������� (�����������)',
                                                  p_funcname => '/barsroot/docinput/docexport.aspx?type=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��� ����� ��������� c ���������� qdoc ********** ');
          --  ��������� ������� ³��� ����� ��������� c ���������� qdoc
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��� ����� ��������� c ���������� qdoc',
                                                  p_funcname => '/barsroot/docinput/docinput.aspx?qdoc=\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���. I�������i��i ������ � ����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���. I�������i��i ������ � ����������',
															  p_funcname => '/barsroot/qdocs/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��� ����� ��������� ********** ');
          --  ��������� ������� ³��� ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��� ����� ���������',
                                                  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� DocInput
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� DocInput',
															  p_funcname => '/barsroot/docinput/docservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������� DocInput ********** ');
          --  ��������� ������� ����� ������� DocInput
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������� DocInput',
                                                  p_funcname => '/barsroot/docinput/docservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ����� �����/������� ����� ********** ');
          --  ��������� ������� ������������ ����� �����/������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ����� �����/������� �����',
                                                  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1',
                                                  p_rolename => 'WR_RATES' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������������ ����� �����/������� ����� - ��� ��i���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������ ����� �����/������� ����� - ��� ��i���',
															  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1&archive=0',
															  p_rolename => 'WR_RATES' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������ ����� �����/������� ����� - ���i�
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������������ ����� �����/������� ����� - ���i�',
															  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1&archive=1',
															  p_rolename => 'WR_RATES' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ����� �����/������� ����� - ��� ��i��� ********** ');
          --  ��������� ������� ������������ ����� �����/������� ����� - ��� ��i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ����� �����/������� ����� - ��� ��i���',
                                                  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1&archive=0',
                                                  p_rolename => 'WR_RATES' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ����� �����/������� ����� - ���i� ********** ');
          --  ��������� ������� ������������ ����� �����/������� ����� - ���i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ����� �����/������� ����� - ���i�',
                                                  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1&archive=1',
                                                  p_rolename => 'WR_RATES' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ����� �����/������� ����� ********** ');
          --  ��������� ������� ³������� ����� �����/������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ����� �����/������� �����',
                                                  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=2',
                                                  p_rolename => 'WR_RATES' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ********** ');
          --  ��������� ������� �������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������',
                                                  p_funcname => '/barsroot/docinput/ttsinput.aspx',
                                                  p_rolename => 'WR_DOC_INPUT' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� �������� ********** ');
          --  ��������� ������� �������� ��������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� ��������',
                                                  p_funcname => '/barsroot/documentsview/default.aspx?type=0',
                                                  p_rolename => 'WR_DOCLIST_TOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��������� ��������� �������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �������� �� �������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �������� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ ���������',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �������� �� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �������� �� �����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������� �� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �������� �� �����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �� �������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=11',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ����������� ********** ');
          --  ��������� ������� �������� ��������� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� �����������',
                                                  p_funcname => '/barsroot/documentsview/default.aspx?type=1',
                                                  p_rolename => 'WR_DOCLIST_USER' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��� ��������� �����������  �� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �����������  �� �����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �����������  �� �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �����������  �� �����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� ����������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� ����������� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=22&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ ���������',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� ����������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� ����������� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� ����������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� ����������� �� �������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=11',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� ����������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� ����������� �� �������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� �볺��� ********** ');
          --  ��������� ������� �������� ��������� �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� �볺���',
                                                  p_funcname => '/barsroot/documentsview/default.aspx?type=2',
                                                  p_rolename => 'WR_DOCLIST_SALDO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ��������� ��������� �볺��� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �볺��� �� �������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �� �������',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=11',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��� ��������� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=21&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �볺��� �� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ��������� ��������� �볺��� �� ����',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=22&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ ���������',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ��������� �� ������� ********** ');
          --  ��������� ������� ������ ��� ��������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ��������� �� �������',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=11',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��������� ��������� �������� �� ������� ********** ');
          --  ��������� ������� ������ ��������� ��������� �������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��������� ��������� �������� �� �������',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=12',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ��������� �� ���� ********** ');
          --  ��������� ������� ������ ��� ��������� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ��������� �� ����',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��������� ��������� �������� �� ���� ********** ');
          --  ��������� ������� ������ ��������� ��������� �������� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��������� ��������� �������� �� ����',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ��������� ����������� �� ������� ********** ');
          --  ��������� ������� ������ ��� ��������� ����������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ��������� ����������� �� �������',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=11',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��������� ��������� ����������� �� ������� ********** ');
          --  ��������� ������� ������ ��������� ��������� ����������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��������� ��������� ����������� �� �������',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=12',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ��������� ����������� �� ���� ********** ');
          --  ��������� ������� ������ ��� ��������� ����������� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ��������� ����������� �� ����',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��������� ��������� ����������� �� ���� ********** ');
          --  ��������� ������� ������ ��������� ��������� ����������� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��������� ��������� ����������� �� ����',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=22&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����� ������� BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ��������� �� ������� ********** ');
          --  ��������� ������� ������ ��� ��������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ��������� �� �������',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=11',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��������� ��������� �볺��� �� ������� ********** ');
          --  ��������� ������� ������ ��������� ��������� �볺��� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��������� ��������� �볺��� �� �������',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=12',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ��������� �� ���� ********** ');
          --  ��������� ������� ������ ��� ��������� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ��������� �� ����',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=21&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��������� ��������� �볺��� �� ���� ********** ');
          --  ��������� ������� ������ ��������� ��������� �볺��� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��������� ��������� �볺��� �� ����',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=22&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������� BarsWeb.DocumentsView ********** ');
          --  ��������� ������� ����� ������� BarsWeb.DocumentsView
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������� BarsWeb.DocumentsView',
                                                  p_funcname => '/barsroot/documentsview/service.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���������: ��� ********** ');
          --  ��������� ������� ������ ���������: ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���������: ���',
                                                  p_funcname => '/barsroot/documentview/bis.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���������: ���. ������ ********** ');
          --  ��������� ������� ������ ���������: ���. ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���������: ���. ������',
                                                  p_funcname => '/barsroot/documentview/buhmodel.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������ ��������� ********** ');
          --  ��������� ������� �������� ������ ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������ ���������',
                                                  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ ���������: ������ ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ���������: ������ ��������',
															  p_funcname => '/barsroot/documentview/document.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ���������: �������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ���������: �������� ��������',
															  p_funcname => '/barsroot/documentview/doprekv.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� documentview
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� documentview',
															  p_funcname => '/barsroot/documentview/docservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ���������: ���. ������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ���������: ���. ������',
															  p_funcname => '/barsroot/documentview/buhmodel.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ���������: S.W.I.F.T �����������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ���������: S.W.I.F.T �����������',
															  p_funcname => '/barsroot/documentview/swift.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ���������: ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ���������: ���',
															  p_funcname => '/barsroot/documentview/visa.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ���������: ���
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ���������: ���',
															  p_funcname => '/barsroot/documentview/bis.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ���������: ������ ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ���������: ������ ��������',
															  p_funcname => '/barsroot/documentview/techrecv.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������� documentview ********** ');
          --  ��������� ������� ����� ������� documentview
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������� documentview',
                                                  p_funcname => '/barsroot/documentview/docservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���������: ������ �������� ********** ');
          --  ��������� ������� ������ ���������: ������ ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���������: ������ ��������',
                                                  p_funcname => '/barsroot/documentview/document.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���������: �������� �������� ********** ');
          --  ��������� ������� ������ ���������: �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���������: �������� ��������',
                                                  p_funcname => '/barsroot/documentview/doprekv.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���������: S.W.I.F.T ����������� ********** ');
          --  ��������� ������� ������ ���������: S.W.I.F.T �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���������: S.W.I.F.T �����������',
                                                  p_funcname => '/barsroot/documentview/swift.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���������: ������ �������� ********** ');
          --  ��������� ������� ������ ���������: ������ ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���������: ������ ��������',
                                                  p_funcname => '/barsroot/documentview/techrecv.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���������: ��� ********** ');
          --  ��������� ������� ������ ���������: ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���������: ���',
                                                  p_funcname => '/barsroot/documentview/visa.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����� ������� ********** ');
          --  ��������� ������� ������ ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����� �������',
                                                  p_funcname => '/barsroot/exchange/default.aspx?inttt=imi&exttt=ime',
                                                  p_rolename => 'WR_IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ��������� ������ �����(������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ������ �����(������� �������)',
															  p_funcname => '/barsroot/exchange/success.aspx?fn=\S+&burl=\S+',
															  p_rolename => 'WR_IMPEXP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ������� �� �����(������� �������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ ������� �� �����(������� �������)',
															  p_funcname => '/barsroot/exchange/payments.aspx',
															  p_rolename => 'WR_IMPEXP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������� � ���� ********** ');
          --  ��������� ������� ������� ������� � ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������� � ����',
                                                  p_funcname => '/barsroot/exchange/export.aspx',
                                                  p_rolename => 'WR_IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������� �� �����(������� �������) ********** ');
          --  ��������� ������� ������ ������� �� �����(������� �������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������� �� �����(������� �������)',
                                                  p_funcname => '/barsroot/exchange/payments.aspx',
                                                  p_rolename => 'WR_IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������ �����(������� �������) ********** ');
          --  ��������� ������� ��������� ������ �����(������� �������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������ �����(������� �������)',
                                                  p_funcname => '/barsroot/exchange/success.aspx?fn=\S+&burl=\S+',
                                                  p_rolename => 'WR_IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.InfoQuery/Default.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.InfoQuery/Default.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.InfoQuery/Default.aspx',
                                                  p_funcname => '/barsroot/infoquery/default.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /BarsWeb.InfoQuery/QueryService.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.InfoQuery/QueryService.asmx',
															  p_funcname => '/barsroot/infoquery/queryservice.asmx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.InfoQuery/QueryResult.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.InfoQuery/QueryResult.aspx',
															  p_funcname => '/barsroot/infoquery/queryresult.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� D. ������� � ������ �������: ��������� ������ ********** ');
          --  ��������� ������� D. ������� � ������ �������: ��������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'D. ������� � ������ �������: ��������� ������',
                                                  p_funcname => '/barsroot/infoquery/query.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /BarsWeb.InfoQuery/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.InfoQuery/Default.aspx',
															  p_funcname => '/barsroot/infoquery/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� E. ������� � ������ �������: �������� ������ ********** ');
          --  ��������� ������� E. ������� � ������ �������: �������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'E. ������� � ������ �������: �������� ������',
                                                  p_funcname => '/barsroot/infoquery/queryanswer.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /BarsWeb.InfoQuery/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.InfoQuery/Default.aspx',
															  p_funcname => '/barsroot/infoquery/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.InfoQuery/QueryResult.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.InfoQuery/QueryResult.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.InfoQuery/QueryResult.aspx',
                                                  p_funcname => '/barsroot/infoquery/queryresult.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.InfoQuery/QueryService.asmx ********** ');
          --  ��������� ������� ������� /BarsWeb.InfoQuery/QueryService.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.InfoQuery/QueryService.asmx',
                                                  p_funcname => '/barsroot/infoquery/queryservice.asmx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ���������� ���������� ������� �� ������� ********** ');
          --  ��������� ������� ��� ���������� ���������� ������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ���������� ���������� ������� �� �������',
                                                  p_funcname => '/barsroot/mobinet/mytrans.aspx?act=0',
                                                  p_rolename => 'MOBINET' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ���������� ���������� ������� �� ����� ********** ');
          --  ��������� ������� ��� ���������� ���������� ������� �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ���������� ���������� ������� �� �����',
                                                  p_funcname => '/barsroot/mobinet/reqperiod.aspx?act=1',
                                                  p_rolename => 'MOBINET' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ������������������ ********** ');
          --  ��������� ������� ���� ������������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ������������������',
                                                  p_funcname => '/barsroot/perfom/default.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����������� ������ ********** ');
          --  ��������� ������� ���. ����������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����������� ������',
                                                  p_funcname => '/barsroot/qdocs/default.aspx',
                                                  p_rolename => 'WR_QDOCS' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ĳ���� ������� "���. ����������� ������"
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ĳ���� ������� "���. ����������� ������"',
															  p_funcname => '/barsroot/qdocs/qdialog.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³��� ����� ��������� c ���������� qdoc
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³��� ����� ��������� c ���������� qdoc',
															  p_funcname => '/barsroot/docinput/docinput.aspx?qdoc=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. I�������i��i ������ � ���������� ********** ');
          --  ��������� ������� ���. I�������i��i ������ � ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. I�������i��i ������ � ����������',
                                                  p_funcname => '/barsroot/qdocs/default.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ĳ���� ������� "���. ����������� ������" ********** ');
          --  ��������� ������� ĳ���� ������� "���. ����������� ������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ĳ���� ������� "���. ����������� ������"',
                                                  p_funcname => '/barsroot/qdocs/qdialog.aspx\S*',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���������� ������� (�� �����) ********** ');
          --  ��������� ������� ����������� ���������� ������� (�� �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���������� ������� (�� �����)',
                                                  p_funcname => '/barsroot/regularpay/default.aspx?grp=0',
                                                  p_rolename => 'WR_REGPAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ���������� ������� ********** ');
          --  ��������� ������� ��������� ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ���������� �������',
                                                  p_funcname => '/barsroot/regularpay/execpay.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ��� ********** ');
          --  ��������� ������� ������������ ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ���',
                                                  p_funcname => '/barsroot/replication/replication.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /BarsWeb.Replication/Service.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.Replication/Service.asmx',
															  p_funcname => '/barsroot/replication/service.asmx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.Replication/Service.asmx ********** ');
          --  ��������� ������� ������� /BarsWeb.Replication/Service.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.Replication/Service.asmx',
                                                  p_funcname => '/barsroot/replication/service.asmx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��������� �� ������� ����� - ����ֲ� ��� �� ����ު ********** ');
          --  ��������� ������� ������ ��������� �� ������� ����� - ����ֲ� ��� �� ����ު
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��������� �� ������� ����� - ����ֲ� ��� �� ����ު',
                                                  p_funcname => '/barsroot/sberutls/import.aspx',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 2: ���������I ������I - ����ֲ� ��� �� ����ު ********** ');
          --  ��������� ������� I����� 2: ���������I ������I - ����ֲ� ��� �� ����ު
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 2: ���������I ������I - ����ֲ� ��� �� ����ު',
                                                  p_funcname => '/barsroot/sberutls/import.aspx?imptype=kp',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 1: �������I �����I (��������) -����ֲ� ��� �� ����ު ********** ');
          --  ��������� ������� I����� 1: �������I �����I (��������) -����ֲ� ��� �� ����ު
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 1: �������I �����I (��������) -����ֲ� ��� �� ����ު',
                                                  p_funcname => '/barsroot/sberutls/import.aspx?imptype=lz',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 4: ����� ��������� ********** ');
          --  ��������� ������� I����� 4: ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 4: ����� ���������',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� I�����   : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I�����   : ����i� ��������i�',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 2: ���������I ������I ********** ');
          --  ��������� ������� I����� 2: ���������I ������I
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 2: ���������I ������I',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=kp',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� I�����   : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I�����   : ����i� ��������i�',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 1: ������I �����I(��������) ********** ');
          --  ��������� ������� I����� 1: ������I �����I(��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 1: ������I �����I(��������)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=lz',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� I�����   : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I�����   : ����i� ��������i�',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 3: �������Ͳ ����� ********** ');
          --  ��������� ������� I����� 3: �������Ͳ �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 3: �������Ͳ �����',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� I�����   : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I�����   : ����i� ��������i�',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����   : ����i� ��������i� ********** ');
          --  ��������� ������� I�����   : ����i� ��������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����   : ����i� ��������i�',
                                                  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� I�����  : ����������� i������������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I�����  : ����������� i������������ ���������',
															  p_funcname => '/barsroot/sberutls/importproced.aspx',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������   : ����i� ��i� �i��������� ��������i� ********** ');
          --  ��������� ������� ������   : ����i� ��i� �i��������� ��������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������   : ����i� ��i� �i��������� ��������i�',
                                                  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=2',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����  : ����������� i������������ ��������� ********** ');
          --  ��������� ������� I�����  : ����������� i������������ ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����  : ����������� i������������ ���������',
                                                  p_funcname => '/barsroot/sberutls/importproced.aspx',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /barsroot/socialdeposit/addsum.aspx ********** ');
          --  ��������� ������� ������� /barsroot/socialdeposit/addsum.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /barsroot/socialdeposit/addsum.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/addsum.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� ********** ');
          --  ��������� ������� ³������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ��������',
                                                  p_funcname => '/barsroot/socialdeposit/default.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositAgreement.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositAgreement.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositagreement.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/Default.aspx',
															  p_funcname => '/barsroot/socialdeposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/SocialServices.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/SocialServices.asmx',
															  p_funcname => '/barsroot/socialdeposit/socialservices.asmx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcancelagreement.aspx\S*',
															  p_rolename => '' ,
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

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositagreementprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositShowClients.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositShowClients.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositshowclients.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³��� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³��� ����� ���������',
															  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/SearchResults.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/SearchResults.aspx',
															  p_funcname => '/barsroot/socialdeposit/searchresults.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx',
															  p_funcname => '/barsroot/socialdeposit/dialogs/depositcontractselect.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositContract.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositPrint.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositagreementtemplate.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositContractTemplate.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositContractTemplate.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcontracttemplate.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositPrintContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositPrintContract.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositprintcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx',
															  p_funcname => '/barsroot/socialdeposit/dialogs/selectcountry.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositselecttrustee.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/PrintButton.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/PrintButton.aspx',
															  p_funcname => '/barsroot/socialdeposit/printbutton.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ������ ���. �������� (� ��������� ����������) ********** ');
          --  ��������� ������� ³������� ������ ���. �������� (� ��������� ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ������ ���. �������� (� ��������� ����������)',
                                                  p_funcname => '/barsroot/socialdeposit/default.aspx?simplify=true',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/Default.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/Default.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/Default.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/default.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /barsroot/socialdeposit/addsum.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /barsroot/socialdeposit/addsum.aspx',
															  p_funcname => '/barsroot/socialdeposit/addsum.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /barsroot/socialdeposit/depositcoowner.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /barsroot/socialdeposit/depositcoowner.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcoowner.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /barsroot/socialdeposit/transfer.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /barsroot/socialdeposit/transfer.aspx',
															  p_funcname => '/barsroot/socialdeposit/transfer.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositAgreement.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositAgreement.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositAgreement.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositagreement.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositagreementprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositagreementtemplate.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositcancelagreement.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositContract.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositContract.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositContract.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositcontract.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositContractTemplate.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositContractTemplate.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositContractTemplate.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositcontracttemplate.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /barsroot/socialdeposit/depositcoowner.aspx ********** ');
          --  ��������� ������� ������� /barsroot/socialdeposit/depositcoowner.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /barsroot/socialdeposit/depositcoowner.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositcoowner.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositPrint.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositPrint.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositPrintContract.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositPrintContract.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositPrintContract.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositprintcontract.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ��������� � ���������� ********** ');
          --  ��������� ������� �������� �������� ��������� � ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ��������� � ����������',
                                                  p_funcname => '/barsroot/socialdeposit/depositsearch.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ³������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� ��������',
															  p_funcname => '/barsroot/socialdeposit/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ********** ');
          --  ��������� ������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������',
                                                  p_funcname => '/barsroot/socialdeposit/depositsearch.aspx?action=add',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/Default.aspx',
															  p_funcname => '/barsroot/socialdeposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ��������� � ���������� ********** ');
          --  ��������� ������� �������� �������� ��������� � ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ��������� � ����������',
                                                  p_funcname => '/barsroot/socialdeposit/depositsearch.aspx?action=close',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ³������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� ��������',
															  p_funcname => '/barsroot/socialdeposit/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ����� ********** ');
          --  ��������� ������� ������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �����',
                                                  p_funcname => '/barsroot/socialdeposit/depositsearch.aspx?action=pay',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /BarsWeb.SocialDeposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.SocialDeposit/Default.aspx',
															  p_funcname => '/barsroot/socialdeposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositselecttrustee.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/DepositShowClients.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/DepositShowClients.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/DepositShowClients.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositshowclients.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/dialogs/depositcontractselect.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/dialogs/selectcountry.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/PrintButton.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/PrintButton.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/PrintButton.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/printbutton.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/SearchResults.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/SearchResults.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/SearchResults.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/searchresults.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ ����������� ������� ********** ');
          --  ��������� ������� ������� ������ ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������ ����������� �������',
                                                  p_funcname => '/barsroot/socialdeposit/socialagencies.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.SocialDeposit/SocialServices.asmx ********** ');
          --  ��������� ������� ������� /BarsWeb.SocialDeposit/SocialServices.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.SocialDeposit/SocialServices.asmx',
                                                  p_funcname => '/barsroot/socialdeposit/socialservices.asmx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /barsroot/socialdeposit/transfer.aspx ********** ');
          --  ��������� ������� ������� /barsroot/socialdeposit/transfer.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /barsroot/socialdeposit/transfer.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/transfer.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.Survey/Default.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.Survey/Default.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.Survey/Default.aspx',
                                                  p_funcname => '/barsroot/survey/default.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /BarsWeb.Survey/SurveyService.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.Survey/SurveyService.asmx',
															  p_funcname => '/barsroot/survey/surveyservice.asmx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.Survey/Survey.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.Survey/Survey.aspx',
															  p_funcname => '/barsroot/survey/survey.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.Survey/Survey.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.Survey/Survey.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.Survey/Survey.aspx',
                                                  p_funcname => '/barsroot/survey/survey.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.Survey/SurveyService.asmx ********** ');
          --  ��������� ������� ������� /BarsWeb.Survey/SurveyService.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.Survey/SurveyService.asmx',
                                                  p_funcname => '/barsroot/survey/surveyservice.asmx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/DocumentPrint.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/DocumentPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/DocumentPrint.aspx',
                                                  p_funcname => '/barsroot/techaccounts/addsum.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ������� �������� ********** ');
          --  ��������� ������� �������� �������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ������� ��������',
                                                  p_funcname => '/barsroot/techaccounts/default.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/DepositCoowner.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/DepositCoowner.aspx',
															  p_funcname => '/barsroot/techaccounts/depositcoowner.aspx\S*',
															  p_rolename => '' ,
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

      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/DocumentPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/DocumentPrint.aspx',
															  p_funcname => '/barsroot/techaccounts/addsum.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/DocumentPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/DocumentPrint.aspx',
															  p_funcname => '/barsroot/techaccounts/documentprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������ ���������',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/DocumentForm.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/DocumentForm.aspx',
															  p_funcname => '/barsroot/techaccounts/documentform.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� /BarsWeb.TechAccounts/DepositTechAcc.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� /BarsWeb.TechAccounts/DepositTechAcc.aspx',
															  p_funcname => '/barsroot/techaccounts/deposittechacc.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ��������� ������� ********** ');
          --  ��������� ������� ���������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ��������� �������',
                                                  p_funcname => '/barsroot/techaccounts/default.aspx?action=add',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� ������� ��������',
															  p_funcname => '/barsroot/techaccounts/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ������� ********** ');
          --  ��������� ������� �������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� �������',
                                                  p_funcname => '/barsroot/techaccounts/default.aspx?action=close',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� ������� ��������',
															  p_funcname => '/barsroot/techaccounts/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/DepositCoowner.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/DepositCoowner.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/DepositCoowner.aspx',
                                                  p_funcname => '/barsroot/techaccounts/depositcoowner.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ��������� ������� ********** ');
          --  ��������� ������� ³������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ��������� �������',
                                                  p_funcname => '/barsroot/techaccounts/depositsearch.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� �������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������� ������� ��������',
															  p_funcname => '/barsroot/techaccounts/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/DepositTechAcc.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/DepositTechAcc.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/DepositTechAcc.aspx',
                                                  p_funcname => '/barsroot/techaccounts/deposittechacc.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/DocumentForm.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/DocumentForm.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/DocumentForm.aspx',
                                                  p_funcname => '/barsroot/techaccounts/documentform.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� /BarsWeb.TechAccounts/DocumentPrint.aspx ********** ');
          --  ��������� ������� ������� /BarsWeb.TechAccounts/DocumentPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� /BarsWeb.TechAccounts/DocumentPrint.aspx',
                                                  p_funcname => '/barsroot/techaccounts/documentprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������� �� ********** ');
          --  ��������� ������� ���������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������� ��',
                                                  p_funcname => '/barsroot/udeposit/default.aspx?mode=0&flt=null&v1.0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���-������ /barsroot/udeposit/dptuservice.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���-������ /barsroot/udeposit/dptuservice.asmx',
															  p_funcname => '/barsroot/udeposit/dptuservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����������� �������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '��������� ����������� �������� ��',
															  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+&dpu_ad=\d*\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� �� ���������� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� ������� �� ���������� ���������',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=4&rnk=\d+&acc=\d+\,\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³��� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³��� ����� ���������',
															  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³������� ����������� �������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '³������� ����������� �������� ��',
															  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&vidd=\d+&vidname=\S*&type=\d&dpu_gen=\d*\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������� �� �������',
															  p_funcname => '/barsroot/customerlist/accextract.aspx?type=\d+&acc=\d+&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� ����������� �������� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� ����������� �������� ��',
															  p_funcname => '/barsroot/udeposit/dptdealstate.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+\S*',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����������� �������� �� ********** ');
          --  ��������� ������� ��������� ����������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����������� �������� ��',
                                                  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+&dpu_ad=\d*\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� ����������� �������� �� ********** ');
          --  ��������� ������� ³������� ����������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� ����������� �������� ��',
                                                  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&vidd=\d+&vidname=\S*&type=\d&dpu_gen=\d*\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ����������� �������� �� ********** ');
          --  ��������� ������� ���� ����������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ����������� �������� ��',
                                                  p_funcname => '/barsroot/udeposit/dptdealstate.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-������ /barsroot/udeposit/dptuservice.asmx ********** ');
          --  ��������� ������� ���-������ /barsroot/udeposit/dptuservice.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-������ /barsroot/udeposit/dptuservice.asmx',
                                                  p_funcname => '/barsroot/udeposit/dptuservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: Գ�. ��������(��������) ********** ');
          --  ��������� ������� �������� �������: Գ�. ��������(��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: Գ�. ��������(��������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_financial.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: Գ�. �������� (�����������) ********** ');
          --  ��������� ������� �������� �������: Գ�. �������� (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: Գ�. �������� (�����������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_financial.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ���. ��������(��������) ********** ');
          --  ��������� ������� �������� �������: ���. ��������(��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ���. ��������(��������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_general.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ���. �������� (�����������) ********** ');
          --  ��������� ������� �������� �������: ���. �������� (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ���. �������� (�����������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_general.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ³������ (��������) ********** ');
          --  ��������� ������� �������� �������: ³������ (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ³������ (��������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_percent.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: �������� (�����������) ********** ');
          --  ��������� ������� �������� �������: �������� (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: �������� (�����������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_percent.aspx?acc=\d+&accessmode=1\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ������(��������) ********** ');
          --  ��������� ������� �������� �������: ������(��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ������(��������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_rates.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ������ (�����������) ********** ');
          --  ��������� ������� �������� �������: ������ (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ������ (�����������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_rates.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ����� ������� (��������) ********** ');
          --  ��������� ������� �������� �������: ����� ������� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ����� ������� (��������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_rights.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ����� ������� (�����������) ********** ');
          --  ��������� ������� �������� �������: ����� ������� (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ����� ������� (�����������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_rights.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ������ ����(��������) ********** ');
          --  ��������� ������� �������� �������: ������ ����(��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ������ ����(��������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_sob.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ������ ���� (�����������) ********** ');
          --  ��������� ������� �������� �������: ������ ���� (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ������ ���� (�����������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_sob.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: �������������(��������) ********** ');
          --  ��������� ������� �������� �������: �������������(��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: �������������(��������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_sp.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������: ������������� (�����������) ********** ');
          --  ��������� ������� �������� �������: ������������� (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������: ������������� (�����������)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_sp.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ������� ********** ');
          --  ��������� ������� �������� �������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� �������',
                                                  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
                                                  p_rolename => 'WR_VIEWACC' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����',
															  p_funcname => '/barsroot/viewaccounts/listvaluts.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ������(��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ������(��������)',
															  p_funcname => '/barsroot/viewaccounts/acc_rates.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� �������',
															  p_funcname => '/barsroot/viewaccounts/listnbs.aspx?rnk=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����',
															  p_funcname => '/barsroot/viewaccounts/print.aspx?acc=\d+&id=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ³������ (��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ³������ (��������)',
															  p_funcname => '/barsroot/viewaccounts/acc_percent.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ������ ����(��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ������ ����(��������)',
															  p_funcname => '/barsroot/viewaccounts/acc_sob.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ����� ������� (��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ����� ������� (��������)',
															  p_funcname => '/barsroot/viewaccounts/acc_rights.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: Գ�. ��������(��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: Գ�. ��������(��������)',
															  p_funcname => '/barsroot/viewaccounts/acc_financial.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: �������������(��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: �������������(��������)',
															  p_funcname => '/barsroot/viewaccounts/acc_sp.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ���. ��������(��������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ���. ��������(��������)',
															  p_funcname => '/barsroot/viewaccounts/acc_general.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� ViewAccounts
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� ViewAccounts',
															  p_funcname => '/barsroot/viewaccounts/accservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������� ������� ********** ');
          --  ��������� ������� ����������� �������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������� �������',
                                                  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ������ �����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �����',
															  p_funcname => '/barsroot/viewaccounts/listvaluts.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: Գ�. �������� (�����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: Գ�. �������� (�����������)',
															  p_funcname => '/barsroot/viewaccounts/acc_financial.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ������������� (�����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ������������� (�����������)',
															  p_funcname => '/barsroot/viewaccounts/acc_sp.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� �������',
															  p_funcname => '/barsroot/viewaccounts/listnbs.aspx?rnk=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����',
															  p_funcname => '/barsroot/viewaccounts/print.aspx?acc=\d+&id=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ������ (�����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ������ (�����������)',
															  p_funcname => '/barsroot/viewaccounts/acc_rates.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: �������� (�����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: �������� (�����������)',
															  p_funcname => '/barsroot/viewaccounts/acc_percent.aspx?acc=\d+&accessmode=1\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ������ ���� (�����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ������ ���� (�����������)',
															  p_funcname => '/barsroot/viewaccounts/acc_sob.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ���. �������� (�����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ���. �������� (�����������)',
															  p_funcname => '/barsroot/viewaccounts/acc_general.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� ViewAccounts
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����� ������� ViewAccounts',
															  p_funcname => '/barsroot/viewaccounts/accservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������: ����� ������� (�����������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� �������: ����� ������� (�����������)',
															  p_funcname => '/barsroot/viewaccounts/acc_rights.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������� ViewAccounts ********** ');
          --  ��������� ������� ����� ������� ViewAccounts
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������� ViewAccounts',
                                                  p_funcname => '/barsroot/viewaccounts/accservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ������� ********** ');
          --  ��������� ������� ���� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� �������',
                                                  p_funcname => '/barsroot/viewaccounts/listnbs.aspx?rnk=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����� ********** ');
          --  ��������� ������� ������ �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����',
                                                  p_funcname => '/barsroot/viewaccounts/listvaluts.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ********** ');
          --  ��������� ������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����',
                                                  p_funcname => '/barsroot/viewaccounts/print.aspx?acc=\d+&id=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ϳ����������� ���� ������������ ********** ');
          --  ��������� ������� ϳ����������� ���� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ϳ����������� ���� ������������',
                                                  p_funcname => 'ApproveUserAccess()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� : ������ ********** ');
          --  ��������� ������� �� : ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� : ������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 0, 701, 0 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ���� + ���� + ��� ********** ');
          --  ��������� ������� �� ��: ���� + ���� + ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���� + ���� + ���',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 02, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ���� + ���� + ��� ********** ');
          --  ��������� ������� �� ��: ���� + ���� + ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���� + ���� + ���',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 03, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ��������� ********** ');
          --  ��������� ������� �� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 12, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ��������� ********** ');
          --  ��������� ������� �� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 13, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ��������� ********** ');
          --  ��������� ������� �� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 22, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ��������� ********** ');
          --  ��������� ������� �� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 23, 0, 5)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ��������� ********** ');
          --  ��������� ������� �� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 32, 0, 3)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ��������� ********** ');
          --  ��������� ������� �� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 33, 0, 5)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����������� ********** ');
          --  ��������� ������� �� ��: �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: �����������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 83, 0,77  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����� ********** ');
          --  ��������� ������� �� ��: �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: �����',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 93, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ��: ���� + ���� + ��� ********** ');
          --  ��������� ������� ��� ��: ���� + ���� + ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ��: ���� + ���� + ���',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 95, 0, 0 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ��: ��������� ********** ');
          --  ��������� ������� ��� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 95, 1, 0 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ��: ��������� ********** ');
          --  ��������� ������� ��� ��: ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ��: ���������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 95, 3, 0 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����� ��% ********** ');
          --  ��������� ������� �� ��: ����� ��%
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ����� ��%',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 97, 03, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����� ��� ********** ');
          --  ��������� ������� �� ��: ����� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ����� ���',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 98, 03, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��: ����� (��������) ********** ');
          --  ��������� ������� �� ��: ����� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��: ����� (��������)',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 99, 00, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ <-> ������ ������ ********** ');
          --  ��������� ������� ������������ <-> ������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ <-> ������ ������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, NUMBER_Null , 0, 0) ',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������  ��  ����� ������� ********** ');
          --  ��������� ������� ��������  ��  ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������  ��  ����� �������',
                                                  p_funcname => 'CC_INKRE(hWndMDI, NUMBER_Null, 298, NUMBER_Null )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� (��� ��������) ********** ');
          --  ��������� ������� ���������� ������� (��� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� (��� ��������)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,101,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� (³������) ********** ');
          --  ��������� ������� ���������� ������� (³������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� (³������)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,101,1820,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� (Գ�. �����) ********** ');
          --  ��������� ������� ���������� ������� (Գ�. �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� (Գ�. �����)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,101,6901,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� (��. �����) ********** ');
          --  ��������� ������� ���������� ������� (��. �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� (��. �����)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,101,6902,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������  (� ����������)  ********** ');
          --  ��������� ������� ���������� �������  (� ����������) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������  (� ����������) ',
                                                  p_funcname => 'CC_INKRE(hWndMDI,102,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������-2 ������� (� ����������) ********** ');
          --  ��������� ������� ����������-2 ������� (� ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������-2 ������� (� ����������)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,104,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� - ������ ********** ');
          --  ��������� ������� ���������� ������� - ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� - ������',
                                                  p_funcname => 'CC_INKRE(hWndMDI,106,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� � ���������� ��������� (��) ********** ');
          --  ��������� ������� �������� � ���������� ��������� (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� � ���������� ��������� (��)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,3,297,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�.���� ����-������������ �� ( ��� ) ********** ');
          --  ��������� ������� �i�.���� ����-������������ �� ( ��� )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�.���� ����-������������ �� ( ��� )',
                                                  p_funcname => 'DEPO( hWndMDI, 60, 11 )',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�.���� ����-������������ �� ( ��� ) ********** ');
          --  ��������� ������� �i�.���� ����-������������ �� ( ��� )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�.���� ����-������������ �� ( ��� )',
                                                  p_funcname => 'DEPO( hWndMDI, 63, 11 )',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�������� ���� ������������ �� ********** ');
          --  ��������� ������� �i�������� ���� ������������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�������� ���� ������������ ��',
                                                  p_funcname => 'DEPO(hWndMDI,60,0)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�������� ���� ����-������������ �� ********** ');
          --  ��������� ������� �i�������� ���� ����-������������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�������� ���� ����-������������ ��',
                                                  p_funcname => 'DEPO(hWndMDI,60,1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�������� ���� ������������ �� ********** ');
          --  ��������� ������� �i�������� ���� ������������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�������� ���� ������������ ��',
                                                  p_funcname => 'DEPO(hWndMDI,63, 0 )',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�������� ���� ����-������������ �� ********** ');
          --  ��������� ������� �i�������� ���� ����-������������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�������� ���� ����-������������ ��',
                                                  p_funcname => 'DEPO(hWndMDI,63,1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���� ������� ********** ');
          --  ��������� ������� ���. ���� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���� �������',
                                                  p_funcname => 'DOC_PROC(TRUE)',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� ��������� ********** ');
          --  ��������� ������� ���. ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� ���������',
                                                  p_funcname => 'DocViewListArc(hWndMDI,'''', '''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �� �������� �������� ********** ');
          --  ��������� ������� ��������� �� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �� �������� ��������',
                                                  p_funcname => 'DocViewListInt(hWndMDI,'' a.ref in (select p.ref from opldok p, accounts a where a.acc=p.acc and a.TOBO=tobopack.GetTobo)'', ''��������� �� ���. ��������'' )',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ���������, ���������� ��� �� ********** ');
          --  ��������� ������� ��. ���������, ���������� ��� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ���������, ���������� ��� ��',
                                                  p_funcname => 'DocViewListInt(hWndMDI,'' a.ref in (select ref from pkk_que where sos=0) and a.sos>=0'', ''��������� ��� ��'' )',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� � ����� �����������, �� �������, ��� �� ������� �� ����� ********** ');
          --  ��������� ������� ��������� � ����� �����������, �� �������, ��� �� ������� �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� � ����� �����������, �� �������, ��� �� ������� �� �����',
                                                  p_funcname => 'DocViewListPayLog( hWndMDI, "", "" )',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������, �� ����� ���������� �� ������ ���� ********** ');
          --  ��������� ������� �������, �� ����� ���������� �� ������ ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������, �� ����� ���������� �� ������ ����',
                                                  p_funcname => 'ExportCatQuery(10,'''',8,'''',TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����6.3 --> ��� ���� (������ 1) ********** ');
          --  ��������� ������� ������ ����6.3 --> ��� ���� (������ 1)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����6.3 --> ��� ���� (������ 1)',
                                                  p_funcname => 'ExportCatQuery(3082,'''',8,'''',FALSE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������  Cddmm.dbf  ����� ��� ���  ********** ');
          --  ��������� ������� ����������  Cddmm.dbf  ����� ��� ��� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������  Cddmm.dbf  ����� ��� ��� ',
                                                  p_funcname => 'ExportCatQuery(55,'''',1,'''',TRUE)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� �������� ��Ͳ ********** ');
          --  ��������� ������� �������� �� �������� ��Ͳ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� �������� ��Ͳ',
                                                  p_funcname => 'F1_Select ( 12, " PAY_SN8 ( 2 ) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Finis/����.����.г����� (�� ����������) ********** ');
          --  ��������� ������� Finis/����.����.г����� (�� ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Finis/����.����.г����� (�� ����������)',
                                                  p_funcname => 'F1_Select ( 12, " PVP_RRR ( DAT ) " )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������ ���(#99) + ��(KURSK___.val) ********** ');
          --  ��������� ������� ����� ������ ���(#99) + ��(KURSK___.val)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������ ���(#99) + ��(KURSK___.val)',
                                                  p_funcname => 'F1_Select ( 99, "")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� OB22 � ���.�����.  (���������� ) ********** ');
          --  ��������� ������� ����� OB22 � ���.�����.  (���������� )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� OB22 � ���.�����.  (���������� )',
                                                  p_funcname => 'F1_Select( 12, " P_AUD_DPT ( 0, ''/'') " ) ',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F/��: ��������� ������� ���. overdraft`� 2200 ********** ');
          --  ��������� ������� F/��: ��������� ������� ���. overdraft`� 2200
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/��: ��������� ������� ���. overdraft`� 2200',
                                                  p_funcname => 'F1_Select( 12, ''PK_OVR(2200, DAT)'' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F/��: ����������� ����������. ���� �� �������� 9 ����� ********** ');
          --  ��������� ������� F/��: ����������� ����������. ���� �� �������� 9 �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/��: ����������� ����������. ���� �� �������� 9 �����',
                                                  p_funcname => 'F1_Select( 12, ''PK_OVR(9, DAT)'' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �����(���������) ********** ');
          --  ��������� ������� ������ �����(���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����(���������)',
                                                  p_funcname => 'F1_Select(101,'''')',
                                                  p_rolename => 'TASK_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� �볺��� (����������� ����������) ********** ');
          --  ��������� ������� ����� �볺��� (����������� ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� �볺��� (����������� ����������)',
                                                  p_funcname => 'F1_Select(115,"")',
                                                  p_rolename => 'AN_KL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� �볺��� (� ������) ********** ');
          --  ��������� ������� ����� �볺��� (� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� �볺��� (� ������)',
                                                  p_funcname => 'F1_Select(116,"")',
                                                  p_rolename => 'AN_KL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F0: ����-����� ������� ��������� SG ********** ');
          --  ��������� ������� �� F0: ����-����� ������� ��������� SG
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F0: ����-����� ������� ��������� SG',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASG ( 0, 1)"  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S. ����-��������� ������� ����� SS -  �� ********** ');
          --  ��������� ������� S. ����-��������� ������� ����� SS -  ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S. ����-��������� ������� ����� SS -  ��',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( -1, 1 ) "  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S. ����-��������� ������� ����� SS -  �� ********** ');
          --  ��������� ������� S. ����-��������� ������� ����� SS -  ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S. ����-��������� ������� ����� SS -  ��',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( -11, 1 ) "  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #1) �� S2: ����-��������� ������� ����� SS ********** ');
          --  ��������� ������� #1) �� S2: ����-��������� ������� ����� SS
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#1) �� S2: ����-��������� ������� ����� SS',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( 0, 1 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F1: ����������� ������� �� 9129 �� �� ********** ');
          --  ��������� ������� �� F1: ����������� ������� �� 9129 �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F1: ����������� ������� �� 9129 �� ��',
                                                  p_funcname => 'F1_Select(12, " cck.CC_9129( DAT, 0, 0 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F/�������������� ��������� (DK-9129) ********** ');
          --  ��������� ������� F/�������������� ��������� (DK-9129)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/�������������� ��������� (DK-9129)',
                                                  p_funcname => 'F1_Select(12, "P_OVR8z(91, 0)" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������.�� ������.������. (2600 - 3570) ********** ');
          --  ��������� ������� ��������� ������.�� ������.������. (2600 - 3570)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������.�� ������.������. (2600 - 3570)',
                                                  p_funcname => 'F1_Select(12, "RKO_FINIS(DAT)") ',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #0) �� S1: ���������� ���.�� ������� ********** ');
          --  ��������� ������� #0) �� S1: ���������� ���.�� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#0) �� S1: ���������� ���.�� �������',
                                                  p_funcname => 'F1_Select(12, "cck.CC_DAY_LIM ( DAT , 0) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ³�������/��������� ���������� ********** ');
          --  ��������� ������� ��. ³�������/��������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ³�������/��������� ����������',
                                                  p_funcname => 'F1_Select(12, ''OBPC.PK_OVR(2)'')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������������ �����. ���� � 9 ���� ********** ');
          --  ��������� ������� ��. ������������ �����. ���� � 9 ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������������ �����. ���� � 9 ����',
                                                  p_funcname => 'F1_Select(12, ''OBPC.PK_OVR(9)'')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ��������� % � �����i� ����  ********** ');
          --  ��������� ������� OVR:  ��������� % � �����i� ���� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ��������� % � �����i� ���� ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(1,0,0,0)'' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ��������� % �� ��������i  ********** ');
          --  ��������� ������� OVR:  ��������� % �� ��������i 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ��������� % �� ��������i ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(11,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ����������� �� ���������  ********** ');
          --  ��������� ������� OVR:  ����������� �� ��������� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ����������� �� ��������� ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(2,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������� �������� % ********** ');
          --  ��������� ������� OVR:  �������� �������� %
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������� �������� %',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(3,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ��������� ��i� ����i� ********** ');
          --  ��������� ������� OVR:  ��������� ��i� ����i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ��������� ��i� ����i�',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(33,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ��������� ���������   ********** ');
          --  ��������� ������� OVR:  ��������� ���������  
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ��������� ���������  ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(4,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �����.���i�i� �� ���������� ��������� ********** ');
          --  ��������� ������� OVR:  �����.���i�i� �� ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �����.���i�i� �� ���������� ���������',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(62,0,0,0)''  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������������� ��������� 9129 ********** ');
          --  ��������� ������� OVR:  �������������� ��������� 9129
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������������� ��������� 9129',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(91,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ����������� ���������� ������. �� ����i��� ********** ');
          --  ��������� ������� OVR:  ����������� ���������� ������. �� ����i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ����������� ���������� ������. �� ����i���',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(96,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���������� �������� 6,7 ��. �� �������   ********** ');
          --  ��������� ������� �������� ���������� �������� 6,7 ��. �� �������  
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������� �������� 6,7 ��. �� �������  ',
                                                  p_funcname => 'F1_Select(12, ''Perek_kp( 0)''  ) ',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� 6,7 ����� �� (5040/5041)  - �������� ���. ����  ********** ');
          --  ��������� ������� ���������� ������� 6,7 ����� �� (5040/5041)  - �������� ���. ���� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� 6,7 ����� �� (5040/5041)  - �������� ���. ���� ',
                                                  p_funcname => 'F1_Select(12, ''Perekgod( 0)''  ) ',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������i� ��� ********** ');
          --  ��������� ������� ������ ������i� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������i� ���',
                                                  p_funcname => 'F1_Select(12, ''bars_cash.clear_cash_journals(DAT-3)'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������� ������� ********** ');
          --  ��������� ������� ������ ������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������� �������',
                                                  p_funcname => 'F1_Select(12, ''bars_xmlklb_imp.clear_import_journals(DAT)'')',
                                                  p_rolename => 'FLSTAPI' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������i ������� �� ���. �i��i����� ********** ');
          --  ��������� ������� �������i ������� �� ���. �i��i�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������i ������� �� ���. �i��i�����',
                                                  p_funcname => 'F1_Select(12, ''bars_xmlklb_ref.postvp_for_all(DAT)'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������i� ������� ********** ');
          --  ��������� ������� ������ ������i� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������i� �������',
                                                  p_funcname => 'F1_Select(12, ''bars_xmlklb_utl.clear_all_journals(DAT-30, DAT-30)'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F/���������� SPOT-����� �� ������������ ��� ********** ');
          --  ��������� ������� F/���������� SPOT-����� �� ������������ ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/���������� SPOT-����� �� ������������ ���',
                                                  p_funcname => 'F1_Select(12," SPOT_P ( 0, DAT) " ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F/���������� ������� �� ����������� ������� �� ����-���.���������� ********** ');
          --  ��������� ������� F/���������� ������� �� ����������� ������� �� ����-���.����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/���������� ������� �� ����������� ������� �� ����-���.����������',
                                                  p_funcname => 'F1_Select(12,''P_CONTRACT_JRNL_UNI(DAT)'')',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F/���������� ������������� OB22 ��� ���������� ������� Գ�.��� ********** ');
          --  ��������� ������� F/���������� ������������� OB22 ��� ���������� ������� Գ�.���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/���������� ������������� OB22 ��� ���������� ������� Գ�.���',
                                                  p_funcname => 'F1_Select(12,''P_DPT_OB22(DAT)'')',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������� ����������� ������������ �� ������. ********** ');
          --  ��������� ������� OVR:  �������� ����������� ������������ �� ������.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������� ����������� ������������ �� ������.',
                                                  p_funcname => 'F1_Select(122, '' '' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������   �i��������� ��`���� �� (�������� ����)  ********** ');
          --  ��������� �������   �i��������� ��`���� �� (�������� ����) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '  �i��������� ��`���� �� (�������� ����) ',
                                                  p_funcname => 'F1_Select(13,  "NU_RESTORE(0);�i������� ��`���� ��?;�i��������� ���������!"  ) ',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ��������� ������� ���. ����� �� ������� ���� ********** ');
          --  ��������� �������  ��������� ������� ���. ����� �� ������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ��������� ������� ���. ����� �� ������� ����',
                                                  p_funcname => 'F1_Select(13, "NAL8_0_OB22(DAT);�������� ��������� ������_� �� �� ������� ����?;��������� ���������!"  ) ',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1. ��������� �������� "�������� ������������ ������" ********** ');
          --  ��������� ������� 1. ��������� �������� "�������� ������������ ������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1. ��������� �������� "�������� ������������ ������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_BLNK'',NUMBER_Null);�������� <�������� ������������ ������?>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2. ��������� �������� "�������� ������ ���� ��������� ������ 䳿" ********** ');
          --  ��������� ������� 2. ��������� �������� "�������� ������ ���� ��������� ������ 䳿"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2. ��������� �������� "�������� ������ ���� ��������� ������ 䳿"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_CLOS'',NUMBER_Null);�������� <�������� ������ ���� ��������� ������ 䳿>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� B. ��������� �������� "������������������ ������" ********** ');
          --  ��������� ������� B. ��������� �������� "������������������ ������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'B. ��������� �������� "������������������ ������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_EXTN'',NUMBER_Null);�������� <������������������ ������>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4. ��������� �������� "��������� ����������� �������" ********** ');
          --  ��������� ������� 4. ��������� �������� "��������� ����������� �������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4. ��������� �������� "��������� ����������� �������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_INTF'',NUMBER_Null);�������� <��������� ����������� �������>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� X. ��������� �������� "����������� ������� �� �������� ����" ********** ');
          --  ��������� ������� X. ��������� �������� "����������� ������� �� �������� ����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'X. ��������� �������� "����������� ������� �� �������� ����"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_INTX'',NUMBER_Null);�������� <����������� ������� �� �������� ����>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5. ��������� �������� "������������� ������ �� %% � ���� ������ 䳿" ********** ');
          --  ��������� ������� 5. ��������� �������� "������������� ������ �� %% � ���� ������ 䳿"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. ��������� �������� "������������� ������ �� %% � ���� ������ 䳿"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_MATU'',NUMBER_Null);�������� <������������� ������ �� %% � ���� ������ 䳿>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6. ��������� �������� "����������� ������� � ���� �����" ********** ');
          --  ��������� ������� 6. ��������� �������� "����������� ������� � ���� �����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6. ��������� �������� "����������� ������� � ���� �����"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_MINT'',0);�������� <����������� %% �� ������� � ������� ���� ��>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3. ��������� �������� "���� ��������� ������ �� 0 �� �����.������" ********** ');
          --  ��������� ������� 3. ��������� �������� "���� ��������� ������ �� 0 �� �����.������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3. ��������� �������� "���� ��������� ������ �� 0 �� �����.������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_RAT0'',NUMBER_Null);�������� <���� ��������� ������ �� 0 �� �����.������>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 8. ��������� �������� "����������� ������� �� ���.���������" ********** ');
          --  ��������� ������� 8. ��������� �������� "����������� ������� �� ���.���������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '8. ��������� �������� "����������� ������� �� ���.���������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_SCDI'',0);�������� <����������� %% �� ���.���.� ������� ���� ��>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 9. ��������� �������� "������� ������� �� ���.���������" ********** ');
          --  ��������� ������� 9. ��������� �������� "������� ������� �� ���.���������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '9. ��������� �������� "������� ������� �� ���.���������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_SCDP'',NUMBER_Null);�������� <������� ������� �� �������� ���.���������>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������� �������� ********** ');
          --  ��������� ������� ��. ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������� ��������',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.export_auto_op(DATETIME_Null);��������� ������� ��������?;������� ��������'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������ ����� ����� FATF ********** ');
          --  ��������� ������� ��. ������ ����� ����� FATF
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������ ����� ����� FATF',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.import_file("FATF");��������� ������ ����� �����?;������ ��������'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������ ����� �_������_ ��� ������_�, �� ����� ��'����� �� ********** ');
          --  ��������� ������� ��. ������ ����� �_������_ ��� ������_�, �� ����� ��'����� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������ ����� �_������_ ��� ������_�, �� ����� ��'����� ��',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.import_file("OPDATA");��������� ������ ����� ��������?;������ ��������'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������ ����� ������ ������ �������� � �� ********** ');
          --  ��������� ������� ��. ������ ����� ������ ������ �������� � ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������ ����� ������ ������ �������� � ��',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.import_file("RULES");��������� ������ ����� ������ ������ �������� � ��?;������ ��������'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������ ����� ����������� ********** ');
          --  ��������� ������� ��. ������ ����� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������ ����� �����������',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.import_file("TRR");��������� ������ ����� �����������?;������ ��������'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S32: ����-��������� ������� �����.% SN �� ********** ');
          --  ��������� ������� �� S32: ����-��������� ������� �����.% SN ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S32: ����-��������� ������� �����.% SN ��',
                                                  p_funcname => 'F1_Select(13,"CCK.CC_ASPN (2, 0, 1 );�� ������ ������� �� ��������� % ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S33: ����-��������� ������� �����.% SN �� ********** ');
          --  ��������� ������� �� S33: ����-��������� ������� �����.% SN ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S33: ����-��������� ������� �����.% SN ��',
                                                  p_funcname => 'F1_Select(13,"CCK.CC_ASPN (3, 0, 1 );�� ������ ������� �� ��������� % ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F4: �������� ����������� ������ ********** ');
          --  ��������� ������� �� F4: �������� ����������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F4: �������� ����������� ������',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY(0,DAT,0);�� ������ ���.������������ ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S7: ����������� ����/���� ********** ');
          --  ��������� ������� �� S7: ����������� ����/����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S7: ����������� ����/����',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY_PET(0,DAT,3);�� ������ ���. ���������� ��������?; ��������!" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 0.��������� ���� �� ������� - ������������� ********** ');
          --  ��������� ������� 0.��������� ���� �� ������� - �������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '0.��������� ���� �� ������� - �������������',
                                                  p_funcname => 'F1_Select(13,"REZ_BRA (0,0); �� ������ �������� <<������������� ���������� ����� �� �������>> ?; �������� !" )',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.��������� ���� �� ������� - ���������� ********** ');
          --  ��������� ������� 1.��������� ���� �� ������� - ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.��������� ���� �� ������� - ����������',
                                                  p_funcname => 'F1_Select(13,"REZ_BRA (1,0); �� ������ �������� <<���������� ���������� ����� �� �������>> ?; �������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ����������� ������� ********** ');
          --  ��������� ������� ������������ ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ����������� �������',
                                                  p_funcname => 'F1_Select(13,"bars_accm_sync.sync_snap(''BALANCE'',GetBankDate(), 0);�������� ����������� �������?;����������� ������� �� �������� ��������� ���� ��������")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S8: ���� �������� �������� �� ********** ');
          --  ��������� ������� �� S8: ���� �������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S8: ���� �������� �������� ��',
                                                  p_funcname => 'F1_Select(13,"cc_close(2,DAT);�� ������ ���. ���� �������� ���. �� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S8: ���� �������� �������� �� ********** ');
          --  ��������� ������� �� S8: ���� �������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S8: ���� �������� �������� ��',
                                                  p_funcname => 'F1_Select(13,"cc_close(3,DAT);�� ������ ���. ���� �������� ���. �� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� �� ********** ');
          --  ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(2,DAT,0);�� ������ ������� �� ��������� ��� ������ ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� �� ********** ');
          --  ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(3,DAT,0);�� ������ ������� �� ��������� ��� ������ ������� ?; ��������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-�������� ���.2620 � ������������� ********** ');
          --  ��������� ������� ����-�������� ���.2620 � �������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-�������� ���.2620 � �������������',
                                                  p_funcname => 'F1_Select(2,"  and a.nbs=2620  ")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Start+Finish: ������i��� ���.���.(����) ********** ');
          --  ��������� ������� Start+Finish: ������i��� ���.���.(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start+Finish: ������i��� ���.���.(����)',
                                                  p_funcname => 'F1_Select(5,'''')',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� ������� ��� ³������/������� ��� ********** ');
          --  ��������� ������� ����������� ������� ������� ��� ³������/������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� ������� ��� ³������/������� ���',
                                                  p_funcname => 'FListEdit(hWndMDI,0)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������ ������� ��� ³������ ��� ********** ');
          --  ��������� ������� ��������� ������ ������� ��� ³������ ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������ ������� ��� ³������ ���',
                                                  p_funcname => 'FListRun(0, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������ ������� ��� ������� ��� ********** ');
          --  ��������� ������� ��������� ������ ������� ��� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������ ������� ��� ������� ���',
                                                  p_funcname => 'FListRun(1, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-4. ���������� ��������� ���������� ********** ');
          --  ��������� ������� ��-4. ���������� ��������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-4. ���������� ��������� ����������',
                                                  p_funcname => 'FListRun(4, FALSE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ����� �������/��������� ��������� �� � ����� �� �������� ********** ');
          --  ��������� ������� ��. ����� �������/��������� ��������� �� � ����� �� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ����� �������/��������� ��������� �� � ����� �� ��������',
                                                  p_funcname => 'FOBPC_Select(10,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��� ********** ');
          --  ��������� ������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���',
                                                  p_funcname => 'FOBPC_Select(11, '''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������ ���������� ����� (txt, dbf) ********** ');
          --  ��������� ������� ��. ������ ���������� ����� (txt, dbf)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������ ���������� ����� (txt, dbf)',
                                                  p_funcname => 'FOBPC_Select(14,'''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ����� ������������ ��������� ��� �� ********** ');
          --  ��������� ������� ��. ����� ������������ ��������� ��� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ����� ������������ ��������� ��� ��',
                                                  p_funcname => 'FOBPC_Select(16,'''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ���������� ����. ������� (�� ����. �������) ********** ');
          --  ��������� ������� ��. ���������� ����. ������� (�� ����. �������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ���������� ����. ������� (�� ����. �������)',
                                                  p_funcname => 'FOBPC_Select(17,'''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �������� �����. �� ����������� ��������� ********** ');
          --  ��������� ������� ��. �������� �����. �� ����������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �������� �����. �� ����������� ���������',
                                                  p_funcname => 'FOBPC_Select(2,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �������� �����. �� ������������  ��������� ********** ');
          --  ��������� ������� ��. �������� �����. �� ������������  ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �������� �����. �� ������������  ���������',
                                                  p_funcname => 'FOBPC_Select(3,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �������� �����. �� ����������� ��������� ********** ');
          --  ��������� ������� ��. �������� �����. �� ����������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �������� �����. �� ����������� ���������',
                                                  p_funcname => 'FOBPC_Select(4,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �������� �����. �� ������������  ��������� ********** ');
          --  ��������� ������� ��. �������� �����. �� ������������  ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �������� �����. �� ������������  ���������',
                                                  p_funcname => 'FOBPC_Select(5,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����� � ��������� ����� ********** ');
          --  ��������� ������� ������ ����� � ��������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����� � ��������� �����',
                                                  p_funcname => 'FOBPC_Select(7,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ��������� ����� ��������� �� �� ********** ');
          --  ��������� ������� ��. ��������� ����� ��������� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ��������� ����� ��������� �� ��',
                                                  p_funcname => 'FOBPC_Select(9,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �Ѳ� ������������ ********** ');
          --  ��������� ������� ��������� �Ѳ� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �Ѳ� ������������',
                                                  p_funcname => 'F_Ctrl_D(TRUE)',
                                                  p_rolename => 'CHCK002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ���-�������� (�������� ��������) ********** ');
          --  ��������� ������� ��������� ���-�������� (�������� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ���-�������� (�������� ��������)',
                                                  p_funcname => 'F_Pay_Bck( hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� (����� ��������) ********** ');
          --  ��������� ������� ³������� �������� (����� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� (����� ��������)',
                                                  p_funcname => 'FunCheckDocumentsEx(hWndMDI, " a.TOBO = tobopack.GetTobo ")',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� (����� ����. � ϳ�������) ********** ');
          --  ��������� ������� ³������� �������� (����� ����. � ϳ�������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� (����� ����. � ϳ�������)',
                                                  p_funcname => 'FunCheckDocumentsEx(hWndMDI, " a.TOBO like tobopack.GetTobo || ''%'' ")',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� "����" �������� ********** ');
          --  ��������� ������� ³������� "����" ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� "����" ��������',
                                                  p_funcname => 'FunCheckDocumentsSel(1,''a.userid=''||Str(GetUserId()),'''',1,0)',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��� �� ���� ********** ');
          --  ��������� ������� �������� ��� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��� �� ����',
                                                  p_funcname => 'FunCheckDocumentsSel(99,'''','''',1,0)',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������������� ********** ');
          --  ��������� ������� ����������� ��������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������������',
                                                  p_funcname => 'FunMetaBaseEdit()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT5 ���������� ��i�� ��� �� "���,�� ���� �� �����.����i�����" ********** ');
          --  ��������� ������� DPT5 ���������� ��i�� ��� �� "���,�� ���� �� �����.����i�����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT5 ���������� ��i�� ��� �� "���,�� ���� �� �����.����i�����"',
                                                  p_funcname => 'FunNSIEdit("[PROC=>PF_NOT_PAY(:Param0,:Param1)][PAR=>:Param0(SEM=��i��� ����,TYPE=D),:Param1(SEM=��i���� ���i��/�i�,TYPE=N)][MSG=>��������!]")',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ���������� ���������� ********** ');
          --  ��������� ������� ��. ���������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ���������� ����������',
                                                  p_funcname => 'FunNSIEdit(''FM_PARAMS'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� OB22 � ���.�����.  (���������� + ��������) ********** ');
          --  ��������� ������� ����� OB22 � ���.�����.  (���������� + ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� OB22 � ���.�����.  (���������� + ��������)',
                                                  p_funcname => 'FunNSIEditF("AUD_CCK",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� OB22 � ���.��������� �� ********** ');
          --  ��������� ������� ����� OB22 � ���.��������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� OB22 � ���.��������� ��',
                                                  p_funcname => 'FunNSIEditF("AUD_DPU",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i���� ��22 � ���.�����. ��+�� ********** ');
          --  ��������� ������� ���i���� ��22 � ���.�����. ��+��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i���� ��22 � ���.�����. ��+��',
                                                  p_funcname => 'FunNSIEditF("CCK_OB22",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������, �� ����� ���������� �� ������� ���� ********** ');
          --  ��������� ������� �������, �� ����� ���������� �� ������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������, �� ����� ���������� �� ������� ����',
                                                  p_funcname => 'FunNSIEditF("CCK_PROBL" , 1 | 0x0010)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����������  CC_DEAL ********** ');
          --  ��������� ������� �����������  CC_DEAL
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����������  CC_DEAL',
                                                  p_funcname => 'FunNSIEditF("CC_DEAL",2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I��������i� ��i� ���.����i� ����� ********** ');
          --  ��������� ������� I��������i� ��i� ���.����i� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I��������i� ��i� ���.����i� �����',
                                                  p_funcname => 'FunNSIEditF("CUR_RATE_KOM_UPD",1 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i���� ��22 � ���.�����. �� ********** ');
          --  ��������� ������� ���i���� ��22 � ���.�����. ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i���� ��22 � ���.�����. ��',
                                                  p_funcname => 'FunNSIEditF("DPT_OB22",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����������i� �� �� ********** ');
          --  ��������� ������� I�����������i� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����������i� �� ��',
                                                  p_funcname => 'FunNSIEditF("INV_CCK_UL[PROC=>P_INV_CCK_UL(:Param0,:Param1)][PAR=>:Param0(SEM=��i��� ����,TYPE=D,REF=REZ_PROTOCOL),:Param1(SEM=�������������?���->1/�i->0,TYPE=N)][EXEC=>BEFORE][MSG=>��������!]", 2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���.��������� OB40 �� ������ 30 ��� ********** ');
          --  ��������� ������� ����������� ���.��������� OB40 �� ������ 30 ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���.��������� OB40 �� ������ 30 ���',
                                                  p_funcname => 'FunNSIEditF("OPER_OB40",2 )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��������� ����� #04 ********** ');
          --  ��������� ������� ����� ��������� ����� #04
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������� ����� #04',
                                                  p_funcname => 'FunNSIEditF("RNBU_HISTORY",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� --����� ������� �� (��+��������� �� 8��) �� ���� ********** ');
          --  ��������� ������� --����� ������� �� (��+��������� �� 8��) �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '--����� ������� �� (��+��������� �� 8��) �� ����',
                                                  p_funcname => 'FunNSIEditF("SB_NAL3",1)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� --8. ������� 8 �����, �� ���'���� � ����������� ********** ');
          --  ��������� ������� --8. ������� 8 �����, �� ���'���� � �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '--8. ������� 8 �����, �� ���'���� � �����������',
                                                  p_funcname => 'FunNSIEditF("SB_NAL8",1)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������������� ������� (���) ********** ');
          --  ��������� ������� �������� ������������� ������� (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������������� ������� (���)',
                                                  p_funcname => 'FunNSIEditF("SPEC1",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������������� �� ********** ');
          --  ��������� ������� �������� ������������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������������� ��',
                                                  p_funcname => 'FunNSIEditF("SPEC1_INT",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��������� ������������� ��  ********** ');
          --  ��������� ������� ����� ��������� ������������� �� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������� ������������� �� ',
                                                  p_funcname => 'FunNSIEditF("SPEC1_INT",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ����� ��������� ������������� ��  �����.���� ********** ');
          --  ��������� �������  ����� ��������� ������������� ��  �����.����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ����� ��������� ������������� ��  �����.����',
                                                  p_funcname => 'FunNSIEditF("SPEC1_INT_PO",2)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ---- ����� |  8-��, ��, P080, OB22 ********** ');
          --  ��������� ������� ---- ����� |  8-��, ��, P080, OB22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '---- ����� |  8-��, ��, P080, OB22',
                                                  p_funcname => 'FunNSIEditF("SSB_NAL88",1)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� OB22 � ���.�����. (��������) ********** ');
          --  ��������� ������� ����� OB22 � ���.�����. (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� OB22 � ���.�����. (��������)',
                                                  p_funcname => 'FunNSIEditF("TEST_AUD_DPT",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������.��������� ����� ������� ���� � ����� �������� ���� ********** ');
          --  ��������� ������� �������.��������� ����� ������� ���� � ����� �������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������.��������� ����� ������� ���� � ����� �������� ����',
                                                  p_funcname => 'FunNSIEditF("TEST_DPT_ERR_OB22" ,2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �� ������.���.(����) ********** ');
          --  ��������� ������� ����������� �� ������.���.(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �� ������.���.(����)',
                                                  p_funcname => 'FunNSIEditF("VPAY_ALT",0)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� � ��������� � ������� ********** ');
          --  ��������� ������� �������� �� � ��������� � �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� � ��������� � �������',
                                                  p_funcname => 'FunNSIEditF("V_CC_SDI" ,1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� � �����.�� ********** ');
          --  ��������� ������� ���������� � �����.��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� � �����.��',
                                                  p_funcname => 'FunNSIEditF("V_CC_START",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �����.������ �� ������ �� �����.��.����.��� � 159 ********** ');
          --  ��������� ������� ����������� �����.������ �� ������ �� �����.��.����.��� � 159
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �����.������ �� ������ �� �����.��.����.��� � 159',
                                                  p_funcname => 'FunNSIEditF("V_DPT_159[PROC=>dpt_159(:DPTID,:Param0)][PAR=>:Param0(SEM=��������,TYPE=C,DEF=���,REF=TTS)][QST=>�������� ����������� ��������� ������ �� ������ �� ���������?][MSG=>��������!]", 1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT6 ������ ���i ��� ���� ���i�������� ********** ');
          --  ��������� ������� DPT6 ������ ���i ��� ���� ���i��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT6 ������ ���i ��� ���� ���i��������',
                                                  p_funcname => 'FunNSIEditF("V_DPT_AGR_DAT",2|0x0010)',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i����i��i��� �� �� ����i����� �� �i���� �����i� ********** ');
          --  ��������� ������� ���i����i��i��� �� �� ����i����� �� �i���� �����i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i����i��i��� �� �� ����i����� �� �i���� �����i�',
                                                  p_funcname => 'FunNSIEditF("V_NBS_BRANCH",1 | 0x0010)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  �� ���� ������� �� �� �� �� SB_P0853 ********** ');
          --  ��������� �������  �� ���� ������� �� �� �� �� SB_P0853
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' �� ���� ������� �� �� �� �� SB_P0853',
                                                  p_funcname => 'FunNSIEditF("V_OB22NU",2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ������� 6 �����,     �� ���'���� � ����������� ********** ');
          --  ��������� �������  ������� 6 �����,     �� ���'���� � �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ������� 6 �����,     �� ���'���� � �����������',
                                                  p_funcname => 'FunNSIEditF("V_OB22_N6",1 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ������� 7 �����,     �� ���'���� � ����������� ********** ');
          --  ��������� �������  ������� 7 �����,     �� ���'���� � �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ������� 7 �����,     �� ���'���� � �����������',
                                                  p_funcname => 'FunNSIEditF("V_OB22_N7",1 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ������� Գ������  , �� ���'���� � �����������(�� R020_FA) ********** ');
          --  ��������� �������  ������� Գ������  , �� ���'���� � �����������(�� R020_FA)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ������� Գ������  , �� ���'���� � �����������(�� R020_FA)',
                                                  p_funcname => 'FunNSIEditF("V_OB22_NN",2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� - ������� ������� ��-���-���-��� ********** ');
          --  ��������� ������� ������� - ������� ������� ��-���-���-���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� - ������� ������� ��-���-���-���',
                                                  p_funcname => 'FunNSIEditF("V_VPLIST",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��������� ������ ********** ');
          --  ��������� ������� ³��������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��������� ������',
                                                  p_funcname => 'FunNSIEditF('''',20)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� �������� ********** ');
          --  ��������� ������� �������� ���� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� ��������',
                                                  p_funcname => 'FunNSIEditF(''BRANCH_BANKDATES_VIEW'',1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i ��� ��������������i� ��������, �� ������ � �� ********** ');
          --  ��������� ������� ���i ��� ��������������i� ��������, �� ������ � ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i ��� ��������������i� ��������, �� ������ � ��',
                                                  p_funcname => 'FunNSIEditF(''CCK_RESTR_ACC'',0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i ��� ��������������i� �� ********** ');
          --  ��������� ������� ���i ��� ��������������i� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i ��� ��������������i� ��',
                                                  p_funcname => 'FunNSIEditF(''CCK_RESTR_V'',0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�.����: ���� ����� �� �������� �� ********** ');
          --  ��������� ������� �i�.����: ���� ����� �� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�.����: ���� ����� �� �������� ��',
                                                  p_funcname => 'FunNSIEditF(''FIN_vR_FL'',1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�.����: ���� ����� �� �������� �� ********** ');
          --  ��������� ������� �i�.����: ���� ����� �� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�.����: ���� ����� �� �������� ��',
                                                  p_funcname => 'FunNSIEditF(''FIN_vR_UL'',1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�.����: ���� ����� �� �������� ��  ********** ');
          --  ��������� ������� �i�.����: ���� ����� �� �������� �� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�.����: ���� ����� �� �������� �� ',
                                                  p_funcname => 'FunNSIEditF(''FIN_vT_FL'',1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i�.����: ���� ����� �� �������� ��  ********** ');
          --  ��������� ������� �i�.����: ���� ����� �� �������� �� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i�.����: ���� ����� �� �������� �� ',
                                                  p_funcname => 'FunNSIEditF(''FIN_vT_UL'',1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ���������� ������-���� ********** ');
          --  ��������� ������� ������� ���������� ������-����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ���������� ������-����',
                                                  p_funcname => 'FunNSIEditF(''KLPEOM'',1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �������� �������������� ������� �� � ����� ********** ');
          --  ��������� ������� ��. �������� �������������� ������� �� � �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �������� �������������� ������� �� � �����',
                                                  p_funcname => 'FunNSIEditF(''OBPC_BAD_ACC'', 2 | 0x0010)',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �������� �������������� ������� �� � ����� ********** ');
          --  ��������� ������� ��. �������� �������������� ������� �� � �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �������� �������������� ������� �� � �����',
                                                  p_funcname => 'FunNSIEditF(''OBPC_BAD_OST'', 2 | 0x0010)',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� �� �� ������ 35 ��� ********** ');
          --  ��������� ������� ����������� ������� �� �� ������ 35 ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� �� �� ������ 35 ���',
                                                  p_funcname => 'FunNSIEditF(''OPER_SK'',2 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���: �������� ������ �� T00. ********** ');
          --  ��������� ������� ���: �������� ������ �� T00.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���: �������� ������ �� T00.',
                                                  p_funcname => 'FunNSIEditF(''OPL4'', 2 | 0x0010)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������,������ ������ ����.: <PO1> �� ������i 30 ��i� ********** ');
          --  ��������� ������� ��������,������ ������ ����.: <PO1> �� ������i 30 ��i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������,������ ������ ����.: <PO1> �� ������i 30 ��i�',
                                                  p_funcname => 'FunNSIEditF(''PROVNU_PO1'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������,������ ������������:<PO3+����i> �� ������i 5 ��i� ********** ');
          --  ��������� ������� ��������,������ ������������:<PO3+����i> �� ������i 5 ��i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������,������ ������������:<PO3+����i> �� ������i 5 ��i�',
                                                  p_funcname => 'FunNSIEditF(''PROVNU_PO3'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������, �� ����������� � ��i� ��� ������ ********** ');
          --  ��������� ������� ��������, �� ����������� � ��i� ��� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������, �� ����������� � ��i� ��� ������',
                                                  p_funcname => 'FunNSIEditF(''PROV_LOT'', 2 | 0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i���� �����i� �� ��  ���i� ********** ');
          --  ��������� ������� ���i���� �����i� �� ��  ���i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i���� �����i� �� ��  ���i�',
                                                  p_funcname => 'FunNSIEditF(''V_BRANCH_TIP'', 2 | 0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i ��� ��������������i� �� �� ********** ');
          --  ��������� ������� ���i ��� ��������������i� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i ��� ��������������i� �� ��',
                                                  p_funcname => 'FunNSIEditFFiltered(''CCK_RESTR_V'',0,''CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (1,2,3))'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i ��� ��������������i� �� �� ********** ');
          --  ��������� ������� ���i ��� ��������������i� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i ��� ��������������i� �� ��',
                                                  p_funcname => 'FunNSIEditFFiltered(''CCK_RESTR_V'',0,''CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (11,12,13))'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� IMPEXP: ������ DBF ����� ********** ');
          --  ��������� ������� IMPEXP: ������ DBF �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'IMPEXP: ������ DBF �����',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,0,10,"","")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� IMPEXP: ������� ����� ������� � DBF ���� ********** ');
          --  ��������� ������� IMPEXP: ������� ����� ������� � DBF ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'IMPEXP: ������� ����� ������� � DBF ����',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,0,110,"","")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����   : ����� ��������� ********** ');
          --  ��������� ������� I�����   : ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����   : ����� ���������',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 0, '''','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 1: �������i �����i(��������) ********** ');
          --  ��������� ������� I����� 1: �������i �����i(��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 1: �������i �����i(��������)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''1'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 2: ��������Ͳ �����Ʋ ********** ');
          --  ��������� ������� I����� 2: ��������Ͳ �����Ʋ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 2: ��������Ͳ �����Ʋ',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''2'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 3: ��������i ����� ********** ');
          --  ��������� ������� I����� 3: ��������i �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 3: ��������i �����',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''3'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 4: ����� ��������� ********** ');
          --  ��������� ������� I����� 4: ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 4: ����� ���������',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''4'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����   : ����� ��� ���������� ��������� ********** ');
          --  ��������� ������� I�����   : ����� ��� ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����   : ����� ��� ���������� ���������',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 3, '''','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ------������������ �������� ��� ********** ');
          --  ��������� ������� ------������������ �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '------������������ �������� ���',
                                                  p_funcname => 'ImpOper(hWndMDI, 5)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ DBF-������� ********** ');
          --  ��������� ������� ������ DBF-�������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ DBF-�������',
                                                  p_funcname => 'Imp_Dbf_New (hWndMDI,2,0, '''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����6.3 --> ��� ���� ********** ');
          --  ��������� ������� ������ ����6.3 --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����6.3 --> ��� ����',
                                                  p_funcname => 'ImportDataAsvo63()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����� --> ��� ���� ********** ');
          --  ��������� ������� ������ ����� --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����� --> ��� ����',
                                                  p_funcname => 'ImportDataSkarb()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.������ � ����������� "�����������" �볺��� ********** ');
          --  ��������� ������� 1.������ � ����������� "�����������" �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.������ � ����������� "�����������" �볺���',
                                                  p_funcname => 'KLOP(0,''KL1'',''KL2'',''KLI'')',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.������ � ����������� "�����������" �볺��� ********** ');
          --  ��������� ������� 1.������ � ����������� "�����������" �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.������ � ����������� "�����������" �볺���',
                                                  p_funcname => 'KLOP(0,''KL1'',''KL2'',''KLI'')',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.������ � ����������� "�����������" �볺��� ********** ');
          --  ��������� ������� 1.������ � ����������� "�����������" �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.������ � ����������� "�����������" �볺���',
                                                  p_funcname => 'KLOP(0,''KL1'',''KL2'',''KLI'')',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��� ���������� (��������) ������� (E) ��������� ��� (SBB) ********** ');
          --  ��������� ������� ³��� ���������� (��������) ������� (E) ��������� ��� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��� ���������� (��������) ������� (E) ��������� ��� (SBB)',
                                                  p_funcname => 'KliTex(1,hWndMDI,"")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F/³��� ������� "�����������" �볺���� ********** ');
          --  ��������� ������� F/³��� ������� "�����������" �볺����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/³��� ������� "�����������" �볺����',
                                                  p_funcname => 'KliTex(2, hWndMDI, "")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��� ����. ������� ��������� ��� (SBB) ********** ');
          --  ��������� ������� ³��� ����. ������� ��������� ��� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��� ����. ������� ��������� ��� (SBB)',
                                                  p_funcname => 'KliTex(4,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S/³��� ����. ������� ��������� ��� (SBB) ********** ');
          --  ��������� ������� S/³��� ����. ������� ��������� ��� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/³��� ����. ������� ��������� ��� (SBB)',
                                                  p_funcname => 'KliTex(4,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³��� ����. ������� ��������� ��� + ����� (SBB) ********** ');
          --  ��������� ������� ³��� ����. ������� ��������� ��� + ����� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³��� ����. ������� ��������� ��� + ����� (SBB)',
                                                  p_funcname => 'KliTex(5,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S/³��� ����. ������� ��������� ��� + ����� (SBB) ********** ');
          --  ��������� ������� S/³��� ����. ������� ��������� ��� + ����� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/³��� ����. ������� ��������� ��� + ����� (SBB)',
                                                  p_funcname => 'KliTex(5,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i��i� ����. ������� �� �����. ��.(����) ********** ');
          --  ��������� ������� �i��i� ����. ������� �� �����. ��.(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i��i� ����. ������� �� �����. ��.(����)',
                                                  p_funcname => 'KliTex(6,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���� ������������ ********** ');
          --  ��������� ������� ����������� ���� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���� ������������',
                                                  p_funcname => 'MakeSubstitutes()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ��������� ��� ********** ');
          --  ��������� ������� ���. ��������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ��������� ���',
                                                  p_funcname => 'ModyTok()',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� * 2.�������� ����������� ����� � ���������� ������� ********** ');
          --  ��������� ������� * 2.�������� ����������� ����� � ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* 2.�������� ����������� ����� � ���������� �������',
                                                  p_funcname => 'NAL_DEC(101)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� * ���� ��������ί ���������� ********** ');
          --  ��������� ������� * ���� ��������ί ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* ���� ��������ί ����������',
                                                  p_funcname => 'NAL_DEC(102)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� * �������� �� ��� ��������� �������  ********** ');
          --  ��������� ������� * �������� �� ��� ��������� ������� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* �������� �� ��� ��������� ������� ',
                                                  p_funcname => 'NAL_DEC(107)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� * ���� ��������ί ���������� �� ��� �� ����� ********** ');
          --  ��������� ������� * ���� ��������ί ���������� �� ��� �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* ���� ��������ί ���������� �� ��� �� �����',
                                                  p_funcname => 'NAL_DEC(112)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.����  ��������ί ���������� (�� ���) ********** ');
          --  ��������� ������� 2.����  ��������ί ���������� (�� ���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.����  ��������ί ���������� (�� ���)',
                                                  p_funcname => 'NAL_DEC(12)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� * ³������� ������� �� ������ ����� ������� ********** ');
          --  ��������� ������� * ³������� ������� �� ������ ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* ³������� ������� �� ������ ����� �������',
                                                  p_funcname => 'NAL_DEC(155)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� � �� �� ��22 (�����) ********** ');
          --  ��������� ������� �������� � �� �� ��22 (�����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� � �� �� ��22 (�����)',
                                                  p_funcname => 'NAL_DEC(22)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1_��. ���.�������� ��������� ********** ');
          --  ��������� ������� 1_��. ���.�������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1_��. ���.�������� ���������',
                                                  p_funcname => 'PB1(hWndMDI)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1_��. ���������� ���� ********** ');
          --  ��������� ������� 1_��. ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1_��. ���������� ����',
                                                  p_funcname => 'PBF(hWndMDI)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S/������ ��������� �� ������� ********** ');
          --  ��������� ������� S/������ ��������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/������ ��������� �� �������',
                                                  p_funcname => 'PayStartDay(GetBankDate())',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Start+Finish: ������i��� ���.���.(����) ********** ');
          --  ��������� ������� Start+Finish: ������i��� ���.���.(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start+Finish: ������i��� ���.���.(����)',
                                                  p_funcname => 'Pereocenka_VP()',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S/���. ���������� ��� ���� �� ������ ��� ********** ');
          --  ��������� ������� S/���. ���������� ��� ���� �� ������ ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/���. ���������� ��� ���� �� ������ ���',
                                                  p_funcname => 'PrestartVegaTOKUpdate()',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.������� ��. ��������� ������ ����� ********** ');
          --  ��������� ������� 2.������� ��. ��������� ������ �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.������� ��. ��������� ������ �����',
                                                  p_funcname => 'RunATime(hWndMDI)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� ����� ********** ');
          --  ��������� ������� ������ �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� �����',
                                                  p_funcname => 'RunHoliday(hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������������ ********** ');
          --  ��������� ������� ������ ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������������',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, 3)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������������ ��� ********** ');
          --  ��������� ������� ������������ ������������ ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������������ ���',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���������ײ� ********** ');
          --  ��������� ������� ������������� ���������ײ�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���������ײ�',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���-�� ********** ');
          --  ��������� ������� ����������� ���-��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���-��',
                                                  p_funcname => 'Run_Arms( hWndMDI, 0 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��'���� ��'���� ������������� ********** ');
          --  ��������� ������� ��'���� ��'���� �������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��'���� ��'���� �������������',
                                                  p_funcname => 'Run_Arms(hWndMDI,77)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S/���. �������������� "�����" ����� ������� ********** ');
          --  ��������� ������� S/���. �������������� "�����" ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/���. �������������� "�����" ����� �������',
                                                  p_funcname => 'SEPFiles_Reform()',
                                                  p_rolename => 'NOCHNYE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� � ������� ���������� ������������� �� ������-���� ********** ');
          --  ��������� ������� �������� � ������� ���������� ������������� �� ������-����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� � ������� ���������� ������������� �� ������-����',
                                                  p_funcname => 'Sel000(hWndMDI,10,0,"","")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���������� �������� �� �� �� - ��������� ��� ********** ');
          --  ��������� ������� ���������� ���������� �������� �� �� �� - ��������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���������� �������� �� �� �� - ��������� ���',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) ","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������  ���������� �������� �� ������� ********** ');
          --  ��������� ������� ����������  ���������� �������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������  ���������� �������� �� �������',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) and oper.userid=USER_ID and oper.vdat=BANKDATE","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���������� �������� �� �� �� (�����������) ********** ');
          --  ��������� ������� ���������� ���������� �������� �� �� �� (�����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���������� �������� �� �� �� (�����������)',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) and oper.userid=USER_ID","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ����������� �������� �� �� � �� ********** ');
          --  ��������� �������  ����������� �������� �� �� � ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ����������� �������� �� �� � ��',
                                                  p_funcname => 'Sel000(hWndMDI,13, 8199599,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���������� ����� � ������ MOPER ********** ');
          --  ��������� ������� ������ ���������� ����� � ������ MOPER
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���������� ����� � ������ MOPER',
                                                  p_funcname => 'Sel000(hWndMDI,21, 0, "", "" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���������, ��������� �� ������ (�˲���-����) ********** ');
          --  ��������� ������� �������� ���������, ��������� �� ������ (�˲���-����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������, ��������� �� ������ (�˲���-����)',
                                                  p_funcname => 'Sel000(hWndMDI,4,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S/������� CUSTCOUNT ��� �˲���-���� (SBB) ********** ');
          --  ��������� ������� S/������� CUSTCOUNT ��� �˲���-���� (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/������� CUSTCOUNT ��� �˲���-���� (SBB)',
                                                  p_funcname => 'Sel000(hWndMDI,8,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� �� ��. ������� (������ ������) ********** ');
          --  ��������� ������� �������� ���� �� ��. ������� (������ ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� �� ��. ������� (������ ������)',
                                                  p_funcname => 'Sel001( hWndMDI, 0, 16, "", "" )',
                                                  p_rolename => 'ELT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� �� ��. ������� (����� ����������) ********** ');
          --  ��������� ������� �������� ���� �� ��. ������� (����� ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� �� ��. ������� (����� ����������)',
                                                  p_funcname => 'Sel001( hWndMDI, 1, 16, "","" )',
                                                  p_rolename => 'ELT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� �볺��� (����������� � �����) ********** ');
          --  ��������� ������� ����� �볺��� (����������� � �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� �볺��� (����������� � �����)',
                                                  p_funcname => 'Sel001( hWndMDI, 114, 0, "", "" )',
                                                  p_rolename => 'AN_KL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� �� ��. ������� (����� �������� ********** ');
          --  ��������� ������� �������� ���� �� ��. ������� (����� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� �� ��. ������� (����� ��������',
                                                  p_funcname => 'Sel001( hWndMDI, 3, 99, "", "" )',
                                                  p_rolename => 'ELT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� �� ��   ********** ');
          --  ��������� ������� ����� �� ��  
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� �� ��  ',
                                                  p_funcname => 'Sel002(hWndMDI,0,0,"0111", "  and a.ACC not in (Select ACC from RKO_3570)")',
                                                  p_rolename => 'RKO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� �� ��  (����� �����. �� 3570) ********** ');
          --  ��������� ������� ����� �� ��  (����� �����. �� 3570)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� �� ��  (����� �����. �� 3570)',
                                                  p_funcname => 'Sel002(hWndMDI,0,0,''0101'', " and  a.ACC  in (select ACC from RKO_3570) ")',
                                                  p_rolename => 'RKO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� STO: ����������� ���������� ������i� (�Ѳ ��.) ********** ');
          --  ��������� ������� STO: ����������� ���������� ������i� (�Ѳ ��.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'STO: ����������� ���������� ������i� (�Ѳ ��.)',
                                                  p_funcname => 'Sel002(hWndMDI,1,0," "," ")',
                                                  p_rolename => 'STO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� STO: ����������� ���������� ������i� (��.3) ********** ');
          --  ��������� ������� STO: ����������� ���������� ������i� (��.3)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'STO: ����������� ���������� ������i� (��.3)',
                                                  p_funcname => 'Sel002(hWndMDI,1,3," "," ")',
                                                  p_rolename => 'STO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� STO: ����������� ���������� ������i� (��.4) ********** ');
          --  ��������� ������� STO: ����������� ���������� ������i� (��.4)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'STO: ����������� ���������� ������i� (��.4)',
                                                  p_funcname => 'Sel002(hWndMDI,1,4," "," ")',
                                                  p_rolename => 'STO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� � ���������� ********** ');
          --  ��������� ������� �������� � ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� � ����������',
                                                  p_funcname => 'Sel002(hWndMDI,13,0," ob22 not in ( ''981902'',''981903'',''981979'',''981983'', ''9819B8'') ","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ********** ');
          --  ��������� ������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������',
                                                  p_funcname => 'Sel002(hWndMDI,14,0," "," ")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������. �������������� ����� �� ������i� ********** ');
          --  ��������� ������� �������. �������������� ����� �� ������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������. �������������� ����� �� ������i�',
                                                  p_funcname => 'Sel002(hWndMDI,15,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� STO: ��������� ���������� ������i� ********** ');
          --  ��������� ������� STO: ��������� ���������� ������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'STO: ��������� ���������� ������i�',
                                                  p_funcname => 'Sel002(hWndMDI,2,0," "," ")',
                                                  p_rolename => 'STO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU0 ���� ���������� �������� ��.��� ********** ');
          --  ��������� ������� DPU0 ���� ���������� �������� ��.���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU0 ���� ���������� �������� ��.���',
                                                  p_funcname => 'Sel006(hWndForm,0,0,''''," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. ����� ���������� �������� �� ********** ');
          --  ��������� ������� DPU. ����� ���������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. ����� ���������� �������� ��',
                                                  p_funcname => 'Sel006(hWndForm,4,0,''''," ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. ���������� �������� �� ********** ');
          --  ��������� ������� DPU. ���������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. ���������� �������� ��',
                                                  p_funcname => 'Sel006(hWndForm,5,0,''''," ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. ��������� ���������� �� ��������� �������� �� ********** ');
          --  ��������� ������� DPU. ��������� ���������� �� ��������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. ��������� ���������� �� ��������� �������� ��',
                                                  p_funcname => 'Sel006(hWndForm,6,0,''NL9''," ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. ������ � ���������� �� ********** ');
          --  ��������� ������� DPU. ������ � ���������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. ������ � ���������� ��',
                                                  p_funcname => 'Sel006(hWndMDI,1,30,"11",'''')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������� ��������Ҳ� (����� ��������) ********** ');
          --  ��������� ������� OVR:  �������� ��������Ҳ� (����� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������� ��������Ҳ� (����� ��������)',
                                                  p_funcname => 'Sel009(hWndMDI,0,0,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������� ��������Ҳ� (���������) ********** ');
          --  ��������� ������� OVR:  �������� ��������Ҳ� (���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������� ��������Ҳ� (���������)',
                                                  p_funcname => 'Sel009(hWndMDI,0,2,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������� ��������Ҳ� (���������, ���������) ********** ');
          --  ��������� ������� OVR:  �������� ��������Ҳ� (���������, ���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������� ��������Ҳ� (���������, ���������)',
                                                  p_funcname => 'Sel009(hWndMDI,0,5,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������� ��������Ҳ�  (��) ********** ');
          --  ��������� ������� OVR:  �������� ��������Ҳ�  (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������� ��������Ҳ�  (��)',
                                                  p_funcname => 'Sel009(hWndMDI,0,7,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� % �� ������� 2560, 2600-2650 ********** ');
          --  ��������� ������� ������������� % �� ������� 2560, 2600-2650
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� % �� ������� 2560, 2600-2650',
                                                  p_funcname => 'Sel010( hWndMDI, 1, 1,  " and s.NBS in (''2560'',''2565'')  and  i.ID=1 and  i.NLSB is not null ", "1" ) ',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� % �� ������� 3902,3903 ********** ');
          --  ��������� ������� ������������� % �� ������� 3902,3903
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� % �� ������� 3902,3903',
                                                  p_funcname => 'Sel010( hWndMDI, 1, 1,  " and s.NBS in (''3902'',''3903'') and i.NLSB is not null ", "1" ) ',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� % �� �������  3902,3903 ********** ');
          --  ��������� ������� ����������� % �� �������  3902,3903
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� % �� �������  3902,3903',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and  s.NBS in (''3902'', ''3903'')  ", ''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� %  ��  2635 ��� ********** ');
          --  ��������� ������� ����������� %  ��  2635 ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� %  ��  2635 ���',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and  s.NBS=''2635''  and  s.NMS like ''%���%''  and  i.ID=1 ", ''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� % �� �������� ���������i� (2600,2067,3600) ********** ');
          --  ��������� ������� ����������� % �� �������� ���������i� (2600,2067,3600)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� % �� �������� ���������i� (2600,2067,3600)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and (s.ACC in (Select ACCO from ACC_OVER) or s.ACC in (Select ACC_3600 from ACC_OVER) or s.ACC in (Select ACC_9129 from ACC_OVER)) and not (s.NBS=''2600'' and i.ID=1)", ''SA'')',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� % �� �������� ���������i� (2600,2067,3600) ********** ');
          --  ��������� ������� ����������� % �� �������� ���������i� (2600,2067,3600)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� % �� �������� ���������i� (2600,2067,3600)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and (s.ACC in (Select ACCO from ACC_OVER) or s.ACC in (Select ACC_3600 from ACC_OVER) or s.ACC in (Select ACC_9129 from ACC_OVER)) and not (s.NBS=''2600'' and i.ID=1)", ''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.����������� % �� �������  2560-2600-2650 ********** ');
          --  ��������� ������� 1.����������� % �� �������  2560-2600-2650
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.����������� % �� �������  2560-2600-2650',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," AND (s.NBS in (''2560'',''2565'',''2600'',''2603'',''2604'',''2650'') or s.NBS=''2620'' and s.ACC in (select ACC from Specparam_INT where OB22=''07'') ) AND s.ACC not in (Select ACC from DPU_DEAL) AND i.ID=1",''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F12: ���i����� ����������� %% �� ��� ���. � �� �� ********** ');
          --  ��������� ������� �� F12: ���i����� ����������� %% �� ��� ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F12: ���i����� ����������� %% �� ��� ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (1,2,3))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #5) �� F13: ���i����� ����������� %% �� ��� ���. � �� �� ********** ');
          --  ��������� ������� #5) �� F13: ���i����� ����������� %% �� ��� ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#5) �� F13: ���i����� ����������� %% �� ��� ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (11,12,13))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S52: ����������� %%  �� ������������ ���. � �� �� ********** ');
          --  ��������� ������� �� S52: ����������� %%  �� ������������ ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S52: ����������� %%  �� ������������ ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SP '') and i.acra is not null and i.acrb is not null",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S42: ����������� %%  �� �������� �����. ����� � �� �� ********** ');
          --  ��������� ������� �� S42: ����������� %%  �� �������� �����. ����� � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S42: ����������� %%  �� �������� �����. ����� � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SS '',''SP '') and i.acra is not null and i.acrb is not null and exists (select 1 from cc_lim where acc=s.accc and fdat=gl.bd  and sumo>0 and not_sn is null)",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S53: ����������� %%  �� ������������ ���. � �� �� ********** ');
          --  ��������� ������� �� S53: ����������� %%  �� ������������ ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S53: ����������� %%  �� ������������ ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''22%'' and s.tip in (''SP '') and i.acra is not null and i.acrb is not null",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F40: ����������� ���� �� 9129 � �� �� ********** ');
          --  ��������� ������� �� F40: ����������� ���� �� 9129 � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F40: ����������� ���� �� 9129 � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''9129%'' and s.tip in (''CR9'') and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc n,cc_deal d where n.nd=d.nd and d.vidd in (1,2,3) and n.acc=s.acc)",''A'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F40: ����������� ���� �� 9129 � �� �� ********** ');
          --  ��������� ������� �� F40: ����������� ���� �� 9129 � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F40: ����������� ���� �� 9129 � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''9129%'' and s.tip in (''CR9'') and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc n,cc_deal d where n.nd=d.nd and d.vidd in (11,12,13) and n.acc=s.acc)",''A'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #3) �� S43: ����������� %% �� ��. ����� � �� �� (��ӯ���) ********** ');
          --  ��������� ������� #3) �� S43: ����������� %% �� ��. ����� � �� �� (��ӯ���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#3) �� S43: ����������� %% �� ��. ����� � �� �� (��ӯ���)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.tip in(''SS '',''SP '')  and s.acc in (select N.acc from nd_acc n, cc_v d  where d.GPK=4 and n.nd=d.nd and d.vidd=11  and cck.PAY_GPK(gl.bd,D.ND,null)=1)","SAN")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F23: ���i����� ����������� ���񳿿 �� ��. ********** ');
          --  ��������� ������� �� F23: ���i����� ����������� ���񳿿 �� ��.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F23: ���i����� ����������� ���񳿿 �� ��.',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=2 and i.metr in (95,96,97,98) and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc nn,cc_deal dd where nn.nd=dd.nd and dd.vidd in (11,12,13) and nn.acc=s.acc) ",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���񳿿 �� �� ********** ');
          --  ��������� ������� ����������� ���񳿿 �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���񳿿 �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.METR>90 and i.acra is not null and i.acrb is not null","SA")',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S62: ����������� ���i  � �� �� ********** ');
          --  ��������� ������� �� S62: ����������� ���i  � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S62: ����������� ���i  � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''20%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs2 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S63: ����������� ���i  � �� �� ********** ');
          --  ��������� ������� �� S63: ����������� ���i  � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S63: ����������� ���i  � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''22%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs1 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� % (��������) ********** ');
          --  ��������� ������� ����������� % (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� % (��������)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,'''',''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����������� ���i����i� ���i�i� �� �� ********** ');
          --  ��������� ������� ��: ����������� ���i����i� ���i�i� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����������� ���i����i� ���i�i� �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,''and i.metr>90'',''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ������� % ������ ********** ');
          --  ��������� ������� ������ ��� ������� % ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ������� % ������',
                                                  p_funcname => 'Sel010(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� �� ********** ');
          --  ��������� ������� �������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ��',
                                                  p_funcname => 'Sel011(hWndMDI,0,1,'''','''')',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ********** ');
          --  ��������� ������� �������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������',
                                                  p_funcname => 'Sel011(hWndMDI,2,1,'''','''')',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ������������ ���� ������ ��������� ********** ');
          --  ��������� ������� ���. ������������ ���� ������ ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ������������ ���� ������ ���������',
                                                  p_funcname => 'Sel014( hWndMDI, 9, 1, '''' ,'''')',
                                                  p_rolename => 'SETLIM01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. �������� ��������� ��� (��������) ********** ');
          --  ��������� ������� ���. �������� ��������� ��� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. �������� ��������� ��� (��������)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"00",'''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ���������  (���������� ̳�����) ********** ');
          --  ��������� ������� ���. ���������� ���������  (���������� ̳�����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ���������  (���������� ̳�����)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11","arc_rrp.BLK =11")',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ���������  (�Ѳ) ********** ');
          --  ��������� ������� ���. ���������� ���������  (�Ѳ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ���������  (�Ѳ)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",'''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ���������  (BLK=2) ********** ');
          --  ��������� ������� ���. ���������� ���������  (BLK=2)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ���������  (BLK=2)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",''arc_rrp.BLK=2'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ���������  (BLK=3)  ********** ');
          --  ��������� ������� ���. ���������� ���������  (BLK=3) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ���������  (BLK=3) ',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",''arc_rrp.BLK=3'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ���������  (BLK=4) ********** ');
          --  ��������� ������� ���. ���������� ���������  (BLK=4)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ���������  (BLK=4)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",''arc_rrp.BLK=4'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ��������� � ���������� ����� �����������, �� �� ������� ********** ');
          --  ��������� ������� ���. ��������� � ���������� ����� �����������, �� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ��������� � ���������� ����� �����������, �� �� �������',
                                                  p_funcname => 'Sel014(hWndMDI,11,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³����� ��� ********** ');
          --  ��������� ������� ³����� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³����� ���',
                                                  p_funcname => 'Sel014(hWndMDI,12,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� 3720  (���) ********** ');
          --  ��������� ������� ���. ����� 3720  (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� 3720  (���)',
                                                  p_funcname => 'Sel014(hWndMDI,2,0,'''',''a.kv<>980'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� 3720  (���) ********** ');
          --  ��������� ������� ���. ����� 3720  (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� 3720  (���)',
                                                  p_funcname => 'Sel014(hWndMDI,2,0,'''',''a.kv=980'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ������� ���-�  �� ���.  . . . ? . . . ********** ');
          --  ��������� ������� ���. ������� ���-�  �� ���.  . . . ? . . .
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ������� ���-�  �� ���.  . . . ? . . .',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''', " mfoa<>:TZ.sBankMfo   AND  accounts.NLS='' . . . ?  . . . '' ")',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� � ���.�i��i����� ********** ');
          --  ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� � ���.�i��i�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������i i��-�i: ������ �� ����.����.�� �������� � ���.�i��i�����',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',"mfoA<>:TZ.sBankMfo  AND  (accounts.TOBO=tobopack.GetTobo  or  length(tobopack.GetTobo)=8 and accounts.TOBO like ''%000000%'')")',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� ������ ����� ********** ');
          --  ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� ������ �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������i i��-�i: ������ �� ����.����.�� �������� ������ �����',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',''mfoA<>:TZ.sBankMfo  AND mfoB=:TZ.sBankMfo'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� � ���.�i��i�.i �i���� ********** ');
          --  ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� � ���.�i��i�.i �i����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������i i��-�i: ������ �� ����.����.�� �������� � ���.�i��i�.i �i����',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',''mfoa<>:TZ.sBankMfo  AND tobopack.GetTobo=substr(accounts.tobo,1,length(tobopack.GetTobo))'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ��� ����� (��������) ********** ');
          --  ��������� ������� ���. ���������� ��� ����� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ��� ����� (��������)',
                                                  p_funcname => 'Sel014(hWndMDI,5,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ��� ����� ********** ');
          --  ��������� ������� ���. ���������� ��� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ��� �����',
                                                  p_funcname => 'Sel014(hWndMDI,5,1,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���� ����������/�����������(3-� ������) ********** ');
          --  ��������� ������� ������������� ���� ����������/�����������(3-� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���� ����������/�����������(3-� ������)',
                                                  p_funcname => 'Sel015(hWndMDI,0,0,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.���������� � ������ ********** ');
          --  ��������� ������� 1.���������� � ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.���������� � ������',
                                                  p_funcname => 'Sel015(hWndMDI,1,1,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.���������� 2902-2600 ********** ');
          --  ��������� ������� 1.���������� 2902-2600
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.���������� 2902-2600',
                                                  p_funcname => 'Sel015(hWndMDI,1,2, ''S'',''a.isp=''||Str(GetUserId()) )',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.��������� ����-���� ���� ����������/����������� ********** ');
          --  ��������� ������� 1.��������� ����-���� ���� ����������/�����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.��������� ����-���� ���� ����������/�����������',
                                                  p_funcname => 'Sel015(hWndMDI,11,0,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� ��������� ����� ********** ');
          --  ��������� ������� ���������� ������� ��������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� ��������� �����',
                                                  p_funcname => 'Sel015(hWndMDI,11,1,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� �� ��������� ********** ');
          --  ��������� ������� ���������� ������� �� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� �� ���������',
                                                  p_funcname => 'Sel015(hWndMDI,11,10,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� � ����� �� ������������� ����� ********** ');
          --  ��������� ������� ���������� ������� � ����� �� ������������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� � ����� �� ������������� �����',
                                                  p_funcname => 'Sel015(hWndMDI,11,3,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� �� г��������� ********** ');
          --  ��������� ������� ���������� ������� �� г���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� �� г���������',
                                                  p_funcname => 'Sel015(hWndMDI,11,4,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������  ��� ��� ���� "������" ********** ');
          --  ��������� ������� ���������� �������  ��� ��� ���� "������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������  ��� ��� ���� "������"',
                                                  p_funcname => 'Sel015(hWndMDI,11,5028,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������  "�����" ********** ');
          --  ��������� ������� ���������� �������  "�����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������  "�����"',
                                                  p_funcname => 'Sel015(hWndMDI,11,6,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� �� �� "���.�������-�������� �������" ********** ');
          --  ��������� ������� ���������� ������� �� �� "���.�������-�������� �������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� �� �� "���.�������-�������� �������"',
                                                  p_funcname => 'Sel015(hWndMDI,11,7,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� �� �� "��������" ********** ');
          --  ��������� ������� ���������� ������� �� �� "��������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� �� �� "��������"',
                                                  p_funcname => 'Sel015(hWndMDI,11,8488,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���� ����������/�����������(2-� ������) ********** ');
          --  ��������� ������� ������������� ���� ����������/�����������(2-� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���� ����������/�����������(2-� ������)',
                                                  p_funcname => 'Sel015(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���� ����������/�����������(� SPS) ********** ');
          --  ��������� ������� ������������� ���� ����������/�����������(� SPS)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���� ����������/�����������(� SPS)',
                                                  p_funcname => 'Sel015(hWndMDI,2,1,"1","")',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� � ����� ��.������ 46 ********** ');
          --  ��������� ������� ���������� ������� � ����� ��.������ 46
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� � ����� ��.������ 46',
                                                  p_funcname => 'Sel015(hWndMDI,3,0,"","")',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ����������: ����������� ********** ');
          --  ��������� ������� ����� ����������: �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ����������: �����������',
                                                  p_funcname => 'Sel015(hWndMDI,4,1,''1'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������. ���������-����������� ********** ');
          --  ��������� ������� ������. ���������-�����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������. ���������-�����������',
                                                  p_funcname => 'Sel016(hWndMDI,1,12,"DP1DP4","DP5DP6 ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT2 ���������� �������� �������� ��� ********** ');
          --  ��������� ������� DPT2 ���������� �������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT2 ���������� �������� �������� ���',
                                                  p_funcname => 'Sel016f(hWndMDI,0,0,""," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� REQ2 �������� �������� ���� �� ����� ������ ********** ');
          --  ��������� ������� REQ2 �������� �������� ���� �� ����� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ2 �������� �������� ���� �� ����� ������',
                                                  p_funcname => 'Sel016f(hWndMDI,13,0,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ���� �� ����� ���������� �������� ********** ');
          --  ��������� ������� ������� ���� �� ����� ���������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ���� �� ����� ���������� ��������',
                                                  p_funcname => 'Sel016f(hWndMDI,13,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� REQ1 ������� ������ �� ��������� ���� ********** ');
          --  ��������� ������� REQ1 ������� ������ �� ��������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ1 ������� ������ �� ��������� ����',
                                                  p_funcname => 'Sel016f(hWndMDI,14,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� REQ3 ������� ������ �� ����� ���� �� ���������� ���.���� ********** ');
          --  ��������� ������� REQ3 ������� ������ �� ����� ���� �� ���������� ���.����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ3 ������� ������ �� ����� ���� �� ���������� ���.����',
                                                  p_funcname => 'Sel016f(hWndMDI,15,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� REQ6 �������� ������ �� ���� ������.������ �� ��������� ********** ');
          --  ��������� ������� REQ6 �������� ������ �� ���� ������.������ �� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ6 �������� ������ �� ���� ������.������ �� ���������',
                                                  p_funcname => 'Sel016f(hWndMDI,16,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� REQ4 ���������� ���.������ �� ���� ������.������ �� ��������� ********** ');
          --  ��������� ������� REQ4 ���������� ���.������ �� ���� ������.������ �� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ4 ���������� ���.������ �� ���� ������.������ �� ���������',
                                                  p_funcname => 'Sel016f(hWndMDI,17,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� REQ5 ���������� ����.������ �� ���� ������.������ �� ��������� ********** ');
          --  ��������� ������� REQ5 ���������� ����.������ �� ���� ������.������ �� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ5 ���������� ����.������ �� ���� ������.������ �� ���������',
                                                  p_funcname => 'Sel016f(hWndMDI,18,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT0 ���� �������� �������� ��� ********** ');
          --  ��������� ������� DPT0 ���� �������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 ���� �������� �������� ���',
                                                  p_funcname => 'Sel016f(hWndMDI,2,1,""," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������. ����� �������� �� �� ������� ********** ');
          --  ��������� ������� ������. ����� �������� �� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������. ����� �������� �� �� �������',
                                                  p_funcname => 'Sel016f(hWndMDI,6,0,"v_dpt_portfolio_access"," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT1 ����� �������� �������� ��� ********** ');
          --  ��������� ������� DPT1 ����� �������� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT1 ����� �������� �������� ���',
                                                  p_funcname => 'Sel016f(hWndMDI,6,0,"v_dpt_s"," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT0 ��������� ������ ������ ********** ');
          --  ��������� ������� DPT0 ��������� ������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 ��������� ������ ������',
                                                  p_funcname => 'Sel016f(hWndMDI,8,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����� ********** ');
          --  ��������� ������� �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �����',
                                                  p_funcname => 'Sel022(hWndMDI,1,4,"","")',
                                                  p_rolename => 'DEP_SKRN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����� (��������) ********** ');
          --  ��������� ������� �������� ����� (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����� (��������)',
                                                  p_funcname => 'Sel022(hWndMDI,1,4,"1","/333368/")',
                                                  p_rolename => 'DEP_SKRN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� NL3 ��������� "����������� ���.���� ��������" ********** ');
          --  ��������� ������� NL3 ��������� "����������� ���.���� ��������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NL3 ��������� "����������� ���.���� ��������"',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NL3","004")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ���������� �� ����. ���������� ������� 2909 (��� NL9) ********** ');
          --  ��������� ������� ��������� ���������� �� ����. ���������� ������� 2909 (��� NL9)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ���������� �� ����. ���������� ������� 2909 (��� NL9)',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NL9","024")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� NLA ���������  "����������� ���.����" ********** ');
          --  ��������� ������� NLA ���������  "����������� ���.����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NLA ���������  "����������� ���.����"',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NLA","TOS")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� NLP ��������� "����������� ���.���� �� ���������"  ********** ');
          --  ��������� ������� NLP ��������� "����������� ���.���� �� ���������" 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NLP ��������� "����������� ���.���� �� ���������" ',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NLP","TOS")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ��������� ������� �������� ********** ');
          --  ��������� ������� ��. ��������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ��������� ������� ��������',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,''NLS'',''PKL'')',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU. ��������� ���������� �� �������-���.����� �������� �� ********** ');
          --  ��������� ������� DPU. ��������� ���������� �� �������-���.����� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. ��������� ���������� �� �������-���.����� �������� ��',
                                                  p_funcname => 'Sel022(hWndMDI,14,0,"NL8","DU0")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� �� ������� ********** ');
          --  ��������� ������� ��������� ������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� �� �������',
                                                  p_funcname => 'Sel025( hWndMDI,297, 0, "CCK", "KK2" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����� ��ϲ�˲-������� USD, EUR, RUB � ���� ********** ');
          --  ��������� ������� ��������� ����� ��ϲ�˲-������� USD, EUR, RUB � ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����� ��ϲ�˲-������� USD, EUR, RUB � ����',
                                                  p_funcname => 'Sel025( hWndMDI,96, 0, " ", "0" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����� ��ϲ�˲-������� USD, EUR, RUB � ���� ********** ');
          --  ��������� ������� �������� ����� ��ϲ�˲-������� USD, EUR, RUB � ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����� ��ϲ�˲-������� USD, EUR, RUB � ����',
                                                  p_funcname => 'Sel025( hWndMDI,96, 1, " ", "0" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����/�����. �������������� ������� 96-98(P1P,P1M) ********** ');
          --  ��������� ������� �������� ����/�����. �������������� ������� 96-98(P1P,P1M)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����/�����. �������������� ������� 96-98(P1P,P1M)',
                                                  p_funcname => 'Sel025( hWndMDI,98, 0, "P1P", "P1M" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������� �������� ********** ');
          --  ��������� ������� ����������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������� ��������',
                                                  p_funcname => 'Sel028(hWndMDI, 0, 1, "/", "")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ �������� ����� �����/������� ����� �������� ����� ********** ');
          --  ��������� ������� ������������ �������� ����� �����/������� ����� �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �������� ����� �����/������� ����� �������� �����',
                                                  p_funcname => 'Sel028(hWndMDI,1,1,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� ������� ********** ');
          --  ��������� ������� ��������� ������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� �������',
                                                  p_funcname => 'Sel028(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: ����� ���i�� ********** ');
          --  ��������� ������� ����: ����� ���i��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: ����� ���i��',
                                                  p_funcname => 'Sel029(hWndMDI,0,0,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: ��������� ����� ********** ');
          --  ��������� ������� ����: ��������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: ��������� �����',
                                                  p_funcname => 'Sel029(hWndMDI,1,0,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: ��������� ����� ������� ********** ');
          --  ��������� ������� ����: ��������� ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: ��������� ����� �������',
                                                  p_funcname => 'Sel029(hWndMDI,10,1,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: ���������� ������ ********** ');
          --  ��������� ������� ����: ���������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: ���������� ������',
                                                  p_funcname => 'Sel029(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: ORA STREAMS: ���i����� ********** ');
          --  ��������� ������� ����: ORA STREAMS: ���i�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: ORA STREAMS: ���i�����',
                                                  p_funcname => 'Sel029(hWndMDI,3,1,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: ORA STREAMS: �i�������� ********** ');
          --  ��������� ������� ����: ORA STREAMS: �i��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: ORA STREAMS: �i��������',
                                                  p_funcname => 'Sel029(hWndMDI,3,2,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: ORA STREAMS: ���i������ ********** ');
          --  ��������� ������� ����: ORA STREAMS: ���i������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: ORA STREAMS: ���i������',
                                                  p_funcname => 'Sel029(hWndMDI,3,3,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: ORA STREAMS: ������� ********** ');
          --  ��������� ������� ����: ORA STREAMS: �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: ORA STREAMS: �������',
                                                  p_funcname => 'Sel029(hWndMDI,3,4,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: �������i���� ����� ********** ');
          --  ��������� ������� ����: �������i���� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: �������i���� �����',
                                                  p_funcname => 'Sel029(hWndMDI,9,1,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: �������i���i� �� ���������� ********** ');
          --  ��������� ������� ����: �������i���i� �� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: �������i���i� �� ����������',
                                                  p_funcname => 'Sel029(hWndMDI,9,2,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: �������i���i� ������� ********** ');
          --  ��������� ������� ����: �������i���i� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: �������i���i� �������',
                                                  p_funcname => 'Sel029(hWndMDI,9,3,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-1. ����� �i����i�����i ���-��� ********** ');
          --  ��������� ������� ANI-1. ����� �i����i�����i ���-���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-1. ����� �i����i�����i ���-���',
                                                  p_funcname => 'Sel030(hWndMDI,1,700,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-10. ����� �i����i�����i ����.���-��� ********** ');
          --  ��������� ������� ANI-10. ����� �i����i�����i ����.���-���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-10. ����� �i����i�����i ����.���-���',
                                                  p_funcname => 'Sel030(hWndMDI,1,800,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����i� ������� �� ���i�� ********** ');
          --  ��������� ������� ����i� ������� �� ���i��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����i� ������� �� ���i��',
                                                  p_funcname => 'Sel030(hWndMDI,22,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI   - ������ ********** ');
          --  ��������� ������� ANI   - ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI   - ������',
                                                  p_funcname => 'Sel030(hWndMDI,3,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-31. ������������ �� �������� ������.�i� �� ����.���,��� ********** ');
          --  ��������� ������� ANI-31. ������������ �� �������� ������.�i� �� ����.���,���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-31. ������������ �� �������� ������.�i� �� ����.���,���',
                                                  p_funcname => 'Sel030(hWndMDI,31,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-32. ��������i��� ����.���-��� �� ���. �� ������. �i�i ********** ');
          --  ��������� ������� ANI-32. ��������i��� ����.���-��� �� ���. �� ������. �i�i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32. ��������i��� ����.���-��� �� ���. �� ������. �i�i',
                                                  p_funcname => 'Sel030(hWndMDI,32,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-32n. ��������i��� ����.���-��� �� ���. �� ������. �i�i ********** ');
          --  ��������� ������� ANI-32n. ��������i��� ����.���-��� �� ���. �� ������. �i�i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32n. ��������i��� ����.���-��� �� ���. �� ������. �i�i',
                                                  p_funcname => 'Sel030(hWndMDI,32,1,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-������ � �������i ��������i� (�/� 6-7 ��) ********** ');
          --  ��������� ������� ��-������ � �������i ��������i� (�/� 6-7 ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-������ � �������i ��������i� (�/� 6-7 ��)',
                                                  p_funcname => 'Sel030(hWndMDI,4,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-5. ����������i� ������i� (SNAP) ********** ');
          --  ��������� ������� ANI-5. ����������i� ������i� (SNAP)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-5. ����������i� ������i� (SNAP)',
                                                  p_funcname => 'Sel030(hWndMDI,5,7,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-6.Var-����i� ********** ');
          --  ��������� ������� ANI-6.Var-����i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-6.Var-����i�',
                                                  p_funcname => 'Sel030(hWndMDI,6,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ANI-7. ���������� �� ���.�������� ********** ');
          --  ��������� ������� ANI-7. ���������� �� ���.��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-7. ���������� �� ���.��������',
                                                  p_funcname => 'Sel030(hWndMDI,7,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ����������� ������� ********** ');
          --  ��������� ������� ������������� ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ����������� �������',
                                                  p_funcname => 'Sel031(hWndMDI,0,0,"","")',
                                                  p_rolename => 'R_KP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ����������� ������� ********** ');
          --  ��������� ������� �������� ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ����������� �������',
                                                  p_funcname => 'Sel031(hWndMDI,297,0,"","")',
                                                  p_rolename => 'R_KP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����� ********** ');
          --  ��������� ������� ��������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �����',
                                                  p_funcname => 'Sel033(hWndMDI,0,0,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ����� ********** ');
          --  ��������� ������� ����������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �����',
                                                  p_funcname => 'Sel037(hWndMDI,0,0,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����-(��)�i���.�i���� ���.��� 1-�� ������ ********** ');
          --  ��������� ������� ����-(��)�i���.�i���� ���.��� 1-�� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����-(��)�i���.�i���� ���.��� 1-�� ������',
                                                  p_funcname => 'Sel040( hWndMDI, 21, 0 , "" ,"" )',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���������� ����.�����. OB22 ********** ');
          --  ��������� ������� �������� ���������� ����.�����. OB22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������� ����.�����. OB22',
                                                  p_funcname => 'Sel040( hWndMDI, 22, 0 , "" ,"" )',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ �������� ����� ��� (S_UCH.DBF) ********** ');
          --  ��������� ������� ������������ �������� ����� ��� (S_UCH.DBF)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �������� ����� ��� (S_UCH.DBF)',
                                                  p_funcname => 'Selector(hWndMDI,1)',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��� ������� ********** ');
          --  ��������� ������� �������� ��� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��� �������',
                                                  p_funcname => 'ShowAllAccounts(hWndMDI)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������ ********** ');
          --  ��������� ������� ������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������',
                                                  p_funcname => 'ShowAttendance(0)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������������ ********** ');
          --  ��������� ������� ������ ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������������',
                                                  p_funcname => 'ShowBAXTA(hWndMDI, TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��������� �������  (����� - ������) ********** ');
          --  ��������� ������� ����� ��������� �������  (����� - ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������� �������  (����� - ������)',
                                                  p_funcname => 'ShowBal(hWndMDI, 1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ODB. ������� ���������� ���� ********** ');
          --  ��������� ������� ODB. ������� ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ODB. ������� ���������� ����',
                                                  p_funcname => 'ShowCloseBankDay()',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������ ����� ********** ');
          --  ��������� ������� ��. ������ �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������ �����',
                                                  p_funcname => 'ShowCustomers(ACCESS_READONLY , 1)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� �볺��� � ������ �������  (��������) ********** ');
          --  ��������� ������� �������� �������� �볺��� � ������ �������  (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� �볺��� � ������ �������  (��������)',
                                                  p_funcname => 'ShowCustomers(ACCESS_READONLY, 3)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � �������  (��������) ********** ');
          --  ��������� ������� ��������� �볺��� � �������  (��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � �������  (��������)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,0,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � ������� (��) ********** ');
          --  ��������� ������� ��������� �볺��� � ������� (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � ������� (��)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,2,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �볺��� � ������� (��) ********** ');
          --  ��������� ������� ��������� �볺��� � ������� (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �볺��� � ������� (��)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,3,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������� ����� � ������� ********** ');
          --  ��������� ������� ����� ������� ����� � �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������� ����� � �������',
                                                  p_funcname => 'ShowDin(hWndMDI)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������/������������ �������� ********** ');
          --  ��������� ������� ���. ���������/������������ ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������/������������ ��������',
                                                  p_funcname => 'ShowDirection()',
                                                  p_rolename => 'TECH007' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �������� ����� ********** ');
          --  ��������� ������� ������� �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �������� �����',
                                                  p_funcname => 'ShowFilesInt(hWndMDI)',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������� @F ********** ');
          --  ��������� ������� ����� ������� @F
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������� @F',
                                                  p_funcname => 'ShowFilesNIByID(hWndMDI,''@F,@K'')',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� � ��� ********** ');
          --  ��������� ������� ������� � ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� � ���',
                                                  p_funcname => 'ShowFilesNbu(hWndMDI) ',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� �� ������� ********** ');
          --  ��������� ������� �������� ������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� �� �������',
                                                  p_funcname => 'ShowGroups(hWndMDI,0)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� �� ������� ( 3 ������) ********** ');
          --  ��������� ������� ������������ ������� �� ������� ( 3 ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� �� ������� ( 3 ������)',
                                                  p_funcname => 'ShowGroups(hWndMDI,1)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� �� �������  ********** ');
          --  ��������� ������� ������������ ������� �� ������� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� �� ������� ',
                                                  p_funcname => 'ShowGroups(hWndMDI,3)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ����� ������������ -> ����� ������� ] ********** ');
          --  ��������� ������� ������������ ������� [ ����� ������������ -> ����� ������� ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ����� ������������ -> ����� ������� ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,4)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ] ********** ');
          --  ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ����� ������� -> ����� ������������ ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,5)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ������� -> ����� ������� ] ********** ');
          --  ��������� ������� ������������ ������� [ ������� -> ����� ������� ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ������� -> ����� ������� ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,6)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������  ����  == > ��� ����-98 ********** ');
          --  ��������� ������� ������  ����  == > ��� ����-98
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������  ����  == > ��� ����-98',
                                                  p_funcname => 'ShowImportData()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.����²����Ͳ ���������-2 ********** ');
          --  ��������� ������� 1.����²����Ͳ ���������-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.����²����Ͳ ���������-2',
                                                  p_funcname => 'ShowNotPayDok(0)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.����²����Ͳ ��������� ********** ');
          --  ��������� ������� 1.����²����Ͳ ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.����²����Ͳ ���������',
                                                  p_funcname => 'ShowNotPayDok(1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ODB. ³������ ���������� ���� ********** ');
          --  ��������� ������� ODB. ³������ ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ODB. ³������ ���������� ����',
                                                  p_funcname => 'ShowOpenBankDay()',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������� ********** ');
          --  ��������� ������� ����������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������',
                                                  p_funcname => 'ShowOperEditor( hWndMDI, 9)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� ********** ');
          --  ��������� ������� ���� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ����',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -1)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������, �� �������������� ********** ');
          --  ��������� ������� ����������� �������, �� ��������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������, �� ��������������',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 1 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������������� ������(����) ********** ');
          --  ��������� ������� ����������� �������������� ������(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������������� ������(����)',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 3 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������������� ������� �������� ********** ');
          --  ��������� ������� ���������� �������������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������������� ������� ��������',
                                                  p_funcname => 'ShowRef(hWndMDI, 3,0,'''','''')',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������� ��, ���, ��� ********** ');
          --  ��������� ������� ������� ������� ��, ���, ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������� ��, ���, ���',
                                                  p_funcname => 'ShowRefCur(''RW'')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ********** ');
          --  ��������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������',
                                                  p_funcname => 'ShowRefList(hWndMDI)',
                                                  p_rolename => 'REF0000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���� � ��� ********** ');
          --  ��������� ������� ������ ���� � ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���� � ���',
                                                  p_funcname => 'ShowSecurity()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����������� ��������� ��� ********** ');
          --  ��������� ������� ���. ����������� ��������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����������� ��������� ���',
                                                  p_funcname => 'ShowSendMessage()',
                                                  p_rolename => 'TECH019' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ����� ********** ');
          --  ��������� ������� ���. ���������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� �����',
                                                  p_funcname => 'ShowSetTechFlags()',
                                                  p_rolename => 'TOSS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ������� ********** ');
          --  ��������� ������� ���. ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� �������',
                                                  p_funcname => 'ShowTechAccountsEx(0)',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ��������� ������ ����� �� S_UCH.DBF ********** ');
          --  ��������� ������� ���. ��������� ������ ����� �� S_UCH.DBF
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ��������� ������ ����� �� S_UCH.DBF',
                                                  p_funcname => 'ShowUpdateBanks()',
                                                  p_rolename => 'TECH020' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� �������� �� ������� �� ���-3900 ********** ');
          --  ��������� ������� �������� ���� �������� �� ������� �� ���-3900
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� �������� �� ������� �� ���-3900',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI, 3 )',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-�������� �� ������� ********** ');
          --  ��������� ������� ������-�������-�������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-�������� �� �������',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,189)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-�������� �������� BRANCH ********** ');
          --  ��������� ������� ������-�������-�������� �������� BRANCH
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-�������� �������� BRANCH',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,91893)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.�������� �������� ������������ ********** ');
          --  ��������� ������� 1.�������� �������� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.�������� �������� ������������',
                                                  p_funcname => 'Show_USERS(hWndMDI , FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => 'Show_USERS(hWndMDI ,TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => 'Show_USERS(hWndMDI ,TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ �����.% �� ��.%-�� ������ �� �� ********** ');
          --  ��������� ������� ������������ �����.% �� ��.%-�� ������ �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �����.% �� ��.%-�� ������ �� ��',
                                                  p_funcname => 'SqlPrepareAndExecute(hSql(),"declare r_ int; BEGIN cck.cc_irr(''IRR'',0,bankdate-1, r_);COMMIT;END;")',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �������� �� ���������� ��� ********** ');
          --  ��������� ������� ��������� �������� �� ���������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �������� �� ���������� ���',
                                                  p_funcname => 'StatBankDay()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� VEGA - ����������� ********** ');
          --  ��������� ������� VEGA - �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'VEGA - �����������',
                                                  p_funcname => 'VEGA_Sel(hWndMDI,0,0,0,'''','''')',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ ********** ');
          --  ��������� ������� ������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������',
                                                  p_funcname => 'ZAPROS(hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����. �������������� �������� ��������� ********** ');
          --  ��������� ������� �����. �������������� �������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����. �������������� �������� ���������',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''ACC%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �볺���. ����������� ������� ����� ���.���������� ********** ');
          --  ��������� ������� �볺���. ����������� ������� ����� ���.����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�볺���. ����������� ������� ����� ���.����������',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''CUST%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT0 ����������� ������� ���������� �������� ���.��� ********** ');
          --  ��������� ������� DPT0 ����������� ������� ���������� �������� ���.���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 ����������� ������� ���������� �������� ���.���',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''DPT%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPU1 ����������� ������� �������� ��.��� ********** ');
          --  ��������� ������� DPU1 ����������� ������� �������� ��.���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU1 ����������� ������� �������� ��.���',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''DPU%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������. ����������� ������� �������� ********** ');
          --  ��������� ������� �������. ����������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������. ����������� ������� ��������',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''KD%''  or id like ''CCK%''")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ������� �������� ���. ������ ********** ');
          --  ��������� ������� ���. ������� �������� ���. ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ������� �������� ���. ������',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''SKRN%'' ")',
                                                  p_rolename => 'CC_DOC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� �������� ********** ');
          --  ��������� ������� ����������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� ��������',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, "")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ���������� ���������� (������) ********** ');
          --  ��������� ������� ��. ���������� ���������� (������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ���������� ���������� (������)',
                                                  p_funcname => 's',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (ALLA) - �� �������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappALLA.sql =========*** En
PROMPT ===================================================================================== 
