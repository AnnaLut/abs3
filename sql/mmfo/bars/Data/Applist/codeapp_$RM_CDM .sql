PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_CDM .sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_CDM  ***
  declare
    l_application_code varchar2(10 char) := '$RM_CDM ';
    l_application_name varchar2(300 char) := 'Робота з ЄБК ФО (Налаштування)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_CDM  створюємо (або оновлюємо) АРМ Робота з ЄБК ФО (Налаштування) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію АРМ Дедублікації ********** ');
          --  Створюємо функцію АРМ Дедублікації
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'АРМ Дедублікації',
                                                  p_funcname => '/barsroot/cdm/Deduplicate/Index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Реєстрація Клієнтів і Рахунків  (ФОП) (ігнорувати дублікат)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Реєстрація Клієнтів і Рахунків  (ФОП) (ігнорувати дублікат)',
															  p_funcname => '/barsroot/cdm/deduplicate/ignorechild\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Реєстрація Клієнтів і Рахунків  (ФОП) (встановлення атрибутів)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Реєстрація Клієнтів і Рахунків  (ФОП) (встановлення атрибутів)',
															  p_funcname => '/barsroot/cdm/deduplicate/moveattributesfromchild\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Реєстрація Клієнтів і Рахунків  (ФОП) (головна сторінка)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Реєстрація Клієнтів і Рахунків  (ФОП) (головна сторінка)',
															  p_funcname => '/barsroot/cdm/deduplicate/index\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Реєстрація Клієнтів і Рахунків  (ФОП) (зробити основною)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Реєстрація Клієнтів і Рахунків  (ФОП) (зробити основною)',
															  p_funcname => '/barsroot/cdm/deduplicate/setnewmaincard\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Реєстрація Клієнтів і Рахунків  (ФОП) (об'єднати)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Реєстрація Клієнтів і Рахунків  (ФОП) (об'єднати)',
															  p_funcname => '/barsroot/cdm/deduplicate/mergedupes\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Реєстрація Клієнтів і Рахунків  (ФОП) (дублікати по РНК)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Реєстрація Клієнтів і Рахунків  (ФОП) (дублікати по РНК)',
															  p_funcname => '/barsroot/cdm/deduplicate/getrnkduplicates\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Реєстрація Клієнтів і Рахунків  (ФОП) (джерело дублікатів)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Реєстрація Клієнтів і Рахунків  (ФОП) (джерело дублікатів)',
															  p_funcname => '/barsroot/cdm/deduplicate/getduplicategrouplist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію АРМ Якості ********** ');
          --  Створюємо функцію АРМ Якості
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'АРМ Якості',
                                                  p_funcname => '/barsroot/cdm/Quality/Index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію АРМ Якості ФО (рекомендації по клієнту)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (рекомендації по клієнту)',
															  p_funcname => '/barsroot/cdm/quality/getcustadvisorylist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (групи якості)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (групи якості)',
															  p_funcname => '/barsroot/cdm/quality/getgroups\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (збереження змін)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (збереження змін)',
															  p_funcname => '/barsroot/cdm/quality/savecustomerattributes\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (головна сторінка)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (головна сторінка)',
															  p_funcname => '/barsroot/cdm/quality/index\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (джерело довідників)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (джерело довідників)',
															  p_funcname => '/barsroot/cdm/quality/getdialogdata\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (інші групи якості)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (інші групи якості)',
															  p_funcname => '/barsroot/cdm/quality/getqualitygrouplist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (головна сторінка - синонім)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (головна сторінка - синонім)',
															  p_funcname => '/barsroot/cdm/quality\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (джерело списків)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (джерело списків)',
															  p_funcname => '/barsroot/cdm/quality/getdropdowndata\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (групи атрибутів)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (групи атрибутів)',
															  p_funcname => '/barsroot/cdm/quality/getallattrgroups\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (списки рекомендацій)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (списки рекомендацій)',
															  p_funcname => '/barsroot/cdm/quality/getadvisorylist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (підгрупи якості)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (підгрупи якості)',
															  p_funcname => '/barsroot/cdm/quality/getsubgroups\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (усі атрибути)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (усі атрибути)',
															  p_funcname => '/barsroot/cdm/quality/getcustattributeslist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію АРМ Якості ФО (рекомендації)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'АРМ Якості ФО (рекомендації)',
															  p_funcname => '/barsroot/cdm/quality/advisorylist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію АРМ Якості. Конструктор груп ********** ');
          --  Створюємо функцію АРМ Якості. Конструктор груп
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'АРМ Якості. Конструктор груп',
                                                  p_funcname => '/barsroot/cdm/Quality/Index?mode=admin',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_CDM ) - Робота з ЄБК ФО (Налаштування)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_CDM .sql =========**
PROMPT ===================================================================================== 
