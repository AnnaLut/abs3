SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_CHIF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  CHIF ***
  declare
    l_application_code varchar2(10 char) := 'CHIF';
    l_application_name varchar2(300 char) := '��� ����������� �� (�������� ���)';
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
     DBMS_OUTPUT.PUT_LINE(' CHIF ��������� (��� ���������) ��� ��� ����������� �� (�������� ���) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���� ������� ********** ');
          --  ��������� ������� ���. ���� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���� �������',
                                                  p_funcname => 'DOC_PROC(TRUE)',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� ��������� ********** ');
          --  ��������� ������� ���. ����� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� ���������',
                                                  p_funcname => 'DocViewListArc(hWndMDI,'''', '''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �����(���������) ********** ');
          --  ��������� ������� ������ �����(���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �����(���������)',
                                                  p_funcname => 'F1_Select(101,'''')',
                                                  p_rolename => 'TASK_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����I�.������� 2909/66->2620/29 ********** ');
          --  ��������� ������� �����I�.������� 2909/66->2620/29
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����I�.������� 2909/66->2620/29',
                                                  p_funcname => 'F1_Select(13,"for_2620_29_ALL(''NLR'');�������� �����I�.������� 2909/66->2620/29?; �� ��������� ����� !" )',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������-2012.������� 2906/16->2625/22 ********** ');
          --  ��������� ������� �������-2012.������� 2906/16->2625/22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������-2012.������� 2906/16->2625/22',
                                                  p_funcname => 'F1_Select(13,"for_2625_22(''NLA'',''2625'',''22'');�������� �������-2012.������� 2906/16->2625/22?; �� !" )',
                                                  p_rolename => 'DPT_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ��������� ��� ********** ');
          --  ��������� ������� ���. ��������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ��������� ���',
                                                  p_funcname => 'ModyTok()',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���������, ��������� �� ������ (�˲���-����) ********** ');
          --  ��������� ������� �������� ���������, ��������� �� ������ (�˲���-����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������, ��������� �� ������ (�˲���-����)',
                                                  p_funcname => 'Sel000(hWndMDI,4,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ���������  (�Ѳ) ********** ');
          --  ��������� ������� ���. ���������� ���������  (�Ѳ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ���������  (�Ѳ)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",'''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ��������� � ���������� ����� �����������, �� �� ������� ********** ');
          --  ��������� ������� ���. ��������� � ���������� ����� �����������, �� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ��������� � ���������� ����� �����������, �� �� �������',
                                                  p_funcname => 'Sel014(hWndMDI,11,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³����� ��� ********** ');
          --  ��������� ������� ³����� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³����� ���',
                                                  p_funcname => 'Sel014(hWndMDI,12,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� 3720  (���) ********** ');
          --  ��������� ������� ���. ����� 3720  (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� 3720  (���)',
                                                  p_funcname => 'Sel014(hWndMDI,2,0,'''',''a.kv<>980'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����� 3720  (���) ********** ');
          --  ��������� ������� ���. ����� 3720  (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����� 3720  (���)',
                                                  p_funcname => 'Sel014(hWndMDI,2,0,'''',''a.kv=980'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� � ���.�i��i����� ********** ');
          --  ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� � ���.�i��i�����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������i i��-�i: ������ �� ����.����.�� �������� � ���.�i��i�����',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',"mfoA<>:TZ.sBankMfo  AND  (accounts.TOBO=tobopack.GetTobo  or  length(tobopack.GetTobo)=8 and accounts.TOBO like ''%000000%'')")',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� ������ ����� ********** ');
          --  ��������� ������� �������i i��-�i: ������ �� ����.����.�� �������� ������ �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������i i��-�i: ������ �� ����.����.�� �������� ������ �����',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',''mfoA<>:TZ.sBankMfo  AND mfoB=:TZ.sBankMfo'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ��� ����� ********** ');
          --  ��������� ������� ���. ���������� ��� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ��� �����',
                                                  p_funcname => 'Sel014(hWndMDI,5,1,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.���������� � ������ ********** ');
          --  ��������� ������� 1.���������� � ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.���������� � ������',
                                                  p_funcname => 'Sel015(hWndMDI,1,1,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.���������� 2902-2600 ********** ');
          --  ��������� ������� 1.���������� 2902-2600
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.���������� 2902-2600',
                                                  p_funcname => 'Sel015(hWndMDI,1,2, ''S'',''a.isp=''||Str(GetUserId()) )',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.��������� ����-���� ���� ����������/����������� ********** ');
          --  ��������� ������� 1.��������� ����-���� ���� ����������/�����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.��������� ����-���� ���� ����������/�����������',
                                                  p_funcname => 'Sel015(hWndMDI,11,0,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ �������� ����� ��� (S_UCH.DBF) ********** ');
          --  ��������� ������� ������������ �������� ����� ��� (S_UCH.DBF)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �������� ����� ��� (S_UCH.DBF)',
                                                  p_funcname => 'Selector(hWndMDI,1)',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��� ������� ********** ');
          --  ��������� ������� �������� ��� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��� �������',
                                                  p_funcname => 'ShowAllAccounts(hWndMDI)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������/������������ �������� ********** ');
          --  ��������� ������� ���. ���������/������������ ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������/������������ ��������',
                                                  p_funcname => 'ShowDirection()',
                                                  p_rolename => 'TECH007' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����������� ��������� ��� ********** ');
          --  ��������� ������� ���. ����������� ��������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����������� ��������� ���',
                                                  p_funcname => 'ShowSendMessage()',
                                                  p_rolename => 'TECH019' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ����� ********** ');
          --  ��������� ������� ���. ���������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� �����',
                                                  p_funcname => 'ShowSetTechFlags()',
                                                  p_rolename => 'TOSS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ������� ********** ');
          --  ��������� ������� ���. ���������� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� �������',
                                                  p_funcname => 'ShowTechAccountsEx(0)',
                                                  p_rolename => 'TECH001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� 1.�������� �������� ������������ ********** ');
          --  ��������� ������� 1.�������� �������� ������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.�������� �������� ������������',
                                                  p_funcname => 'Show_USERS(hWndMDI , FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (CHIF) - ��� ����������� �� (�������� ���)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappCHIF.sql =========*** En
PROMPT ===================================================================================== 
