SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_SWAP.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_SWAP ***
  declare
    l_application_code varchar2(10 char) := '$RM_SWAP';
    l_application_name varchar2(300 char) := '��� ������������ FOREX: 1 �� 2 "����"';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_SWAP ��������� (��� ���������) ��� ��� ������������ FOREX: 1 �� 2 "����" ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.FOREX: �������� ����� (1 ����) ********** ');
          --  ��������� ������� 1.FOREX: �������� ����� (1 ����)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.FOREX: �������� ����� (1 ����)',
                                                  p_funcname => '/barsroot/Forex/RegularDeals/RegularDeals?dealtypeid=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.FOREX: �������� ���� ���-���� (2 ����) ********** ');
          --  ��������� ������� 2.FOREX: �������� ���� ���-���� (2 ����)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.FOREX: �������� ���� ���-���� (2 ����)',
                                                  p_funcname => '/barsroot/Forex/RegularDeals/RegularDeals?dealtypeid=1',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3.FOREX: �������� ���� ����-���� (2 ����) ********** ');
          --  ��������� ������� 3.FOREX: �������� ���� ����-���� (2 ����)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.FOREX: �������� ���� ����-���� (2 ����)',
                                                  p_funcname => '/barsroot/Forex/RegularDeals/RegularDeals?dealtypeid=2',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 8.FOREX: �������� ������ �� ������� �� �/� ����� ********** ');
          --  ��������� ������� 8.FOREX: �������� ������ �� ������� �� �/� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '8.FOREX: �������� ������ �� ������� �� �/� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&tableName=INT_RATN_MB',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� FOREX: ��� ����� ���� �� ���� ********** ');
          --  ��������� ������� FOREX: ��� ����� ���� �� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FOREX: ��� ����� ���� �� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TMP_SWAP_ARC[PROC=>frx_populate_tmp(:p_dat)][PAR=>:p_dat(SEM=����� ����,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 9.FOREX:����� �� ����� �� /300465/000010/ ********** ');
          --  ��������� ������� 9.FOREX:����� �� ����� �� /300465/000010/
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '9.FOREX:����� �� ����� �� /300465/000010/',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_SPOT[CONDITIONS=>V_SPOT.branch = ''/300465/000010/''',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� 3800/3801 �� ob22 ********** ');
          --  ��������� ������� ��������� ������� 3800/3801 �� ob22
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� 3800/3801 �� ob22',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CLOS_380(3,:V,:M,:W,:N)][PAR=>:V(SEM=�_��22_���_���,TYPE=�),:M(SEM=�_��22_���_��,TYPE=�),:W(SEM=��_��22_���_���,TYPE=�),:N(SEM=��_��22_���_��,TYPE=�)][EXEC=>BEFORE][QST=>������� ����� �������� ?][MSG=>��!]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 7.FOREX: ����� ���� ********** ');
          --  ��������� ������� 7.FOREX: ����� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7.FOREX: ����� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_FXS_ARCHIVE&sPar=[NSIFUNCTION]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6.FOREX: ����� ����(�����) ********** ');
          --  ��������� ������� 6.FOREX: ����� ����(�����)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.FOREX: ����� ����(�����)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_FXS_ARCHIVE&sPar=[NSIFUNCTION][CONDITIONS=>dat>=gl.bd or dat_a>=gl.bd or dat_b>=gl.bd]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5.FOREX: Netting �i� ������� ********** ');
          --  ��������� ������� 5.FOREX: Netting �i� �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5.FOREX: Netting �i� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_FOREX_NETTING[NSIFUNCTION][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.FOREX:�������� �� ������/������/������ ���� ********** ');
          --  ��������� ������� 4.FOREX:�������� �� ������/������/������ ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.FOREX:�������� �� ������/������/������ ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=V_SWAP&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������: ����� ���i�� �� ��������� ********** ');
          --  ��������� ������� ������: ����� ���i�� �� ���������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������: ����� ���i�� �� ���������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FOREX_OB22&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� FOREX. ������� ������������� ������� ********** ');
          --  ��������� ������� FOREX. ������� ������������� �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FOREX. ������� ������������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FX_DEAL_ACCSPARAM&accessCode=0',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� �� ��� ������-������ ********** ');
          --  ��������� ������� �������� �������� �� ��� ������-������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� �� ��� ������-������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FX_PL_CAL&accessCode=1&sPar=[PROC=>PUL_DAT(:A,null)][PAR=>:A(SEM=����_�...,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SALDO_DSW: ������� �����-����� �� ����-������ ********** ');
          --  ��������� ������� SALDO_DSW: ������� �����-����� �� ����-������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SALDO_DSW: ������� �����-����� �� ����-������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=SALDO_DSW&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� N 3. Գ�.��������� �� ����� �� �������� ���.������������ ********** ');
          --  ��������� ������� N 3. Գ�.��������� �� ����� �� �������� ���.������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'N 3. Գ�.��������� �� ����� �� �������� ���.������������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TMP_ANI34&accessCode=2&sPar=[PROC=>P_ANI34(34,:B,:E,:R)][PAR=>:B(SEM=�_DD.MM.YYYY,TYPE=D),:E(SEM=��_DD.MM.YYYY,TYPE=D),:R(SEM=��_�/0,TYPE=N)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� N 2 ������� �������� ��������� �������� (�i�) ********** ');
          --  ��������� ������� N 2 ������� �������� ��������� �������� (�i�)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'N 2 ������� �������� ��������� �������� (�i�)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_ANI33&accessCode=2&sPar=[PROC=>P_ANI33(33,:B,:E,:V)][PAR=>:B(SEM=�_����>,TYPE=D),:E(SEM=��_����>,TYPE=D),:V(SEM=���_���_0,TYPE=N)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������: �������i ��������� ********** ');
          --  ��������� ������� ������: �������i ���������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������: �������i ���������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FOREX_PAR&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� FOREX Netting - ��������I� ********** ');
          --  ��������� ������� FOREX Netting - ��������I�
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FOREX Netting - ��������I�',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FOR_NET_PRO&accessCode=1',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A00. �������� �� ������-������ �� ����� ********** ');
          --  ��������� ������� A00. �������� �� ������-������ �� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A00. �������� �� ������-������ �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�_����>,TYPE=S),:E(SEM=��_����>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A0P. Գ�������� ��������� �� ������.6 �� ������-���� �� ����� ********** ');
          --  ��������� ������� A0P. Գ�������� ��������� �� ������.6 �� ������-���� �� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A0P. Գ�������� ��������� �� ������.6 �� ������-���� �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_0P&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�_����>,TYPE=S),:E(SEM=��_����>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A1S. Գ�������� ��������� �� ������.6 �� ������-���� �� ����� ********** ');
          --  ��������� ������� A1S. Գ�������� ��������� �� ������.6 �� ������-���� �� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A1S. Գ�������� ��������� �� ������.6 �� ������-���� �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_1S&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�_����>,TYPE=S),:E(SEM=��_����>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A2D. Գ�������� ��������� �� ��������� ������-���� �� ����� ********** ');
          --  ��������� ������� A2D. Գ�������� ��������� �� ��������� ������-���� �� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A2D. Գ�������� ��������� �� ��������� ������-���� �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_2D&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�_����>,TYPE=S),:E(SEM=��_����>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ���.��� �� ������-��������� ********** ');
          --  ��������� ������� ������� ���.��� �� ������-���������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ���.��� �� ������-���������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_3800&accessCode=1&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�_����>,TYPE=S),:E(SEM=��_����>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A3K. Գ�������� ��������� �� ���������. ������-���� �� ����� ********** ');
          --  ��������� ������� A3K. Գ�������� ��������� �� ���������. ������-���� �� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A3K. Գ�������� ��������� �� ���������. ������-���� �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_3K&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�_����>,TYPE=S),:E(SEM=��_����>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A4V. Գ�������� ��������� �� ����� ������-���� �� ����� ********** ');
          --  ��������� ������� A4V. Գ�������� ��������� �� ����� ������-���� �� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A4V. Գ�������� ��������� �� ����� ������-���� �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_4V&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�_����>,TYPE=S),:E(SEM=��_����>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_SWAP) - ��� ������������ FOREX: 1 �� 2 "����"  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_SWAP.sql =========**
PROMPT ===================================================================================== 
