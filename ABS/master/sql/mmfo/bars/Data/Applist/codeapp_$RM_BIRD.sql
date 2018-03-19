PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_BIRD.sql =========*
PROMPT ===================================================================================== 



PROMPT *** Create/replace  ARM  $RM_BIRD ***
  declare
    l_application_code varchar2(10 char) := '$RM_BIRD';
    l_application_name varchar2(300 char) := 'АРМ Біржеві операції (ДІЛЕР)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_BIRD створюємо (або оновлюємо) АРМ АРМ Біржеві операції (ДІЛЕР) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY11. Введення заявок на КУПІВЛЮ валюти ********** ');
          --  Створюємо функцію ZAY11. Введення заявок на КУПІВЛЮ валюти
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY11. Введення заявок на КУПІВЛЮ валюти',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_buy_add',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Перегляд статусів заявки
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перегляд статусів заявки',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_statuses\S*',
                                                              p_rolename => 'ZAY' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY111. Інформація про курси ділера
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY111. Інформація про курси ділера',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm.ref.zay_kv_kurs',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY114. Додавання заявки на купівлю валюти
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY114. Додавання заявки на купівлю валюти',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_buy_add_edit&p_id=\S+',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Архів заявок купівлі
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Архів заявок купівлі',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_buy_arch',
                                                              p_rolename => 'ZAY' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY112. Параметри клієнта
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY112. Параметри клієнта',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_cust_zay\S*',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY12. Введення заявок на ПРОДАЖ валюти ********** ');
          --  Створюємо функцію ZAY12. Введення заявок на ПРОДАЖ валюти
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY12. Введення заявок на ПРОДАЖ валюти',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_sal_add',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Перегляд статусів заявки
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перегляд статусів заявки',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_statuses\S*',
                                                              p_rolename => 'ZAY' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY111. Інформація про курси ділера
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY111. Інформація про курси ділера',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm.ref.zay_kv_kurs',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Архів заявок продажу
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Архів заявок продажу',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_sal_arch',
                                                              p_rolename => 'ZAY' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY114. Додавання заявки на продаж валюти
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY114. Додавання заявки на продаж валюти',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_sal_add_edit&p_id=\S+',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY112. Параметри клієнта
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY112. Параметри клієнта',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_cust_zay\S*',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY0-1. Передача індикативних курсів в РУ ********** ');
          --  Створюємо функцію ZAY0-1. Передача індикативних курсів в РУ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY0-1. Передача індикативних курсів в РУ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>bars_zay.p_kurs_transfer(1, DATETIME_Null)][EXEC=>BEFORE][QST=>Виконати передачу індикативних курсів в РУ?][MSG=>Виконано!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY0-2. Передача фактичних курсів в РУ ********** ');
          --  Створюємо функцію ZAY0-2. Передача фактичних курсів в РУ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY0-2. Передача фактичних курсів в РУ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>bars_zay.p_kurs_transfer(2, DATETIME_Null)][EXEC=>BEFORE][QST=>Виконати передачу фактичних курсів в РУ??][MSG=>Виконано!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAYD. Перегляд консолідованих надходжень ********** ');
          --  Створюємо функцію ZAYD. Перегляд консолідованих надходжень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAYD. Перегляд консолідованих надходжень',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_ZAY_CURRENCY_INCOME&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY0. Протокол взаємодії ********** ');
          --  Створюємо функцію ZAY0. Протокол взаємодії
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY0. Протокол взаємодії',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_ZAY_DATA_TRANSFER&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Акцептовані дилером заявки ********** ');
          --  Створюємо функцію Акцептовані дилером заявки
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Акцептовані дилером заявки',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_ZAY_DEALER_ACCEPT&accessCode=1',
                                                  p_rolename => '' ,    
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY52. Біржа.Візування курсів дилера ********** ');
          --  Створюємо функцію ZAY52. Біржа.Візування курсів дилера
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY52. Біржа.Візування курсів дилера',
                                                  p_funcname => '/barsroot/zay/birja/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     
            --Додавання довідника біржевих рахунків РУ в АРМ 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Додавання довідника біржевих рахунків РУ в АРМ  ********** ');
           
    BARS_METABASE.ADDTABLETOREF(GET_TABID('ZAY_ACC_RU'),7);
    
    USER_MENU_UTL.ADD_REFERENCE2ARM(GET_TABID('ZAY_ACC_RU'),'$RM_BIRD',2,1);
  
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY9. Видалення/Відновлення заявок ********** ');
          --  Створюємо функцію ZAY9. Видалення/Відновлення заявок
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY9. Видалення/Відновлення заявок',
                                                  p_funcname => '/barsroot/zay/currencyoperations/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY42. Дилер. Задоволення заявок клієнтів ********** ');
          --  Створюємо функцію ZAY42. Дилер. Задоволення заявок клієнтів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY42. Дилер. Задоволення заявок клієнтів',
                                                  p_funcname => '/barsroot/zay/dealer/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
       --  Створюємо функцію Зведення біржевих заявок за день
      l := l +1;
      l_function_ids.extend(l);      
	  l_function_ids(l):= abs_utils.add_func(
							   p_name     => 'Зведення біржевих заявок за день',
							   p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=ZAY_FXE_GROUP[NSIFUNCTION][PROC=>ZAY_FXE.CREATE_FXE(:D)][PAR=>:D(SEM=Дата формування проводок,TYPE=D)][EXEC=>BEFORE][CONDITIONS=>USER_ID=sys_context(''bars_global'',''user_id'')][DESCR=>Дата формування проводок]',
							   p_rolename => 'BARS_ACCESS_DEFROLE',    
							   p_frontend => l_application_type_id
							   );

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_BIRD) - АРМ Біржеві операції (ДІЛЕР)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_BIRD.sql =========**
PROMPT ===================================================================================== 
