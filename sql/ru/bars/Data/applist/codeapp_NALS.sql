SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_NALS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  NALS ***
  declare
    l_application_code varchar2(10 char) := 'NALS';
    l_application_name varchar2(300 char) := 'АРМ Податковий облік ОБ';
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
     DBMS_OUTPUT.PUT_LINE(' NALS створюємо (або оновлюємо) АРМ АРМ Податковий облік ОБ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію XLS - Проводки для визначення подат.зобов`язання та кредиту  ********** ');
          --  Створюємо функцію XLS - Проводки для визначення подат.зобов`язання та кредиту 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'XLS - Проводки для визначення подат.зобов`язання та кредиту ',
                                                  p_funcname => 'ExportCatQuery(4539,'''', 8,'''',TRUE)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію XLS - Iсторiя спецпараметрiв P080+R020_FA+OB22 (установка та змiни) ********** ');
          --  Створюємо функцію XLS - Iсторiя спецпараметрiв P080+R020_FA+OB22 (установка та змiни)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'XLS - Iсторiя спецпараметрiв P080+R020_FA+OB22 (установка та змiни)',
                                                  p_funcname => 'ExportCatQuery(4706,'''', 8,'''',TRUE)',
                                                  p_rolename => 'RPBN001' ,
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
                                                  p_funcname => 'ExportCatQuery(4967,"",11,"",TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Списання сум збiльшення-зменшення резерву 1 кв 2013 року ********** ');
          --  Створюємо функцію Списання сум збiльшення-зменшення резерву 1 кв 2013 року
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Списання сум збiльшення-зменшення резерву 1 кв 2013 року',
                                                  p_funcname => 'F1_Select(13, "NAL8_PAY_7720(DAT);Виконати списання сумм резерву на 1 кв 2013 року?;Списання завершено!"  ) ',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ф87  Коригування показникiв РУ пiсля мiграцiї фiлiй ********** ');
          --  Створюємо функцію ф87  Коригування показникiв РУ пiсля мiграцiї фiлiй
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ф87  Коригування показникiв РУ пiсля мiграцiї фiлiй',
                                                  p_funcname => 'F1_Select(13, "NAL8_pay_87(DAT);Виконати коригування ?; Коригування показникiв завершено!"  ) ',
                                                  p_rolename => 'NALOG' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ф87 Данi 87 файлу фiлiй пiсля мiграцiї, не проведенi в РУ ********** ');
          --  Створюємо функцію ф87 Данi 87 файлу фiлiй пiсля мiграцiї, не проведенi в РУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ф87 Данi 87 файлу фiлiй пiсля мiграцiї, не проведенi в РУ',
                                                  p_funcname => 'FunNSIEditF("V_FIL_87",1 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Зв язок рахунків ФО та ПО по SB_P0853 ********** ');
          --  Створюємо функцію  Зв язок рахунків ФО та ПО по SB_P0853
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Зв язок рахунків ФО та ПО по SB_P0853',
                                                  p_funcname => 'FunNSIEditF("V_OB22NU",2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Рахунки ФінОбліку  , НЕ пов'язані з Декларацією(по R020_FA) ********** ');
          --  Створюємо функцію  Рахунки ФінОбліку  , НЕ пов'язані з Декларацією(по R020_FA)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Рахунки ФінОбліку  , НЕ пов'язані з Декларацією(по R020_FA)',
                                                  p_funcname => 'FunNSIEditF("V_OB22_NN",2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдкриття рахункiв ПО (SB_P086 - 86 файл) ********** ');
          --  Створюємо функцію Вiдкриття рахункiв ПО (SB_P086 - 86 файл)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдкриття рахункiв ПО (SB_P086 - 86 файл)',
                                                  p_funcname => 'FunNSIEditF(''ACC_86_NEW'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдкриття рахункiв ПО (SB_P0853 - 87 файл) ********** ');
          --  Створюємо функцію Вiдкриття рахункiв ПО (SB_P0853 - 87 файл)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдкриття рахункiв ПО (SB_P0853 - 87 файл)',
                                                  p_funcname => 'FunNSIEditF(''ACC_87_NEW'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдкриття рахункiв ПО (SB_P088 - 88 файл) ********** ');
          --  Створюємо функцію Вiдкриття рахункiв ПО (SB_P088 - 88 файл)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдкриття рахункiв ПО (SB_P088 - 88 файл)',
                                                  p_funcname => 'FunNSIEditF(''ACC_88_NEW'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд,сторно ручних пров.: <PO1> за останнi 30 днiв ********** ');
          --  Створюємо функцію Перегляд,сторно ручних пров.: <PO1> за останнi 30 днiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд,сторно ручних пров.: <PO1> за останнi 30 днiв',
                                                  p_funcname => 'FunNSIEditF(''PROVNU_PO1'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд,сторно автопроводок:<PO3+знятi> за останнi 5 днiв ********** ');
          --  Створюємо функцію Перегляд,сторно автопроводок:<PO3+знятi> за останнi 5 днiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд,сторно автопроводок:<PO3+знятi> за останнi 5 днiв',
                                                  p_funcname => 'FunNSIEditF(''PROVNU_PO3'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Проводки в ПО по ОБ22 (валові) ********** ');
          --  Створюємо функцію Проводки в ПО по ОБ22 (валові)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Проводки в ПО по ОБ22 (валові)',
                                                  p_funcname => 'NAL_DEC(22)',
                                                  p_rolename => 'NALOG' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (NALS) - АРМ Податковий облік ОБ  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappNALS.sql =========*** En
PROMPT ===================================================================================== 
