SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_ANIN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  ANIN ***
  declare
    l_application_code varchar2(10 char) := 'ANIN';
    l_application_name varchar2(300 char) := '��� �������� ������ NEW';
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
     DBMS_OUTPUT.PUT_LINE(' ANIN ��������� (��� ���������) ��� ��� �������� ������ NEW ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-2(XLS) �����������������Ͳ ������� �� ���. ��� �� ����� ********** ');
          --  ��������� ������� ���-2(XLS) �����������������Ͳ ������� �� ���. ��� �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-2(XLS) �����������������Ͳ ������� �� ���. ��� �� �����',
                                                  p_funcname => 'ExportCatQuery(5338,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-4(XLS) �����������������Ͳ ������� �� ����. ���. �� ����� ********** ');
          --  ��������� ������� ���-4(XLS) �����������������Ͳ ������� �� ����. ���. �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-4(XLS) �����������������Ͳ ������� �� ����. ���. �� �����',
                                                  p_funcname => 'ExportCatQuery(5339,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-8(XLS) ������������� �� ������ �� �� (�� �����) ********** ');
          --  ��������� ������� ���-8(XLS) ������������� �� ������ �� �� (�� �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-8(XLS) ������������� �� ������ �� �� (�� �����)',
                                                  p_funcname => 'ExportCatQuery(5340,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-4(���) �����������������Ͳ ������� �� ����. ���. �� ����� ********** ');
          --  ��������� ������� ���-4(���) �����������������Ͳ ������� �� ����. ���. �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-4(���) �����������������Ͳ ������� �� ����. ���. �� �����',
                                                  p_funcname => 'FunNSIEditF("NADA4[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�  dd.mm.yyyy>,TYPE=S),:E(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-2(���) �����������������Ͳ ������� �� ���. ���. �� ����� ********** ');
          --  ��������� ������� ���-2(���) �����������������Ͳ ������� �� ���. ���. �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-2(���) �����������������Ͳ ������� �� ���. ���. �� �����',
                                                  p_funcname => 'FunNSIEditF("NADA5[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=� dd.mm.yyyy>,TYPE=S),:E(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 7.����� �� �������� ������� �� ������ ********** ');
          --  ��������� ������� 7.����� �� �������� ������� �� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7.����� �� �������� ������� �� ������',
                                                  p_funcname => 'FunNSIEditF("NADA7[PROC=>NADA.NB7(0,:B,:E)][PAR=>:B(SEM=� dd.mm.yyyy>,TYPE=S),:E(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���-8(���) ������������� �� ������ �� �� (�� �����) ********** ');
          --  ��������� ������� ���-8(���) ������������� �� ������ �� �� (�� �����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���-8(���) ������������� �� ������ �� �� (�� �����)',
                                                  p_funcname => 'FunNSIEditF("NADA8[PROC=>NADA.NB8(0,:B,:E)][PAR=>:B(SEM=� dd.mm.yyyy>,TYPE=S),:E(SEM=�� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ���������: ��i� ��  �i����, �������� ********** ');
          --  ��������� ������� �� ���������: ��i� ��  �i����, ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ���������: ��i� ��  �i����, ��������',
                                                  p_funcname => 'FunNSIEditF("TEST_MART7[PROC=>NADA.cckGL(7,:D,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null)][PAR=>:D(SEM=����_��,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���:�i���i��� �������� �������� ********** ');
          --  ��������� ������� ���:�i���i��� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���:�i���i��� �������� ��������',
                                                  p_funcname => 'FunNSIEditF("TMPR_CCK5[PROC=>NADA.cckGL(1,:B1,:E1,:B2,:E2,:B3,:E3,:B4,:E4,:B5,:E5)][PAR=>:B1(SEM=B1),:E1(SEM=E1),:B2(SEM=B2),:E2(SEM=E2),:B3(SEM=B3),:E3(SEM=E3),:B4(SEM=B4),:E4(SEM=E4),:B5(SEM=B5),:E5(SEM=E5)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���:�i���i��� �������� �������� ********** ');
          --  ��������� ������� ���:�i���i��� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���:�i���i��� �������� ��������',
                                                  p_funcname => 'FunNSIEditF("TMPV_CCK5[PROC=>NADA.cckGL(0,:B1,:E1,:B2,:E2,:B3,:E3,:B4,:E4,:B5,:E5)][PAR=>:B1(SEM=B1),:E1(SEM=E1),:B2(SEM=B2),:E2(SEM=E2),:B3(SEM=B3),:E3(SEM=E3),:B4(SEM=B4),:E4(SEM=E4),:B5(SEM=B5),:E5(SEM=E5)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ���������: ��i� ��  �i����, �������� ********** ');
          --  ��������� ������� �� ���������: ��i� ��  �i����, ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ���������: ��i� ��  �i����, ��������',
                                                  p_funcname => 'FunNSIEditF("V_TEST_MART7[PROC=>NADA.cckGL(7,:D,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null,STRING_Null)][PAR=>:D(SEM=����_��,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (ANIN) - ��� �������� ������ NEW  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappANIN.sql =========*** En
PROMPT ===================================================================================== 
