SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_DEVR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  DEVR ***
  declare
    l_application_code varchar2(10 char) := 'DEVR';
    l_application_name varchar2(300 char) := '��� ����������';
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
     DBMS_OUTPUT.PUT_LINE(' DEVR ��������� (��� ���������) ��� ��� ���������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������������� �������� SNAP �� ���� ********** ');
          --  ��������� ������� �������������� �������� SNAP �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������������� �������� SNAP �� ����',
                                                  p_funcname => 'F1_Select(12,''DRAPS(DAT)'')',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� (����� ��������) ********** ');
          --  ��������� ������� ³������� �������� (����� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� (����� ��������)',
                                                  p_funcname => 'FunCheckDocumentsEx(hWndMDI, " a.TOBO = tobopack.GetTobo ")',
                                                  p_rolename => 'CHCK' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��� �� ���� ********** ');
          --  ��������� ������� �������� ��� �� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��� �� ����',
                                                  p_funcname => 'FunCheckDocumentsSel(99,'''','''',1,0)',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������������� ********** ');
          --  ��������� ������� ����������� ��������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������������',
                                                  p_funcname => 'FunMetaBaseEdit()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� AGG_02.��������� ����������� ������� �� �i���� ********** ');
          --  ��������� ������� AGG_02.��������� ����������� ������� �� �i����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'AGG_02.��������� ����������� ������� �� �i����',
                                                  p_funcname => 'FunNSIEdit("[PROC=>AGG_02(:D)][PAR=>:D(SEM=��i����_���i��=MM-YY,TYPE=S)][MSG=>��������!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �������� ���������� (��������� ��������) ********** ');
          --  ��������� ������� ���������� �������� ���������� (��������� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �������� ���������� (��������� ��������)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>DFO_BP(''2'')][QST=>������� ���������� �������� ��������� ����������?][MSG=>��������!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� SNAP-���������� �� ����(�����) ********** ');
          --  ��������� ������� �������� SNAP-���������� �� ����(�����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� SNAP-���������� �� ����(�����)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>DRAPS(:Param0)][PAR=>:Param0(SEM=��i��� ����,TYPE=D)][MSG=>��������!]")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ����������� ������� �� �i���� ********** ');
          --  ��������� ������� ��������� ����������� ������� �� �i����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ����������� ������� �� �i����',
                                                  p_funcname => 'FunNSIEdit("[PROC=>MDRAPS(:Param0)][PAR=>:Param0(SEM=��i��� ����,TYPE=D)][MSG=>��������!]")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �����, �����-���, ����, I���... ********** ');
          --  ��������� ������� ���������� �����, �����-���, ����, I���...
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� �����, �����-���, ����, I���...',
                                                  p_funcname => 'FunNSIEdit("[PROC=>NERUXOMI(0)][MSG=>OK NERUXOMI!]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������: 1=SNAP, 2=SALDOA ********** ');
          --  ��������� ������� ������������: 1=SNAP, 2=SALDOA
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������: 1=SNAP, 2=SALDOA',
                                                  p_funcname => 'FunNSIEdit("[PROC=>SNP_SALDOA(:sP)][PAR=>:sP(SEM=1_SNP/2_SAL),TYPE=S)][MSG=>OK SNP_SALDOA !]")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �� ������.���.(����) ********** ');
          --  ��������� ������� ����������� �� ������.���.(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �� ������.���.(����)',
                                                  p_funcname => 'FunNSIEditF("VPAY_ALT",0)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i����i��i��� �� �� ����i����� �� �i���� �����i� ********** ');
          --  ��������� ������� ���i����i��i��� �� �� ����i����� �� �i���� �����i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i����i��i��� �� �� ����i����� �� �i���� �����i�',
                                                  p_funcname => 'FunNSIEditF("V_NBS_BRANCH",1 | 0x0010)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWT. ������ �������� ��������� SWIFT (XML) ********** ');
          --  ��������� ������� SWT. ������ �������� ��������� SWIFT (XML)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWT. ������ �������� ��������� SWIFT (XML)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI, 3, 1, ''IMP_XML_SWIFT_BIC(sFileName,0)'', '''')',
                                                  p_rolename => 'BARS013' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� IMPEXP: ������ DBF ����� ********** ');
          --  ��������� ������� IMPEXP: ������ DBF �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'IMPEXP: ������ DBF �����',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,0,10,"","")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� IMPEXP: ������� ����� ������� � DBF ���� ********** ');
          --  ��������� ������� IMPEXP: ������� ����� ������� � DBF ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'IMPEXP: ������� ����� ������� � DBF ����',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,0,110,"","")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� ���i����� ����� ********** ');
          --  ��������� ������� I����� ���i����� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� ���i����� �����',
                                                  p_funcname => 'ImpOper(hWndMDI, 13)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ DBF-������� ********** ');
          --  ��������� ������� ������ DBF-�������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ DBF-�������',
                                                  p_funcname => 'Imp_Dbf_New (hWndMDI,2,0, '''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����6.3 --> ��� ���� ********** ');
          --  ��������� ������� ������ ����6.3 --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����6.3 --> ��� ����',
                                                  p_funcname => 'ImportDataAsvo63()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����6.5 --> ��� ���� ********** ');
          --  ��������� ������� ������ ����6.5 --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����6.5 --> ��� ����',
                                                  p_funcname => 'ImportDataAsvo65()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���� (�) --> ��� ���� ********** ');
          --  ��������� ������� ������ ���� (�) --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���� (�) --> ��� ����',
                                                  p_funcname => 'ImportDataFHitc()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �����5 (�) --> ��� ���� ********** ');
          --  ��������� ������� ������ �����5 (�) --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����5 (�) --> ��� ����',
                                                  p_funcname => 'ImportDataFSkarb5()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �����6 (�) --> ��� ���� ********** ');
          --  ��������� ������� ������ �����6 (�) --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����6 (�) --> ��� ����',
                                                  p_funcname => 'ImportDataFSkarb6()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ Unicorn(�) --> ��� ���� ********** ');
          --  ��������� ������� ������ Unicorn(�) --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ Unicorn(�) --> ��� ����',
                                                  p_funcname => 'ImportDataFUnicorn()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ������� ���� --> ��� ���� ********** ');
          --  ��������� ������� ������ ����������� ������� ���� --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����������� ������� ���� --> ��� ����',
                                                  p_funcname => 'ImportDataImmobile()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �������� --> ��� ���� ********** ');
          --  ��������� ������� ������ �������� --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �������� --> ��� ����',
                                                  p_funcname => 'ImportDataMegabank()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���� --> ��� ���� ********** ');
          --  ��������� ������� ������ ���� --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���� --> ��� ����',
                                                  p_funcname => 'ImportDataSBON()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����� --> ��� ���� ********** ');
          --  ��������� ������� ������ ����� --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����� --> ��� ����',
                                                  p_funcname => 'ImportDataSkarb()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ Unicorn --> ��� ���� ********** ');
          --  ��������� ������� ������ Unicorn --> ��� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ Unicorn --> ��� ����',
                                                  p_funcname => 'ImportDataUnicorn()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i��i� ����. ������� �� �����. ��.(����) ********** ');
          --  ��������� ������� �i��i� ����. ������� �� �����. ��.(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i��i� ����. ������� �� �����. ��.(����)',
                                                  p_funcname => 'KliTex(6,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���������ײ� ********** ');
          --  ��������� ������� ������������� ���������ײ�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���������ײ�',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ���-�� ********** ');
          --  ��������� ������� ����������� ���-��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ���-��',
                                                  p_funcname => 'Run_Arms( hWndMDI, 0 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWT. ������ ����������� ���������� ********** ');
          --  ��������� ������� SWT. ������ ����������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWT. ������ ����������� ����������',
                                                  p_funcname => 'Sel013(hWndMDI, 10, 0, '''', '''')',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ���� ����������/�����������(3-� ������) ********** ');
          --  ��������� ������� ������������� ���� ����������/�����������(3-� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ���� ����������/�����������(3-� ������)',
                                                  p_funcname => 'Sel015(hWndMDI,0,0,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ����������: ����������� ********** ');
          --  ��������� ������� ����� ����������: �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ����������: �����������',
                                                  p_funcname => 'Sel015(hWndMDI,4,1,''1'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ CSV ����� ********** ');
          --  ��������� ������� ������ CSV �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ CSV �����',
                                                  p_funcname => 'Sel016(hWndMDI,20,9,"","")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� DPT0 ��������� ������ ������ ********** ');
          --  ��������� ������� DPT0 ��������� ������ ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 ��������� ������ ������',
                                                  p_funcname => 'Sel016f(hWndMDI,8,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ��� 6-7 ����� (����������) ********** ');
          --  ��������� ������� ��������� ��� 6-7 ����� (����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ��� 6-7 ����� (����������)',
                                                  p_funcname => 'Sel023(hWndMDI,7,10,"PER_REBRANCH","")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� ������� ********** ');
          --  ��������� ������� ��������� ������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� �������',
                                                  p_funcname => 'Sel028(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ����� ********** ');
          --  ��������� ������� ����������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �����',
                                                  p_funcname => 'Sel037(hWndMDI,0,0,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ������������ ********** ');
          --  ��������� ������� ������ ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ������������',
                                                  p_funcname => 'ShowBAXTA(hWndMDI, TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������� ********** ');
          --  ��������� ������� ����������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������',
                                                  p_funcname => 'ShowOperEditor( hWndMDI, 9)',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������, �� �������������� ********** ');
          --  ��������� ������� ����������� �������, �� ��������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������, �� ��������������',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 1 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������������� ������(����) ********** ');
          --  ��������� ������� ����������� �������������� ������(����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �������������� ������(����)',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 3 )',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���� � ��� ********** ');
          --  ��������� ������� ������ ���� � ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���� � ���',
                                                  p_funcname => 'ShowSecurity()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ��������� ������ ����� �� S_UCH.DBF ********** ');
          --  ��������� ������� ���. ��������� ������ ����� �� S_UCH.DBF
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ��������� ������ ����� �� S_UCH.DBF',
                                                  p_funcname => 'ShowUpdateBanks()',
                                                  p_rolename => 'TECH020' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ����������� ********** ');
          --  ��������� ������� ������ �����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����������',
                                                  p_funcname => 'Show_USERS(hWndMDI ,TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ ********** ');
          --  ��������� ������� ������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������',
                                                  p_funcname => 'ZAPROS(hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� �������� ********** ');
          --  ��������� ������� ����������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� ��������',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, "")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (DEVR) - ��� ����������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappDEVR.sql =========*** En
PROMPT ===================================================================================== 
