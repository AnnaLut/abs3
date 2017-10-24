SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_TEHA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  TEHA ***
  declare
    l_application_code varchar2(10 char) := 'TEHA';
    l_application_name varchar2(300 char) := '��� ���������� ������';
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
     DBMS_OUTPUT.PUT_LINE(' TEHA ��������� (��� ���������) ��� ��� ���������� ������ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� � ����� �����������, �� �������, ��� �� ������� �� ����� ********** ');
          --  ��������� ������� ��������� � ����� �����������, �� �������, ��� �� ������� �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� � ����� �����������, �� �������, ��� �� ������� �� �����',
                                                  p_funcname => 'DocViewListPayLog( hWndMDI, "", "" )',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��� --> ���� ********** ');
          --  ��������� ������� �������� ��� --> ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��� --> ����',
                                                  p_funcname => 'ExportCatQuery(4853,'''',1,'''',TRUE)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������  Cddmm.dbf  ����� ��� ���  ********** ');
          --  ��������� ������� ����������  Cddmm.dbf  ����� ��� ��� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������  Cddmm.dbf  ����� ��� ��� ',
                                                  p_funcname => 'ExportCatQuery(55,'''',1,'''',TRUE)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���� --> ���� ********** ');
          --  ��������� ������� �������� ���� --> ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���� --> ����',
                                                  p_funcname => 'ExportCatQuery(5614,'''',1,'''',TRUE)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� 15% �� ���������� ������ �� ********** ');
          --  ��������� ������� ��������� ������� 15% �� ���������� ������ ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� 15% �� ���������� ������ ��',
                                                  p_funcname => 'F1_Select(13, "BARS.INT15(DAT);�������� <��������� ������� 15% �� ���������� ������ ��>?;��������!")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����������� �������� ********** ');
          --  ��������� ������� ��������� ����������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����������� ��������',
                                                  p_funcname => 'F1_Select(13, "BARS.dpt_finally_amort(DAT);�������� <��������� ����������� ��������>?;��������!")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� B. ��������� �������� "������������������ ������" ********** ');
          --  ��������� ������� B. ��������� �������� "������������������ ������"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'B. ��������� �������� "������������������ ������"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_EXTN'',NUMBER_Null);�������� <������������������ ������>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 5. ��������� �������� "������������� ������ �� %% � ���� ������ 䳿" ********** ');
          --  ��������� ������� 5. ��������� �������� "������������� ������ �� %% � ���� ������ 䳿"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. ��������� �������� "������������� ������ �� %% � ���� ������ 䳿"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_MATU'',NUMBER_Null);�������� <������������� ������ �� %% � ���� ������ 䳿>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 7. ��������� �������� "�����������/������� %% �� ������� (���.������)" ********** ');
          --  ��������� ������� 7. ��������� �������� "�����������/������� %% �� ������� (���.������)"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7. ��������� �������� "�����������/������� %% �� ������� (���.������)"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_PIPL'',NUMBER_Null);�������� <����������� � ������� %% �� ���.�������>?;��������!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ����������� ������� ********** ');
          --  ��������� ������� ������������ ����������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ����������� �������',
                                                  p_funcname => 'F1_Select(13,"bars_accm_sync.sync_snap(''BALANCE'',GetBankDate(), 0);�������� ����������� �������?;����������� ������� �� �������� ��������� ���� ��������")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ XML-����� ������ ��������� ********** ');
          --  ��������� ������� ������ XML-����� ������ ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ XML-����� ������ ���������',
                                                  p_funcname => 'F1_Select(189,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-��������: ������ �������� ����� ********** ');
          --  ��������� ������� ������-��������: ������ �������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-��������: ������ �������� �����',
                                                  p_funcname => 'F1_Select(191,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-��������: ������������ ���������� �������� ********** ');
          --  ��������� ������� ������-��������: ������������ ���������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-��������: ������������ ���������� ��������',
                                                  p_funcname => 'F1_Select(192,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-��������: ������ ����� �� ������������ ���������� �������� ********** ');
          --  ��������� ������� ������-��������: ������ ����� �� ������������ ���������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-��������: ������ ����� �� ������������ ���������� ��������',
                                                  p_funcname => 'F1_Select(193,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ VIP ********** ');
          --  ��������� ������� ������ VIP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ VIP',
                                                  p_funcname => 'F1_Select(307,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������ ������� ��� ³������ ��� ********** ');
          --  ��������� ������� ��������� ������ ������� ��� ³������ ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������ ������� ��� ³������ ���',
                                                  p_funcname => 'FListRun(0, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������ ������� ��� ������� ��� ********** ');
          --  ��������� ������� ��������� ������ ������� ��� ������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������ ������� ��� ������� ���',
                                                  p_funcname => 'FListRun(1, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ���-�������� (�������� ��������) ********** ');
          --  ��������� ������� ��������� ���-�������� (�������� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ���-�������� (�������� ��������)',
                                                  p_funcname => 'F_Pay_Bck( hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� i��.��� ������.��i�i� ********** ');
          --  ��������� ������� ���������� i��.��� ������.��i�i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� i��.��� ������.��i�i�',
                                                  p_funcname => 'FunNSIEdit("[PROC=>ANI_AUTO(0,:Param0)][PAR=>:Param0(SEM=��i��� ����,TYPE=D)][MSG=>��������!]")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� 15% �� ���������� ������ �� (�� �������� ��) ********** ');
          --  ��������� ������� ��������� ������� 15% �� ���������� ������ �� (�� �������� ��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� 15% �� ���������� ������ �� (�� �������� ��)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>INT15_dailycheck(:sPar1)][PAR=>:sPar1(SEM=���� ��,TYPE=D)][MSG=>��������!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <���.�������� ���.���> ���������� ��������� ********** ');
          --  ��������� ������� <���.�������� ���.���> ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<���.�������� ���.���> ���������� ���������',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_ZVT_DOC(:D)][PAR=>:D(SEM=��i���_���� DD.MM.YYYY>,TYPE=S)][MSG=>����������]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <���.�������� ���.���> ����������  ��������� ********** ');
          --  ��������� ������� <���.�������� ���.���> ����������  ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<���.�������� ���.���> ����������  ���������',
                                                  p_funcname => 'FunNSIEditF("V_ZVT_KOL",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���: �������� ������ �� T00. ********** ');
          --  ��������� ������� ���: �������� ������ �� T00.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���: �������� ������ �� T00.',
                                                  p_funcname => 'FunNSIEditF(''OPL4'', 2 | 0x0010)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ������ �� ����������� �� ������ ������� ********** ');
          --  ��������� ������� ����� ������ �� ����������� �� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ������ �� ����������� �� ������ �������',
                                                  p_funcname => 'FunNSIEditF(''V_DPT_INTPAYPRETENDERS'', 1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� ����� ********** ');
          --  ��������� ������� ������ �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� �����',
                                                  p_funcname => 'RunHoliday(hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� A���������� ���  �������� �� ���������� ********** ');
          --  ��������� ������� A���������� ���  �������� �� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A���������� ���  �������� �� ����������',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and s.NBS=''2636'' and i.metr=4 ", "SA" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S62: ����������� ���i  � �� �� ********** ');
          --  ��������� ������� �� S62: ����������� ���i  � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S62: ����������� ���i  � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''20%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs2 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ODB. ������� ���������� ���� ********** ');
          --  ��������� ������� ODB. ������� ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ODB. ������� ���������� ����',
                                                  p_funcname => 'ShowCloseBankDay()',
                                                  p_rolename => 'TECH005' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� � ��� ********** ');
          --  ��������� ������� ������� � ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� � ���',
                                                  p_funcname => 'ShowFilesNbu(hWndMDI) ',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.����²����Ͳ ���������-2 ********** ');
          --  ��������� ������� 1.����²����Ͳ ���������-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.����²����Ͳ ���������-2',
                                                  p_funcname => 'ShowNotPayDok(0)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.����²����Ͳ ��������� ********** ');
          --  ��������� ������� 1.����²����Ͳ ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.����²����Ͳ ���������',
                                                  p_funcname => 'ShowNotPayDok(1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ODB. ³������ ���������� ���� ********** ');
          --  ��������� ������� ODB. ³������ ���������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ODB. ³������ ���������� ����',
                                                  p_funcname => 'ShowOpenBankDay()',
                                                  p_rolename => 'TECH005' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �������� �� ���������� ��� ********** ');
          --  ��������� ������� ��������� �������� �� ���������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �������� �� ���������� ���',
                                                  p_funcname => 'StatBankDay()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (TEHA) - ��� ���������� ������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappTEHA.sql =========*** En
PROMPT ===================================================================================== 
