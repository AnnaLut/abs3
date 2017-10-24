SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WIMF.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WIMF ***
  declare
    l_application_code varchar2(10 char) := '$RM_WIMF';
    l_application_name varchar2(300 char) := 'АРМ Страхування ФО (Менеджер)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WIMF створюємо (або оновлюємо) АРМ АРМ Страхування ФО (Менеджер) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель (Менеджер) ********** ');
          --  Створюємо функцію Портфель (Менеджер)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель (Менеджер)',
                                                  p_funcname => '/barsroot/ins/deals.aspx?fid=mgrf&type=mgr',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Графік пдатежів по СД
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Графік пдатежів по СД',
                                                              p_funcname => '/barsroot/ins/pmts_schedule.aspx?deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка СД
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка СД',
                                                              p_funcname => '/barsroot/ins/deal_card.aspx?deal_id=\d+&type=(user)|(mgr)|(contr)|(head)&mode=(view)|(pmt)|(addagr)|(edit)',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка контрагента',
                                                              p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Події (Менеджер) ********** ');
          --  Створюємо функцію Події (Менеджер)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Події (Менеджер)',
                                                  p_funcname => '/barsroot/ins/deals.aspx?fid=mgrf_tasks&type=mgr',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Графік пдатежів по СД
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Графік пдатежів по СД',
                                                              p_funcname => '/barsroot/ins/pmts_schedule.aspx?deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка СД
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка СД',
                                                              p_funcname => '/barsroot/ins/deal_card.aspx?deal_id=\d+&type=(user)|(mgr)|(contr)|(head)&mode=(view)|(pmt)|(addagr)|(edit)',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка контрагента',
                                                              p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Новий СД (Менеджер) ********** ');
          --  Створюємо функцію Новий СД (Менеджер)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Новий СД (Менеджер)',
                                                  p_funcname => '/barsroot/ins/new.aspx?custtype=3',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Перезаключення договору страхування
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перезаключення договору страхування',
                                                              p_funcname => '/barsroot/ins/new.aspx?oldid=\d+&comm=\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_WIMF) - АРМ Страхування ФО (Менеджер)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WIMF.sql =========**
PROMPT ===================================================================================== 
