PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WCSC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WCSC ***
  declare
    l_application_code varchar2(10 char) := '$RM_WCSC';
    l_application_name varchar2(300 char) := 'АРМ Конструктора кредитних продуктів (WEB)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WCSC створюємо (або оновлюємо) АРМ АРМ Конструктора кредитних продуктів (WEB) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Повернення заявки ********** ');
          --  Створюємо функцію Повернення заявки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Повернення заявки',
                                                  p_funcname => '/barsroot/credit/admin/queries_arh.aspx?type=all',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Картка заявки (админ)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка заявки (админ)',
															  p_funcname => '/barsroot/credit/admin/bid_card.aspx?bid_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Карти авторизації ********** ');
          --  Створюємо функцію Карти авторизації
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Карти авторизації',
                                                  p_funcname => '/barsroot/credit/constructor/wcsauths.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Забезпечення ********** ');
          --  Створюємо функцію Забезпечення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Забезпечення',
                                                  p_funcname => '/barsroot/credit/constructor/wcsgarantees.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Інформаційні запити ********** ');
          --  Створюємо функцію Інформаційні запити
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Інформаційні запити',
                                                  p_funcname => '/barsroot/credit/constructor/wcsinfoqueries.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Страховки ********** ');
          --  Створюємо функцію Страховки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Страховки',
                                                  p_funcname => '/barsroot/credit/constructor/wcsinsurances.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію МАКи ********** ');
          --  Створюємо функцію МАКи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'МАКи',
                                                  p_funcname => '/barsroot/credit/constructor/wcsmacs.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Продукти ********** ');
          --  Створюємо функцію Продукти
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Продукти',
                                                  p_funcname => '/barsroot/credit/constructor/wcsproducts.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Субпродукти
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Субпродукти',
															  p_funcname => '/barsroot/credit/constructor/wcssubproducts.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Карти сканкопій ********** ');
          --  Створюємо функцію Карти сканкопій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Карти сканкопій',
                                                  p_funcname => '/barsroot/credit/constructor/wcsscancopies.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Доступні сканкопії
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Доступні сканкопії',
															  p_funcname => '/barsroot/credit/constructor/wcsavailablescancopyquestions.aspx?scopy_id=\S*&rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Скорингові карти (Фін. стан.) ********** ');
          --  Створюємо функцію Скорингові карти (Фін. стан.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Скорингові карти (Фін. стан.)',
                                                  p_funcname => '/barsroot/credit/constructor/wcsscorings.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Скорингові бали по питанню
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Скорингові бали по питанню',
															  p_funcname => '/barsroot/credit/constructor/wcsscoringballs.aspx?scoring_id=\S*&question_id=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Карти кредитоспроможності ********** ');
          --  Створюємо функцію Карти кредитоспроможності
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Карти кредитоспроможності',
                                                  p_funcname => '/barsroot/credit/constructor/wcssolvencies.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стоп-правила/фактори ********** ');
          --  Створюємо функцію Стоп-правила/фактори
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Стоп-правила/фактори',
                                                  p_funcname => '/barsroot/credit/constructor/wcsstops.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Анкети ********** ');
          --  Створюємо функцію Анкети
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Анкети',
                                                  p_funcname => '/barsroot/credit/constructor/wcssurveys.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Питання групи анкети
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Питання групи анкети',
															  p_funcname => '/barsroot/credit/constructor/wcssurveygroupquestions.aspx?survey_id=\S*&group_id=\S*&rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Групи анкет для клонування
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Групи анкет для клонування',
															  p_funcname => '/barsroot/credit/constructor/dialogs/wcsavlbsurveygroups.aspx?survey_id=\S*&rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Шаблони документів ********** ');
          --  Створюємо функцію Шаблони документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Шаблони документів',
                                                  p_funcname => '/barsroot/credit/constructor/wcstemplates.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт МАКів з файлу ********** ');
          --  Створюємо функцію Імпорт МАКів з файлу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт МАКів з файлу',
                                                  p_funcname => '/barsroot/credit/sync/import_macs.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_WCSC) - АРМ Конструктора кредитних продуктів (WEB)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WCSC.sql =========**
PROMPT ===================================================================================== 
