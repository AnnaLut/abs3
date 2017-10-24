SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KREF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KREF ***
  declare
    l_application_code varchar2(10 char) := 'KREF';
    l_application_name varchar2(300 char) := 'АРМ Кредити ЮО';
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
     DBMS_OUTPUT.PUT_LINE(' KREF створюємо (або оновлюємо) АРМ АРМ Кредити ЮО ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ЮЛ: Кред + Бухг + Зал ********** ');
          --  Створюємо функцію КП ЮЛ: Кред + Бухг + Зал
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ЮЛ: Кред + Бухг + Зал',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 02, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ЮЛ: Кредитчик ********** ');
          --  Створюємо функцію КП ЮЛ: Кредитчик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ЮЛ: Кредитчик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 12, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ЮЛ: Залоговик ********** ');
          --  Створюємо функцію КП ЮЛ: Залоговик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ЮЛ: Залоговик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 32, 0, 3)',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звіт за запитом - ефективна ставка ********** ');
          --  Створюємо функцію Звіт за запитом - ефективна ставка
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звіт за запитом - ефективна ставка',
                                                  p_funcname => 'ExportCatQuery(4992,"=(select ''ZE''||substr(ncks,2,3)||substr(bars_report.frmt_date(nvl(:sFdat1,to_char(gl.bd,''dd/mm/yyyy'')), ''DMY''),1,3)||''.TXT''  from rcukru where mfo=gl.kf)",7,"",TRUE)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DBF:Фінансова звітність клієнтів ЮО ********** ');
          --  Створюємо функцію DBF:Фінансова звітність клієнтів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DBF:Фінансова звітність клієнтів ЮО',
                                                  p_funcname => 'ExportCatQuery(5254,"",12,"",TRUE)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію REP: Інф. про рахунки корпоративних клієнтів ********** ');
          --  Створюємо функцію REP: Інф. про рахунки корпоративних клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REP: Інф. про рахунки корпоративних клієнтів',
                                                  p_funcname => 'ExportCatQuery(5295,"=(select ''ZvitAccounts2''||substr(ncks,2,3)||substr(bars_report.frmt_date(nvl(:sFdat1,to_char(gl.bd,''dd/mm/yyyy'')), ''DMY''),1,3)||''.DBF'' from rcukru where mfo=gl.kf)",12,"",TRUE)',
                                                  p_rolename => 'RCC_DEAL' ,
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
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_SET_S080(2,:Param0)][PAR=>:Param0(SEM=БРАНЧ для встановл з підл. ТВБВ додавати  *,TYPE=C)][QST=> Встановити розрахунковий параметр S080 для ЮО ?][MSG=>Встановлення виканано !]")',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнвентаризацiя КП ЮО ********** ');
          --  Створюємо функцію Iнвентаризацiя КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнвентаризацiя КП ЮО',
                                                  p_funcname => 'FunNSIEditF("INV_CCK_UL[PROC=>P_INV_CCK_UL(:Param0,:Param1)][PAR=>:Param0(SEM=Звiтна дата,TYPE=D,REF=REZ_PROTOCOL),:Param1(SEM=Переформувати?Так->1/Нi->0,TYPE=N)][EXEC=>BEFORE][MSG=>Виконано!]", 2)',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Об-сал вiдомiсть Мiсячна по КП ЮО  (за мiс, з корр) ********** ');
          --  Створюємо функцію Об-сал вiдомiсть Мiсячна по КП ЮО  (за мiс, з корр)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Об-сал вiдомiсть Мiсячна по КП ЮО  (за мiс, з корр)',
                                                  p_funcname => 'FunNSIEditF("V_CCK_MES2[PROC=>PUL_DAT(:Par1,'''')][PAR=>:Par1(SEM=Дата перiоду dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Об-сал вiдомiсть за перiод по КП ЮО ********** ');
          --  Створюємо функцію Об-сал вiдомiсть за перiод по КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Об-сал вiдомiсть за перiод по КП ЮО',
                                                  p_funcname => 'FunNSIEditF("V_CCK_SAL2[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM=Поч.Дата перiоду dd.mm.yyyy>,TYPE=S),:Par2(SEM=Кiн.Дата перiоду dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію *Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ЮО ********** ');
          --  Створюємо функцію *Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ЮО',
                                                  p_funcname => 'FunNSIEditF("V_S080_2[PROC=>P_279_6_2 (''2'',:M,:B)][PAR=>:B(SEM=Бранч,TYPE=S,REF=BRANCH_VAR),:M(SEM=Мicяцiв,TYPE=N,DEF=6) ][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відображення актуальних траншів на задану дату ********** ');
          --  Створюємо функцію Відображення актуальних траншів на задану дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відображення актуальних траншів на задану дату',
                                                  p_funcname => 'FunNSIEditF("cc_trans_dat[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=На дату dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Просмотр параметров для распоряжений на выдачу кредита ********** ');
          --  Створюємо функцію Просмотр параметров для распоряжений на выдачу кредита
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Просмотр параметров для распоряжений на выдачу кредита',
                                                  p_funcname => 'FunNSIEditF(''V_CCK_DT_SS'',1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Данi про реструктуризацiю КД ЮО ********** ');
          --  Створюємо функцію Данi про реструктуризацiю КД ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Данi про реструктуризацiю КД ЮО',
                                                  p_funcname => 'FunNSIEditFFiltered(''CCK_RESTR_V'',0,''CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (1,2,3))'')',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків  (загальна) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків  (загальна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків  (загальна)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,0,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків (ЮО) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків (ЮО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків (ЮО)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,2,"##2012220#")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів у відкладеному режимі ********** ');
          --  Створюємо функцію Друк звітів у відкладеному режимі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів у відкладеному режимі',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -2)',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (KREF) - АРМ Кредити ЮО  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKREF.sql =========*** En
PROMPT ===================================================================================== 
