SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_CHIF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  CHIF ***
  declare
    l_application_code varchar2(10 char) := 'CHIF';
    l_application_name varchar2(300 char) := 'АРМ Операціоніст РЦ (Технолог СЕП)';
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
     DBMS_OUTPUT.PUT_LINE(' CHIF створюємо (або оновлюємо) АРМ АРМ Операціоніст РЦ (Технолог СЕП) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Стан платежів ********** ');
          --  Створюємо функцію СЕП. Стан платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Стан платежів',
                                                  p_funcname => 'DOC_PROC(TRUE)',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Архів документів ********** ');
          --  Створюємо функцію СЕП. Архів документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Архів документів',
                                                  p_funcname => 'DocViewListArc(hWndMDI,'''', '''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Журнал задач(виконання) ********** ');
          --  Створюємо функцію Журнал задач(виконання)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Журнал задач(виконання)',
                                                  p_funcname => 'F1_Select(101,'''')',
                                                  p_rolename => 'TASK_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію РОДОВIД.Автомат 2909/66->2620/29 ********** ');
          --  Створюємо функцію РОДОВIД.Автомат 2909/66->2620/29
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'РОДОВIД.Автомат 2909/66->2620/29',
                                                  p_funcname => 'F1_Select(13,"for_2620_29_ALL(''NLR'');Виконати РОДОВIД.Автомат 2909/66->2620/29?; ОК Отримуйте кошти !" )',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Компенс-2012.Автомат 2906/16->2625/22 ********** ');
          --  Створюємо функцію Компенс-2012.Автомат 2906/16->2625/22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Компенс-2012.Автомат 2906/16->2625/22',
                                                  p_funcname => 'F1_Select(13,"for_2625_22(''NLA'',''2625'',''22'');Виконати Компенс-2012.Автомат 2906/16->2625/22?; ОК !" )',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Оновлення ТОК ********** ');
          --  Створюємо функцію СЕП. Оновлення ТОК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Оновлення ТОК',
                                                  p_funcname => 'ModyTok()',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд документів, переданих на ОПЛАТУ (КЛІЄНТ-БАНК) ********** ');
          --  Створюємо функцію Перегляд документів, переданих на ОПЛАТУ (КЛІЄНТ-БАНК)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд документів, переданих на ОПЛАТУ (КЛІЄНТ-БАНК)',
                                                  p_funcname => 'Sel000(hWndMDI,4,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи  (ВСІ) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи  (ВСІ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи  (ВСІ)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",'''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Документи з майбутньою датою валютування, що НЕ настала ********** ');
          --  Створюємо функцію СЕП. Документи з майбутньою датою валютування, що НЕ настала
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Документи з майбутньою датою валютування, що НЕ настала',
                                                  p_funcname => 'Sel014(hWndMDI,11,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відповіді ІПС ********** ');
          --  Створюємо функцію Відповіді ІПС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відповіді ІПС',
                                                  p_funcname => 'Sel014(hWndMDI,12,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Розбір 3720  (ВАЛ) ********** ');
          --  Створюємо функцію СЕП. Розбір 3720  (ВАЛ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Розбір 3720  (ВАЛ)',
                                                  p_funcname => 'Sel014(hWndMDI,2,0,'''',''a.kv<>980'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Розбір 3720  (ГРН) ********** ');
          --  Створюємо функцію СЕП. Розбір 3720  (ГРН)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Розбір 3720  (ГРН)',
                                                  p_funcname => 'Sel014(hWndMDI,2,0,'''',''a.kv=980'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах з рах.Вiддiлення ********** ');
          --  Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах з рах.Вiддiлення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Одержанi iнф-нi: Запити на уточ.рекв.по платежах з рах.Вiддiлення',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',"mfoA<>:TZ.sBankMfo  AND  (accounts.TOBO=tobopack.GetTobo  or  length(tobopack.GetTobo)=8 and accounts.TOBO like ''%000000%'')")',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах всього Банку ********** ');
          --  Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах всього Банку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Одержанi iнф-нi: Запити на уточ.рекв.по платежах всього Банку',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',''mfoA<>:TZ.sBankMfo  AND mfoB=:TZ.sBankMfo'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Інформація про файли ********** ');
          --  Створюємо функцію СЕП. Інформація про файли
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Інформація про файли',
                                                  p_funcname => 'Sel014(hWndMDI,5,1,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Перекриття в БЮДЖЕТ ********** ');
          --  Створюємо функцію 1.Перекриття в БЮДЖЕТ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Перекриття в БЮДЖЕТ',
                                                  p_funcname => 'Sel015(hWndMDI,1,1,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Перекрития 2902-2600 ********** ');
          --  Створюємо функцію 1.Перекрития 2902-2600
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Перекрития 2902-2600',
                                                  p_funcname => 'Sel015(hWndMDI,1,2, ''S'',''a.isp=''||Str(GetUserId()) )',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Виконання БУДЬ-ЯКИХ схем перекриття/розщіплення ********** ');
          --  Створюємо функцію 1.Виконання БУДЬ-ЯКИХ схем перекриття/розщіплення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Виконання БУДЬ-ЯКИХ схем перекриття/розщіплення',
                                                  p_funcname => 'Sel015(hWndMDI,11,0,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вивантаження довідника банків СЕП (S_UCH.DBF) ********** ');
          --  Створюємо функцію Вивантаження довідника банків СЕП (S_UCH.DBF)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вивантаження довідника банків СЕП (S_UCH.DBF)',
                                                  p_funcname => 'Selector(hWndMDI,1)',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд всіх рахунків ********** ');
          --  Створюємо функцію Перегляд всіх рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд всіх рахунків',
                                                  p_funcname => 'ShowAllAccounts(hWndMDI)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Блокувати/Розблокувати напрямки ********** ');
          --  Створюємо функцію СЕП. Блокувати/Розблокувати напрямки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Блокувати/Розблокувати напрямки',
                                                  p_funcname => 'ShowDirection()',
                                                  p_rolename => 'TECH007' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.НЕЗАВІЗОВАНІ документи ********** ');
          --  Створюємо функцію 1.НЕЗАВІЗОВАНІ документи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.НЕЗАВІЗОВАНІ документи',
                                                  p_funcname => 'ShowNotPayDok(1)',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідники ********** ');
          --  Створюємо функцію Довідники
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідники',
                                                  p_funcname => 'ShowRefList(hWndMDI)',
                                                  p_rolename => 'REF0000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ВПС. Повідомлення учасникам ВПС ********** ');
          --  Створюємо функцію ВПС. Повідомлення учасникам ВПС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ВПС. Повідомлення учасникам ВПС',
                                                  p_funcname => 'ShowSendMessage()',
                                                  p_rolename => 'TECH019' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Технологічні флаги ********** ');
          --  Створюємо функцію СЕП. Технологічні флаги
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Технологічні флаги',
                                                  p_funcname => 'ShowSetTechFlags()',
                                                  p_rolename => 'TOSS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Технологічні рахунки ********** ');
          --  Створюємо функцію СЕП. Технологічні рахунки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Технологічні рахунки',
                                                  p_funcname => 'ShowTechAccountsEx(0)',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Оновлення списку банків із S_UCH.DBF ********** ');
          --  Створюємо функцію СЕП. Оновлення списку банків із S_UCH.DBF
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Оновлення списку банків із S_UCH.DBF',
                                                  p_funcname => 'ShowUpdateBanks()',
                                                  p_rolename => 'TECH020' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Активні користувачі ********** ');
          --  Створюємо функцію Активні користувачі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Активні користувачі',
                                                  p_funcname => 'Show_USERS(hWndMDI ,TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (CHIF) - АРМ Операціоніст РЦ (Технолог СЕП)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappCHIF.sql =========*** En
PROMPT ===================================================================================== 
