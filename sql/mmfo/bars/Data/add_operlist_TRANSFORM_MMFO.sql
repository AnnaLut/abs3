declare
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
    l_function_id integer;
begin
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' Перегляд прогнозних номерів рахунків');
          --  Створення чудо-функції
      l_function_id :=   operlist_adm.add_new_func(
                                                  p_name     => 'Перегляд прогнозних номерів рахунків',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'tableName=TRANSFORM_2017_FORECAST',
                                                  p_frontend => l_application_type_id
                                                  );

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу $RM_BUHG - $RM_METO ');
   operlist_adm.add_func_to_arm(l_function_id, '$RM_BUHG', p_approve => true);
   operlist_adm.add_func_to_arm(l_function_id, '$RM_METO', p_approve => true);
   DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
end;
/