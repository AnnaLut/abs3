  declare
    l_application_code varchar2(10 char) := '$RM_999';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
    l_function_ids number_list := number_list();
    l_application_id integer;
    l_arm_resource_type_id  integer := resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_application_type_id));
    l_func_resource_type_id integer := resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_application_type_id));
    l integer := 0;
    d integer := 0;
begin
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ������� �������� ���������� �������� 6,7 ��. �� ������� ********** ');
          --  ��������� ������� �������� ���������� �������� 6,7 ��. �� �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������� �������� 6,7 ��. �� �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>Perek_kp(0)][QST=>��������?][MSG=>��!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_999) - ��� �������� ����������� ����  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;
     
     DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
end;
/