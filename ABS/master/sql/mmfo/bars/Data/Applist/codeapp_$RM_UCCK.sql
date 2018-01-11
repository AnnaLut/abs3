PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_UCCK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_UCCK ***
  declare
    l_application_code varchar2(10 char) := '$RM_UCCK';
    l_application_name varchar2(300 char) := '��� <<������� ��>>';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_UCCK ��������� (��� ���������) ��� ��� <<������� ��>> ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1) �������� ������ �� �� ********** ');
          --  ��������� ������� 1) �������� ������ �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1) �������� ������ �� ��',
                                                  p_funcname => '/barsroot/CreditUi/NewCredit/?custtype=2',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���� ********** ');
          --  ��������� ������� ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ����',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_UCCK',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Start/ ����-��������� ������� ����� SS - �� ********** ');
          --  ��������� ������� Start/ ����-��������� ������� ����� SS - ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start/ ����-��������� ������� ����� SS - ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> CCK.CC_ASP ( -1,1)][QST=>�������� Start/ ����-��������� ������� ����� SS - ��?][MSG=>��������!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F0: ��������� ������� ��������� SG ********** ');
          --  ��������� ������� �� F0: ��������� ������� ��������� SG
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F0: ��������� ������� ��������� SG',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK.CC_ASG (0)][QST=>�������� "�� F0: ��������� ������� ��������� SG"?][MSG=>�������� !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S32: ����-��������� ������� �����.% SN �� ********** ');
          --  ��������� ������� �� S32: ����-��������� ������� �����.% SN ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S32: ����-��������� ������� �����.% SN ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK.CC_ASPN(2,0,1)][QST=>�� ������ �������� ��������� �� ���������� �������� �볺���?][MSG=>�������� !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������-�� �� �����. %% ����� ��� � ���� ����� �� ********** ');
          --  ��������� ������� �������-�� �� �����. %% ����� ��� � ���� ����� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������-�� �� �����. %% ����� ��� � ���� ����� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �� �� - ������ �� ����������(�� �����) ********** ');
          --  ��������� ������� ������� �� �� - ������ �� ����������(�� �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �� �� - ������ �� ����������(�� �����)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCT.StartI(0)][QST=>�� ������ �������� ��������� �� ����������(�� �����)?][MSG=>�������� !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��������/���쳿 �� ********** ');
          --  ��������� ������� ����������� ��������/���쳿 ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������/���쳿 ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(-1,bankdate,3)][QST=>�������� ����������� �������� ��?][MSG=>������!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��������/���쳿 ********** ');
          --  ��������� ������� ����������� ��������/���쳿
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������/���쳿',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(0,bankdate,3)][QST=>�������� ����������� ��������?][MSG=>������!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� (��)���������� ������ � �� ********** ');
          --  ��������� ������� �������� (��)���������� ������ � ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� (��)���������� ������ � ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>ICCK(0)][QST=>�������� �������� (��)���������� ������ � ��?][MSG=>��������!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i���������� �� 9819* ���������i� i�����������i� ********** ');
          --  ��������� ������� �i���������� �� 9819* ���������i� i�����������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i���������� �� 9819* ���������i� i�����������i�',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>ICCK(3)][QST=>�������� �i���������� �� 9819* ���������i� i�����������i�?][MSG=>��������!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� �������� ��Ͳ ********** ');
          --  ��������� ������� �������� �� �������� ��Ͳ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� �������� ��Ͳ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>PAY_SN8(2)][QST=>�� ������ �������� ��������� ���?][MSG=>�������� �������� !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S8: ���� �������� �������� �� ********** ');
          --  ��������� ������� �� S8: ���� �������� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S8: ���� �������� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cc_close(2,bankdate)][QST=>�� ������ �������� ����-�������� �������� ��?][MSG=>�������� �������� !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� �� 9129 �� �� �� ********** ');
          --  ��������� ������� ����������� ������� �� 9129 �� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� �� 9129 �� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.CC_9129(bankdate,0,2) ][QST=>�������� "����������� ������� �� 9129 �� �� ��"?][MSG=>�������� !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� OB22 � ���.�����. (���������� + ��������) ********** ');
          --  ��������� ������� ����� OB22 � ���.�����. (���������� + ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� OB22 � ���.�����. (���������� + ��������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=AUD_CCK&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i���� ��22 � ���.�����. ��+�� ********** ');
          --  ��������� ������� ���i���� ��22 � ���.�����. ��+��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i���� ��22 � ���.�����. ��+��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_OB22&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������, �� ����� ���������� �� ������� ���� ********** ');
          --  ��������� ������� �������, �� ����� ���������� �� ������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������, �� ����� ���������� �� ������� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_PROBL&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i ��� ��������������i� �� �� ********** ');
          --  ��������� ������� ���i ��� ��������������i� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i ��� ��������������i� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_RESTR_V&accessCode=0&sPar=[CONDITIONS=>CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (1,2,3))]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ - ������������ - ������� ********** ');
          --  ��������� ������� ������ - ������������ - �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ - ������������ - �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_PAWN_DP&accessCode=2',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SNO-0) ����������� �� ����������: SPN => (SNO+GPP) ********** ');
          --  ��������� ������� SNO-0) ����������� �� ����������: SPN => (SNO+GPP)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SNO-0) ����������� �� ����������: SPN => (SNO+GPP)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V0_SNO&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>V0_SNO.vidd in (1,2,3)]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SNO-1) ����������� �� ��� : SNO => GPP ********** ');
          --  ��������� ������� SNO-1) ����������� �� ��� : SNO => GPP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SNO-1) ����������� �� ��� : SNO => GPP',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V1_SNO&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>V1_SNO.vidd in (1,2,3)]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SNO-2) �������� : SNO + GPP ********** ');
          --  ��������� ������� SNO-2) �������� : SNO + GPP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SNO-2) �������� : SNO + GPP',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V2_SNO&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>V2_SNO.vidd in (1,2,3)]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ��� ������������ �� ������ ������� ********** ');
          --  ��������� ������� �������� ��������� ��� ������������ �� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� ��� ������������ �� ������ �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_DT_SS&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ������� �� �� ********** ');
          --  ��������� ������� �������� ��������� ������� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� ������� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_ERR_REL_ACC&accessCode=6&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2) �������� ����� ������� �� ********** ');
          --  ��������� ������� 2) �������� ����� ������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2) �������� ����� ������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_NU&accessCode=1&sPar=[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��������� R013 � �� �� ********** ');
          --  ��������� ������� ����� ��������� R013 � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������� R013 � �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_R013&accessCode=1&sPar=[CONDITIONS=>vidd in(1,2,3)]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3) �������� ������� ������� �� ********** ');
          --  ��������� ������� 3) �������� ������� ������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3) �������� ������� ������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_RU&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-��� �i���i��� �� ���i�� �� �� �� ********** ');
          --  ��������� ������� ��-��� �i���i��� �� ���i�� �� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-��� �i���i��� �� ���i�� �� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_SAL2&accessCode=1&sPar=[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM=��� ���� ���i��� dd_mm_yyyy>,TYPE=S),:Par2(SEM=�i� ���� ���i��� dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����������  ��������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������  ��������� ������� ����',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,324,''PER_KRM'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������, ������������� ���� �� �������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������, ������������� ���� �� �������',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_PDFO[NSIFUNCTION][PROC=>PUL.PUT(''WDAT'',to_char(:P,''dd.mm.yyyy''))][PAR=>:P(SEM=����,TYPE=D)][EXEC=>BEFORE]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� �� ��������� (��.��. ����. ���.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� �� ��������� (��.��. ����. ���.)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,77,''PER_INK_N'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������-�� �� �����. %% ����� ��� � ���� ����� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������-�� �� �����. %% ����� ��� � ���� ����� ��',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �������� ������i� �����������i� �� �� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '������ �������� ������i� �����������i� �� �� ��',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_PAY1&accessCode=1&sPar=[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM= dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� �� ������������ �������� �� ��
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���� �� ������������ �������� �� ��',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_REP&accessCode=1&sPar=[PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=���� �������,TYPE=N,REF=V_CCK_REP_LIST_YL)][NSIFUNCTION][EXEC=>BEFORE][MSG=>��������!]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_UCCK) - ��� <<������� ��>>  ');
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
umu.add_report2arm(11,'$RM_UCCK');
umu.add_report2arm(18,'$RM_UCCK');
umu.add_report2arm(27,'$RM_UCCK');
umu.add_report2arm(30,'$RM_UCCK');
umu.add_report2arm(31,'$RM_UCCK');
umu.add_report2arm(43,'$RM_UCCK');
umu.add_report2arm(61,'$RM_UCCK');
umu.add_report2arm(78,'$RM_UCCK');
umu.add_report2arm(119,'$RM_UCCK');
umu.add_report2arm(125,'$RM_UCCK');
umu.add_report2arm(173,'$RM_UCCK');
umu.add_report2arm(189,'$RM_UCCK');
umu.add_report2arm(190,'$RM_UCCK');
umu.add_report2arm(194,'$RM_UCCK');
umu.add_report2arm(218,'$RM_UCCK');
umu.add_report2arm(232,'$RM_UCCK');
umu.add_report2arm(235,'$RM_UCCK');
umu.add_report2arm(252,'$RM_UCCK');
umu.add_report2arm(261,'$RM_UCCK');
umu.add_report2arm(262,'$RM_UCCK');
umu.add_report2arm(263,'$RM_UCCK');
umu.add_report2arm(264,'$RM_UCCK');
umu.add_report2arm(265,'$RM_UCCK');
umu.add_report2arm(294,'$RM_UCCK');
umu.add_report2arm(309,'$RM_UCCK');
umu.add_report2arm(375,'$RM_UCCK');
umu.add_report2arm(415,'$RM_UCCK');
umu.add_report2arm(416,'$RM_UCCK');
umu.add_report2arm(426,'$RM_UCCK');
umu.add_report2arm(429,'$RM_UCCK');
umu.add_report2arm(479,'$RM_UCCK');
umu.add_report2arm(490,'$RM_UCCK');
umu.add_report2arm(491,'$RM_UCCK');
umu.add_report2arm(495,'$RM_UCCK');
umu.add_report2arm(674,'$RM_UCCK');
umu.add_report2arm(805,'$RM_UCCK');
umu.add_report2arm(3002,'$RM_UCCK');
umu.add_report2arm(3003,'$RM_UCCK');
umu.add_report2arm(3099,'$RM_UCCK');
umu.add_report2arm(4011,'$RM_UCCK');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_UCCK.sql =========**
PROMPT ===================================================================================== 
