SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_PRVN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  PRVN ***
  declare
    l_application_code varchar2(10 char) := 'PRVN';
    l_application_name varchar2(300 char) := '���-PRVN';
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
     DBMS_OUTPUT.PUT_LINE(' PRVN ��������� (��� ���������) ��� ���-PRVN ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 2) ����� � ���, �� ���`���� � Գ�.���. ********** ');
          --  ��������� ������� 2) ����� � ���, �� ���`���� � Գ�.���.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2) ����� � ���, �� ���`���� � Գ�.���.',
                                                  p_funcname => 'FunNSIEditF("FIN_DEBM",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 3) �������: "Բ������� ���������" � �� ********** ');
          --  ��������� ������� 3) �������: "Բ������� ���������" � ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3) �������: "Բ������� ���������" � ��',
                                                  p_funcname => 'FunNSIEditF("FIN_DEBT[NSIFUNCTION]",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� : "Բ������� ���������" ********** ');
          --  ��������� ������� �������� : "Բ������� ���������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� : "Բ������� ���������"',
                                                  p_funcname => 'FunNSIEditF("FIN_DEBVA[NSIFUNCTION]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1) ���������� "Գ�/���" �� ��� ********** ');
          --  ��������� ������� 1) ���������� "Գ�/���" �� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1) ���������� "Գ�/���" �� ���',
                                                  p_funcname => 'FunNSIEditF("FIN_DEB_NBU",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ABS=>��1: ������� �� �� �� ������ ********** ');
          --  ��������� ������� ABS=>��1: ������� �� �� �� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ABS=>��1: ������� �� �� �� ������',
                                                  p_funcname => 'FunNSIEditF("PRVN_FLOW_DEALS[NSIFUNCTION][PROC=>PUL_DAT(:A,STRING_Null)][PAR=>:A(SEM=��i�-���� 01/��/����)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� FV=>���: ������� ���-³����� "������-����" ********** ');
          --  ��������� ������� FV=>���: ������� ���-³����� "������-����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FV=>���: ������� ���-³����� "������-����"',
                                                  p_funcname => 'FunNSIEditF("PRVN_OSAQ[NSIFUNCTION][PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��_���� 01/��/����)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������������� �������� �� ���� �� 2014 + 2015.1 ���� ********** ');
          --  ��������� ������� �������������� �������� �� ���� �� 2014 + 2015.1 ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������������� �������� �� ���� �� 2014 + 2015.1 ����',
                                                  p_funcname => 'FunNSIEditF("VREZ14[NSIFUNCTION]",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������/�������� ���� ������� ********** ');
          --  ��������� ������� ����������/�������� ���� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������/�������� ���� �������',
                                                  p_funcname => 'FunNSIEditF("V_PRVN_AUTOMATIC_EVENT[PROC=>bars_loss_events.loss_events(:D,:Z)][PAR=>:D(SEM=��_����,TYPE=D),:Z(SEM=�����.����: 0=ͳ / 1=���,TYPE=N)][EXEC=>BEFORE]",2 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (PRVN) - ���-PRVN  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappPRVN.sql =========*** En
PROMPT ===================================================================================== 
