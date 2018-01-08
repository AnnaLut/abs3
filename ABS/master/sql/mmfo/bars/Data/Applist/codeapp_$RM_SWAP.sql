SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_SWAP.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_SWAP ***
  declare
    l_application_code varchar2(10 char) := '$RM_SWAP';
    l_application_name varchar2(300 char) := 'АРМ Казначейство FOREX: 1 та 2 "ноги"';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_SWAP створюємо (або оновлюємо) АРМ АРМ Казначейство FOREX: 1 та 2 "ноги" ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.FOREX: Введення угоди (1 нога) ********** ');
          --  Створюємо функцію 1.FOREX: Введення угоди (1 нога)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.FOREX: Введення угоди (1 нога)',
                                                  p_funcname => '/barsroot/Forex/RegularDeals/RegularDeals?dealtypeid=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.FOREX: Введення угод ВАЛ-СВОП (2 ноги) ********** ');
          --  Створюємо функцію 2.FOREX: Введення угод ВАЛ-СВОП (2 ноги)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.FOREX: Введення угод ВАЛ-СВОП (2 ноги)',
                                                  p_funcname => '/barsroot/Forex/RegularDeals/RegularDeals?dealtypeid=1',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3.FOREX: Введення угод ДЕПО-СВОП (2 ноги) ********** ');
          --  Створюємо функцію 3.FOREX: Введення угод ДЕПО-СВОП (2 ноги)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.FOREX: Введення угод ДЕПО-СВОП (2 ноги)',
                                                  p_funcname => '/barsroot/Forex/RegularDeals/RegularDeals?dealtypeid=2',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 8.FOREX: Процентні ставки на ресурси на М/Б ринку ********** ');
          --  Створюємо функцію 8.FOREX: Процентні ставки на ресурси на М/Б ринку
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '8.FOREX: Процентні ставки на ресурси на М/Б ринку',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&tableName=INT_RATN_MB',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію FOREX: Звіт архів угод на дату ********** ');
          --  Створюємо функцію FOREX: Звіт архів угод на дату
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FOREX: Звіт архів угод на дату',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TMP_SWAP_ARC[PROC=>frx_populate_tmp(:p_dat)][PAR=>:p_dat(SEM=Звітна дата,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 9.FOREX:СЗККВ та СЗКПВ по /300465/000010/ ********** ');
          --  Створюємо функцію 9.FOREX:СЗККВ та СЗКПВ по /300465/000010/
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '9.FOREX:СЗККВ та СЗКПВ по /300465/000010/',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_SPOT[CONDITIONS=>V_SPOT.branch = ''/300465/000010/''',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Згортання залишків 3800/3801 по ob22 ********** ');
          --  Створюємо функцію Згортання залишків 3800/3801 по ob22
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Згортання залишків 3800/3801 по ob22',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CLOS_380(3,:V,:M,:W,:N)][PAR=>:V(SEM=З_Об22_для_Вал,TYPE=С),:M(SEM=З_Об22_для_БМ,TYPE=С),:W(SEM=На_Об22_для_Вал,TYPE=С),:N(SEM=На_Об22_для_БМ,TYPE=С)][EXEC=>BEFORE][QST=>Зробити плоскі проводки ?][MSG=>ОК!]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 7.FOREX: Архів угод ********** ');
          --  Створюємо функцію 7.FOREX: Архів угод
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7.FOREX: Архів угод',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_FXS_ARCHIVE&sPar=[NSIFUNCTION]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6.FOREX: Архів угод(діючих) ********** ');
          --  Створюємо функцію 6.FOREX: Архів угод(діючих)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.FOREX: Архів угод(діючих)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_FXS_ARCHIVE&sPar=[NSIFUNCTION][CONDITIONS=>dat>=gl.bd or dat_a>=gl.bd or dat_b>=gl.bd]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 5.FOREX: Netting мiж угодами ********** ');
          --  Створюємо функцію 5.FOREX: Netting мiж угодами
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5.FOREX: Netting мiж угодами',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_FOREX_NETTING[NSIFUNCTION][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4.FOREX:Перегляд та Переоц/Закрит/Анулюв угод ********** ');
          --  Створюємо функцію 4.FOREX:Перегляд та Переоц/Закрит/Анулюв угод
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.FOREX:Перегляд та Переоц/Закрит/Анулюв угод',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=V_SWAP&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФОРЕКС: Схема облiку по продуктам ********** ');
          --  Створюємо функцію ФОРЕКС: Схема облiку по продуктам
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФОРЕКС: Схема облiку по продуктам',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FOREX_OB22&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію FOREX. Довідник спецпараметрів рахунків ********** ');
          --  Створюємо функцію FOREX. Довідник спецпараметрів рахунків
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FOREX. Довідник спецпараметрів рахунків',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FX_DEAL_ACCSPARAM&accessCode=0',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Платіжний календар по всім Форекс-угодам ********** ');
          --  Створюємо функцію Платіжний календар по всім Форекс-угодам
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Платіжний календар по всім Форекс-угодам',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FX_PL_CAL&accessCode=1&sPar=[PROC=>PUL_DAT(:A,null)][PAR=>:A(SEM=Дата_З...,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SALDO_DSW: Таблиця СТАРТ-даних по ДЕПО-СВОПАМ ********** ');
          --  Створюємо функцію SALDO_DSW: Таблиця СТАРТ-даних по ДЕПО-СВОПАМ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SALDO_DSW: Таблиця СТАРТ-даних по ДЕПО-СВОПАМ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=SALDO_DSW&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію N 3. Фін.результат за період по похідним фін.інструментам ********** ');
          --  Створюємо функцію N 3. Фін.результат за період по похідним фін.інструментам
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'N 3. Фін.результат за період по похідним фін.інструментам',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TMP_ANI34&accessCode=2&sPar=[PROC=>P_ANI34(34,:B,:E,:R)][PAR=>:B(SEM=з_DD.MM.YYYY,TYPE=D),:E(SEM=по_DD.MM.YYYY,TYPE=D),:R(SEM=Вн_№/0,TYPE=N)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію N 2 Динаміка основних показників ліквідності (мiс) ********** ');
          --  Створюємо функцію N 2 Динаміка основних показників ліквідності (мiс)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'N 2 Динаміка основних показників ліквідності (мiс)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_ANI33&accessCode=2&sPar=[PROC=>P_ANI33(33,:B,:E,:V)][PAR=>:B(SEM=З_дата>,TYPE=D),:E(SEM=По_дата>,TYPE=D),:V(SEM=Вал_або_0,TYPE=N)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФОРЕКС: Загальнi параметри ********** ');
          --  Створюємо функцію ФОРЕКС: Загальнi параметри
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФОРЕКС: Загальнi параметри',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FOREX_PAR&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію FOREX Netting - ПРОПОЗИЦIЇ ********** ');
          --  Створюємо функцію FOREX Netting - ПРОПОЗИЦIЇ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FOREX Netting - ПРОПОЗИЦIЇ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FOR_NET_PRO&accessCode=1',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію A00. Проводки по ФОРЕКС-угодам за період ********** ');
          --  Створюємо функцію A00. Проводки по ФОРЕКС-угодам за період
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A00. Проводки по ФОРЕКС-угодам за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З_дати>,TYPE=S),:E(SEM=По_дату>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію A0P. Фінансовий результат по Провод.6 кл ФОРЕКС-угод за період ********** ');
          --  Створюємо функцію A0P. Фінансовий результат по Провод.6 кл ФОРЕКС-угод за період
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A0P. Фінансовий результат по Провод.6 кл ФОРЕКС-угод за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_0P&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З_дати>,TYPE=S),:E(SEM=По_дату>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію A1S. Фінансовий результат по Рахунк.6 кл ФОРЕКС-угод за період ********** ');
          --  Створюємо функцію A1S. Фінансовий результат по Рахунк.6 кл ФОРЕКС-угод за період
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A1S. Фінансовий результат по Рахунк.6 кл ФОРЕКС-угод за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_1S&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З_дати>,TYPE=S),:E(SEM=По_дату>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію A2D. Фінансовий результат по Договорам ФОРЕКС-угод за період ********** ');
          --  Створюємо функцію A2D. Фінансовий результат по Договорам ФОРЕКС-угод за період
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A2D. Фінансовий результат по Договорам ФОРЕКС-угод за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_2D&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З_дати>,TYPE=S),:E(SEM=По_дату>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Динаміка Вал.Поз по Форекс-продуктам ********** ');
          --  Створюємо функцію Динаміка Вал.Поз по Форекс-продуктам
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Динаміка Вал.Поз по Форекс-продуктам',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_3800&accessCode=1&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З_дати>,TYPE=S),:E(SEM=По_дату>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію A3K. Фінансовий результат по Контраген. ФОРЕКС-угод за період ********** ');
          --  Створюємо функцію A3K. Фінансовий результат по Контраген. ФОРЕКС-угод за період
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A3K. Фінансовий результат по Контраген. ФОРЕКС-угод за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_3K&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З_дати>,TYPE=S),:E(SEM=По_дату>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію A4V. Фінансовий результат по Видам ФОРЕКС-угод за період ********** ');
          --  Створюємо функцію A4V. Фінансовий результат по Видам ФОРЕКС-угод за період
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A4V. Фінансовий результат по Видам ФОРЕКС-угод за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FXANI_4V&accessCode=2&sPar=[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З_дати>,TYPE=S),:E(SEM=По_дату>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_SWAP) - АРМ Казначейство FOREX: 1 та 2 "ноги"  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_SWAP.sql =========**
PROMPT ===================================================================================== 
