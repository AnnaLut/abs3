SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@WFT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@WFT ***
  declare
    l_application_code varchar2(10 char) := '$RM_@WFT';
    l_application_name varchar2(300 char) := 'АРМ SWIFT. Інтерфейс з платіжною системою';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@WFT створюємо (або оновлюємо) АРМ АРМ SWIFT. Інтерфейс з платіжною системою ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Х-2) Авто-Переадресацiя СВIФТ-повiдомлень на /262* ********** ');
          --  Створюємо функцію Х-2) Авто-Переадресацiя СВIФТ-повiдомлень на /262*
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Х-2) Авто-Переадресацiя СВIФТ-повiдомлень на /262*',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>LORO.SWIFT_RU(0,:N,:P)][PAR=>:P(SEM=Поле_50K,REF=TEST_50K),:N(SEM=SWREF_или_ПУСТО,TYPE=N)][QST=>Виконати переадресацiю SWT-103 на /262* ?][MSG=>ОК!]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Банки учасники ********** ');
          --  Створюємо функцію SWIFT. Банки учасники
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Банки учасники',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=SW_BANKS&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Коррахунки банку ********** ');
          --  Створюємо функцію SWIFT. Коррахунки банку
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Коррахунки банку',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CORR_ACC&accessCode=0',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Імпортовані повідомлення БЕЗ аутентифікації ********** ');
          --  Створюємо функцію SWIFT. Імпортовані повідомлення БЕЗ аутентифікації
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Імпортовані повідомлення БЕЗ аутентифікації',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_SW_AUTH_MESSAGES&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>DATE_IN>=sysdate-30]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Прогноз стану НОСТРО рахунків ********** ');
          --  Створюємо функцію SWIFT. Прогноз стану НОСТРО рахунків
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Прогноз стану НОСТРО рахунків',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_SW_FORECAST_NOSTRO&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. МВПС платежі на 191992, 3720, 1600, 2906 ********** ');
          --  Створюємо функцію SWIFT. МВПС платежі на 191992, 3720, 1600, 2906
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. МВПС платежі на 191992, 3720, 1600, 2906',
                                                  p_funcname => '/barsroot/sep/seplockdocs/index?swt=swt',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Пошук повідомлень ********** ');
          --  Створюємо функцію SWIFT. Пошук повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Пошук повідомлень',
                                                  p_funcname => '/barsroot/swift/search',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Архів повідомлень ********** ');
          --  Створюємо функцію SWIFT. Архів повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Архів повідомлень',
                                                  p_funcname => '/barsroot/swi/archive.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію SWIFT. Архів повідомлень(дочірня)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'SWIFT. Архів повідомлень(дочірня)',
                                                              p_funcname => '/barsroot/swi/pickup_doc.aspx?swref=/d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Імпорт довідника BIC(XML) ********** ');
          --  Створюємо функцію SWIFT. Імпорт довідника BIC(XML)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Імпорт довідника BIC(XML)',
                                                  p_funcname => '/barsroot/swi/import_bic.aspx',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Nostro Reconciliation ********** ');
          --  Створюємо функцію Nostro Reconciliation
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Nostro Reconciliation',
                                                  p_funcname => '/barsroot/swi/reconsilation.aspx',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Перегляд SWIFT
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перегляд SWIFT',
                                                              p_funcname => '/barsroot/documentview/view_swift.aspx?swref=\d+',
                                                              p_rolename => 'bars_access_defrole' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Nostro Reconciliation
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Nostro Reconciliation',
                                                              p_funcname => '/barsroot/swi/reconsilation_tt.aspx?stmt_ref=\d+&coln=\d+',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Nostro Reconciliation
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Nostro Reconciliation',
                                                              p_funcname => '/barsroot/swi/reconsilation_link_swt.aspx?stmt_ref=\d+&coln=\d+',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Перегляд нерозібраних та необроблених SWIFT повідомлень ********** ');
          --  Створюємо функцію SWIFT. Перегляд нерозібраних та необроблених SWIFT повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Перегляд нерозібраних та необроблених SWIFT повідомлень',
                                                  p_funcname => '/barsroot/swi/undistributed.aspx',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Користувачі SWIFT
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Користувачі SWIFT',
                                                              p_funcname => '/barsroot/swi/swi_users.aspx?fromUser=/d+',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT.Видалення прив"язки документів ********** ');
          --  Створюємо функцію SWIFT.Видалення прив"язки документів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT.Видалення прив"язки документів',
                                                  p_funcname => '/barsroot/swi/unlink_document.aspx',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Візування повідомлень ********** ');
          --  Створюємо функцію SWIFT. Візування повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Візування повідомлень',
                                                  p_funcname => '/barsroot/swift/Approval',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Позиціонер ********** ');
          --  Створюємо функцію Позиціонер
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Позиціонер',
                                                  p_funcname => '/barsroot/swift/positioner',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Позиціонер child
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Позиціонер child',
                                                              p_funcname => '/barsroot/swi/positioner_mt.aspx?acc=\d+&ref=\d+',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Обробка прийнятих повідомлень (Всіх) ********** ');
          --  Створюємо функцію SWIFT. Обробка прийнятих повідомлень (Всіх)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Обробка прийнятих повідомлень (Всіх)',
                                                  p_funcname => '/barsroot/swift/swift',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Way4. Несквитовані документи (web)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Way4. Несквитовані документи (web)',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Формування виписок на закритті дня ********** ');
          --  Створюємо функцію SWIFT. Формування виписок на закритті дня
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func( 
                                                  p_name     => 'SWIFT. Формування виписок на закритті дня.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>BARS_SWIFT.SheduleStatementMessages][QST=>Виконати формування виписок?][MSG=>Виконано!]',
                                                  p_rolename => '',    
                                                  p_frontend => l_application_type_id
                                                  );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. CLAIMS. Обробка прийнятих повідомлень ********** ');
          --  Створюємо функцію SWIFT. CLAIMS. Обробка прийнятих повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. CLAIMS. Обробка прийнятих повідомлень',
                                                  p_funcname => '/barsroot/swift/swift?isClaims=true',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. МВПС Розподіл/Обробка прийнятих повідомлень ********** ');
          --  Створюємо функцію SWIFT. МВПС Розподіл/Обробка прийнятих повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. МВПС Розподіл/Обробка прийнятих повідомлень',
                                                  p_funcname => '/barsroot/swift/swift?sUserF=0',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Обробка прийнятих повідомлень ********** ');
          --  Створюємо функцію SWIFT. Обробка прийнятих повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Обробка прийнятих повідомлень',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Розподіл/Обробка прийнятих повідомлень ********** ');
          --  Створюємо функцію SWIFT. Розподіл/Обробка прийнятих повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Розподіл/Обробка прийнятих повідомлень',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=&sUserF=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Обробка прийнятих повідомлень(не термінових) ********** ');
          --  Створюємо функцію SWIFT. Обробка прийнятих повідомлень(не термінових)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Обробка прийнятих повідомлень(не термінових)',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=&sUserF=0&sFILTR=noturgently',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Обробка прийнятих повідомлень(термінових) ********** ');
          --  Створюємо функцію SWIFT. Обробка прийнятих повідомлень(термінових)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Обробка прийнятих повідомлень(термінових)',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=&sUserF=0&sFILTR=urgently',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Управління формуванням повідомлень(300,320) ********** ');
          --  Створюємо функцію SWIFT. Управління формуванням повідомлень(300,320)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Управління формуванням повідомлень(300,320)',
                                                  p_funcname => '/barsroot/swift/unlockmsg?mt=3_0',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Управління формуванням повідомлень(950) ********** ');
          --  Створюємо функцію SWIFT. Управління формуванням повідомлень(950)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Управління формуванням повідомлень(950)',
                                                  p_funcname => '/barsroot/swift/unlockmsg?mt=950',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. Управління формуванням повідомлень ********** ');
          --  Створюємо функцію SWIFT. Управління формуванням повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. Управління формуванням повідомлень',
                                                  p_funcname => '/barsroot/swift/unlockmsg?mt=all',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_@WFT) - АРМ SWIFT. Інтерфейс з платіжною системою  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@WFT.sql =========**
PROMPT ===================================================================================== 
