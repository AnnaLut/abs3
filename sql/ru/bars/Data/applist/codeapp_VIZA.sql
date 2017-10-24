SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_VIZA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  VIZA ***
  declare
    l_application_code varchar2(10 char) := 'VIZA';
    l_application_name varchar2(300 char) := '��� ��������� ��������';
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
     DBMS_OUTPUT.PUT_LINE(' VIZA ��������� (��� ���������) ��� ��� ��������� �������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �� �������� �������� ********** ');
          --  ��������� ������� ��������� �� �������� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �� �������� ��������',
                                                  p_funcname => 'DocViewListInt(hWndMDI,'' a.ref in (select p.ref from opldok p, accounts a where a.acc=p.acc and a.TOBO=tobopack.GetTobo)'', ''��������� �� ���. ��������'' )',
                                                  p_rolename => 'RPBN001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� (����� ����. � ϳ�������) ********** ');
          --  ��������� ������� ³������� �������� (����� ����. � ϳ�������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� (����� ����. � ϳ�������)',
                                                  p_funcname => 'FunCheckDocumentsEx(hWndMDI, " a.TOBO like tobopack.GetTobo || ''%'' ")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I�����   : ����� ��� ���������� ��������� ********** ');
          --  ��������� ������� I�����   : ����� ��� ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I�����   : ����� ��� ���������� ���������',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 3, '''','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �i��i� ��������i� ��� �i�. ���i���i��� [��������� �I�����I��] ********** ');
          --  ��������� ������� ��. �i��i� ��������i� ��� �i�. ���i���i��� [��������� �I�����I��]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �i��i� ��������i� ��� �i�. ���i���i��� [��������� �I�����I��]',
                                                  p_funcname => 'Sel005(hWndMDI,0,1,''IBS5C'',''exists (select 1 from v_fm_func_kontr where ref = v_finmon_que.ref)'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� �������(����� �������) ********** ');
          --  ��������� ������� �������� �������(����� �������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� �������(����� �������)',
                                                  p_funcname => 'ShowAccList(0, AVIEW_ALL, AVIEW_Linked| AVIEW_Special, "a.acc in (select acc from accounts where substr(branch,1,15) in (select branch from cash_sxo_b where branch_sxo = sys_context(''bars_context'',''user_branch'')))")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������-�������-�������� �� ������� ********** ');
          --  ��������� ������� ������-�������-�������� �� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������-�������-�������� �� �������',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,189)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (VIZA) - ��� ��������� ��������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappVIZA.sql =========*** En
PROMPT ===================================================================================== 
