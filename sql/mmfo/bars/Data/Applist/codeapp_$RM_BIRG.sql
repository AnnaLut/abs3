PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_BIRG.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_BIRG ***
  declare
    l_application_code varchar2(10 char) := '$RM_BIRG';
    l_application_name varchar2(300 char) := 'АРМ Біржеві операції (ЦА)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_BIRG створюємо (або оновлюємо) АРМ АРМ Біржеві операції (ЦА) ');
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
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_sal_add&edb_KV_new=840&edb_KB_new=0&edb_DK_new=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAYO. Передача інформації щодо надходжень ********** ');
          --  Створюємо функцію ZAYO. Передача інформації щодо надходжень
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAYO. Передача інформації щодо надходжень',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>bars_zay.set_currency_income(:DAT)][PAR=>:DAT(SEM= Дата передачі,TYPE=D)][QST=>Виконати передачу даних про надходження в ЦА?][MSG=>Готово!]',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAYR. Формування та редагування надходжень ********** ');
          --  Створюємо функцію ZAYR. Формування та редагування надходжень
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAYR. Формування та редагування надходжень',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=ZAY_CURRENCY_INCOME&accessCode=1&sPar=[PROC=>p_zay_currency_income(:DAT,1)][PAR=>:DAT(SEM= Дата передачі,TYPE=D)][QST=>Переформувати?][MSG=>Готово!][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY95. Обов'язковий продаж валюти ********** ');
          --  Створюємо функцію ZAY95. Обов'язковий продаж валюти
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY95. Обов'язковий продаж валюти',
                                                  p_funcname => '/barsroot/zay/MandatorySale/Index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (сторінка із документами)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. Обов'язковий продаж валюти (сторінка із документами)',
															  p_funcname => '/barsroot/zay/mandatorysale/linkeddocs\S*',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (показники #D27)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. Обов'язковий продаж валюти (показники #D27)',
															  p_funcname => '/barsroot/zay/mandatorysale/getd27params\S*',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (заявка на обов. продаж валюти)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. Обов'язковий продаж валюти (заявка на обов. продаж валюти)',
															  p_funcname => '/barsroot/zay/mandatorysale/createbid\S*',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (зняття заявки з контролю)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. Обов'язковий продаж валюти (зняття заявки з контролю)',
															  p_funcname => '/barsroot/zay/mandatorysale/delitem\S*',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (головна сторінка)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. Обов'язковий продаж валюти (головна сторінка)',
															  p_funcname => '/barsroot/zay/mandatorysale/index\S*',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (перелік пов'язаних документів)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. Обов'язковий продаж валюти (перелік пов'язаних документів)',
															  p_funcname => '/barsroot/zay/mandatorysale/getzaylinkeddocs\S*',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (джерело даних для основної таблиці)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY95. Обов'язковий продаж валюти (джерело даних для основної таблиці)',
															  p_funcname => '/barsroot/zay/mandatorysale/getmandatorycurrsalelist\S*',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY3. Підтвердження ПРІОРИТЕТНИХ заявок ********** ');
          --  Створюємо функцію ZAY3. Підтвердження ПРІОРИТЕТНИХ заявок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY3. Підтвердження ПРІОРИТЕТНИХ заявок',
                                                  p_funcname => '/barsroot/zay/confirmprimaryzay/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY21. Візування введених угод (покупка) ********** ');
          --  Створюємо функцію ZAY21. Візування введених угод (покупка)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY21. Візування введених угод (покупка)',
                                                  p_funcname => '/barsroot/zay/currencybuysighting/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY22. Візування введених угод (продаж) ********** ');
          --  Створюємо функцію ZAY22. Візування введених угод (продаж)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY22. Візування введених угод (продаж)',
                                                  p_funcname => '/barsroot/zay/currencysalesighting/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_BIRG) - АРМ Біржеві операції (ЦА)  ');
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
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_BIRG.sql =========**
PROMPT ===================================================================================== 
