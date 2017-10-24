SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_FFF2.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  FFF2 ***
  declare
    l_application_code varchar2(10 char) := 'FFF2';
    l_application_name varchar2(300 char) := '��� ������������������ ��������  �� (��) ';
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
     DBMS_OUTPUT.PUT_LINE(' FFF2 ��������� (��� ���������) ��� ��� ������������������ ��������  �� (��)  ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �� �������� ��Ͳ ********** ');
          --  ��������� ������� �������� �� �������� ��Ͳ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �� �������� ��Ͳ',
                                                  p_funcname => 'F1_Select ( 12, " PAY_SN8 ( 2 ) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� S. ����-��������� ������� ����� SS -  �� ********** ');
          --  ��������� ������� S. ����-��������� ������� ����� SS -  ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S. ����-��������� ������� ����� SS -  ��',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( -1, 1 ) "  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F0_2: ����-����_� ������_� ��������� SG �� ********** ');
          --  ��������� ������� �� F0_2: ����-����_� ������_� ��������� SG ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F0_2: ����-����_� ������_� ��������� SG ��',
                                                  p_funcname => 'F1_Select(12, " CCK_ASG_SBER ( 2 , 1 )"  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������������� ��������� 9129 ********** ');
          --  ��������� ������� OVR:  �������������� ��������� 9129
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������������� ��������� 9129',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(91,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F05: ���� ����� ������� ISG (3600) ����-� ������-� �� (SPN,SN) ********** ');
          --  ��������� ������� �� F05: ���� ����� ������� ISG (3600) ����-� ������-� �� (SPN,SN)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F05: ���� ����� ������� ISG (3600) ����-� ������-� �� (SPN,SN)',
                                                  p_funcname => 'F1_Select(13,"CC_ISG(0,''SPN|SN '');�� ������ ������� ���� ����� ������� ����-� ������-� ?; �������� !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S7_2: ����������� ��������/���쳿 �� ********** ');
          --  ��������� ������� �� S7_2: ����������� ��������/���쳿 ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S7_2: ����������� ��������/���쳿 ��',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY_PET(-1,DAT,3);�� ������ ���. ���������� �������� ��?; ��������!" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� �� ********** ');
          --  ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(2,DAT,0);�� ������ ������� �� ��������� ��� ������ ������� ?; ��������� !" )',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� R01: ���� �� ������������ �������� �� �� ********** ');
          --  ��������� ������� �� R01: ���� �� ������������ �������� �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� R01: ���� �� ������������ �������� �� ��',
                                                  p_funcname => 'FunNSIEditF("TMP_CCK_REP[NSIFUNCTION][PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=���� �������,TYPE=N,REF=V_CCK_REP_LIST_YL)][EXEC=>BEFORE][MSG=>��������!]", 6)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� % �� �������� ���������i� (2600,2067,3600) ********** ');
          --  ��������� ������� ����������� % �� �������� ���������i� (2600,2067,3600)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� % �� �������� ���������i� (2600,2067,3600)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and (s.ACC in (Select ACCO from ACC_OVER) or s.ACC in (Select ACC_3600 from ACC_OVER) or s.ACC in (Select ACC_9129 from ACC_OVER)) and not (s.NBS=''2600'' and i.ID=1)", ''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S42: ����������� %%  �� �������� �����. ����� � �� �� ********** ');
          --  ��������� ������� �� S42: ����������� %%  �� �������� �����. ����� � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S42: ����������� %%  �� �������� �����. ����� � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SS '',''SP '') and i.acra is not null and i.acrb is not null and exists (select 1 from cc_lim where acc=s.accc and fdat=gl.bd  and sumo>0 and not_sn is null)",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F40: ����������� ���� �� 9129 � �� �� ********** ');
          --  ��������� ������� �� F40: ����������� ���� �� 9129 � �� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F40: ����������� ���� �� 9129 � �� ��',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''9129%'' and s.tip in (''CR9'') and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc n,cc_deal d where n.nd=d.nd and d.vidd in (1,2,3) and n.acc=s.acc)",''A'')',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (FFF2) - ��� ������������������ ��������  �� (��)   ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappFFF2.sql =========*** En
PROMPT ===================================================================================== 
