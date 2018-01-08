SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_METO.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_METO ***
  declare
    l_application_code varchar2(10 char) := '$RM_METO';
    l_application_name varchar2(300 char) := 'АРМ Методолога';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
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
     DBMS_OUTPUT.PUT_LINE(' $RM_METO створюємо (або оновлюємо) АРМ АРМ Методолога ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд доступу [ групи користувачів -> ролі,користувачі,рахунки] ********** ');
          --  Створюємо функцію Перегляд доступу [ групи користувачів -> ролі,користувачі,рахунки]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд доступу [ групи користувачів -> ролі,користувачі,рахунки]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccessRoleGroups/AccessGroups',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів ********** ');
          --  Створюємо функцію Друк звітів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів',
                                                  p_funcname => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Друк звітів
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Друк звітів',
                                                              p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Друк звітів
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Друк звітів',
                                                              p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Провідник по РОЛЬОВІЙ МОДЕЛІ/тільки перегляд ********** ');
          --  Створюємо функцію Провідник по РОЛЬОВІЙ МОДЕЛІ/тільки перегляд
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Провідник по РОЛЬОВІЙ МОДЕЛІ/тільки перегляд',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=M_ROLE[NSIFUNCTION][BASE_OPTIONS=>ACCESSCODE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Продукт: "ФІНАНСОВА ДЕБІТОРКА" в ОБ ********** ');
          --  Створюємо функцію Продукт: "ФІНАНСОВА ДЕБІТОРКА" в ОБ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Продукт: "ФІНАНСОВА ДЕБІТОРКА" в ОБ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FIN_DEBT&accessCode=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФОРЕКС: Схема облiку по продуктам ********** ');
          --  Створюємо функцію ФОРЕКС: Схема облiку по продуктам
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФОРЕКС: Схема облiку по продуктам',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FOREX_OB22&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Таблиця рахунків ВП, ЕВП, НКР ********** ');
          --  Створюємо функцію Таблиця рахунків ВП, ЕВП, НКР
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Таблиця рахунків ВП, ЕВП, НКР',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TABVAL&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФОРЕКС: Загальнi параметри ********** ');
          --  Створюємо функцію ФОРЕКС: Загальнi параметри
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФОРЕКС: Загальнi параметри',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FOREX_PAR&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Таблиця - Матриця рахунків ВП-ЕВП-НКР-РКР ********** ');
          --  Створюємо функцію Таблиця - Матриця рахунків ВП-ЕВП-НКР-РКР
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Таблиця - Матриця рахунків ВП-ЕВП-НКР-РКР',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_VPLIST&accessCode=2&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідники NEW ********** ');
          --  Створюємо функцію Довідники NEW
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідники NEW',
                                                  p_funcname => '/barsroot/referencebook/referencelist/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстр операцій за день ********** ');
          --  Створюємо функцію Реєстр операцій за день
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстр операцій за день',
                                                  p_funcname => '/barsroot/tools/operation_list.aspx',
                                                  p_rolename => 'BASIC_INFO' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_METO) - АРМ Методолога  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_METO.sql =========**
PROMPT ===================================================================================== 
