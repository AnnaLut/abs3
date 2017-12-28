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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Функція наповнення довідника перекриття 6,7 класів на 5040(5041) ********** ');
          --  Створюємо Функцію наповнення довідника перекриття 6,7 класів на 5040(5041)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Функція наповнення довідника перекриття 6,7 класів на 5040(5041)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>p_fill_perek6_7(:Param0,:Param1)][PAR=>:Param0(SEM=Рахунок 50**,TYPE=C),:Param1(SEM=Призначення платежу,TYPE=C)][QST=>Виконати?][MSG=>ОК!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_999) - АРМ Закриття фінансового року  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;
     
     DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
end;
/