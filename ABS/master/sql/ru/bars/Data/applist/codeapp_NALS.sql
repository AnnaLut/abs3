SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_NALS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  NALS ***
  declare
    l_application_code varchar2(10 char) := 'NALS';
    l_application_name varchar2(300 char) := '��� ���������� ���� ��';
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
     DBMS_OUTPUT.PUT_LINE(' NALS ��������� (��� ���������) ��� ��� ���������� ���� �� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� XLS - �������� ��� ���������� �����.�����`������ �� �������  ********** ');
          --  ��������� ������� XLS - �������� ��� ���������� �����.�����`������ �� ������� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'XLS - �������� ��� ���������� �����.�����`������ �� ������� ',
                                                  p_funcname => 'ExportCatQuery(4539,'''', 8,'''',TRUE)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� XLS - I����i� ������������i� P080+R020_FA+OB22 (��������� �� ��i��) ********** ');
          --  ��������� ������� XLS - I����i� ������������i� P080+R020_FA+OB22 (��������� �� ��i��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'XLS - I����i� ������������i� P080+R020_FA+OB22 (��������� �� ��i��)',
                                                  p_funcname => 'ExportCatQuery(4706,'''', 8,'''',TRUE)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F1. DA<FFFF>.dbf ��� ��� �� ����.����������� �� �����-2 ********** ');
          --  ��������� ������� F1. DA<FFFF>.dbf ��� ��� �� ����.����������� �� �����-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F1. DA<FFFF>.dbf ��� ��� �� ����.����������� �� �����-2',
                                                  p_funcname => 'ExportCatQuery(4932,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F0.��������� DBF-���� ��� ��� �� ����.���������i� ********** ');
          --  ��������� ������� F0.��������� DBF-���� ��� ��� �� ����.���������i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F0.��������� DBF-���� ��� ��� �� ����.���������i�',
                                                  p_funcname => 'ExportCatQuery(4934,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� F3. DA<FFFFFF>.dbf ��� ��� �� ����.������. �� �����-3 ********** ');
          --  ��������� ������� F3. DA<FFFFFF>.dbf ��� ��� �� ����.������. �� �����-3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F3. DA<FFFFFF>.dbf ��� ��� �� ����.������. �� �����-3',
                                                  p_funcname => 'ExportCatQuery(4967,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��� ��i�������-��������� ������� 1 �� 2013 ���� ********** ');
          --  ��������� ������� �������� ��� ��i�������-��������� ������� 1 �� 2013 ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��� ��i�������-��������� ������� 1 �� 2013 ����',
                                                  p_funcname => 'F1_Select(13, "NAL8_PAY_7720(DAT);�������� �������� ���� ������� �� 1 �� 2013 ����?;�������� ���������!"  ) ',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �87  ����������� ��������i� �� �i��� �i����i� �i�i� ********** ');
          --  ��������� ������� �87  ����������� ��������i� �� �i��� �i����i� �i�i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�87  ����������� ��������i� �� �i��� �i����i� �i�i�',
                                                  p_funcname => 'F1_Select(13, "NAL8_pay_87(DAT);�������� ����������� ?; ����������� ��������i� ���������!"  ) ',
                                                  p_rolename => 'NALOG' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �87 ���i 87 ����� �i�i� �i��� �i����i�, �� ��������i � �� ********** ');
          --  ��������� ������� �87 ���i 87 ����� �i�i� �i��� �i����i�, �� ��������i � ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�87 ���i 87 ����� �i�i� �i��� �i����i�, �� ��������i � ��',
                                                  p_funcname => 'FunNSIEditF("V_FIL_87",1 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ��� ����������� �� �� �� ������� ��� ********** ');
          --  ��������� ������� ��� ��� ����������� �� �� �� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ��� ����������� �� �� �� ������� ���',
                                                  p_funcname => 'FunNSIEditF("V_KF3800[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=����_�,TYPE=S),:E(SEM=����_��,TYPE=S)][EXEC=>BEFORE]", 1 )',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������, ������������� ����+�� �� ������� ********** ');
          --  ��������� ������� ����������, ������������� ����+�� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������, ������������� ����+�� �� �������',
                                                  p_funcname => 'FunNSIEditF("V_PDFO[NSIFUNCTION][PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=��i��� ���� 01/��/��)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� ��� ����������� �� �� �� ������� ��� ********** ');
          --  ��������� ������� ��� ��� ����������� �� �� �� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� ��� ����������� �� �� �� ������� ���',
                                                  p_funcname => 'FunNSIEditF("V_RF3800[PROC=>Bank_PF (0,:B,:E)][PAR=>:B(SEM=����_�,TYPE=D),:E(SEM=����_��,TYPE=D)][EXEC=>BEFORE]", 1 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������� ������i� �� (SB_P086 - 86 ����) ********** ');
          --  ��������� ������� �i������� ������i� �� (SB_P086 - 86 ����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������� ������i� �� (SB_P086 - 86 ����)',
                                                  p_funcname => 'FunNSIEditF(''ACC_86_NEW'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������� ������i� �� (SB_P0853 - 87 ����) ********** ');
          --  ��������� ������� �i������� ������i� �� (SB_P0853 - 87 ����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������� ������i� �� (SB_P0853 - 87 ����)',
                                                  p_funcname => 'FunNSIEditF(''ACC_87_NEW'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������� ������i� �� (SB_P088 - 88 ����) ********** ');
          --  ��������� ������� �i������� ������i� �� (SB_P088 - 88 ����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������� ������i� �� (SB_P088 - 88 ����)',
                                                  p_funcname => 'FunNSIEditF(''ACC_88_NEW'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (NALS) - ��� ���������� ���� ��  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappNALS.sql =========*** En
PROMPT ===================================================================================== 
