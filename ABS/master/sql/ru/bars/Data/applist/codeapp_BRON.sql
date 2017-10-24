SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_BRON.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  BRON ***
  declare
    l_application_code varchar2(10 char) := 'BRON';
    l_application_name varchar2(300 char) := 'АРМ Бронювання коштів на рахунках СГ';
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
     DBMS_OUTPUT.PUT_LINE(' BRON створюємо (або оновлюємо) АРМ АРМ Бронювання коштів на рахунках СГ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію *BRO  :Нарахування бонус-відсотків в ост.день місяця ********** ');
          --  Створюємо функцію *BRO  :Нарахування бонус-відсотків в ост.день місяця
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*BRO  :Нарахування бонус-відсотків в ост.день місяця',
                                                  p_funcname => 'F1_Select(12,''bro.INT_BRO_LAST_DAY(DAT)'')',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію *BROF: Авто-закриття завершених угод бронювання коштів ********** ');
          --  Створюємо функцію *BROF: Авто-закриття завершених угод бронювання коштів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*BROF: Авто-закриття завершених угод бронювання коштів',
                                                  p_funcname => 'F1_Select(13,"BRO.CLOS_ALL(DAT);Виконати авто-закриття завершених угод бронювання коштів ?;Виконано!")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію *BRO%: Нарахування бонус-відсотків ********** ');
          --  Створюємо функцію *BRO%: Нарахування бонус-відсотків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*BRO%: Нарахування бонус-відсотків',
                                                  p_funcname => 'FunNSIEdit("[PROC=>BRO.INT_BRO(:D)][PAR=>:D(SEM=По дату включно,TYPE=D)][MSG=>Виконано !]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію "Корпоративний залишок"(cen) ********** ');
          --  Створюємо функцію "Корпоративний залишок"(cen)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"Корпоративний залишок"(cen)',
                                                  p_funcname => 'FunNSIEditF("V1_BRO",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію "Корпоративний залишок" ********** ');
          --  Створюємо функцію "Корпоративний залишок"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"Корпоративний залишок"',
                                                  p_funcname => 'FunNSIEditF("V1_BRO[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=Період_З),:E(SEM=Період_ПО)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію BR1: Брон.коштів на рах.СГ: Ввод ********** ');
          --  Створюємо функцію BR1: Брон.коштів на рах.СГ: Ввод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BR1: Брон.коштів на рах.СГ: Ввод',
                                                  p_funcname => 'Sel027(hWndMDI,26,1," "," ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію BR3: Брон.коштів на рах.СГ: Активація ********** ');
          --  Створюємо функцію BR3: Брон.коштів на рах.СГ: Активація
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BR3: Брон.коштів на рах.СГ: Активація',
                                                  p_funcname => 'Sel027(hWndMDI,26,3," "," ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію BR4: Брон.коштів на рах.СГ: Супровід активних ********** ');
          --  Створюємо функцію BR4: Брон.коштів на рах.СГ: Супровід активних
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BR4: Брон.коштів на рах.СГ: Супровід активних',
                                                  p_funcname => 'Sel027(hWndMDI,26,4," "," ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію BR9: Брон.коштів на рах.СГ: Перегляд та Аналіз ********** ');
          --  Створюємо функцію BR9: Брон.коштів на рах.СГ: Перегляд та Аналіз
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BR9: Брон.коштів на рах.СГ: Перегляд та Аналіз',
                                                  p_funcname => 'Sel027(hWndMDI,26,9," "," ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (BRON) - АРМ Бронювання коштів на рахунках СГ  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappBRON.sql =========*** En
PROMPT ===================================================================================== 
