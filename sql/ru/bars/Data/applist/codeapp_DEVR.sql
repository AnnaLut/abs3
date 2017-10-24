SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_DEVR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  DEVR ***
  declare
    l_application_code varchar2(10 char) := 'DEVR';
    l_application_name varchar2(300 char) := 'АРМ Розробника';
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
     DBMS_OUTPUT.PUT_LINE(' DEVR створюємо (або оновлюємо) АРМ АРМ Розробника ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перенакоплення ЩОДЕННИХ SNAP на дату ********** ');
          --  Створюємо функцію Перенакоплення ЩОДЕННИХ SNAP на дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перенакоплення ЩОДЕННИХ SNAP на дату',
                                                  p_funcname => 'F1_Select(12,''DRAPS(DAT)'')',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій (свого відділення) ********** ');
          --  Створюємо функцію Візування операцій (свого відділення)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій (свого відділення)',
                                                  p_funcname => 'FunCheckDocumentsEx(hWndMDI, " a.TOBO = tobopack.GetTobo ")',
                                                  p_rolename => 'CHCK' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перевірка ЕЦП на візах ********** ');
          --  Створюємо функцію Перевірка ЕЦП на візах
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перевірка ЕЦП на візах',
                                                  p_funcname => 'FunCheckDocumentsSel(99,'''','''',1,0)',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування БазиМетаДанних ********** ');
          --  Створюємо функцію Редагування БазиМетаДанних
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування БазиМетаДанних',
                                                  p_funcname => 'FunMetaBaseEdit()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію AGG_02.Процедура накопичення балансу за мiсяць ********** ');
          --  Створюємо функцію AGG_02.Процедура накопичення балансу за мiсяць
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'AGG_02.Процедура накопичення балансу за мiсяць',
                                                  p_funcname => 'FunNSIEdit("[PROC=>AGG_02(:D)][PAR=>:D(SEM=Звiтний_перiод=MM-YY,TYPE=S)][MSG=>Виконано!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Наповнення довідника перекриття (параметри підрозділу) ********** ');
          --  Створюємо функцію Наповнення довідника перекриття (параметри підрозділу)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Наповнення довідника перекриття (параметри підрозділу)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>DFO_BP(''2'')][QST=>Зробити наповнення довідника параметри перекриття?][MSG=>Виконано!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Щоденний SNAP-накоплення на дату(ручне) ********** ');
          --  Створюємо функцію Щоденний SNAP-накоплення на дату(ручне)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Щоденний SNAP-накоплення на дату(ручне)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>DRAPS(:Param0)][PAR=>:Param0(SEM=Звiтна дата,TYPE=D)][MSG=>Виконано!]")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Процедура накопичення балансу за мiсяць ********** ');
          --  Створюємо функцію Процедура накопичення балансу за мiсяць
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Процедура накопичення балансу за мiсяць',
                                                  p_funcname => 'FunNSIEdit("[PROC=>MDRAPS(:Param0)][PAR=>:Param0(SEM=Звiтна дата,TYPE=D)][MSG=>Виконано!]")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Доповнення НЕРУХ, НЕТТО-лот, СПОТ, Iнше... ********** ');
          --  Створюємо функцію Доповнення НЕРУХ, НЕТТО-лот, СПОТ, Iнше...
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Доповнення НЕРУХ, НЕТТО-лот, СПОТ, Iнше...',
                                                  p_funcname => 'FunNSIEdit("[PROC=>NERUXOMI(0)][MSG=>OK NERUXOMI!]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Переключення: 1=SNAP, 2=SALDOA ********** ');
          --  Створюємо функцію Переключення: 1=SNAP, 2=SALDOA
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Переключення: 1=SNAP, 2=SALDOA',
                                                  p_funcname => 'FunNSIEdit("[PROC=>SNP_SALDOA(:sP)][PAR=>:sP(SEM=1_SNP/2_SAL),TYPE=S)][MSG=>OK SNP_SALDOA !]")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зарахування по Альтер.рах.(АСВО) ********** ');
          --  Створюємо функцію Зарахування по Альтер.рах.(АСВО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зарахування по Альтер.рах.(АСВО)',
                                                  p_funcname => 'FunNSIEditF("VPAY_ALT",0)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Невiдповiднiсть ОР їх розмiщенню по рiвням бранчiв ********** ');
          --  Створюємо функцію Невiдповiднiсть ОР їх розмiщенню по рiвням бранчiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Невiдповiднiсть ОР їх розмiщенню по рiвням бранчiв',
                                                  p_funcname => 'FunNSIEditF("V_NBS_BRANCH",1 | 0x0010)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWT. Імпорт довідника участників SWIFT (XML) ********** ');
          --  Створюємо функцію SWT. Імпорт довідника участників SWIFT (XML)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWT. Імпорт довідника участників SWIFT (XML)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI, 3, 1, ''IMP_XML_SWIFT_BIC(sFileName,0)'', '''')',
                                                  p_rolename => 'BARS013' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію IMPEXP: Імпорт DBF файлів ********** ');
          --  Створюємо функцію IMPEXP: Імпорт DBF файлів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'IMPEXP: Імпорт DBF файлів',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,0,10,"","")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію IMPEXP: Експорт даних таблиць в DBF файл ********** ');
          --  Створюємо функцію IMPEXP: Експорт даних таблиць в DBF файл
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'IMPEXP: Експорт даних таблиць в DBF файл',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,0,110,"","")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт довiдника монет ********** ');
          --  Створюємо функцію Iмпорт довiдника монет
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт довiдника монет',
                                                  p_funcname => 'ImpOper(hWndMDI, 13)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт DBF-таблиць ********** ');
          --  Створюємо функцію Імпорт DBF-таблиць
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт DBF-таблиць',
                                                  p_funcname => 'Imp_Dbf_New (hWndMDI,2,0, '''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт АСВО6.3 --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт АСВО6.3 --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт АСВО6.3 --> АБС БАРС',
                                                  p_funcname => 'ImportDataAsvo63()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт АСВО6.5 --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт АСВО6.5 --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт АСВО6.5 --> АБС БАРС',
                                                  p_funcname => 'ImportDataAsvo65()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт ХИТЦ (ф) --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт ХИТЦ (ф) --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт ХИТЦ (ф) --> АБС БАРС',
                                                  p_funcname => 'ImportDataFHitc()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт СКАРБ5 (ф) --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт СКАРБ5 (ф) --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт СКАРБ5 (ф) --> АБС БАРС',
                                                  p_funcname => 'ImportDataFSkarb5()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт СКАРБ6 (ф) --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт СКАРБ6 (ф) --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт СКАРБ6 (ф) --> АБС БАРС',
                                                  p_funcname => 'ImportDataFSkarb6()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт Unicorn(ф) --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт Unicorn(ф) --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт Unicorn(ф) --> АБС БАРС',
                                                  p_funcname => 'ImportDataFUnicorn()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт неподвижных вкладов АСВО --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт неподвижных вкладов АСВО --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт неподвижных вкладов АСВО --> АБС БАРС',
                                                  p_funcname => 'ImportDataImmobile()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт МЕГАБАНК --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт МЕГАБАНК --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт МЕГАБАНК --> АБС БАРС',
                                                  p_funcname => 'ImportDataMegabank()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт СБОН --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт СБОН --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт СБОН --> АБС БАРС',
                                                  p_funcname => 'ImportDataSBON()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт СКАРБ --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт СКАРБ --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт СКАРБ --> АБС БАРС',
                                                  p_funcname => 'ImportDataSkarb()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт Unicorn --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт Unicorn --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт Unicorn --> АБС БАРС',
                                                  p_funcname => 'ImportDataUnicorn()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдбiр ЗАКЛ. виписок по елекр. кл.(ТЕСТ) ********** ');
          --  Створюємо функцію Вiдбiр ЗАКЛ. виписок по елекр. кл.(ТЕСТ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдбiр ЗАКЛ. виписок по елекр. кл.(ТЕСТ)',
                                                  p_funcname => 'KliTex(6,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування КОРИСТУВАЧІВ ********** ');
          --  Створюємо функцію Адміністрування КОРИСТУВАЧІВ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування КОРИСТУВАЧІВ',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструктор АРМ-ів ********** ');
          --  Створюємо функцію Конструктор АРМ-ів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструктор АРМ-ів',
                                                  p_funcname => 'Run_Arms( hWndMDI, 0 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWT. Импорт справочника участников ********** ');
          --  Створюємо функцію SWT. Импорт справочника участников
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWT. Импорт справочника участников',
                                                  p_funcname => 'Sel013(hWndMDI, 10, 0, '''', '''')',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструювання схем перекриття/розщіплення(3-х віконне) ********** ');
          --  Створюємо функцію Конструювання схем перекриття/розщіплення(3-х віконне)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструювання схем перекриття/розщіплення(3-х віконне)',
                                                  p_funcname => 'Sel015(hWndMDI,0,0,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Схеми перекриття: редагування ********** ');
          --  Створюємо функцію Схеми перекриття: редагування
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Схеми перекриття: редагування',
                                                  p_funcname => 'Sel015(hWndMDI,4,1,''1'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт CSV файлу ********** ');
          --  Створюємо функцію Імпорт CSV файлу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт CSV файлу',
                                                  p_funcname => 'Sel016(hWndMDI,20,9,"","")',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Згортання рах 6-7 класу (ребранчинг) ********** ');
          --  Створюємо функцію Згортання рах 6-7 класу (ребранчинг)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Згортання рах 6-7 класу (ребранчинг)',
                                                  p_funcname => 'Sel023(hWndMDI,7,10,"PER_REBRANCH","")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Управління списком завдань ********** ');
          --  Створюємо функцію Управління списком завдань
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Управління списком завдань',
                                                  p_funcname => 'Sel028(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструктор анкет ********** ');
          --  Створюємо функцію Конструктор анкет
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструктор анкет',
                                                  p_funcname => 'Sel037(hWndMDI,0,0,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Допуск користувачів ********** ');
          --  Створюємо функцію Допуск користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Допуск користувачів',
                                                  p_funcname => 'ShowBAXTA(hWndMDI, TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструктор операцій ********** ');
          --  Створюємо функцію Конструктор операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструктор операцій',
                                                  p_funcname => 'ShowOperEditor( hWndMDI, 9)',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування таблиць, що синхронізуються ********** ');
          --  Створюємо функцію Редагування таблиць, що синхронізуються
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування таблиць, що синхронізуються',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 1 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування каталогізованих запитів(розр) ********** ');
          --  Створюємо функцію Редагування каталогізованих запитів(розр)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування каталогізованих запитів(розр)',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 3 )',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Журнал подій в АБС ********** ');
          --  Створюємо функцію Журнал подій в АБС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Журнал подій в АБС',
                                                  p_funcname => 'ShowSecurity()',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування шаблонів договорів ********** ');
          --  Створюємо функцію Редагування шаблонів договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування шаблонів договорів',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, "")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (DEVR) - АРМ Розробника  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappDEVR.sql =========*** En
PROMPT ===================================================================================== 
