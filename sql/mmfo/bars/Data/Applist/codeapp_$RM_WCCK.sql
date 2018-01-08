SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WCCK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WCCK ***
  declare
    l_application_code varchar2(10 char) := '$RM_WCCK';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WCCK ��������� (��� ���������) ��� ��� <<������� ��>> ');
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
                                                  p_funcname => '/barsroot/CreditUi/NewCredit/?custtype=3',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����� ������������� �� ���������� ����� ********** ');
          --  ��������� ������� ��������� ����� ������������� �� ���������� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����� ������������� �� ���������� �����',
                                                  p_funcname => '/barsroot/credit/import_hits.aspx',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F0: ��������� ������� ��������� SG ********** ');
          --  ��������� ������� �� F0: ��������� ������� ��������� SG
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F0: ��������� ������� ��������� SG',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK.CC_ASG (0)][QST=>�������� "�� F0: ��������� ������� ��������� SG"?][MSG=>�������� !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #4) �� F0_3: ����-����i� ������i� ��������� SG �� ********** ');
          --  ��������� ������� #4) �� F0_3: ����-����i� ������i� ��������� SG ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#4) �� F0_3: ����-����i� ������i� ��������� SG ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_ASG_SBER (3)][QST=>�������� ����� ������� ���������?][MSG=>����� ������i� �������� !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� �����. �� ********** ');
          --  ��������� ������� #2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� �����. ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� �����. ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''3'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��������/���쳿 �� ********** ');
          --  ��������� ������� ����������� ��������/���쳿 ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������/���쳿 ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(-11,bankdate,3)][QST=>�������� ����������� �������� ��?][MSG=>������!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��������/���쳿 ********** ');
          --  ��������� ������� ����������� ��������/���쳿
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������/���쳿',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(0,bankdate,3)][QST=>�������� ����������� ��������?][MSG=>������!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��������, ���쳿 �� ������ �� ********** ');
          --  ��������� ������� ����������� ��������, ���쳿 �� ������ ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������, ���쳿 �� ������ ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(:ND,gl.bd,3)][PAR=>:ND(SEM=�������� ��)][QST=>������� ����������� �������� �� ��?][MSG=>��������!]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� (��)���������� ������ � �� ********** ');
          --  ��������� ������� �������� (��)���������� ������ � ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� (��)���������� ������ � ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>ICCK(0)][QST=>�������� �������� (��)���������� ������ � ��?][MSG=>��������!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i���������� �� 9819* ���������i� i�����������i� ********** ');
          --  ��������� ������� �i���������� �� 9819* ���������i� i�����������i�
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i���������� �� 9819* ���������i� i�����������i�',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>ICCK(3)][QST=>�������� �i���������� �� 9819* ���������i� i�����������i�?][MSG=>��������!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S8: ���� �������� �������� �� ********** ');
          --  ��������� ������� �� S8: ���� �������� �������� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S8: ���� �������� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cc_close(3,bankdate)][QST=>�� ������ �������� ����-�������� �������� ��?][MSG=>�������� �������� !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� OB22 � ���.�����. (���������� + ��������) ********** ');
          --  ��������� ������� ����� OB22 � ���.�����. (���������� + ��������)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� OB22 � ���.�����. (���������� + ��������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=AUD_CCK&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i���� ��22 � ���.�����. ��+�� ********** ');
          --  ��������� ������� ���i���� ��22 � ���.�����. ��+��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i���� ��22 � ���.�����. ��+��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_OB22&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������, �� ����� ���������� �� ������� ���� ********** ');
          --  ��������� ������� �������, �� ����� ���������� �� ������� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������, �� ����� ���������� �� ������� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_PROBL&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i ��� ��������������i� �� �� ********** ');
          --  ��������� ������� ���i ��� ��������������i� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i ��� ��������������i� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_RESTR_V&accessCode=0&sPar=[CONDITIONS=>CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (11,12,13))]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ���������� ������� �������� ��� ********** ');
          --  ��������� ������� ����� ���������� ������� �������� ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ���������� ������� �������� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_DEAL_PROBL&accessCode=1&sPar=[PROC=>P_CCK_PROBL(:Par0,11)][PAR=>:Par0(SEM= �� ���� ,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ - ������������ - ������� ********** ');
          --  ��������� ������� ������ - ������������ - �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ - ������������ - �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_PAWN_DP&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� REAL-̳������ �� � �� ********** ');
          --  ��������� ������� REAL-̳������ �� � ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REAL-̳������ �� � ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_V&accessCode=1&sPar=[PROC=>MI_CCK(:L,:KF,:ND,1)][PAR=>:L(SEM=���_��_�����,TYPE=S),:KF(SEM=���_��,TYPE=S,REF=BANKS_RU),:ND(SEM=���_��_�_��,TYPE=N)][EXEC=>BEFORE][MSG=>��������!][CONDITIONS=> CC_V.ND in (select new_val from MIGR_RU where TIP=''ND'')]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ��� ������� ��������� ���� �� �� �� ����� ********** ');
          --  ��������� ������� ��� ��� ������� ��������� ���� �� �� �� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ��� ������� ��������� ���� �� �� �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=COUNT_CCK&accessCode=1&sPar=[PROC=>CCK_REPORT.COUNT_CCK(0,:F,:T)][PAR=>:F(SEM=��_����_�>,TYPE=D),:T(SEM=��_����_��>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����������i� �� �� - �����i�����i ��� - 23 ���� ********** ');
          --  ��������� ������� I�����������i� �� �� - �����i�����i ��� - 23 ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����������i� �� �� - �����i�����i ��� - 23 ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_BPK_23&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����������i� �� �� - 23 ���� ********** ');
          --  ��������� ������� I�����������i� �� �� - 23 ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����������i� �� �� - 23 ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_FL_23&accessCode=1&sPar=[PROC=>P_INV_CCK_FL_23 (:Param0,1)][PAR=>:Param0(SEM=����,TYPE=D)][QST=>������������� �������������� ��?][EXEC=>BEFORE][CONDITIONS=>INV_FL_23.G00=TO_DATE(pul.get_mas_ini_val(''sFdat1''),''dd.mm.yyyy'')]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����������i� �� �� - I��i - 23 ���� ********** ');
          --  ��������� ������� I�����������i� �� �� - I��i - 23 ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����������i� �� �� - I��i - 23 ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_INSHI_23&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �� �� �� ������ ********** ');
          --  ��������� ������� ������� �� �� �� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �� �� �� ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=PRVN_FLOW_DEALS&accessCode=2&sPar=[NSIFUNCTION][PROC=>PUL_DAT(:A,null)][PAR=>:A(SEM=��i��� ���� dd_mm_yyyy)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ����� ������������� �� ���������� ����� ********** ');
          --  ��������� ������� �������� ��������� ����� ������������� �� ���������� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� ����� ������������� �� ���������� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TMP_BANK_EMPLOYEE_PROT&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ��� ������������ �� ������ ������� ********** ');
          --  ��������� ������� �������� ��������� ��� ������������ �� ������ �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� ��� ������������ �� ������ �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_DT_SS&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ������� �� �� ********** ');
          --  ��������� ������� �������� ��������� ������� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� ������� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_ERR_REL_ACC&accessCode=6&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2) �������� ����� ������� �� ********** ');
          --  ��������� ������� 2) �������� ����� ������� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2) �������� ����� ������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_NF&accessCode=1&sPar=[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������, �� ����� ���������� �� ������ ���� ********** ');
          --  ��������� ������� �������, �� ����� ���������� �� ������ ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������, �� ����� ���������� �� ������ ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_PROBL_ON_DATE&accessCode=1&sPar=[PROC=>P_CCK_PROBL_ON_DATE(:SPAR,:KV,:BRANCH,:VID)][PAR=>:SPAR(SEM= �� ���� ,TYPE=D),:KV(SEM= ���_0-�� ,TYPE=S),:BRANCH(SEM= ³�������_�����-��,TYPE=S,REF=BRANCH_VAR),:VID(SEM= 2-��_3-��,TYPE=S) ][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��������� R013 � �� �� ********** ');
          --  ��������� ������� ����� ��������� R013 � �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��������� R013 � �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_R013&accessCode=1&sPar=[CONDITIONS=>vidd in(11,12,13)]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3) �������� ������� ������� �� ********** ');
          --  ��������� ������� 3) �������� ������� ������� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3) �������� ������� ������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_RF&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-��� �i���i��� �� ���i�� �� �� �� ********** ');
          --  ��������� ������� ��-��� �i���i��� �� ���i�� �� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-��� �i���i��� �� ���i�� �� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_SAL3&accessCode=1&sPar=[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM=��� ���� ���i��� dd_mm_yyyy>,TYPE=S),:Par2(SEM=�i� ���� ���i��� dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
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

      --  ��������� ������� ������� �������-�� �� �����. %% ����� ��� � ���� ����� ��
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������-�� �� �����. %% ����� ��� � ���� ����� ��',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]',
                                                              p_rolename => 'bars_access_defrole' ,    
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

      --  ��������� ������� ������� ������ �������� ������i� �����������i� �� �� ��
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ �������� ������i� �����������i� �� �� ��',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_PAY1&accessCode=1&sPar=[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM= dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                              p_rolename => 'bars_access_defrole' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������, ������������� ���� �� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����������, ������������� ���� �� �������',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_PDFO[NSIFUNCTION][PROC=>PUL.PUT(''WDAT'',to_char(:P,''dd.mm.yyyy''))][PAR=>:P(SEM=����,TYPE=D)][EXEC=>BEFORE]',
                                                              p_rolename => 'bars_access_defrole' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� �� ������������ �������� �� ��
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���� �� ������������ �������� �� ��',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_REP&accessCode=1&sPar=[PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=���� �������,TYPE=N,REF=V_CCK_REP_LIST_YL)][NSIFUNCTION][EXEC=>BEFORE][MSG=>��������!]',
                                                              p_rolename => 'bars_access_defrole' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �� ���������� (���) ********** ');
          --  ��������� ������� ����������� �� ���������� (���)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �� ���������� (���)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_GRACE_ATO&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����������� ���i����� ���i�i� �� �� ********** ');
          --  ��������� ������� ��: ����������� ���i����� ���i�i� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����������� ���i����� ���i�i� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK&accessCode=1&sPar=[PROC=>p_interest_cck(null,5,:E)][PAR=>:E(SEM=���� ��,TYPE=D)][showDialogWindow=>false][DESCR=>��: �����.%%][EXEC=>BEFORE][NSIFUNCTION]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �������� ������i� �����������i� �� �� �� ********** ');
          --  ��������� ������� ������ �������� ������i� �����������i� �� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �������� ������i� �����������i� �� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_PAY1&accessCode=1&sPar=[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM= dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_WCCK) - ��� <<������� ��>>  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WCCK.sql =========**
PROMPT ===================================================================================== 
