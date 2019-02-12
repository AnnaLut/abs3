set define off
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_W_FM.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_W_FM ***
  declare
    l_application_code varchar2(10 char) := '$RM_W_FM';
    l_application_name varchar2(300 char) := 'АРМ Уповноваженої особи ФМ   ';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_W_FM створюємо (або оновлюємо) АРМ АРМ Уповноваженої особи ФМ    ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд документів відділення ********** ');
          --  Створюємо функцію Перегляд документів відділення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд документів відділення',
                                                  p_funcname => '/barsroot/DocView/Docs/DocumentDateFilter?type=0',
                                                  p_rolename => 'WR_DOCLIST_TOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перелік усіх документів за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів відділення за період
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів відділення за період',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів відділення за період
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів відділення за період',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=11',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд картки документу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд картки документу',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів відділення за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів відділення за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів відділення за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів відділення за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Анкети ФМ по операціях без відкриття рахунків ********** ');
          --  Створюємо функцію Анкети ФМ по операціях без відкриття рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Анкети ФМ по операціях без відкриття рахунків',
                                                  p_funcname => '/barsroot/Finmon/Finmon/Index?lastDays=720',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Анкети ФМ по операціях без відкриття рахунків (rtf звіт)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Анкети ФМ по операціях без відкриття рахунків (rtf звіт)',
															  p_funcname => '/barsroot/finmon/finmon/printfmform\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Анкети ФМ по операціях без відкриття рахунків (джерело даних)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Анкети ФМ по операціях без відкриття рахунків (джерело даних)',
															  p_funcname => '/barsroot/finmon/finmon/getfmdata\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Анкети ФМ по операціях без відкриття рахунків (головна сторінка)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Анкети ФМ по операціях без відкриття рахунків (головна сторінка)',
															  p_funcname => '/barsroot/finmon/finmon/index\S*',
															  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків  ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд рахунків контрагенту
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків контрагенту',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд Клієнтів і Рахунків ********** ');
          --  Створюємо функцію Перегляд Клієнтів і Рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд Клієнтів і Рахунків',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=0&accessmode=0',
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перегляд рахунків контрагенту(readonly)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків контрагенту(readonly)',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+&mod=ro',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд атрибутів рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд атрибутів рахунку',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Відбір документів [ВСІ ДОКУМЕНТИ] ********** ');
          --  Створюємо функцію ФМ. Відбір документів [ВСІ ДОКУМЕНТИ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Відбір документів [ВСІ ДОКУМЕНТИ]',
                                                  p_funcname => '/barsroot/finmon/doc.aspx?access=assignee',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію ФМ. Фільтр кокументів по статусам
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Фільтр кокументів по статусам',
															  p_funcname => '/barsroot/finmon/docstatusfilter.aspx?rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ФМ. Довідник терористів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Довідник терористів',
															  p_funcname => '/barsroot/finmon/ref_terorist.aspx?otm=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ФМ. Перегляд і вибір документів(фільтр)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Перегляд і вибір документів(фільтр)',
															  p_funcname => '/barsroot/finmon/docfilter.aspx?rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ФМ. Параметри
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Параметри',
															  p_funcname => '/barsroot/finmon/docparams.aspx?ref=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ФМ. Довідник статусів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Довідник статусів',
															  p_funcname => '/barsroot/finmon/docstatus.aspx?ref=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);
                     
          --  Створюємо функцію ФМ. Відбір документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Відбір документів',
                                                  p_funcname => '/barsroot/Finmon/FmDocuments/index?access=assignee',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт файлів з переліком публічних діячів ********** ');
          --  Створюємо функцію Імпорт файлів з переліком публічних діячів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт файлів з переліком КІС',
                                                  p_funcname => '/barsroot/finmon/finmon/ImportFile?fileType=KIS',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );

                                                  
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт файлів з переліком PEP ********** ');
          --  Створюємо функцію Імпорт файлів з переліком публічних діячів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт файлів з переліком PEP',
                                                  p_funcname => '/barsroot/finmon/finmon/ImportFile?fileType=PEP',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт файлу терористів ********** ');
          --  Створюємо функцію Імпорт файлу терористів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт файлу терористів',
                                                  p_funcname => '/barsroot/finmon/finmon/ImportFile?fileType=Terr',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Збіг ПЕП БАЗОВИЙ ********** ');
          --  Створюємо функцію ФМ. Збіг ПЕП БАЗОВИЙ
      l := l +1;
      l_function_ids.extend(l);
      update operlist
      set funcname = '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_FINMON_PUBLIC_CUSTOMERS'
      where funcname = '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=FINMON_PUBLIC_CUSTOMERS';
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Збіг ПЕП БАЗОВИЙ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_FINMON_PUBLIC_CUSTOMERS',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Збіг ТЕРОРИСТИ ********** ');
          --  Створюємо функцію ФМ. Збіг ТЕРОРИСТИ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Збіг ТЕРОРИСТИ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_FM_KLIENT',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Перевірка ТЕРОРИСТИ ********** ');
          --  Створюємо функцію ФМ. Перевірка ТЕРОРИСТИ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Перевірка ТЕРОРИСТИ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> fm_utl.run_deferred_task(''fm_terrorist_utl.check_terrorists'', ''Перевірку клієнтів на список терористів завершено. Перевірте довідник підозрілих клієнтів.'')][QST=>Запустити перевірку всіх клієнтів банку?][MSG=>Перевірку запущено, очікуйте повідомлення]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Перевірка ПЕП БАЗОВИЙ ********** ');
          --  Створюємо функцію ФМ. Перевірка ПЕП БАЗОВИЙ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Перевірка ПЕП БАЗОВИЙ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> fm_utl.run_deferred_task(''fm_public_utl.check_public'', ''Перевірку клієнтів на список публ. діячів завершено. Перевірте довідник ПЕП.'')][QST=>Запустити перевірку всіх клієнтів банку?][MSG=>Перевірку запущено, очікуйте повідомлення]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ: Підтвердження рівня ризику клієнтів ********** ');
          --  Створюємо функцію ФМ: Підтвердження рівня ризику клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ: Підтвердження рівня ризику клієнтів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CUSTOMER_RIZIK&accessCode=1&sPar=[NSIFUNCTION][SHOW_COUNT=>TRUE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд рівню ризику клієнтів ********** ');
          --  Створюємо функцію Перегляд рівню ризику клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд рівню ризику клієнтів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CUST_R&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ: Корегування рівня ризику клієнтів ********** ');
          --  Створюємо функцію ФМ: Корегування рівня ризику клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ: Корегування рівня ризику клієнтів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CUST_R&accessCode=1&sPar=[NSIFUNCTION]',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_W_FM) - АРМ Уповноваженої особи ФМ     ');
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
umu.add_report2arm(11,'$RM_W_FM');
umu.add_report2arm(35,'$RM_W_FM');
umu.add_report2arm(42,'$RM_W_FM');
umu.add_report2arm(119,'$RM_W_FM');
umu.add_report2arm(184,'$RM_W_FM');
umu.add_report2arm(213,'$RM_W_FM');
umu.add_report2arm(375,'$RM_W_FM');
umu.add_report2arm(376,'$RM_W_FM');
umu.add_report2arm(997,'$RM_W_FM');
umu.add_report2arm(998,'$RM_W_FM');
umu.add_report2arm(1009,'$RM_W_FM');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_W_FM.sql =========**
PROMPT ===================================================================================== 
set define on