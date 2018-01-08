SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WSSR.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WSSR ***
  declare
    l_application_code varchar2(10 char) := '$RM_WSSR';
    l_application_name varchar2(300 char) := 'АРМ Cлужби безпеки РУ (WEB)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WSSR створюємо (або оновлюємо) АРМ АРМ Cлужби безпеки РУ (WEB) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перепризначення виконавця по заявці (служба безпеки РУ) ********** ');
          --  Створюємо функцію Перепризначення виконавця по заявці (служба безпеки РУ)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перепризначення виконавця по заявці (служба безпеки РУ)',
                                                  p_funcname => '/barsroot/credit/srv/change_user.aspx?srv=ss&srvhr=ru',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка заявок (служба безпеки РУ) ********** ');
          --  Створюємо функцію Обробка заявок (служба безпеки РУ)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка заявок (служба безпеки РУ)',
                                                  p_funcname => '/barsroot/credit/srv/queries.aspx?srv=ss&srvhr=ru',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Картка заявки
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка заявки',
                                                              p_funcname => '/barsroot/credit/srv/bid_card.aspx?srv=\S+&srvhr=\S+&bid_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Архів заявок (служба безпеки РУ) ********** ');
          --  Створюємо функцію Архів заявок (служба безпеки РУ)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Архів заявок (служба безпеки РУ)',
                                                  p_funcname => '/barsroot/credit/srv/queries_arh.aspx?srv=ss&srvhr=ru&type=all',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Картка заявки (архів)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка заявки (архів)',
                                                              p_funcname => '/barsroot/credit/srv/bid_card_arh.aspx?bid_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Архів заявок відділення(служба безпеки РУ) ********** ');
          --  Створюємо функцію Архів заявок відділення(служба безпеки РУ)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Архів заявок відділення(служба безпеки РУ)',
                                                  p_funcname => '/barsroot/credit/srv/queries_arh.aspx?srv=ss&srvhr=ru&type=branch',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Картка заявки (архів)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка заявки (архів)',
                                                              p_funcname => '/barsroot/credit/srv/bid_card_arh.aspx?bid_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Архів заявок користувача(служба безпеки РУ) ********** ');
          --  Створюємо функцію Архів заявок користувача(служба безпеки РУ)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Архів заявок користувача(служба безпеки РУ)',
                                                  p_funcname => '/barsroot/credit/srv/queries_arh.aspx?srv=ss&srvhr=ru&type=user',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Картка заявки (архів)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка заявки (архів)',
                                                              p_funcname => '/barsroot/credit/srv/bid_card_arh.aspx?bid_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_WSSR) - АРМ Cлужби безпеки РУ (WEB)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WSSR.sql =========**
PROMPT ===================================================================================== 
