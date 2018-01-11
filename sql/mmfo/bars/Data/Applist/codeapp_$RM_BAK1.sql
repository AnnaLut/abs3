PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_BAK1.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_BAK1 ***
  declare
    l_application_code varchar2(10 char) := '$RM_BAK1';
    l_application_name varchar2(300 char) := 'АРМ Вилучення документів';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_BAK1 створюємо (або оновлюємо) АРМ АРМ Вилучення документів ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виконання повернення операцій ********** ');
          --  Створюємо функцію Виконання повернення операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виконання повернення операцій',
                                                  p_funcname => '/barsroot/docview/docs/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Завантажити *.html
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Завантажити *.html',
															  p_funcname => '/barsroot/docview/docs/loadhtml\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Назва файлу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Назва файлу',
															  p_funcname => '/barsroot/docview/docs/getticketfilename\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Завантажити *.txt
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Завантажити *.txt',
															  p_funcname => '/barsroot/docview/docs/loadtxt\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Експорт в ексель
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Експорт в ексель',
															  p_funcname => '/barsroot/docview/docs/exporttoexcel\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторно
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторно',
															  p_funcname => '/barsroot/docview/docs/storno\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Наповнення таблиці
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Наповнення таблиці',
															  p_funcname => '/barsroot/docview/docs/grid\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Друк
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк',
															  p_funcname => '/barsroot/docview/docs/getfileforprint\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Причини(довідник)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Причини(довідник)',
															  p_funcname => '/barsroot/docview/docs/reasonshandbook\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фільтр
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Фільтр',
															  p_funcname => '/barsroot/docview/docs/documentdatefilter\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Друкована форау HTML
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друкована форау HTML',
															  p_funcname => '/barsroot/docview/docs/gettickethtml\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Файл
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Файл',
															  p_funcname => '/barsroot/docview/docs/getticketfile\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд одного документу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд одного документу',
															  p_funcname => '/barsroot/docview/docs/item\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_BAK1) - АРМ Вилучення документів  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_BAK1.sql =========**
PROMPT ===================================================================================== 
