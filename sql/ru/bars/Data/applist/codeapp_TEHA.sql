SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_TEHA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  TEHA ***
  declare
    l_application_code varchar2(10 char) := 'TEHA';
    l_application_name varchar2(300 char) := 'АРМ Регламентні роботи';
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
     DBMS_OUTPUT.PUT_LINE(' TEHA створюємо (або оновлюємо) АРМ АРМ Регламентні роботи ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи з датою валютування, що настала, але не оплачені на старті ********** ');
          --  Створюємо функцію Документи з датою валютування, що настала, але не оплачені на старті
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи з датою валютування, що настала, але не оплачені на старті',
                                                  p_funcname => 'DocViewListPayLog( hWndMDI, "", "" )',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вигрузка ЦРВ --> АСВО ********** ');
          --  Створюємо функцію Вигрузка ЦРВ --> АСВО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вигрузка ЦРВ --> АСВО',
                                                  p_funcname => 'ExportCatQuery(4853,'''',1,'''',TRUE)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування  Cddmm.dbf  файлу для ПФУ  ********** ');
          --  Створюємо функцію Формування  Cddmm.dbf  файлу для ПФУ 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування  Cddmm.dbf  файлу для ПФУ ',
                                                  p_funcname => 'ExportCatQuery(55,'''',1,'''',TRUE)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вигрузка ЦРНВ --> АСВО ********** ');
          --  Створюємо функцію Вигрузка ЦРНВ --> АСВО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вигрузка ЦРНВ --> АСВО',
                                                  p_funcname => 'ExportCatQuery(5614,'''',1,'''',TRUE)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стягнення податку 15% від процентних доходів ФО ********** ');
          --  Створюємо функцію Стягнення податку 15% від процентних доходів ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Стягнення податку 15% від процентних доходів ФО',
                                                  p_funcname => 'F1_Select(13, "BARS.INT15(DAT);Виконати <Стягнення податку 15% від процентних доходів ФО>?;Виконано!")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Остаточна амортизація дисконту ********** ');
          --  Створюємо функцію Остаточна амортизація дисконту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Остаточна амортизація дисконту',
                                                  p_funcname => 'F1_Select(13, "BARS.dpt_finally_amort(DAT);Виконати <Остаточна амортизація дисконту>?;Виконано!")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію B. Виконання операції "Автопереоформлення вкладів" ********** ');
          --  Створюємо функцію B. Виконання операції "Автопереоформлення вкладів"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'B. Виконання операції "Автопереоформлення вкладів"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_EXTN'',NUMBER_Null);Виконати <Автопереоформлення вкладів>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 5. Виконання операції "Перерахування вкладу та %% в кінці строку дії" ********** ');
          --  Створюємо функцію 5. Виконання операції "Перерахування вкладу та %% в кінці строку дії"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. Виконання операції "Перерахування вкладу та %% в кінці строку дії"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_MATU'',NUMBER_Null);Виконати <Перерахування вкладу та %% в кінці строку дії>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 7. Виконання операції "Нарахування/виплата %% по вкладах (інд.графік)" ********** ');
          --  Створюємо функцію 7. Виконання операції "Нарахування/виплата %% по вкладах (інд.графік)"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7. Виконання операції "Нарахування/виплата %% по вкладах (інд.графік)"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_PIPL'',NUMBER_Null);Виконати <Нарахування і виплата %% по інд.графіку>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Синхронізация накопичення балансу ********** ');
          --  Створюємо функцію Синхронізация накопичення балансу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Синхронізация накопичення балансу',
                                                  p_funcname => 'F1_Select(13,"bars_accm_sync.sync_snap(''BALANCE'',GetBankDate(), 0);Виконати накопичення балансу?;Накопичення балансу за поточний банківській день виконано")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прийом XML-файлів реєстру інсайдерів ********** ');
          --  Створюємо функцію Прийом XML-файлів реєстру інсайдерів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прийом XML-файлів реєстру інсайдерів',
                                                  p_funcname => 'F1_Select(189,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Бізнес-напрямки: прийом вхідного файлу ********** ');
          --  Створюємо функцію Бізнес-напрямки: прийом вхідного файлу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Бізнес-напрямки: прийом вхідного файлу',
                                                  p_funcname => 'F1_Select(191,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Бізнес-напрямки: встановлення додаткових реквізитів ********** ');
          --  Створюємо функцію Бізнес-напрямки: встановлення додаткових реквізитів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Бізнес-напрямки: встановлення додаткових реквізитів',
                                                  p_funcname => 'F1_Select(192,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Бізнес-напрямки: прийом файлу та встановлення додаткових реквізитів ********** ');
          --  Створюємо функцію Бізнес-напрямки: прийом файлу та встановлення додаткових реквізитів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Бізнес-напрямки: прийом файлу та встановлення додаткових реквізитів',
                                                  p_funcname => 'F1_Select(193,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прийом VIP ********** ');
          --  Створюємо функцію Прийом VIP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прийом VIP',
                                                  p_funcname => 'F1_Select(307,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виконання списку функцій при Відкритті дня ********** ');
          --  Створюємо функцію Виконання списку функцій при Відкритті дня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виконання списку функцій при Відкритті дня',
                                                  p_funcname => 'FListRun(0, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виконання списку функцій при Закритті дня ********** ');
          --  Створюємо функцію Виконання списку функцій при Закритті дня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виконання списку функцій при Закритті дня',
                                                  p_funcname => 'FListRun(1, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виконання ВАК-операцій (Вилучити операцію) ********** ');
          --  Створюємо функцію Виконання ВАК-операцій (Вилучити операцію)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виконання ВАК-операцій (Вилучити операцію)',
                                                  p_funcname => 'F_Pay_Bck( hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування iфн.для управл.звiтiв ********** ');
          --  Створюємо функцію Формування iфн.для управл.звiтiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування iфн.для управл.звiтiв',
                                                  p_funcname => 'FunNSIEdit("[PROC=>ANI_AUTO(0,:Param0)][PAR=>:Param0(SEM=Звiтна дата,TYPE=D)][MSG=>Виконано!]")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стягнення податку 15% від процентних доходів ФО (за попередні дні) ********** ');
          --  Створюємо функцію Стягнення податку 15% від процентних доходів ФО (за попередні дні)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Стягнення податку 15% від процентних доходів ФО (за попередні дні)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>INT15_dailycheck(:sPar1)][PAR=>:sPar1(SEM=Дата за,TYPE=D)][MSG=>Виконано!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <Бух.зведення док.дня> Формування Протоколу ********** ');
          --  Створюємо функцію <Бух.зведення док.дня> Формування Протоколу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<Бух.зведення док.дня> Формування Протоколу',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_ZVT_DOC(:D)][PAR=>:D(SEM=Звiтна_Дата DD.MM.YYYY>,TYPE=S)][MSG=>Сформовано]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <Бух.зведення док.дня> Статистика  Протоколу ********** ');
          --  Створюємо функцію <Бух.зведення док.дня> Статистика  Протоколу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<Бух.зведення док.дня> Статистика  Протоколу',
                                                  p_funcname => 'FunNSIEditF("V_ZVT_KOL",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП: Затримка доплат по T00. ********** ');
          --  Створюємо функцію СЕП: Затримка доплат по T00.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП: Затримка доплат по T00.',
                                                  p_funcname => 'FunNSIEditF(''OPL4'', 2 | 0x0010)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстр вкладів до нарахування та сплати відсотків ********** ');
          --  Створюємо функцію Реєстр вкладів до нарахування та сплати відсотків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстр вкладів до нарахування та сплати відсотків',
                                                  p_funcname => 'FunNSIEditF(''V_DPT_INTPAYPRETENDERS'', 1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вихідні та свята ********** ');
          --  Створюємо функцію Вихідні та свята
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вихідні та свята',
                                                  p_funcname => 'RunHoliday(hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Aмортизація сум  дисконту за депозитами ********** ');
          --  Створюємо функцію Aмортизація сум  дисконту за депозитами
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Aмортизація сум  дисконту за депозитами',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and s.NBS=''2636'' and i.metr=4 ", "SA" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S62: Нарахування Пенi  у КП ЮЛ ********** ');
          --  Створюємо функцію КП S62: Нарахування Пенi  у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S62: Нарахування Пенi  у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''20%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs2 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ODB. Закрити банківський день ********** ');
          --  Створюємо функцію ODB. Закрити банківський день
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ODB. Закрити банківський день',
                                                  p_funcname => 'ShowCloseBankDay()',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звітність Ощадного Банку ********** ');
          --  Створюємо функцію Звітність Ощадного Банку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звітність Ощадного Банку',
                                                  p_funcname => 'ShowFilesInt(hWndMDI)',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звітність в НБУ ********** ');
          --  Створюємо функцію Звітність в НБУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звітність в НБУ',
                                                  p_funcname => 'ShowFilesNbu(hWndMDI) ',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.НЕЗАВІЗОВАНІ документи-2 ********** ');
          --  Створюємо функцію 1.НЕЗАВІЗОВАНІ документи-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.НЕЗАВІЗОВАНІ документи-2',
                                                  p_funcname => 'ShowNotPayDok(0)',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ODB. Відкрити банківський день ********** ');
          --  Створюємо функцію ODB. Відкрити банківський день
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ODB. Відкрити банківський день',
                                                  p_funcname => 'ShowOpenBankDay()',
                                                  p_rolename => 'TECH005' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Управління доступом до банківських днів ********** ');
          --  Створюємо функцію Управління доступом до банківських днів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Управління доступом до банківських днів',
                                                  p_funcname => 'StatBankDay()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (TEHA) - АРМ Регламентні роботи  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappTEHA.sql =========*** En
PROMPT ===================================================================================== 
