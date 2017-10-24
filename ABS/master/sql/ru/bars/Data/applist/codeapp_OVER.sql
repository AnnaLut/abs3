SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_OVER.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  OVER ***
  declare
    l_application_code varchar2(10 char) := 'OVER';
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
     DBMS_OUTPUT.PUT_LINE(' OVER ��������� (��� ���������) ��� ��� ���������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ��������� % � �����i� ����  ********** ');
          --  ��������� ������� OVR:  ��������� % � �����i� ���� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ��������� % � �����i� ���� ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(1,0,0,0)'' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ��������� % �� ��������i  ********** ');
          --  ��������� ������� OVR:  ��������� % �� ��������i 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ��������� % �� ��������i ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(11,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ����������� �� ���������  ********** ');
          --  ��������� ������� OVR:  ����������� �� ��������� 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ����������� �� ��������� ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(2,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������� �������� % ********** ');
          --  ��������� ������� OVR:  �������� �������� %
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������� �������� %',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(3,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ��������� ��i� ����i� ********** ');
          --  ��������� ������� OVR:  ��������� ��i� ����i�
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ��������� ��i� ����i�',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(33,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ��������� ���������   ********** ');
          --  ��������� ������� OVR:  ��������� ���������  
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ��������� ���������  ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(4,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �����.���i�i� �� ���������� ��������� ********** ');
          --  ��������� ������� OVR:  �����.���i�i� �� ���������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �����.���i�i� �� ���������� ���������',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(62,0,0,0)''  )',
                                                  p_rolename => 'TECH005' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  ����������� ���������� ������. �� ����i��� ********** ');
          --  ��������� ������� OVR:  ����������� ���������� ������. �� ����i���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  ����������� ���������� ������. �� ����i���',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(96,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������� ����������� ������������ �� ������. ********** ');
          --  ��������� ������� OVR:  �������� ����������� ������������ �� ������.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������� ����������� ������������ �� ������.',
                                                  p_funcname => 'F1_Select(122, '' '' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� OVR:  �������� ��������Ҳ�  (��) ********** ');
          --  ��������� ������� OVR:  �������� ��������Ҳ�  (��)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  �������� ��������Ҳ�  (��)',
                                                  p_funcname => 'Sel009(hWndMDI,0,7,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� % �� �������� ���������i� (2600,2067,3600) ********** ');
          --  ��������� ������� ����������� % �� �������� ���������i� (2600,2067,3600)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� % �� �������� ���������i� (2600,2067,3600)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and (s.ACC in (Select ACCO from ACC_OVER) or s.ACC in (Select ACC_3600 from ACC_OVER) or s.ACC in (Select ACC_9129 from ACC_OVER)) and not (s.NBS=''2600'' and i.ID=1)", ''SA'')',
                                                  p_rolename => 'TECH005' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� (OVER) - ��� ����������  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappOVER.sql =========*** En
PROMPT ===================================================================================== 
