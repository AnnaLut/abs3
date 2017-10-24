SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_MANY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_MANY ***
  declare
    l_application_code varchar2(10 char) := '$RM_MANY';
    l_application_name varchar2(300 char) := '��� ���������� ���������� �����';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_MANY ��������� (��� ���������) ��� ��� ���������� ���������� ����� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ������������ �� ********** ');
          --  ��������� ������� �������� �������� ������������ ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ������������ ��',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_portfolio&mode=3',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_deposits&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ������� ����',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dog_events&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� - �����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������� - �����',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage_land&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ���������',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_vehicles&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ����� ��������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ����� ��������',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dual&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_valuables&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_products&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ! �������� ���������� ������� �� ���-23 ********** ');
          --  ��������� ������� ! �������� ���������� ������� �� ���-23
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '! �������� ���������� ������� �� ���-23',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=NBU23_REZ',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� !!����������+�����+��� ���������� ��������� �� ���-23 ********** ');
          --  ��������� ������� !!����������+�����+��� ���������� ��������� �� ���-23
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '!!����������+�����+��� ���������� ��������� �� ���-23',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=NBU23_REZ[PROC=>REZ_23_BLOCK(:A,1)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3.1. �������� ��������� ������� ********** ');
          --  ��������� ������� 3.1. �������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.1. �������� ��������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=REZ_NBU23_DELTA[PROC=>z23.P_DELTA(:A,:B)][PAR=>:A(SEM=��_����_�_01-��-����,TYPE=D),:B(SEM=��_����_��_01-��-����,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 04. �������� ������� �� �������� ********** ');
          --  ��������� ������� 04. �������� ������� �� ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '04. �������� ������� �� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TEST_MANY_CCK[PROC=>Z23.TK_MANY(:A,:D,1,0,1)][PAR=>:A(SEM=���_��,TYPE=N),:D(SEM=��_����_01,TYPE=D))][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 98_1. �������� ���������� �������� (������<->����.�����.���.�������) ********** ');
          --  ��������� ������� 98_1. �������� ���������� �������� (������<->����.�����.���.�������)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98_1. �������� ���������� �������� (������<->����.�����.���.�������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=VER_DOC_MAKET[PROC=>P_DOC_MAKET(:A)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 05. �������� ������� �� �� ********** ');
          --  ��������� ������� 05. �������� ������� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '05. �������� ������� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_MANY[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��i���_���� 01.mm.yyyy>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6.1. ������ �� ���.���.�������������� (�������) ********** ');
          --  ��������� ������� 6.1. ������ �� ���.���.�������������� (�������)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.1. ������ �� ���.���.�������������� (�������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=DEB_FIN[PROC=>P_DEB_FIN(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6.2. ������ �� ����.���.�������������� (�������) ********** ');
          --  ��������� ������� 6.2. ������ �� ����.���.�������������� (�������)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.2. ������ �� ����.���.�������������� (�������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=DEB_HOZ[PROC=>P_DEB_HOZ(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.3. ��������/���������� ��������i� ���� �� ����� (����) ********** ');
          --  ��������� ������� 4.3. ��������/���������� ��������i� ���� �� ����� (����)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.3. ��������/���������� ��������i� ���� �� ����� (����)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CCK_BN_KOR[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��i���_���� 01.��.����>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-23/R.��������/���������� ��������i� ���� �� �� ********** ');
          --  ��������� ������� ���-23/R.��������/���������� ��������i� ���� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-23/R.��������/���������� ��������i� ���� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CCK_FL[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��_����_01-MM-����,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.1. ��������/���������� ��������i� ���� �� �� ********** ');
          --  ��������� ������� 4.1. ��������/���������� ��������i� ���� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.1. ��������/���������� ��������i� ���� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CCK_UL[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-23/R.��������/���������� ��������i� �� ********** ');
          --  ��������� ������� ���-23/R.��������/���������� ��������i� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-23/R.��������/���������� ��������i� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CP[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM=��i���_���� 01.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 98_ ������������� �� �������� ********** ');
          --  ��������� ������� 98_ ������������� �� ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98_ ������������� �� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=ORDER_REZ[PROC=>P_ORDER_REZ(:A)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� FV=>���: ������� ���-³����� "������-����" ********** ');
          --  ��������� ������� FV=>���: ������� ���-³����� "������-����"
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FV=>���: ������� ���-³����� "������-����"',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=PRVN_OSAQ[NSIFUNCTION][PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��_���� 01/��/����,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3.2. �������� ��������� ������� ���������� ������� ********** ');
          --  ��������� ������� 3.2. �������� ��������� ������� ���������� �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.2. �������� ��������� ������� ���������� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=REZ_LOG',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 07. �������� BV �� ���.�������.������. ********** ');
          --  ��������� ������� 07. �������� BV �� ���.�������.������.
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '07. �������� BV �� ���.�������.������.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=TEST_MANY_CCK_DF[PROC=>Z23.REZ_DEB_F(:D,0,0,1)][PAR=>:D(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 08. �������� BV �� ���.�������.������. ********** ');
          --  ��������� ������� 08. �������� BV �� ���.�������.������.
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '08. �������� BV �� ���.�������.������.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=TEST_MANY_CCK_DH[PROC=>Z23.REZ_DEB_F(:D,1,0,1)][PAR=>:D(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->00.������� ���.����� �� ����� �� ������� ********** ');
          --  ��������� ������� ->00.������� ���.����� �� ����� �� �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->00.������� ���.����� �� ����� �� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,2)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->01. ����������� �������� ��� � ���i� ********** ');
          --  ��������� ������� ->01. ����������� �������� ��� � ���i�
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->01. ����������� �������� ��� � ���i�',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,3)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->02.���������� ���.����� �� ��  ********** ');
          --  ��������� ������� ->02.���������� ���.����� �� �� 
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->02.���������� ���.����� �� �� ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,4)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->03.���������� ���.����� �� ��� ********** ');
          --  ��������� ������� ->03.���������� ���.����� �� ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->03.���������� ���.����� �� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,5)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->04.���������� ���.����� �� ��K ********** ');
          --  ��������� ������� ->04.���������� ���.����� �� ��K
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->04.���������� ���.����� �� ��K',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,6)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->04_0.���������� ���.����� �� ����������� ********** ');
          --  ��������� ������� ->04_0.���������� ���.����� �� �����������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->04_0.���������� ���.����� �� �����������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,7)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->05. ���������� ������������ ********** ');
          --  ��������� ������� ->05. ���������� ������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->05. ���������� ������������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,8)][PAR=>:A(SEM=��_����_01-��-����,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ������� ������� ���.% ������������ <30 �� >30 ��� ********** ');
          --  ��������� ������� ���������� ������� ������� ���.% ������������ <30 �� >30 ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ������� ������� ���.% ������������ <30 �� >30 ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=ACC_30&accessCode=1&sPar=[PROC=>p_acc_d30(:A)][PAR=>:A(SEM=����� ����,TYPE=D)][EXEC=>BEFORE]',
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_MANY) - ��� ���������� ���������� �����  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_MANY.sql =========**
PROMPT ===================================================================================== 
