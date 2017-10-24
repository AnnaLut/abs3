SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_BIRZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  BIRZ ***
  declare
    l_application_code varchar2(10 char) := 'BIRZ';
    l_application_name varchar2(300 char) := 'АРМ Біржеві операції(ЗАГАЛЬНИЙ)';
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
     DBMS_OUTPUT.PUT_LINE(' BIRZ створюємо (або оновлюємо) АРМ АРМ Біржеві операції(ЗАГАЛЬНИЙ) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAYO. Передача інформації щодо надходжень ********** ');
          --  Створюємо функцію ZAYO. Передача інформації щодо надходжень
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAYO. Передача інформації щодо надходжень',
                                                  p_funcname => 'F1_Select(13,"bars_zay.set_currency_income(DAT);Виконати передачу даних про надходження в ЦА?;Виконано!")',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAYR. Формування та редагування надходжень ********** ');
          --  Створюємо функцію ZAYR. Формування та редагування надходжень
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAYR. Формування та редагування надходжень',
                                                  p_funcname => 'FunNSIEditF("zay_currency_income[PROC=>p_zay_currency_income(:Par0,:Par1)][PAR=>:Par0(SEM=Дата,TYPE=D),:Par1(SEM=Переформувати?Так->1/Нi->0,TYPE=N)][EXEC=>BEFORE][MSG=>Ок]",2)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY0. Протокол взаємодії ********** ');
          --  Створюємо функцію ZAY0. Протокол взаємодії
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY0. Протокол взаємодії',
                                                  p_funcname => 'FunNSIEditF(''V_ZAY_DATA_TRANSFER'', 2 | 0x0010)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів ********** ');
          --  Створюємо функцію Друк звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -1)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів у відкладеному режимі ********** ');
          --  Створюємо функцію Друк звітів у відкладеному режимі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів у відкладеному режимі',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -2)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідники ********** ');
          --  Створюємо функцію Довідники
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідники',
                                                  p_funcname => 'ShowRefList(hWndMDI)',
                                                  p_rolename => 'REF0000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY1.  ГОУ: ввод заявок на покупку-продажу валюты ********** ');
          --  Створюємо функцію ZAY1.  ГОУ: ввод заявок на покупку-продажу валюты
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY1.  ГОУ: ввод заявок на покупку-продажу валюты',
                                                  p_funcname => 'ZAYAVKA(hWndMDI,31)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY8. Просмотр заявок на коверсию(CORP2) ********** ');
          --  Створюємо функцію ZAY8. Просмотр заявок на коверсию(CORP2)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY8. Просмотр заявок на коверсию(CORP2)',
                                                  p_funcname => 'ZAYAVKA(hWndMDI,8)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY21. ГОУ: визирование заявок на покупку валюты ********** ');
          --  Створюємо функцію ZAY21. ГОУ: визирование заявок на покупку валюты
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY21. ГОУ: визирование заявок на покупку валюты',
                                                  p_funcname => 'ZAYf(hWndMDI,3321)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY22. ГОУ: визирование заявок на продажу валюты ********** ');
          --  Створюємо функцію ZAY22. ГОУ: визирование заявок на продажу валюты
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY22. ГОУ: визирование заявок на продажу валюты',
                                                  p_funcname => 'ZAYf(hWndMDI,3322)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY95. Обязательная продажа валюты ********** ');
          --  Створюємо функцію ZAY95. Обязательная продажа валюты
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY95. Обязательная продажа валюты',
                                                  p_funcname => 'ZAYf(hWndMDI,34)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY3.  ГОУ: підтвердження пріоритетних заявок ********** ');
          --  Створюємо функцію ZAY3.  ГОУ: підтвердження пріоритетних заявок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY3.  ГОУ: підтвердження пріоритетних заявок',
                                                  p_funcname => 'ZAYf(hWndMDI,36)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY9.  ГОУ: удаление и восстановление заявок на покупку-продажу валюты ********** ');
          --  Створюємо функцію ZAY9.  ГОУ: удаление и восстановление заявок на покупку-продажу валюты
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY9.  ГОУ: удаление и восстановление заявок на покупку-продажу валюты',
                                                  p_funcname => 'ZAYf(hWndMDI,999)',
                                                  p_rolename => 'ZAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (BIRZ) - АРМ Біржеві операції(ЗАГАЛЬНИЙ)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappBIRZ.sql =========*** En
PROMPT ===================================================================================== 
