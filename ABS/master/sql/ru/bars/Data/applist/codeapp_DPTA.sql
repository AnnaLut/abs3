SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_DPTA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  DPTA ***
  declare
    l_application_code varchar2(10 char) := 'DPTA';
    l_application_name varchar2(300 char) := 'АРМ Адміністратора депозитної системи ФО';
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
     DBMS_OUTPUT.PUT_LINE(' DPTA створюємо (або оновлюємо) АРМ АРМ Адміністратора депозитної системи ФО ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT Оновлення базових ставок по видам депозитів ФО ********** ');
          --  Створюємо функцію DPT Оновлення базових ставок по видам депозитів ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT Оновлення базових ставок по видам депозитів ФО',
                                                  p_funcname => 'F1_Select(12,"DPT_START_BRATES(''DPT'')")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Синхронізація % ставок по змігрованим депозитам ********** ');
          --  Створюємо функцію Синхронізація % ставок по змігрованим депозитам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Синхронізація % ставок по змігрованим депозитам',
                                                  p_funcname => 'F1_Select(13, "SET_RATES_MIGR_DPT( STRING_Null );Виконати <Синхронізацю % ставок по змігрованим депозитам? >;Виконано!")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT. Заповнення довідника «Рахунки доходів-витрат по проц.Акт.-Пас.» ********** ');
          --  Створюємо функцію DPT. Заповнення довідника «Рахунки доходів-витрат по проц.Акт.-Пас.»
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. Заповнення довідника «Рахунки доходів-витрат по проц.Акт.-Пас.»',
                                                  p_funcname => 'FunNSIEdit("[PROC=>DPT_PROCDR(''DPT'',:Param1,:Param2)][PAR=>:Param1(SEM=З очищенням довідника {1-так/0-ні},TYPE=N),:Param2(SEM=Відкрити рахунки {1-так/0-ні},TYPE=N)][MSG=>Виконано!]")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT5 Формування звiту для ПФ "Рах,по яким НЕ отрим.персiонери" ********** ');
          --  Створюємо функцію DPT5 Формування звiту для ПФ "Рах,по яким НЕ отрим.персiонери"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT5 Формування звiту для ПФ "Рах,по яким НЕ отрим.персiонери"',
                                                  p_funcname => 'FunNSIEdit("[PROC=>PF_NOT_PAY(:Param0,:Param1)][PAR=>:Param0(SEM=Звiтна дата,TYPE=D),:Param1(SEM=Звiтний перiод/мiс,TYPE=N)][MSG=>Виконано!]")',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перенесення строк.вкладів на вклади до запит.зг.Пост.НБУ № 159 ********** ');
          --  Створюємо функцію Перенесення строк.вкладів на вклади до запит.зг.Пост.НБУ № 159
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перенесення строк.вкладів на вклади до запит.зг.Пост.НБУ № 159',
                                                  p_funcname => 'FunNSIEditF("V_DPT_159[PROC=>dpt_159(:DPTID,:Param0)][PAR=>:Param0(SEM=Операція,TYPE=C,DEF=АСВ,REF=TTS)][QST=>Виконати перенесення строкових вкладів на вклади до запитання?][MSG=>Виконано!]", 1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT6 Внести данi про ДАТИ довiреностей ********** ');
          --  Створюємо функцію DPT6 Внести данi про ДАТИ довiреностей
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT6 Внести данi про ДАТИ довiреностей',
                                                  p_funcname => 'FunNSIEditF("V_DPT_AGR_DAT",2|0x0010)',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Экспорт базовых процентных ставок ********** ');
          --  Створюємо функцію Экспорт базовых процентных ставок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Экспорт базовых процентных ставок',
                                                  p_funcname => 'GeneralImpExp(hWndMDI, 3, 2, ''dpt_brates_export(0, sFileName)'', '''')',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Історія змін базових % ставок ********** ');
          --  Створюємо функцію Історія змін базових % ставок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Історія змін базових % ставок',
                                                  p_funcname => 'Sel010(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'DPT_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розподіл пільг по видах депозитних договорів ********** ');
          --  Створюємо функцію Розподіл пільг по видах депозитних договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розподіл пільг по видах депозитних договорів',
                                                  p_funcname => 'Sel016f(hWndMDI,13,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT0 Види депозитів фізичних осіб ********** ');
          --  Створюємо функцію DPT0 Види депозитів фізичних осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 Види депозитів фізичних осіб',
                                                  p_funcname => 'Sel016f(hWndMDI,2,1,""," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT Історія змін базових ставок по видам депозитів ФО ********** ');
          --  Створюємо функцію DPT Історія змін базових ставок по видам депозитів ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT Історія змін базових ставок по видам депозитів ФО',
                                                  p_funcname => 'Sel016f(hWndMDI,20,0,"DPT","")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT1 Архів депозитів фізичних осіб ********** ');
          --  Створюємо функцію DPT1 Архів депозитів фізичних осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT1 Архів депозитів фізичних осіб',
                                                  p_funcname => 'Sel016f(hWndMDI,6,0,"v_dpt_s"," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT. Редагування штрафів ДФО ********** ');
          --  Створюємо функцію DPT. Редагування штрафів ДФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT. Редагування штрафів ДФО',
                                                  p_funcname => 'Sel016f(hWndMDI,7,1,"DPT","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT0 Коррекція строку вкладу ********** ');
          --  Створюємо функцію DPT0 Коррекція строку вкладу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 Коррекція строку вкладу',
                                                  p_funcname => 'Sel016f(hWndMDI,8,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT0 Редагування шаблонів депозитних договорів фіз.осіб ********** ');
          --  Створюємо функцію DPT0 Редагування шаблонів депозитних договорів фіз.осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 Редагування шаблонів депозитних договорів фіз.осіб',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''DPT%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (DPTA) - АРМ Адміністратора депозитної системи ФО  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappDPTA.sql =========*** En
PROMPT ===================================================================================== 
