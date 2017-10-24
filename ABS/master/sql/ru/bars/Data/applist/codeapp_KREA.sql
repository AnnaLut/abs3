SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KREA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KREA ***
  declare
    l_application_code varchar2(10 char) := 'KREA';
    l_application_name varchar2(300 char) := '��� ��������������� ������i� ��';
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
     DBMS_OUTPUT.PUT_LINE(' KREA ��������� (��� ���������) ��� ��� ��������������� ������i� �� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F1_2: ���_�������� ������_� �� 9129 �� �� �� ********** ');
          --  ��������� ������� �� F1_2: ���_�������� ������_� �� 9129 �� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F1_2: ���_�������� ������_� �� 9129 �� �� ��',
                                                  p_funcname => 'F1_Select(12, " cck.CC_9129( DAT, 0, 2 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F6: ���������� ���������� ��� �� ����� ���� ********** ');
          --  ��������� ������� �� F6: ���������� ���������� ��� �� ����� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F6: ���������� ���������� ��� �� ����� ����',
                                                  p_funcname => 'F1_Select(12, "cck_arc_cc_lim ( DAT , -1) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� �����-����� �������� �� ********** ');
          --  ��������� ������� ��������� ������� �����-����� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� �����-����� �������� ��',
                                                  p_funcname => 'F1_Select(12,"CCK_SCAN (''%'') ") ',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �� �� - ������ �� ���������(�� ������) ********** ');
          --  ��������� ������� ������� �� �� - ������ �� ���������(�� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �� �� - ������ �� ���������(�� ������)',
                                                  p_funcname => 'F1_Select(12,"CCT.StartI (0)")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �� �� - ������� � ����������(�� ������) ********** ');
          --  ��������� ������� ������� �� �� - ������� � ����������(�� ������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �� �� - ������� � ����������(�� ������)',
                                                  p_funcname => 'F1_Select(12,"CCT.StartIO (0)")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S69: ������� �� ������������� ��������� ���. ********** ');
          --  ��������� ������� �� S69: ������� �� ������������� ��������� ���.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S69: ������� �� ������������� ��������� ���.',
                                                  p_funcname => 'F1_Select(13,  "PENY_PAY(DAT,0);������� ��������� ���?; ��������� ���������!"  ) ',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F05_2: ���� ����� ���-�� ISG (3600) ����-� ������-� �� (SPN,SN) ********** ');
          --  ��������� ������� �� F05_2: ���� ����� ���-�� ISG (3600) ����-� ������-� �� (SPN,SN)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F05_2: ���� ����� ���-�� ISG (3600) ����-� ������-� �� (SPN,SN)',
                                                  p_funcname => 'F1_Select(13,"CC_ISG(-1,''SPN|SN '');�� ������ ������� ���� ����� ������� ����-� ������-� ��?; �������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S36: ����������� �� ���������� ������� ����� ��� ����� �� ********** ');
          --  ��������� ������� �� S36: ����������� �� ���������� ������� ����� ��� ����� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S36: ����������� �� ���������� ������� ����� ��� ����� ��',
                                                  p_funcname => 'FunNSIEdit("[PROC=>CCK_SBER(''2'',''2'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C)][QST=>������� ������� % ����� ��� ����� �� ?][MSG=>����������� �������� !]")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� �� ********** ');
          --  ��������� ������� �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��',
                                                  p_funcname => 'FunNSIEdit("[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� �� ********** ');
          --  ��������� ������� #2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��',
                                                  p_funcname => 'FunNSIEdit("[PROC=>CCK_SBER(''3'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� �� ********** ');
          --  ��������� ������� #2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��',
                                                  p_funcname => 'FunNSIEdit("[PROC=>CCK_SBER(''3'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������� "����" ********** ');
          --  ��������� ������� �������� �������� "����"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������� "����"',
                                                  p_funcname => 'FunNSIEditF("V_CCK_OSBB[PROC=>cck_OSBB_ex(0)][EXEC=>BEFORE]", 2 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F12: ���i����� ����������� %% �� ��� ���. � �� �� ********** ');
          --  ��������� ������� �� F12: ���i����� ����������� %% �� ��� ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F12: ���i����� ����������� %% �� ��� ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (1,2,3))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #5) �� F13: ���i����� ����������� %% �� ��� ���. � �� �� ********** ');
          --  ��������� ������� #5) �� F13: ���i����� ����������� %% �� ��� ���. � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#5) �� F13: ���i����� ����������� %% �� ��� ���. � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (11,12,13))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S55: ����������� %%  �� �� � ��������� �� ���. ��������� �� ********** ');
          --  ��������� ������� �� S55: ����������� %%  �� �� � ��������� �� ���. ��������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S55: ����������� %%  �� �� � ��������� �� ���. ��������� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SS '',''SP '' , ''SL '') and exists (select n.acc from nd_acc n, nd_acc n2,accounts a2  where n.acc=s.acc and  n.nd=n2.nd and n2.acc=a2.acc and a2.tip=''SG '' and a2.ostc>0)",''SA''),''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S54: ����������� %%  �� �� � ��������� �� ���. ��������� �� ********** ');
          --  ��������� ������� �� S54: ����������� %%  �� �� � ��������� �� ���. ��������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S54: ����������� %%  �� �� � ��������� �� ���. ��������� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''22%'' and s.tip in (''SS '',''SP '' , ''SL '') and exists (select n.acc from nd_acc n, nd_acc n2,accounts a2  where n.acc=s.acc and  n.nd=n2.nd and n2.acc=a2.acc and a2.tip=''SG '' and a2.ostc>0)",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #3) �� S42: ����������� %% �� ��. ����� � �� �� (��ӯ���) ********** ');
          --  ��������� ������� #3) �� S42: ����������� %% �� ��. ����� � �� �� (��ӯ���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#3) �� S42: ����������� %% �� ��. ����� � �� �� (��ӯ���)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.tip in(''SS '',''SP '')  and s.acc in (select N.acc from nd_acc n, cc_v d  where d.GPK=4 and n.nd=d.nd and d.vidd=1  and cck.PAY_GPK(gl.bd,D.ND,null)=1)","SAN")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #3) �� S43: ����������� %% �� ��. ����� � �� �� (��ӯ���) ********** ');
          --  ��������� ������� #3) �� S43: ����������� %% �� ��. ����� � �� �� (��ӯ���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#3) �� S43: ����������� %% �� ��. ����� � �� �� (��ӯ���)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.tip in(''SS '',''SP '')  and s.acc in (select N.acc from nd_acc n, cc_v d  where d.GPK=4 and n.nd=d.nd and d.vidd=11  and cck.PAY_GPK(gl.bd,D.ND,null)=1)","SAN")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F22: ���i����� ����������� ���� �� ��. ********** ');
          --  ��������� ������� �� F22: ���i����� ����������� ���� �� ��.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F22: ���i����� ����������� ���� �� ��.',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=2 and i.metr in (95,96,97,98) and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc nn,cc_deal dd where nn.nd=dd.nd and dd.vidd in (1,2,3) and nn.acc=s.acc) ",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (KREA) - ��� ��������������� ������i� ��  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKREA.sql =========*** En
PROMPT ===================================================================================== 
