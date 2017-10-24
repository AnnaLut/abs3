SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_AN01.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  AN01 ***
  declare
    l_application_code varchar2(10 char) := 'AN01';
    l_application_name varchar2(300 char) := 'АРМ Керівника';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_CENTURA;
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
     DBMS_OUTPUT.PUT_LINE(' AN01 створюємо (або оновлюємо) АРМ АРМ Керівника ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи ВСІХ користувачів ********** ');
          --  Створюємо функцію Документи ВСІХ користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи ВСІХ користувачів',
                                                  p_funcname => 'F_Ctrl_D(TRUE)',
                                                  p_rolename => 'CHCK002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Повноваження користувачів АБС ********** ');
          --  Створюємо функцію Повноваження користувачів АБС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Повноваження користувачів АБС',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель угод на ел. послуги (тільки Перегляд ********** ');
          --  Створюємо функцію Портфель угод на ел. послуги (тільки Перегляд
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель угод на ел. послуги (тільки Перегляд',
                                                  p_funcname => 'Sel001( hWndMDI, 3, 99, "", "" )',
                                                  p_rolename => 'ELT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд проводок ********** ');
          --  Створюємо функцію Перегляд проводок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд проводок',
                                                  p_funcname => 'Sel002(hWndMDI,14,0," "," ")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Архів депозитних договорів ЮО ********** ');
          --  Створюємо функцію DPU. Архів депозитних договорів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Архів депозитних договорів ЮО',
                                                  p_funcname => 'Sel006(hWndForm,4,0,''''," ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Депозитний портфель ЮО ********** ');
          --  Створюємо функцію DPU. Депозитний портфель ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Депозитний портфель ЮО',
                                                  p_funcname => 'Sel006(hWndForm,5,0,''''," ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ (тільки перегляд) ********** ');
          --  Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ (тільки перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Портфель ОВЕРДРАФТІВ (тільки перегляд)',
                                                  p_funcname => 'Sel009(hWndMDI,0,0,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT2 Депозитний портфель фізичних осіб ********** ');
          --  Створюємо функцію DPT2 Депозитний портфель фізичних осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT2 Депозитний портфель фізичних осіб',
                                                  p_funcname => 'Sel016f(hWndMDI,0,0,""," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО ********** ');
          --  Створюємо функцію Перегляд курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО',
                                                  p_funcname => 'Sel025( hWndMDI,96, 1, " ", "0" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-1. Аналіз вiдповiдностi АКТ-ПАС ********** ');
          --  Створюємо функцію ANI-1. Аналіз вiдповiдностi АКТ-ПАС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-1. Аналіз вiдповiдностi АКТ-ПАС',
                                                  p_funcname => 'Sel030(hWndMDI,1,700,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-10. Аналіз вiдповiдностi Проц.АКТ-ПАС ********** ');
          --  Створюємо функцію ANI-10. Аналіз вiдповiдностi Проц.АКТ-ПАС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-10. Аналіз вiдповiдностi Проц.АКТ-ПАС',
                                                  p_funcname => 'Sel030(hWndMDI,1,800,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-31. Номенклатура та значення трансф.цiн на проц.АКТ,ПАС ********** ');
          --  Створюємо функцію ANI-31. Номенклатура та значення трансф.цiн на проц.АКТ,ПАС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-31. Номенклатура та значення трансф.цiн на проц.АКТ,ПАС',
                                                  p_funcname => 'Sel030(hWndMDI,31,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-32. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi ********** ');
          --  Створюємо функцію ANI-32. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi',
                                                  p_funcname => 'Sel030(hWndMDI,32,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-32n. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi ********** ');
          --  Створюємо функцію ANI-32n. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32n. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi',
                                                  p_funcname => 'Sel030(hWndMDI,32,1,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ОБ-БЮДЖЕТ в стуктурi показникiв (б/р 6-7 кл) ********** ');
          --  Створюємо функцію ОБ-БЮДЖЕТ в стуктурi показникiв (б/р 6-7 кл)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ОБ-БЮДЖЕТ в стуктурi показникiв (б/р 6-7 кл)',
                                                  p_funcname => 'Sel030(hWndMDI,4,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-5. Концентрацiя ресурсiв (SNAP) ********** ');
          --  Створюємо функцію ANI-5. Концентрацiя ресурсiв (SNAP)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-5. Концентрацiя ресурсiв (SNAP)',
                                                  p_funcname => 'Sel030(hWndMDI,5,7,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-6.Var-аналiз ********** ');
          --  Створюємо функцію ANI-6.Var-аналiз
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-6.Var-аналiз',
                                                  p_funcname => 'Sel030(hWndMDI,6,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз структури балансів  (розріз - Валюта) ********** ');
          --  Створюємо функцію Аналіз структури балансів  (розріз - Валюта)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз структури балансів  (розріз - Валюта)',
                                                  p_funcname => 'ShowBal(hWndMDI, 1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз балансів банку в динаміці ********** ');
          --  Створюємо функцію Аналіз балансів банку в динаміці
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз балансів банку в динаміці',
                                                  p_funcname => 'ShowDin(hWndMDI)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд доступу до рахунків ********** ');
          --  Створюємо функцію Перегляд доступу до рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд доступу до рахунків',
                                                  p_funcname => 'ShowGroups(hWndMDI,0)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів ********** ');
          --  Створюємо функцію Друк звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -1)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Журнал подій в АБС ********** ');
          --  Створюємо функцію Журнал подій в АБС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Журнал подій в АБС',
                                                  p_funcname => 'ShowSecurity()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ по доступу ********** ');
          --  Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ по доступу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БАЛАНС-РАХУНОК-ДОКУМЕНТ по доступу',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,189)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ кураторство BRANCH ********** ');
          --  Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ кураторство BRANCH
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БАЛАНС-РАХУНОК-ДОКУМЕНТ кураторство BRANCH',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,21893)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ поточний BRANCH ********** ');
          --  Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ поточний BRANCH
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БАЛАНС-РАХУНОК-ДОКУМЕНТ поточний BRANCH',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,91893)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Перегляд Активних Користувачів ********** ');
          --  Створюємо функцію 1.Перегляд Активних Користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Перегляд Активних Користувачів',
                                                  p_funcname => 'Show_USERS(hWndMDI , FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (AN01) - АРМ Керівника  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappAN01.sql =========*** En
PROMPT ===================================================================================== 
