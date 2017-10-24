SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KREF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KREF ***
  declare
    l_application_code varchar2(10 char) := 'KREF';
    l_application_name varchar2(300 char) := '��� ������� ��';
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
     DBMS_OUTPUT.PUT_LINE(' KREF ��������� (��� ���������) ��� ��� ������� �� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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
                                                  p_funcname => 'CC_INKRE(hWndMDI, 32, 0, 3)',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������i���i� (�������) �� �� ********** ');
          --  ��������� ������� ������i���i� (�������) �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������i���i� (�������) �� ��',
                                                  p_funcname => 'ExportCatQuery(4446,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��� �� ������� - ��������� ������ ********** ');
          --  ��������� ������� ��� �� ������� - ��������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��� �� ������� - ��������� ������',
                                                  p_funcname => 'ExportCatQuery(4992,"=(select ''ZE''||substr(ncks,2,3)||substr(bars_report.frmt_date(nvl(:sFdat1,to_char(gl.bd,''dd/mm/yyyy'')), ''DMY''),1,3)||''.TXT''  from rcukru where mfo=gl.kf)",7,"",TRUE)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DBF:Գ������� ������� �볺��� �� ********** ');
          --  ��������� ������� DBF:Գ������� ������� �볺��� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DBF:Գ������� ������� �볺��� ��',
                                                  p_funcname => 'ExportCatQuery(5254,"",12,"",TRUE)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� REP: ���. ��� ������� ������������� �볺��� ********** ');
          --  ��������� ������� REP: ���. ��� ������� ������������� �볺���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REP: ���. ��� ������� ������������� �볺���',
                                                  p_funcname => 'ExportCatQuery(5295,"=(select ''ZvitAccounts2''||substr(ncks,2,3)||substr(bars_report.frmt_date(nvl(:sFdat1,to_char(gl.bd,''dd/mm/yyyy'')), ''DMY''),1,3)||''.DBF'' from rcukru where mfo=gl.kf)",12,"",TRUE)',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� CCK: ���������� ������������� ������������ S080 ��� �� ********** ');
          --  ��������� ������� CCK: ���������� ������������� ������������ S080 ��� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'CCK: ���������� ������������� ������������ S080 ��� ��',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_SET_S080(2,:Param0)][PAR=>:Param0(SEM=����� ��� �������� � ���. ���� ��������  *,TYPE=C)][QST=> ���������� ������������� �������� S080 ��� �� ?][MSG=>������������ �������� !]")',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ <-> ������������ <-> ������� ********** ');
          --  ��������� ������� ������ <-> ������������ <-> �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ <-> ������������ <-> �������',
                                                  p_funcname => 'FunNSIEditF("CC_PAWN_DP",2)',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ��� ����������� ��������� ������ �� �������� ********** ');
          --  ��������� ������� ���������� ��� ����������� ��������� ������ �� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ��� ����������� ��������� ������ �� ��������',
                                                  p_funcname => 'FunNSIEditF("V_ACCOUNTS_RATN", 1 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-��� �i���i��� �i����� �� �� ��  (�� �i�, � ����) ********** ');
          --  ��������� ������� ��-��� �i���i��� �i����� �� �� ��  (�� �i�, � ����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-��� �i���i��� �i����� �� �� ��  (�� �i�, � ����)',
                                                  p_funcname => 'FunNSIEditF("V_CCK_MES2[PROC=>PUL_DAT(:Par1,'''')][PAR=>:Par1(SEM=���� ���i��� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��-��� �i���i��� �� ���i�� �� �� �� ********** ');
          --  ��������� ������� ��-��� �i���i��� �� ���i�� �� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��-��� �i���i��� �� ���i�� �� �� ��',
                                                  p_funcname => 'FunNSIEditF("V_CCK_SAL2[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM=���.���� ���i��� dd.mm.yyyy>,TYPE=S),:Par2(SEM=�i�.���� ���i��� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� *����������� �� ��i�� ���.������ �� ����.��� � 279 �.6.2.�� ********** ');
          --  ��������� ������� *����������� �� ��i�� ���.������ �� ����.��� � 279 �.6.2.��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*����������� �� ��i�� ���.������ �� ����.��� � 279 �.6.2.��',
                                                  p_funcname => 'FunNSIEditF("V_S080_2[PROC=>P_279_6_2 (''2'',:M,:B)][PAR=>:B(SEM=�����,TYPE=S,REF=BRANCH_VAR),:M(SEM=�ic��i�,TYPE=N,DEF=6) ][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³���������� ���������� ������� �� ������ ���� ********** ');
          --  ��������� ������� ³���������� ���������� ������� �� ������ ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³���������� ���������� ������� �� ������ ����',
                                                  p_funcname => 'FunNSIEditF("cc_trans_dat[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=�� ���� dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���������� ��� ������������ �� ������ ������� ********** ');
          --  ��������� ������� �������� ���������� ��� ������������ �� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������� ��� ������������ �� ������ �������',
                                                  p_funcname => 'FunNSIEditF(''V_CCK_DT_SS'',1)',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������. �������i ������. ********** ');
          --  ��������� ������� �������. �������i ������.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������. �������i ������.',
                                                  p_funcname => 'Sel002(hWndMDI,13,0," ob22 in ( ''981902'',''981903'',''981979'',''981983'', ''9819B8'' ) ","CC_PD9")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� � ����������� ����� ********** ');
          --  ��������� ������� ���� ���� � ����������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ���� � ����������� �����',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -2)',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (KREF) - ��� ������� ��  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKREF.sql =========*** En
PROMPT ===================================================================================== 
