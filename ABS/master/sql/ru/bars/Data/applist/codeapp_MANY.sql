SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_MANY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  MANY ***
  declare
    l_application_code varchar2(10 char) := 'MANY';
    l_application_name varchar2(300 char) := '��� ���������� ���������� �����';
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
     DBMS_OUTPUT.PUT_LINE(' MANY ��������� (��� ���������) ��� ��� ���������� ���������� ����� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->04.���������� ���.����� �� ��K ********** ');
          --  ��������� ������� ->04.���������� ���.����� �� ��K
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->04.���������� ���.����� �� ��K',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OBS_23_BPK_BLOCK(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->02.���������� ���.����� �� ��  ********** ');
          --  ��������� ������� ->02.���������� ���.����� �� �� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->02.���������� ���.����� �� �� ',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OBS_23_KP_block(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->03.���������� ���.����� �� ��� ********** ');
          --  ��������� ������� ->03.���������� ���.����� �� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->03.���������� ���.����� �� ���',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OBS_23_MBK_block(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->04_0.���������� ���.����� �� ����������� ********** ');
          --  ��������� ������� ->04_0.���������� ���.����� �� �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->04_0.���������� ���.����� �� �����������',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OBS_23_OVER_BLOCK(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->00.������� ���.����� �� ����� �� ������� ********** ');
          --  ��������� ������� ->00.������� ���.����� �� ����� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->00.������� ���.����� �� ����� �� �������',
                                                  p_funcname => 'FunNSIEdit("[PROC=>REZ_351_BLOCK(:A,2)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->01.���������� ������������ ********** ');
          --  ��������� ������� ->01.���������� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->01.���������� ������������',
                                                  p_funcname => 'FunNSIEdit("[PROC=>REZ_351_BLOCK(:A,3)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ->01.����������� �������� ��� � ���i� ********** ');
          --  ��������� ������� ->01.����������� �������� ��� � ���i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->01.����������� �������� ��� � ���i�',
                                                  p_funcname => 'FunNSIEdit("[PROC=>START_REZ_block(:A)][PAR=>:A(SEM=��_����_��-��-pppp,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �!�������������, ��� ���������� ���������� ������� �� �������� ********** ');
          --  ��������� ������� �!�������������, ��� ���������� ���������� ������� �� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�!�������������, ��� ���������� ���������� ������� �� ��������',
                                                  p_funcname => 'FunNSIEdit("[PROC=>p_rez_dat(0)][QST=>�����! ���������� ������������� ��������! ������������?][MSG=>OK! �������� �����������!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6.1. ������ �� ���.���.�������������� (�������) ********** ');
          --  ��������� ������� 6.1. ������ �� ���.���.�������������� (�������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.1. ������ �� ���.���.�������������� (�������)',
                                                  p_funcname => 'FunNSIEditF("DEB_FIN[PROC=>P_DEB_FIN(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 6.2. ������ �� ����.���.�������������� (�������) ********** ');
          --  ��������� ������� 6.2. ������ �� ����.���.�������������� (�������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.2. ������ �� ����.���.�������������� (�������)',
                                                  p_funcname => 'FunNSIEditF("DEB_HOZ[PROC=>P_DEB_HOZ(:A)][PAR=>:A(SEM=��_����_��-��-����,TYPE=D)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ! ������ + �������� ���������� ������� �� ���-23 ********** ');
          --  ��������� ������� ! ������ + �������� ���������� ������� �� ���-23
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '! ������ + �������� ���������� ������� �� ���-23',
                                                  p_funcname => 'FunNSIEditF("GL_NBU23_REZ[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��_����_01,TYPE=S)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ! ������ + �������� (����i�����i �� ���) ********** ');
          --  ��������� ������� ! ������ + �������� (����i�����i �� ���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '! ������ + �������� (����i�����i �� ���)',
                                                  p_funcname => 'FunNSIEditF("GL_NBU23_REZ_ACC[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��_����_01,TYPE=S)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.3. ��������/���������� ��������i� ���� �� ����� (����) ********** ');
          --  ��������� ������� 4.3. ��������/���������� ��������i� ���� �� ����� (����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.3. ��������/���������� ��������i� ���� �� ����� (����)',
                                                  p_funcname => 'FunNSIEditF("NBU23_CCK_BN_KOR[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=��i���_���� 01.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.2. ��������/���������� ��������i� ���� �� �� ********** ');
          --  ��������� ������� 4.2. ��������/���������� ��������i� ���� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.2. ��������/���������� ��������i� ���� �� ��',
                                                  p_funcname => 'FunNSIEditF("NBU23_CCK_FL[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��_����_01,TYPE=S)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 4.1. ��������/���������� ��������i� ���� �� �� ********** ');
          --  ��������� ������� 4.1. ��������/���������� ��������i� ���� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.1. ��������/���������� ��������i� ���� �� ��',
                                                  p_funcname => 'FunNSIEditF("NBU23_CCK_UL[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��_����_01,TYPE=S)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ! !����������+�����+���� ���������� ��������� �� ���-23 ********** ');
          --  ��������� ������� ! !����������+�����+���� ���������� ��������� �� ���-23
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '! !����������+�����+���� ���������� ��������� �� ���-23',
                                                  p_funcname => 'FunNSIEditF("NBU23_REZ[PROC=>REZ_23_BLOCK(:A)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]",0| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2.0. �������� ���������� ������� �� ���-351+FINEVARE ********** ');
          --  ��������� ������� 2.0. �������� ���������� ������� �� ���-351+FINEVARE
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.0. �������� ���������� ������� �� ���-351+FINEVARE',
                                                  p_funcname => 'FunNSIEditF("NBU23_REZ_P[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��_����_01,TYPE=S)][EXEC=>BEFORE]",0| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 98_ ������������� �� �������� ********** ');
          --  ��������� ������� 98_ ������������� �� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98_ ������������� �� ��������',
                                                  p_funcname => 'FunNSIEditF("ORDER_REZ[PROC=>P_ORDER_REZ(:A)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]",0| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����:���� �������� �� �� ���� ���� �� ���i�� ********** ');
          --  ��������� ������� ����:���� �������� �� �� ���� ���� �� ���i��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����:���� �������� �� �� ���� ���� �� ���i��',
                                                  p_funcname => 'FunNSIEditF("POG_ARJK[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=� dd.mm.yyyy>,TYPE=S),:E(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1|0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3.2. �������� ��������� ������� ���������� ������� ********** ');
          --  ��������� ������� 3.2. �������� ��������� ������� ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.2. �������� ��������� ������� ���������� �������',
                                                  p_funcname => 'FunNSIEditF("REZ_LOG",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3.1. �������� ��������� ������� ********** ');
          --  ��������� ������� 3.1. �������� ��������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.1. �������� ��������� �������',
                                                  p_funcname => 'FunNSIEditF("REZ_NBU23_DELTA[PROC=>z23.P_DELTA(:A,:B)][PAR=>:A(SEM=��_����_�_��-��-����,TYPE=D),:B(SEM=��_����_��_��-��-����,TYPE=D)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5.1. ����� ���������� ������� ********** ');
          --  ��������� ������� 5.1. ����� ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5.1. ����� ���������� �������',
                                                  p_funcname => 'FunNSIEditF("TEST_FINREZ[PROC=>FINREZ_SB(:B)][PAR=>:B(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 04.�������� PV,BV,Irr �� � �������� ********** ');
          --  ��������� ������� 04.�������� PV,BV,Irr �� � ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '04.�������� PV,BV,Irr �� � ��������',
                                                  p_funcname => 'FunNSIEditF("TEST_MANY_CCK[PROC=>Z23.TK_MANY(:A,:D,:R,:Z,1)][PAR=>:A(SEM=���_��,TYPE=N),:D(SEM=��_����_01,TYPE=D),:R(SEM=�����=1/0,TYPE=N),:Z(SEM=�����.� 1B=1/0,TYPE=N)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 07.�������� BV �� ���.�������.������. ********** ');
          --  ��������� ������� 07.�������� BV �� ���.�������.������.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '07.�������� BV �� ���.�������.������.',
                                                  p_funcname => 'FunNSIEditF("TEST_MANY_CCK_DF[PROC=>Z23.REZ_DEB_F(:D,0,0,1)][PAR=>:D(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 08.�������� BV �� ���.�������.������. ********** ');
          --  ��������� ������� 08.�������� BV �� ���.�������.������.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '08.�������� BV �� ���.�������.������.',
                                                  p_funcname => 'FunNSIEditF("TEST_MANY_CCK_DH[PROC=>Z23.REZ_DEB_F(:D,1,:Z,1)][PAR=>:D(SEM=��_����_01,TYPE=D),:Z(SEM=�����.� 1B=1/0,TYPE=N))][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 98_1. �������� ���������� �������� (������<->����.�����.���.�������) ********** ');
          --  ��������� ������� 98_1. �������� ���������� �������� (������<->����.�����.���.�������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98_1. �������� ���������� �������� (������<->����.�����.���.�������)',
                                                  p_funcname => 'FunNSIEditF("VER_DOC_MAKET[PROC=>P_DOC_MAKET(:A)][PAR=>:A(SEM=��_����_01-MM-����,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 18.�������� �������� PV,BV,Irr, ������� �� �� ********** ');
          --  ��������� ������� 18.�������� �������� PV,BV,Irr, ������� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '18.�������� �������� PV,BV,Irr, ������� �� ��',
                                                  p_funcname => 'FunNSIEditF("V_CP_MANY[PROC=>Z23.PUL_DAT_CP(:B,:Z,1)][PAR=>:B(SEM=��i���_���� 01.mm.yyyy>,TYPE=D),:Z(SEM=�����.� 1B=1/0,TYPE=N)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 13.�������� ���������� ������� �� 9100 ********** ');
          --  ��������� ������� 13.�������� ���������� ������� �� 9100
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '13.�������� ���������� ������� �� 9100',
                                                  p_funcname => 'FunNSIEditF("V_REZ_9100[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��_����_01,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 17.�������� ���������� ������� �� ������������ ********** ');
          --  ��������� ������� 17.�������� ���������� ������� �� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '17.�������� ���������� ������� �� ������������',
                                                  p_funcname => 'FunNSIEditF("V_REZ_NLO[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��_����_01,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 09.�������� �������:9000,9001,9002,9003,9020,9023,9129` ********** ');
          --  ��������� ������� 09.�������� �������:9000,9001,9002,9003,9020,9023,9129`
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '09.�������� �������:9000,9001,9002,9003,9020,9023,9129`',
                                                  p_funcname => 'FunNSIEditFFiltered("NBU23_REZ[PROC=>Z23.PUL_DAT_9(:A,1,1)][PAR=>:A(SEM=��_����_��-��-pppp)][EXEC=>BEFORE]",2,"FDAT=z23.B and id like ''9%'' ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 99. ���������� �������� �� ���� ********** ');
          --  ��������� ������� 99. ���������� �������� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '99. ���������� �������� �� ����',
                                                  p_funcname => 'FunNSIEditFFiltered("REZ_DOC_MAKET[PROC=>PAY_23(:A,0,NUMBER_Null,0)][PAR=>:A(SEM=��_����_01,TYPE=D)][QST=> �������� ����������� �� �����. ��������?][EXEC=>BEFORE]",1,"DK>=0")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 98. ����� �������� �� 23 ��������i (��� ����������) ********** ');
          --  ��������� ������� 98. ����� �������� �� 23 ��������i (��� ����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98. ����� �������� �� 23 ��������i (��� ����������)',
                                                  p_funcname => 'FunNSIEditFFiltered("REZ_DOC_MAKET[PROC=>PAY_23(:A,1,NUMBER_Null,0)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]",1,"DK>=0")',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ---- ********** ');
          --  ��������� ������� ----
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '----',
                                                  p_funcname => 'SqlPrepareAndExecute(hSql(),"begin delete from acc_nlo; commit; end;")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (MANY) - ��� ���������� ���������� �����  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappMANY.sql =========*** En
PROMPT ===================================================================================== 
