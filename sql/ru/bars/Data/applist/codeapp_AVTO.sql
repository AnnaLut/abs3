SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_AVTO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  AVTO ***
  declare
    l_application_code varchar2(10 char) := 'AVTO';
    l_application_name varchar2(300 char) := 'АРМ Виконання автоматичних операцій';
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
     DBMS_OUTPUT.PUT_LINE(' AVTO створюємо (або оновлюємо) АРМ АРМ Виконання автоматичних операцій ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Анкета клієнта субпродукту ********** ');
          --  Створюємо функцію Анкета клієнта субпродукту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Анкета клієнта субпродукту',
                                                  p_funcname => '/barsroot/credit/constructor/wcssubproductsurvey.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F1. DA<FFFF>.dbf для ДПС по випл.компенсацій по Бранч-2 ********** ');
          --  Створюємо функцію F1. DA<FFFF>.dbf для ДПС по випл.компенсацій по Бранч-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F1. DA<FFFF>.dbf для ДПС по випл.компенсацій по Бранч-2',
                                                  p_funcname => 'ExportCatQuery(4932,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F0.Загальний DBF-файл для ДПС по випл.компенсацiй ********** ');
          --  Створюємо функцію F0.Загальний DBF-файл для ДПС по випл.компенсацiй
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F0.Загальний DBF-файл для ДПС по випл.компенсацiй',
                                                  p_funcname => 'ExportCatQuery(4934,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F3. DA<FFFFFF>.dbf для ДПС по випл.компен. по Бранч-3 ********** ');
          --  Створюємо функцію F3. DA<FFFFFF>.dbf для ДПС по випл.компен. по Бранч-3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F3. DA<FFFFFF>.dbf для ДПС по випл.компен. по Бранч-3',
                                                  p_funcname => 'ExportCatQuery(4952,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F3. DA<FFFFFF>.dbf для ДПС по випл.компен. по Бранч-3 ********** ');
          --  Створюємо функцію F3. DA<FFFFFF>.dbf для ДПС по випл.компен. по Бранч-3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F3. DA<FFFFFF>.dbf для ДПС по випл.компен. по Бранч-3',
                                                  p_funcname => 'ExportCatQuery(4967,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT. Перевірка "пенсійності" вкладів ********** ');
          --  Створюємо функцію DPT. Перевірка "пенсійності" вкладів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. Перевірка "пенсійності" вкладів',
                                                  p_funcname => 'F1_Select(12, "DPT_PF.NO_TRANSFER_PF(1)" )',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT. Архівація протоколу виконання автоматичних операцій ********** ');
          --  Створюємо функцію DPT. Архівація протоколу виконання автоматичних операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. Архівація протоколу виконання автоматичних операцій',
                                                  p_funcname => 'F1_Select(12, "DPT_UTILS.TRANSFER_LOG2ARCHIVE(0)")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Пролонгація депозитних договорів ЮО ********** ');
          --  Створюємо функцію DPU. Пролонгація депозитних договорів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Пролонгація депозитних договорів ЮО',
                                                  p_funcname => 'F1_Select(12,"DPU.AUTO_EXTENSION(DAT)")',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Нарахування та виплата %% по завершенні ********** ');
          --  Створюємо функцію DPU. Нарахування та виплата %% по завершенні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Нарахування та виплата %% по завершенні',
                                                  p_funcname => 'F1_Select(12,"DPU.AUTO_MAKE_INT_FINALLY(DAT)")',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію "DPU Закриття деп.дог.ЮО по завершенні терміну дії" ********** ');
          --  Створюємо функцію "DPU Закриття деп.дог.ЮО по завершенні терміну дії"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"DPU Закриття деп.дог.ЮО по завершенні терміну дії"',
                                                  p_funcname => 'F1_Select(12,"DPU.AUTO_MOVE2ARCHIVE( DAT )")',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Закриття деп.дог.ЮО по завершенні терміну дії ********** ');
          --  Створюємо функцію DPU. Закриття деп.дог.ЮО по завершенні терміну дії
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Закриття деп.дог.ЮО по завершенні терміну дії',
                                                  p_funcname => 'F1_Select(12,"DPU.AUTO_MOVE2ARCHIVE(DAT)")',
                                                  p_rolename => 'TECH001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Z. Капіталізаця нарахованих відсотків в кінці року ********** ');
          --  Створюємо функцію Z. Капіталізаця нарахованих відсотків в кінці року
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Z. Капіталізаця нарахованих відсотків в кінці року',
                                                  p_funcname => 'F1_Select(13, "DPT_COMPROC_END_YEAR( DAT );Виконати <Капіталізацю нарахованих %% по депозитам? >;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сплата прибуткового податку утриманого з ФО ********** ');
          --  Створюємо функцію Сплата прибуткового податку утриманого з ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сплата прибуткового податку утриманого з ФО',
                                                  p_funcname => 'F1_Select(13, "DPT_WEB.AUTO_PAY_TAX( DAT );Виконати <Сплату прибуткового податку утриманого з ФО? >;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1. Виконання операції "Закриття непоповнених вкладів" ********** ');
          --  Створюємо функцію 1. Виконання операції "Закриття непоповнених вкладів"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1. Виконання операції "Закриття непоповнених вкладів"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_BLNK'',NUMBER_Null);Виконати <Закриття непоповнених вкладів?>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2. Виконання операції "Закриття вкладів після закінчення строку дії" ********** ');
          --  Створюємо функцію 2. Виконання операції "Закриття вкладів після закінчення строку дії"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2. Виконання операції "Закриття вкладів після закінчення строку дії"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_CLOS'',NUMBER_Null);Виконати <Закриття вкладів після закінчення строку дії>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4. Виконання операції "Остаточне нарахування відсотків" ********** ');
          --  Створюємо функцію 4. Виконання операції "Остаточне нарахування відсотків"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4. Виконання операції "Остаточне нарахування відсотків"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_INTF'',NUMBER_Null);Виконати <Остаточне нарахування відсотків>?;Виконано!")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6. Виконання операції "Нарахування відсотків в кінці місяця" ********** ');
          --  Створюємо функцію 6. Виконання операції "Нарахування відсотків в кінці місяця"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6. Виконання операції "Нарахування відсотків в кінці місяця"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_MINT'',0);Виконати <Нарахування %% по вкладах в останній день міс>?;Виконано!")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звіт про нарахування до ПФ за ПРОДАНУ вал ********** ');
          --  Створюємо функцію Звіт про нарахування до ПФ за ПРОДАНУ вал
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звіт про нарахування до ПФ за ПРОДАНУ вал',
                                                  p_funcname => 'FunNSIEditF("V_KF3800[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=Дата_З,TYPE=S),:E(SEM=Дата_ПО,TYPE=S)][EXEC=>BEFORE]", 1 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття, перерахування ПДФО+ВЗ до бюджету ********** ');
          --  Створюємо функцію Перекриття, перерахування ПДФО+ВЗ до бюджету
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття, перерахування ПДФО+ВЗ до бюджету',
                                                  p_funcname => 'FunNSIEditF("V_PDFO[NSIFUNCTION][PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Звiтна дата 01/ММ/РР)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звіт про нарахування до ПФ за КУПЛЕНУ вал ********** ');
          --  Створюємо функцію Звіт про нарахування до ПФ за КУПЛЕНУ вал
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звіт про нарахування до ПФ за КУПЛЕНУ вал',
                                                  p_funcname => 'FunNSIEditF("V_RF3800[PROC=>Bank_PF (0,:B,:E)][PAR=>:B(SEM=Дата_З,TYPE=D),:E(SEM=Дата_ПО,TYPE=D)][EXEC=>BEFORE]", 1 )',
                                                  p_rolename => 'START1' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (AVTO) - АРМ Виконання автоматичних операцій  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappAVTO.sql =========*** En
PROMPT ===================================================================================== 
