SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_OPER.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  OPER ***
  declare
    l_application_code varchar2(10 char) := 'OPER';
    l_application_name varchar2(300 char) := 'АРМ Операціоніста';
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
     DBMS_OUTPUT.PUT_LINE(' OPER створюємо (або оновлюємо) АРМ АРМ Операціоніста ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи по рахунках відділення ********** ');
          --  Створюємо функцію Документи по рахунках відділення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи по рахунках відділення',
                                                  p_funcname => 'DocViewListInt(hWndMDI,'' a.ref in (select p.ref from opldok p, accounts a where a.acc=p.acc and a.TOBO=tobopack.GetTobo)'', ''Документи по рах. відділення'' )',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування "своїх" операцій ********** ');
          --  Створюємо функцію Візування "своїх" операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування "своїх" операцій',
                                                  p_funcname => 'FunCheckDocumentsSel(1,''a.userid=''||Str(GetUserId()),'''',1,0)',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт   : Розбір документів ********** ');
          --  Створюємо функцію Iмпорт   : Розбір документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт   : Розбір документів',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 0, '''','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 1: Локальнi задачi(щоденник) ********** ');
          --  Створюємо функцію Iмпорт 1: Локальнi задачi(щоденник)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 1: Локальнi задачi(щоденник)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''1'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 2: КОМУНАЛЬНІ ПЛАТЕЖІ ********** ');
          --  Створюємо функцію Iмпорт 2: КОМУНАЛЬНІ ПЛАТЕЖІ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 2: КОМУНАЛЬНІ ПЛАТЕЖІ',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''2'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3: Зарплатнi файли ********** ');
          --  Створюємо функцію Iмпорт 3: Зарплатнi файли
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3: Зарплатнi файли',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''3'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3.1: Зарплатнi файли (tt=PKS,sk=84) ********** ');
          --  Створюємо функцію Iмпорт 3.1: Зарплатнi файли (tt=PKS,sk=84)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3.1: Зарплатнi файли (tt=PKS,sk=84)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''3'',''imp_3_1'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3.2: Пенсiйнi файли (tt=PKX,sk=87) ********** ');
          --  Створюємо функцію Iмпорт 3.2: Пенсiйнi файли (tt=PKX,sk=87)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3.2: Пенсiйнi файли (tt=PKX,sk=87)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''3'',''imp_3_2'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3.3: Iншi зарахувння (tt=PKR,sk=88) ********** ');
          --  Створюємо функцію Iмпорт 3.3: Iншi зарахувння (tt=PKR,sk=88)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3.3: Iншi зарахувння (tt=PKR,sk=88)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''3'',''imp_3_3'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 4: Файли інкасації ********** ');
          --  Створюємо функцію Iмпорт 4: Файли інкасації
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 4: Файли інкасації',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''4'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 4.1: Файли iнкасацiї(вибiр опер.) ********** ');
          --  Створюємо функцію Iмпорт 4.1: Файли iнкасацiї(вибiр опер.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 4.1: Файли iнкасацiї(вибiр опер.)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''4'',''imp_4_1'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Робота с документами "електронних" клієнтів ********** ');
          --  Створюємо функцію 1.Робота с документами "електронних" клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Робота с документами "електронних" клієнтів',
                                                  p_funcname => 'KLOP(0,''KL1'',''KL2'',''KLI'')',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення додаткових реквізитів за всі дні - документи всіх ********** ');
          --  Створюємо функцію Довведення додаткових реквізитів за всі дні - документи всіх
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення додаткових реквізитів за всі дні - документи всіх',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) ","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення  додаткових реквізитів за сьогодні ********** ');
          --  Створюємо функцію Довведення  додаткових реквізитів за сьогодні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення  додаткових реквізитів за сьогодні',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) and oper.userid=USER_ID and oper.vdat=BANKDATE","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення додаткових реквізитів за всі дні (користувача) ********** ');
          --  Створюємо функцію Довведення додаткових реквізитів за всі дні (користувача)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення додаткових реквізитів за всі дні (користувача)',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) and oper.userid=USER_ID","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунки з операторами лотерей ********** ');
          --  Створюємо функцію Розрахунки з операторами лотерей
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунки з операторами лотерей',
                                                  p_funcname => 'Sel002(hWndMDI,12,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Операції з цінностями ********** ');
          --  Створюємо функцію Операції з цінностями
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Операції з цінностями',
                                                  p_funcname => 'Sel002(hWndMDI,13,0," ob22 not in ( ''981902'',''981903'',''981979'',''981983'', ''9819B8'') ","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сховище. Оприбуткування монет та футлярiв ********** ');
          --  Створюємо функцію Сховище. Оприбуткування монет та футлярiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сховище. Оприбуткування монет та футлярiв',
                                                  p_funcname => 'Sel002(hWndMDI,15,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Створення розпорядження по вибору ********** ');
          --  Створюємо функцію Створення розпорядження по вибору
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Створення розпорядження по вибору',
                                                  p_funcname => 'Sel002(hWndMDI,19,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Вiдбiр документiв для Фiн. Монiторiнгу [СВОЇ ДОКУМЕНТИ] ********** ');
          --  Створюємо функцію ФМ. Вiдбiр документiв для Фiн. Монiторiнгу [СВОЇ ДОКУМЕНТИ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Вiдбiр документiв для Фiн. Монiторiнгу [СВОЇ ДОКУМЕНТИ]',
                                                  p_funcname => 'Sel005(hWndMDI,0,1,''I56OC'',''exists (select 1 from v_fm_func_oper where ref = v_finmon_que.ref)'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення зведених МО ********** ');
          --  Створюємо функцію Введення зведених МО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення зведених МО',
                                                  p_funcname => 'Sel011(hWndMDI,0,1,'''','''')',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення документів ********** ');
          --  Створюємо функцію Введення документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення документів',
                                                  p_funcname => 'Sel011(hWndMDI,2,1,'''','''')',
                                                  p_rolename => 'PYOD001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картотека надходжень на конс. балансовий рахунок 2909 (тип NL9) ********** ');
          --  Створюємо функцію Картотека надходжень на конс. балансовий рахунок 2909 (тип NL9)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картотека надходжень на конс. балансовий рахунок 2909 (тип NL9)',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NL9","024")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картотека надходжень на конс.балансовий рахунок 2909. MUU ********** ');
          --  Створюємо функцію Картотека надходжень на конс.балансовий рахунок 2909. MUU
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картотека надходжень на конс.балансовий рахунок 2909. MUU',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NL9","MUU")',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію NL9 Картотека 2909 зарахування на картковi рахунки (тип NL9) ********** ');
          --  Створюємо функцію NL9 Картотека 2909 зарахування на картковi рахунки (тип NL9)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NL9 Картотека 2909 зарахування на картковi рахунки (тип NL9)',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NL9","PKR")',
                                                  p_rolename => 'PYOD001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію "НЕ-БАРС"-операцiї за день(Centura) ********** ');
          --  Створюємо функцію "НЕ-БАРС"-операцiї за день(Centura)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"НЕ-БАРС"-операцiї за день(Centura)',
                                                  p_funcname => 'Sel040( hWndMDI, 100, 0 ,"" , "" )',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка запитів ********** ');
          --  Створюємо функцію Обробка запитів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка запитів',
                                                  p_funcname => 'ZAPROS(hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (OPER) - АРМ Операціоніста  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappOPER.sql =========*** En
PROMPT ===================================================================================== 
