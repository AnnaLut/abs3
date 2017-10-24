SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_OWAY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  OWAY ***
  declare
    l_application_code varchar2(10 char) := 'OWAY';
    l_application_name varchar2(300 char) := '��� ��������� � OpenWay';
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
     DBMS_OUTPUT.PUT_LINE(' OWAY ��������� (��� ���������) ��� ��� ��������� � OpenWay ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������������ �/� ������� CardMake ********** ');
          --  ��������� ������� Way4. ������������ �/� ������� CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������������ �/� ������� CardMake',
                                                  p_funcname => 'F1_Select(13,''bars_ow.cm_salary_sync(0)'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. �������� ������� ����� �� �� ********** ');
          --  ��������� ������� Way4. �������� ������� ����� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. �������� ������� ����� �� ��',
                                                  p_funcname => 'FOBPC_Select(101, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� ������� ����� OIC*.xml ********** ');
          --  ��������� ������� Way4. ������ �� ������� ����� OIC*.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� ������� ����� OIC*.xml',
                                                  p_funcname => 'FOBPC_Select(101, ''OIC'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� ������� ����� ����� OIC_FTransfers*.xml ********** ');
          --  ��������� ������� Way4. ������ �� ������� ����� ����� OIC_FTransfers*.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� ������� ����� ����� OIC_FTransfers*.xml',
                                                  p_funcname => 'FOBPC_Select(101, ''OIC_FTRANSFERS'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ ����� ������� CNG*.xml ********** ');
          --  ��������� ������� Way4. ������ ����� ������� CNG*.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ ����� ������� CNG*.xml',
                                                  p_funcname => 'FOBPC_Select(102, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������� ��������� R_IIC � Way4 ********** ');
          --  ��������� ������� Way4. ������� ��������� R_IIC � Way4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������� ��������� R_IIC � Way4',
                                                  p_funcname => 'FOBPC_Select(105, ''R_IIC'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������� ��������� R_OIC � Way4 ********** ');
          --  ��������� ������� Way4. ������� ��������� R_OIC � Way4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������� ��������� R_OIC � Way4',
                                                  p_funcname => 'FOBPC_Select(105, ''R_OIC'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���������� ����� ���������/������� IIC_Documents*.xml ��� Way4 ********** ');
          --  ��������� ������� Way4. ���������� ����� ���������/������� IIC_Documents*.xml ��� Way4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���������� ����� ���������/������� IIC_Documents*.xml ��� Way4',
                                                  p_funcname => 'FOBPC_Select(106, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���������� ����� IIC_Documents*.xml �� ���. ��������� �� � 2625 ********** ');
          --  ��������� ������� Way4. ���������� ����� IIC_Documents*.xml �� ���. ��������� �� � 2625
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���������� ����� IIC_Documents*.xml �� ���. ��������� �� � 2625',
                                                  p_funcname => 'FOBPC_Select(106, ''1'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���������� ����� IIC_Documents*.xml �� ���. �����.����. ********** ');
          --  ��������� ������� Way4. ���������� ����� IIC_Documents*.xml �� ���. �����.����.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���������� ����� IIC_Documents*.xml �� ���. �����.����.',
                                                  p_funcname => 'FOBPC_Select(106, ''2'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���������� ����� ���������� ������� OIC*LOCPAY*.xml ********** ');
          --  ��������� ������� Way4. ���������� ����� ���������� ������� OIC*LOCPAY*.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���������� ����� ���������� ������� OIC*LOCPAY*.xml',
                                                  p_funcname => 'FOBPC_Select(106, ''3'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� ����� IIC ********** ');
          --  ��������� ������� Way4. ����� ����� IIC
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� ����� IIC',
                                                  p_funcname => 'FOBPC_Select(108, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ��������� �� �������� ********** ');
          --  ��������� ������� Way4. ��������� �� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ��������� �� ��������',
                                                  p_funcname => 'FOBPC_Select(109, ''0'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����������� ��������� ********** ');
          --  ��������� ������� Way4. ����������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����������� ���������',
                                                  p_funcname => 'FOBPC_Select(109, ''1'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. �������� ���(��) ********** ');
          --  ��������� ������� Way4. �������� ���(��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. �������� ���(��)',
                                                  p_funcname => 'FOBPC_Select(111, "substr(acc_nls,1,4) in (''2605'',''2655'',''2552'',''2554'')")',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. �������� ���(��) ********** ');
          --  ��������� ������� Way4. �������� ���(��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. �������� ���(��)',
                                                  p_funcname => 'FOBPC_Select(111, "substr(acc_nls,1,4) not in (''2605'',''2655'',''2552'',''2554'')")',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ ���������� ������� ********** ');
          --  ��������� ������� Way4. ������ ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ ���������� �������',
                                                  p_funcname => 'FOBPC_Select(115, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� ����� ���������� ������� ********** ');
          --  ��������� ������� Way4. ����� ����� ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� ����� ���������� �������',
                                                  p_funcname => 'FOBPC_Select(116, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� CardMake ********** ');
          --  ��������� ������� Way4. ������ �� CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� CardMake',
                                                  p_funcname => 'FOBPC_Select(119, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� CardMake - �������� ********** ');
          --  ��������� ������� Way4. ������ �� CardMake - ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� CardMake - ��������',
                                                  p_funcname => 'FOBPC_Select(120, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ ����� �� ���������� �������� �볺��� ********** ');
          --  ��������� ������� Way4. ������ ����� �� ���������� �������� �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ ����� �� ���������� �������� �볺���',
                                                  p_funcname => 'FOBPC_Select(122, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� �� ����� ������ ********** ');
          --  ��������� ������� Way4. ����� �� ����� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� �� ����� ������',
                                                  p_funcname => 'FOBPC_Select(123, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ ������� PENSION ********** ');
          --  ��������� ������� Way4. ������ ������� PENSION
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ ������� PENSION',
                                                  p_funcname => 'FOBPC_Select(127, ''PENSION'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ ������� SOCIAL ********** ');
          --  ��������� ������� Way4. ������ ������� SOCIAL
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ ������� SOCIAL',
                                                  p_funcname => 'FOBPC_Select(127, ''SOCIAL'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� �������� ������(��. ����.) ********** ');
          --  ��������� ������� ������������� �������� ������(��. ����.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� �������� ������(��. ����.)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>p_locpay_fee(:Param0)][PAR=>:Param0(SEM=��i��� ���� 01/mm/yyyy,TYPE=D)][MSG=>³������� ����� �� ������ �����]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �������� �������� OW6 ********** ');
          --  ��������� ������� ������� �������� �������� OW6
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �������� �������� OW6',
                                                  p_funcname => 'FunNSIEdit("[PROC=>visa_batch_ow6(97,100)][MSG=>�������� ������!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���� �������� �� �/� �������� ********** ');
          --  ��������� ������� Way4. ���� �������� �� �/� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���� �������� �� �/� ��������',
                                                  p_funcname => 'FunNSIEdit(''[PROC=>p_w4_change_branch(:proect,:branch)][PAR=>:proect(SEM=�/� ������,REF=v_w4_proect_sal),:branch(SEM=³�������,REF=branch)][MSG=>����� ������]'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� � ������i� 2625/22(����.2012) ********** ');
          --  ��������� ������� ������� � ������i� 2625/22(����.2012)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� � ������i� 2625/22(����.2012)',
                                                  p_funcname => 'FunNSIEditF("VDEB_2625_22[PROC=>PUL_DAT(:Par0,:Par1)][PAR=>:Par0(SEM=� dd.mm.yyyy>,TYPE=S),:Par1(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ��������� ��� ����� ��������� ********** ');
          --  ��������� ������� ���������� ��������� ��� ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ��������� ��� ����� ���������',
                                                  p_funcname => 'FunNSIEditF("V_OW_FORM_REVERS",4 | 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������� ��� ������� ����� �� �� ���� ������ ���. ********** ');
          --  ��������� ������� Way4. ������� ��� ������� ����� �� �� ���� ������ ���.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������� ��� ������� ����� �� �� ���� ������ ���.',
                                                  p_funcname => 'FunNSIEditF(''OW_CL_INFO_DATA_ERROR'', 1 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� ������� �� ��� ********** ');
          --  ��������� ������� �������� �������� ������� �� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� ������� �� ���',
                                                  p_funcname => 'FunNSIEditF(''V_BPK_CREDIT_DEAL[NSIFUNCTION]'', 1 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ �� CardMake ********** ');
          --  ��������� ������� Way4. ������ �� CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ �� CardMake',
                                                  p_funcname => 'FunNSIEditF(''V_CM_ACC_REQUEST[PROC=>bars_ow.cm_process_request(0)][EXEC=>ONCE][QST=>�������� ������?][MSG=>������ ���������]'', 4 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ��������� ������� - ������ ********** ');
          --  ��������� ������� Way4. ��������� ������� - ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ��������� ������� - ������',
                                                  p_funcname => 'FunNSIEditF(''V_OW_ACCHISTORY'',1)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ���������, �� ������� �� ������ ��볺�� ���� ********** ');
          --  ��������� ������� Way4. ���������, �� ������� �� ������ ��볺�� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ���������, �� ������� �� ������ ��볺�� ����',
                                                  p_funcname => 'FunNSIEditF(''V_OW_KLBAD'', 2)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� ������� ********** ');
          --  ��������� ������� Way4. ����� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� �������',
                                                  p_funcname => 'FunNSIEditF(''V_W4_BALANCE'', 1 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ����� �������(new) ********** ');
          --  ��������� ������� Way4. ����� �������(new)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ����� �������(new)',
                                                  p_funcname => 'FunNSIEditF(''V_W4_BALANCE_TXT'', 1 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ��������� ������� �� �������� ********** ');
          --  ��������� ������� Way4. ��������� ������� �� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ��������� ������� �� ��������',
                                                  p_funcname => 'FunNSIEditFFiltered(''V_OW_ACCQUE'',1,''sos=0'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ��������� �������, �� ������� �������� ********** ');
          --  ��������� ������� Way4. ��������� �������, �� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ��������� �������, �� ������� ��������',
                                                  p_funcname => 'FunNSIEditFFiltered(''V_OW_ACCQUE'',1,''sos=1'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Way4. ������ ����� � CM �� ���� ��������� �������� ********** ');
          --  ��������� ������� Way4. ������ ����� � CM �� ���� ��������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. ������ ����� � CM �� ���� ��������� ��������',
                                                  p_funcname => 'GeneralImpExp(hWndMDI, 3, 1, ''bars_ow.import_files(1, sFileName)'', '''')',
                                                  p_rolename => 'OW' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (OWAY) - ��� ��������� � OpenWay  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappOWAY.sql =========*** En
PROMPT ===================================================================================== 
