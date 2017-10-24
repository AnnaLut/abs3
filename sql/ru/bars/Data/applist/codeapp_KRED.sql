SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KRED.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KRED ***
  declare
    l_application_code varchar2(10 char) := 'KRED';
    l_application_name varchar2(300 char) := 'АРМ Кредити ФО';
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
     DBMS_OUTPUT.PUT_LINE(' KRED створюємо (або оновлюємо) АРМ АРМ Кредити ФО ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Кред + Бухг + Зал ********** ');
          --  Створюємо функцію КП ФЛ: Кред + Бухг + Зал
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Кред + Бухг + Зал',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 03, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Кредитчик ********** ');
          --  Створюємо функцію КП ФЛ: Кредитчик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Кредитчик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 13, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Залоговик ********** ');
          --  Створюємо функцію КП ФЛ: Залоговик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Залоговик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 33, 0, 5)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Авторизація ********** ');
          --  Створюємо функцію КП ФЛ: Авторизація
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Авторизація',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 83, 0,77  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити, що мають прострочку на ЗАДАНУ дату ********** ');
          --  Створюємо функцію Кредити, що мають прострочку на ЗАДАНУ дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити, що мають прострочку на ЗАДАНУ дату',
                                                  p_funcname => 'ExportCatQuery(10,'''',8,'''',TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Специфiкацiя (виписка) по КД ********** ');
          --  Створюємо функцію Специфiкацiя (виписка) по КД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Специфiкацiя (виписка) по КД',
                                                  p_funcname => 'ExportCatQuery(4446,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прийняття файлу «Приналежність до працівників Банку» ********** ');
          --  Створюємо функцію Прийняття файлу «Приналежність до працівників Банку»
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прийняття файлу «Приналежність до працівників Банку»',
                                                  p_funcname => 'F1_Select(308,"")',
                                                  p_rolename => 'TECH005' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію CCK: Встановити розрахунковий спецпараметр S080 для ЮО ********** ');
          --  Створюємо функцію CCK: Встановити розрахунковий спецпараметр S080 для ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'CCK: Встановити розрахунковий спецпараметр S080 для ЮО',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_SET_S080(3,:Param0)][PAR=>:Param0(SEM=БРАНЧ для встановл з підл. ТВБВ додавати  *,TYPE=C)][QST=> Встановити розрахунковий параметр S080 для ФО ?][MSG=>Встановлення виканано !]")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити ФО 2202/56, 2203/46 => 2202/57, 2203/47 ********** ');
          --  Створюємо функцію Кредити ФО 2202/56, 2203/46 => 2202/57, 2203/47
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити ФО 2202/56, 2203/46 => 2202/57, 2203/47',
                                                  p_funcname => 'FunNSIEditF( "CC_ENERGY", 2) ',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату ********** ');
          --  Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити, що мають прострочку на ПОТОЧНУ дату',
                                                  p_funcname => 'FunNSIEditF("CCK_PROBL" , 1 | 0x0010)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування  CC_DEAL ********** ');
          --  Створюємо функцію Редагування  CC_DEAL
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування  CC_DEAL',
                                                  p_funcname => 'FunNSIEditF("CC_DEAL",2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Позика <-> Забезпечення <-> Депозит ********** ');
          --  Створюємо функцію Позика <-> Забезпечення <-> Депозит
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Позика <-> Забезпечення <-> Депозит',
                                                  p_funcname => 'FunNSIEditF("CC_PAWN_DP",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію АРЖК:Суми погашень по КП пулу АРЖК за перiод ********** ');
          --  Створюємо функцію АРЖК:Суми погашень по КП пулу АРЖК за перiод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'АРЖК:Суми погашень по КП пулу АРЖК за перiод',
                                                  p_funcname => 'FunNSIEditF("POG_ARJK[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З dd.mm.yyyy>,TYPE=S),:E(SEM=По dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1|0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Протокол прийняття файлу "Приналежність до працівників банку" ********** ');
          --  Створюємо функцію Протокол прийняття файлу "Приналежність до працівників банку"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Протокол прийняття файлу "Приналежність до працівників банку"',
                                                  p_funcname => 'FunNSIEditF("TMP_BANK_EMPLOYEE_PROT", 1 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстр проблемних кредитів фізичних осіб ********** ');
          --  Створюємо функцію Реєстр проблемних кредитів фізичних осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстр проблемних кредитів фізичних осіб',
                                                  p_funcname => 'FunNSIEditF("TMP_CC_DEAL_PROBL[PROC=>P_CCK_PROBL(:Par0,11)][PAR=>:Par0(SEM= dd/mm/yyyy > ,TYPE=D)][EXEC=>BEFORE]", 1|0x0010)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію V2. Портфель : SNO + GPP ********** ');
          --  Створюємо функцію V2. Портфель : SNO + GPP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'V2. Портфель : SNO + GPP',
                                                  p_funcname => 'FunNSIEditF("V11_SNO_FL", 0 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію V1. Претенденты на ГПП : SNO => GPP ********** ');
          --  Створюємо функцію V1. Претенденты на ГПП : SNO => GPP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'V1. Претенденты на ГПП : SNO => GPP',
                                                  p_funcname => 'FunNSIEditF("V12_SNO_FL", 0 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію V0. Претенденты на реструктур: SPN => (SNO+GPP) ********** ');
          --  Створюємо функцію V0. Претенденты на реструктур: SPN => (SNO+GPP)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'V0. Претенденты на реструктур: SPN => (SNO+GPP)',
                                                  p_funcname => 'FunNSIEditF("V1_SNO_FL[PROC=>SNO.P0_SNO(0)][EXEC=>BEFORE]", 2|0x0010 ) ',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію АРЖК:Середньо-деннi зал. та % ст по КП пулу за перiод ********** ');
          --  Створюємо функцію АРЖК:Середньо-деннi зал. та % ст по КП пулу за перiод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'АРЖК:Середньо-деннi зал. та % ст по КП пулу за перiод',
                                                  p_funcname => 'FunNSIEditF("VV_ARJK[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З dd.mm.yyyy>,TYPE=S),:E(SEM=По dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ESCR:Картотека відшкодувань по енергокредитам   ********** ');
          --  Створюємо функцію ESCR:Картотека відшкодувань по енергокредитам  
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ESCR:Картотека відшкодувань по енергокредитам  ',
                                                  p_funcname => 'FunNSIEditF("VZ_ESCR[NSIFUNCTION]",6)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Інформація про встановлену процентну ставку по рахунках ********** ');
          --  Створюємо функцію Інформація про встановлену процентну ставку по рахунках
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Інформація про встановлену процентну ставку по рахунках',
                                                  p_funcname => 'FunNSIEditF("V_ACCOUNTS_RATN", 1 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію АРЖК:Вiдношення КД щодо Держ.установи ********** ');
          --  Створюємо функцію АРЖК:Вiдношення КД щодо Держ.установи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'АРЖК:Вiдношення КД щодо Держ.установи',
                                                  p_funcname => 'FunNSIEditF("V_CCK_DU[PROC=>PUL_DAT(:Par0,STRING_Null)][PAR=>:Par0(SEM=dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Об-сал вiдомiсть Мiсячна по КП ФО  (за мiс, з корр) ********** ');
          --  Створюємо функцію Об-сал вiдомiсть Мiсячна по КП ФО  (за мiс, з корр)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Об-сал вiдомiсть Мiсячна по КП ФО  (за мiс, з корр)',
                                                  p_funcname => 'FunNSIEditF("V_CCK_MES3[PROC=>PUL_DAT(:Par1,'''')][PAR=>:Par1(SEM=Дата перiоду dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Об-сал вiдомiсть за перiод по КП ФО ********** ');
          --  Створюємо функцію Об-сал вiдомiсть за перiод по КП ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Об-сал вiдомiсть за перiод по КП ФО',
                                                  p_funcname => 'FunNSIEditF("V_CCK_SAL3[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM=Поч.Дата перiоду dd.mm.yyyy>,TYPE=S),:Par2(SEM=Кiн.Дата перiоду dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Претенденты на реструктур (АТО) ********** ');
          --  Створюємо функцію Претенденты на реструктур (АТО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Претенденты на реструктур (АТО)',
                                                  p_funcname => 'FunNSIEditF("V_GRACE_ATO", 2) ',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Список планових платежiв позичальникiв ФО по КД  ********** ');
          --  Створюємо функцію Список планових платежiв позичальникiв ФО по КД 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Список планових платежiв позичальникiв ФО по КД ',
                                                  p_funcname => 'FunNSIEditF("V_PAY1[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=   dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію *Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ФО ********** ');
          --  Створюємо функцію *Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ФО',
                                                  p_funcname => 'FunNSIEditF("V_S080_3[PROC=>P_279_6_2 (''3'',:M,:B)][PAR=>:B(SEM=Бранч,TYPE=S,REF=BRANCH_VAR),:M(SEM=Мicяцiв,TYPE=N,DEF=6) ][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Данi про реструктуризацiю КД ********** ');
          --  Створюємо функцію Данi про реструктуризацiю КД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Данi про реструктуризацiю КД',
                                                  p_funcname => 'FunNSIEditF(''CCK_RESTR_V'',0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сховище. Оприбуткування цінностей по КД з дороги ********** ');
          --  Створюємо функцію Сховище. Оприбуткування цінностей по КД з дороги
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сховище. Оприбуткування цінностей по КД з дороги',
                                                  p_funcname => 'FunNSIEditF(''V_CC_989917'',2 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Данi про реструктуризацiю КД ФО ********** ');
          --  Створюємо функцію Данi про реструктуризацiю КД ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Данi про реструктуризацiю КД ФО',
                                                  p_funcname => 'FunNSIEditFFiltered(''CCK_RESTR_V'',0,''CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (11,12,13))'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сховище. Кредитнi справи. ********** ');
          --  Створюємо функцію Сховище. Кредитнi справи.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сховище. Кредитнi справи.',
                                                  p_funcname => 'Sel002(hWndMDI,13,0," ob22 in ( ''981902'',''981903'',''981979'',''981983'', ''9819B8'' ) ","CC_PD9")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків (ФО) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків (ФО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків (ФО)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,3,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити. Редагування шаблонів договорів ********** ');
          --  Створюємо функцію Кредити. Редагування шаблонів договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити. Редагування шаблонів договорів',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''KD%''  or id like ''CCK%''")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (KRED) - АРМ Кредити ФО  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKRED.sql =========*** En
PROMPT ===================================================================================== 
