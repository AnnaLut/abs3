SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_WADM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  WADM ***
  declare
    l_application_code varchar2(10 char) := 'WADM';
    l_application_name varchar2(300 char) := 'АРМ Адміністратора BarsWeb (Web)';
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
     DBMS_OUTPUT.PUT_LINE(' WADM створюємо (або оновлюємо) АРМ АРМ Адміністратора BarsWeb (Web) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування КОРИСТУВАЧІВ ********** ');
          --  Створюємо функцію Адміністрування КОРИСТУВАЧІВ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування КОРИСТУВАЧІВ',
                                                  p_funcname => '/barsroot/admin/adminusers.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Черга повідомлень для синхронізаціх з ЕА ********** ');
          --  Створюємо функцію Черга повідомлень для синхронізаціх з ЕА
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Черга повідомлень для синхронізаціх з ЕА',
                                                  p_funcname => '/barsroot/admin/ead_sync_queue.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Налаштування системи ********** ');
          --  Створюємо функцію Налаштування системи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Налаштування системи',
                                                  p_funcname => '/barsroot/admin/globaloptions.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування користувачів ********** ');
          --  Створюємо функцію Редагування користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування користувачів',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=6056&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адмiнiстрування дошки об`яв ********** ');
          --  Створюємо функцію Адмiнiстрування дошки об`яв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адмiнiстрування дошки об`яв',
                                                  p_funcname => '/barsroot/board/admin/',
                                                  p_rolename => 'WR_BOARD' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Видалення повідомлення дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Видалення повідомлення дошки оголошень',
															  p_funcname => '/barsroot/board/delete/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування повідомлень дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Адміністрування повідомлень дошки оголошень',
															  p_funcname => '/barsroot/board/admin/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Редагування повідомлення дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редагування повідомлення дошки оголошень',
															  p_funcname => '/barsroot/board/edit/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Створення повідомлення дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Створення повідомлення дошки оголошень',
															  p_funcname => '/barsroot/board/add/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування рекламних повідомлень ********** ');
          --  Створюємо функцію Адміністрування рекламних повідомлень
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування рекламних повідомлень',
                                                  p_funcname => '/barsroot/doc/advertising/index/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(перегляд картинки)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Адміністрування рекламних повідомлень(перегляд картинки)',
															  p_funcname => '/barsroot/doc/advertising/image\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(API)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Адміністрування рекламних повідомлень(API)',
															  p_funcname => '/barsroot/api/doc/advertising\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(редагування)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Адміністрування рекламних повідомлень(редагування)',
															  p_funcname => '/barsroot/doc/advertising/edit\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(редагування картинки)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Адміністрування рекламних повідомлень(редагування картинки)',
															  p_funcname => '/barsroot/doc/advertising/imageeditor\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(Головна)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Адміністрування рекламних повідомлень(Головна)',
															  p_funcname => '/barsroot/doc/advertising/index\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(детальна інф.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Адміністрування рекламних повідомлень(детальна інф.)',
															  p_funcname => '/barsroot/doc/advertising/detail\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(завантаження картинки)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Адміністрування рекламних повідомлень(завантаження картинки)',
															  p_funcname => '/barsroot/doc/advertising/fileupload\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування звітів ********** ');
          --  Створюємо функцію Формування звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування звітів',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=WADM',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Тест производительности ********** ');
          --  Створюємо функцію Тест производительности
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Тест производительности',
                                                  p_funcname => '/barsroot/perfom/default.aspx',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (WADM) - АРМ Адміністратора BarsWeb (Web)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappWADM.sql =========*** En
PROMPT ===================================================================================== 
