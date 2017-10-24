SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_MIGV.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  MIGV ***
  declare
    l_application_code varchar2(10 char) := 'MIGV';
    l_application_name varchar2(300 char) := 'АРМ Міграція вкладів';
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
     DBMS_OUTPUT.PUT_LINE(' MIGV створюємо (або оновлюємо) АРМ АРМ Міграція вкладів ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт компенсаційних вкладів АСВО6.3 (перегляд по ТВБВ) ********** ');
          --  Створюємо функцію Імпорт компенсаційних вкладів АСВО6.3 (перегляд по ТВБВ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт компенсаційних вкладів АСВО6.3 (перегляд по ТВБВ)',
                                                  p_funcname => 'FunNSIEditF("V_COMPEN_COUNT",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт АСВО6.3 --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт АСВО6.3 --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт АСВО6.3 --> АБС БАРС',
                                                  p_funcname => 'ImportDataAsvo63()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт АСВО6.5 --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт АСВО6.5 --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт АСВО6.5 --> АБС БАРС',
                                                  p_funcname => 'ImportDataAsvo65()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт неподвижных вкладов АСВО --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт неподвижных вкладов АСВО --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт неподвижных вкладов АСВО --> АБС БАРС',
                                                  p_funcname => 'ImportDataImmobile()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт МЕГАБАНК --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт МЕГАБАНК --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт МЕГАБАНК --> АБС БАРС',
                                                  p_funcname => 'ImportDataMegabank()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт СБОН --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт СБОН --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт СБОН --> АБС БАРС',
                                                  p_funcname => 'ImportDataSBON()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт компенсаційних вкладів АСВО6.3 --> ЦРКР ********** ');
          --  Створюємо функцію Імпорт компенсаційних вкладів АСВО6.3 --> ЦРКР
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт компенсаційних вкладів АСВО6.3 --> ЦРКР',
                                                  p_funcname => 'Sel000(hWndMDI,49,0,"","")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт компенсаційних вкладів ДЕЛЬТАБАНК --> ЦРКР ********** ');
          --  Створюємо функцію Імпорт компенсаційних вкладів ДЕЛЬТАБАНК --> ЦРКР
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт компенсаційних вкладів ДЕЛЬТАБАНК --> ЦРКР',
                                                  p_funcname => 'Sel000(hWndMDI,50,0,"","")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт компенсаційних вкладів МЕГАБАНК --> ЦРКР ********** ');
          --  Створюємо функцію Імпорт компенсаційних вкладів МЕГАБАНК --> ЦРКР
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт компенсаційних вкладів МЕГАБАНК --> ЦРКР',
                                                  p_funcname => 'Sel000(hWndMDI,51,0,"","")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (MIGV) - АРМ Міграція вкладів  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;


    DBMS_OUTPUT.PUT_LINE(' Bидані функції можливо потребують підтвердження - автоматично підтверджуємо їх ');
    for i in (select a.id
              from   adm_resource_activity a
              where  a.grantee_type_id = l_arm_resource_type_id and
                     a.resource_type_id = l_func_resource_type_id and
                     a.grantee_id = l_application_id and
                     a.resource_id in (select column_value from table(l_function_ids))  and
                     a.access_mode_id = 1 and
                     a.resolution_time is null) loop
        resource_utl.approve_resource_access(i.id, 'Автоматичне підтвердження прав на функції для АРМу');
    end loop;
     DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappMIGV.sql =========*** En
PROMPT ===================================================================================== 
