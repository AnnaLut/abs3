PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_F601.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_F601 ***

set define off

  declare
    l_application_code varchar2(10 char) := '$RM_F601';
    l_application_name varchar2(300 char) := 'АРМ "ФОРМА 601"';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_F601 створюємо (або оновлюємо) АРМ АРМ "ФОРМА 601" ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Підпис даних перед відправкою до НБУ ********** ');
          --  Створюємо функцію Підпис даних перед відправкою до НБУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l) := operlist_adm.add_new_func(
                                                  p_name     => 'Підпис даних перед відправкою до НБУ',
                                                  p_funcname => '/barsroot/F601/F601Data/Index',
                                                  p_usearc   => 0,
                                                  p_frontend => l_application_type_id,
                                                  p_forceupd => 1,
                                                  p_runnable => 1,
                                                  p_parent_function_id => null);
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Моніторинг сесій, відправлених до НБУ ********** ');
          --  Створюємо функцію Моніторинг сесій, відправлених до НБУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l) := operlist_adm.add_new_func(
                                                  p_name     => 'Моніторинг сесій, відправлених до НБУ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_NBU_SESSION_HISTORY[NSIFUNCTION]',
                                                  p_usearc   => 0,
                                                  p_frontend => l_application_type_id,
                                                  p_forceupd => 1,
                                                  p_runnable => 1,
                                                  p_parent_function_id => null);


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стан завантаження даних ********** ');
          --  Створюємо функцію Стан завантаження даних
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l) := operlist_adm.add_new_func(
                                                  p_name     => 'Стан завантаження даних',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=v_nbu_core_data_request&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_usearc   => 0,
                                                  p_frontend => l_application_type_id,
                                                  p_forceupd => 1,
                                                  p_runnable => 1,
                                                  p_parent_function_id => null);


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_F601) - АРМ "ФОРМА 601"  ');
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

set define on

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_F601.sql =========**
PROMPT ===================================================================================== 
