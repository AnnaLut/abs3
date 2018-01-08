SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_TENA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_TENA ***
  declare
    l_application_code varchar2(10 char) := '$RM_TENA';
    l_application_name varchar2(300 char) := 'АРМ Регламентні роботи (РУ)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_TENA створюємо (або оновлюємо) АРМ АРМ Регламентні роботи (РУ) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прийом XML файлів реєстру інсайдерів ********** ');
          --  Створюємо функцію Прийом XML файлів реєстру інсайдерів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прийом XML файлів реєстру інсайдерів',
                                                  p_funcname => '/barsroot/TechWorks/RI',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

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
     

      --  Створюємо дочірню функцію Р”СЂСѓРєРѕРІР°РЅР° С„РѕСЂР°Сѓ HTML
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Р”СЂСѓРєРѕРІР°РЅР° С„РѕСЂР°Сѓ HTML',
                                                              p_funcname => '/barsroot/docview/docs/gettickethtml\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію РќР°Р·РІР° С„Р°Р№Р»Сѓ
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'РќР°Р·РІР° С„Р°Р№Р»Сѓ',
                                                              p_funcname => '/barsroot/docview/docs/getticketfilename\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Р—Р°РІР°РЅС‚Р°Р¶РёС‚Рё *.txt
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Р—Р°РІР°РЅС‚Р°Р¶РёС‚Рё *.txt',
                                                              p_funcname => '/barsroot/docview/docs/loadtxt\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію РќР°РїРѕРІРЅРµРЅРЅСЏ С‚Р°Р±Р»РёС†С–
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'РќР°РїРѕРІРЅРµРЅРЅСЏ С‚Р°Р±Р»РёС†С–',
                                                              p_funcname => '/barsroot/docview/docs/grid\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію РџСЂРёС‡РёРЅРё(РґРѕРІС–РґРЅРёРє)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'РџСЂРёС‡РёРЅРё(РґРѕРІС–РґРЅРёРє)',
                                                              p_funcname => '/barsroot/docview/docs/reasonshandbook\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Р¤Р°Р№Р»
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Р¤Р°Р№Р»',
                                                              p_funcname => '/barsroot/docview/docs/getticketfile\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію РџРµСЂРµРіР»СЏРґ РѕРґРЅРѕРіРѕ РґРѕРєСѓРјРµРЅС‚Сѓ
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'РџРµСЂРµРіР»СЏРґ РѕРґРЅРѕРіРѕ РґРѕРєСѓРјРµРЅС‚Сѓ',
                                                              p_funcname => '/barsroot/docview/docs/item\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Р¤С–Р»СЊС‚СЂ
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Р¤С–Р»СЊС‚СЂ',
                                                              p_funcname => '/barsroot/docview/docs/documentdatefilter\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Р”СЂСѓРє
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Р”СЂСѓРє',
                                                              p_funcname => '/barsroot/docview/docs/getfileforprint\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Р—Р°РІР°РЅС‚Р°Р¶РёС‚Рё *.html
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Р—Р°РІР°РЅС‚Р°Р¶РёС‚Рё *.html',
                                                              p_funcname => '/barsroot/docview/docs/loadhtml\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Р•РєСЃРїРѕСЂС‚ РІ РµРєСЃРµР»СЊ
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Р•РєСЃРїРѕСЂС‚ РІ РµРєСЃРµР»СЊ',
                                                              p_funcname => '/barsroot/docview/docs/exporttoexcel\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію РЎС‚РѕСЂРЅРѕ
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'РЎС‚РѕСЂРЅРѕ',
                                                              p_funcname => '/barsroot/docview/docs/storno\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <Бух.зведення док.дня> Статистика Протоколу ********** ');
          --  Створюємо функцію <Бух.зведення док.дня> Статистика Протоколу
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<Бух.зведення док.дня> Статистика Протоколу',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_ZVT_KOL',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію AGG_02. Процедура накопичення балансу за мiсяць ********** ');
          --  Створюємо функцію AGG_02. Процедура накопичення балансу за мiсяць
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'AGG_02. Процедура накопичення балансу за мiсяць',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>AGG_02(:Param0)][PAR=>:Param0(SEM=Звiтний_перiод MM_YY,TYPE=S)][MSG=>Виконано!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <Бух.зведення док.дня> Формування Протоколу ********** ');
          --  Створюємо функцію <Бух.зведення док.дня> Формування Протоколу
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<Бух.зведення док.дня> Формування Протоколу',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>bars_zvtdoc.nest_report_table(:D)][PAR=>:D(SEM=Звiтна_Дата,TYPE=S)][EXEC=>BEFORE][MSG=>Сформовано]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи з датою валютування, що настала, але НЕ оплачені на старті ********** ');
          --  Створюємо функцію Документи з датою валютування, що настала, але НЕ оплачені на старті
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи з датою валютування, що настала, але НЕ оплачені на старті',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_DOCS_NOT_PAYD_IN_START',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вихідні та свята ********** ');
          --  Створюємо функцію Вихідні та свята
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вихідні та свята',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=HOLIDAY&accessCode=7&sPar=[NSIFUNCTION][CONDITIONS=>kv=980]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Незавізовані документи - 2  ********** ');
          --  Створюємо функцію Незавізовані документи - 2 
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Незавізовані документи - 2 ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DOC_NOT_VISA&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Незавізовані документи ********** ');
          --  Створюємо функцію Незавізовані документи
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Незавізовані документи',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DOC_NOT_VISA_REF&accessCode=1',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Управління банківськими датами ********** ');
          --  Створюємо функцію Управління банківськими датами
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Управління банківськими датами',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FDAT&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Закриття банківського дня ********** ');
          --  Створюємо функцію Закриття банківського дня
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Закриття банківського дня',
                                                  p_funcname => '/barsroot/opencloseday/closeday/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зміна банківського дня ********** ');
          --  Створюємо функцію Зміна банківського дня
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зміна банківського дня',
                                                  p_funcname => '/barsroot/opencloseday/openclose/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відкриття банківського дня ********** ');
          --  Створюємо функцію Відкриття банківського дня
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відкриття банківського дня',
                                                  p_funcname => '/barsroot/opencloseday/openday/index',
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звітність (до НБУ та внутрішня) ********** ');
          --  Створюємо функцію Звітність (до НБУ та внутрішня)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звітність (до НБУ та внутрішня)',
                                                  p_funcname => '/barsroot/reporting/nbu/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_TENA) - АРМ Регламентні роботи (РУ)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_TENA.sql =========**
PROMPT ===================================================================================== 
