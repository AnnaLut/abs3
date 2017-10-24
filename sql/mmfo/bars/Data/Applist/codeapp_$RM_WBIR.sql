SET SERVEROUTPUT ON 
SET DEFINE OFF
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WBIR.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WBIR ***
  declare
    l_application_code varchar2(10 char) := '$RM_WBIR';
    l_application_name varchar2(300 char) := 'АРМ Біржеві операції-ведення заявок (WEB)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WBIR створюємо (або оновлюємо) АРМ АРМ Біржеві операції-ведення заявок (WEB) ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY8. ПЕРЕГЛЯД заявок на КОНВЕРСІЮ валют (CORP2) ********** ');
          --  Створюємо функцію ZAY8. ПЕРЕГЛЯД заявок на КОНВЕРСІЮ валют (CORP2)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY8. ПЕРЕГЛЯД заявок на КОНВЕРСІЮ валют (CORP2)',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_zay_conversion',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування відсотків (S) ********** ');
          --  Створюємо функцію Нарахування відсотків (S)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування відсотків (S)',
                                                  p_funcname => '/barsroot/basicfunctions/acrint.aspx?par=s&flt=null',
                                                  p_rolename => 'WR_ACRINT' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Друк звіту про нарахування відсотків
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Друк звіту про нарахування відсотків',
                                                              p_funcname => '/barsroot/basicfunctions/reports/printreport.aspx?key=\d+',
                                                              p_rolename => 'WR_ACRINT' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Веб-сервіс /BarsWeb.BasicFunctions/BasicService.asmx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Веб-сервіс /BarsWeb.BasicFunctions/BasicService.asmx',
                                                              p_funcname => '/barsroot/basicfunctions/basicservice.asmx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Відсоткова картка рахунка
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Відсоткова картка рахунка',
                                                              p_funcname => '/barsroot/basicfunctions/procaccounts.aspx?acc=\d+',
                                                              p_rolename => 'WR_ACRINT' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ZAY95. Обов''язковий продаж валюти ********** ');
          --  Створюємо функцію ZAY95. Обов'язковий продаж валюти
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ZAY95. Обов''язковий продаж валюти',
                                                  p_funcname => '/barsroot/zay/MandatorySale/Index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію ZAY95. Обов''язковий продаж валюти (сторінка із документами)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY95. Обов''язковий продаж валюти (сторінка із документами)',
                                                              p_funcname => '/barsroot/zay/mandatorysale/linkeddocs\S*',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (показники #D27)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY95. Обов''язковий продаж валюти (показники #D27)',
                                                              p_funcname => '/barsroot/zay/mandatorysale/getd27params\S*',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов''язковий продаж валюти (заявка на обов. продаж валюти)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY95. Обов''язковий продаж валюти (заявка на обов. продаж валюти)',
                                                              p_funcname => '/barsroot/zay/mandatorysale/createbid\S*',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (зняття заявки з контролю)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY95. Обов''язковий продаж валюти (зняття заявки з контролю)',
                                                              p_funcname => '/barsroot/zay/mandatorysale/delitem\S*',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (головна сторінка)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY95. Обов''язковий продаж валюти (головна сторінка)',
                                                              p_funcname => '/barsroot/zay/mandatorysale/index\S*',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (перелік пов'язаних документів)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY95. Обов''язковий продаж валюти (перелік пов''язаних документів)',
                                                              p_funcname => '/barsroot/zay/mandatorysale/getzaylinkeddocs\S*',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY95. Обов'язковий продаж валюти (джерело даних для основної таблиці)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ZAY95. Обов''язковий продаж валюти (джерело даних для основної таблиці)',
                                                              p_funcname => '/barsroot/zay/mandatorysale/getmandatorycurrsalelist\S*',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_WBIR) - АРМ Біржеві операції-ведення заявок (WEB)  ');
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


bars.umu.add_func2arm_bypath(p_func_path => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*', p_arm_code => '$RM_WBIR',  p_approve => 1);

bars.umu.add_report2arm(  p_report_id => 566, p_arm_code  =>  '$RM_WBIR', p_approve=>1) ; 

bars.umu.add_report2arm(  p_report_id => 4012, p_arm_code  =>  '$RM_WBIR', p_approve=>1) ; 

bars.umu.add_report2arm(  p_report_id => 4015, p_arm_code  =>  '$RM_WBIR', p_approve=>1) ; 

bars.umu.add_report2arm(  p_report_id => 4016, p_arm_code  =>  '$RM_WBIR', p_approve=>1) ; 

end;
/
begin DBMS_OUTPUT.PUT_LINE(' Commit;  '); end;
/
commit;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WBIR.sql =========**
PROMPT ===================================================================================== 

SET DEFINE ON
