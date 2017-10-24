SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_MAIN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  MAIN ***
  declare
    l_application_code varchar2(10 char) := 'MAIN';
    l_application_name varchar2(300 char) := 'АРМ Адміністратора АБС';
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
     DBMS_OUTPUT.PUT_LINE(' MAIN створюємо (або оновлюємо) АРМ АРМ Адміністратора АБС ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію XLS - Оборотно-сальдова вiдомiсть фiлiї (данi ф.#02) - аудит НБУ ********** ');
          --  Створюємо функцію XLS - Оборотно-сальдова вiдомiсть фiлiї (данi ф.#02) - аудит НБУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'XLS - Оборотно-сальдова вiдомiсть фiлiї (данi ф.#02) - аудит НБУ',
                                                  p_funcname => 'ExportCatQuery(4789,"", 8,"",TRUE)',
                                                  p_rolename => 'RPBN001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Журнал задач(редагування) ********** ');
          --  Створюємо функцію Журнал задач(редагування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Журнал задач(редагування)',
                                                  p_funcname => 'F1_Select(102,'''')',
                                                  p_rolename => 'TASK_LIST' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перевірка з'єднання з сервером валютообміну ********** ');
          --  Створюємо функцію Перевірка з'єднання з сервером валютообміну
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перевірка з'єднання з сервером валютообміну',
                                                  p_funcname => 'F1_Select(840,"")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування переліку функцій при Відкритті/Закритті дня ********** ');
          --  Створюємо функцію Редагування переліку функцій при Відкритті/Закритті дня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування переліку функцій при Відкритті/Закритті дня',
                                                  p_funcname => 'FListEdit(hWndMDI,0)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SMS: Перемикач вкл/викл sms-підтв.тел при реєстр.ФО ********** ');
          --  Створюємо функцію SMS: Перемикач вкл/викл sms-підтв.тел при реєстр.ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SMS: Перемикач вкл/викл sms-підтв.тел при реєстр.ФО',
                                                  p_funcname => 'FunNSIEdit("V_SMS_CONFIRM_ADM")',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Бранчі-2 та їх "Сховища" ********** ');
          --  Створюємо функцію Бранчі-2 та їх "Сховища"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Бранчі-2 та їх "Сховища"',
                                                  p_funcname => 'FunNSIEditF("CASH_SXO_B[NSIFUNCTION]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію D8.Автоперекодування параметрів для D8 ********** ');
          --  Створюємо функцію D8.Автоперекодування параметрів для D8
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'D8.Автоперекодування параметрів для D8',
                                                  p_funcname => 'FunNSIEditF("D8_CUST_LINK_GROUPS[PROC=>P_D8_041(:RNK)][PAR=>:RNK(SEM=РНК,TYPE=S,DEF=%)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SMS: Перегляд журналу вкл/викл sms-підтв. м.тел. при реєстр. ФО ********** ');
          --  Створюємо функцію SMS: Перегляд журналу вкл/викл sms-підтв. м.тел. при реєстр. ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SMS: Перегляд журналу вкл/викл sms-підтв. м.тел. при реєстр. ФО',
                                                  p_funcname => 'FunNSIEditF("SMS_CONFIRM_AUDIT", 1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Ручна установка спецпараметрів ОБ  ********** ');
          --  Створюємо функцію Ручна установка спецпараметрів ОБ 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Ручна установка спецпараметрів ОБ ',
                                                  p_funcname => 'FunNSIEditF("SPEC1_INT",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Исправл.несоотвия видов вкладов БАРС и кодов картотек АСВО ********** ');
          --  Створюємо функцію Исправл.несоотвия видов вкладов БАРС и кодов картотек АСВО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Исправл.несоотвия видов вкладов БАРС и кодов картотек АСВО',
                                                  p_funcname => 'FunNSIEditF("TEST_DPT_ERR_OB22" ,2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відновлення записів ********** ');
          --  Створюємо функцію Відновлення записів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відновлення записів',
                                                  p_funcname => 'FunNSIEditF('''',20)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зв'язок користувачі<=>типові користувачі ********** ');
          --  Створюємо функцію Зв'язок користувачі<=>типові користувачі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зв'язок користувачі<=>типові користувачі',
                                                  p_funcname => 'FunNSIEditF(''V_STAFF_TIPS'',1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Делегування прав користувачів ********** ');
          --  Створюємо функцію Делегування прав користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Делегування прав користувачів',
                                                  p_funcname => 'MakeSubstitutes()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування звiтних груп для виписок ********** ');
          --  Створюємо функцію Редагування звiтних груп для виписок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування звiтних груп для виписок',
                                                  p_funcname => 'Otcn(hWndMDI, 2, 0, 0, '''','''')',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Профілі користувачів ********** ');
          --  Створюємо функцію Профілі користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Профілі користувачів',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, 3)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування типових користувачів ********** ');
          --  Створюємо функцію Адміністрування типових користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування типових користувачів',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, 5)',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зв'язок об'єктів адміністрування ********** ');
          --  Створюємо функцію Зв'язок об'єктів адміністрування
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зв'язок об'єктів адміністрування',
                                                  p_funcname => 'Run_Arms(hWndMDI,77)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування ієрархії підрозділів ********** ');
          --  Створюємо функцію Редагування ієрархії підрозділів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування ієрархії підрозділів',
                                                  p_funcname => 'Sel028(hWndMDI, 0, 1, "/", "")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу до рахунків ( 3 режима) ********** ');
          --  Створюємо функцію Встановлення доступу до рахунків ( 3 режима)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу до рахунків ( 3 режима)',
                                                  p_funcname => 'ShowGroups(hWndMDI,1)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу до рахунків  ********** ');
          --  Створюємо функцію Встановлення доступу до рахунків 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу до рахунків ',
                                                  p_funcname => 'ShowGroups(hWndMDI,3)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу [ групи користувачів -> групи рахунків ] ********** ');
          --  Створюємо функцію Встановлення доступу [ групи користувачів -> групи рахунків ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу [ групи користувачів -> групи рахунків ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,4)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу [ групи рахунків -> групи користувачів ] ********** ');
          --  Створюємо функцію Встановлення доступу [ групи рахунків -> групи користувачів ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу [ групи рахунків -> групи користувачів ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,5)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу [ рахунки -> групи рахунків ] ********** ');
          --  Створюємо функцію Встановлення доступу [ рахунки -> групи рахунків ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу [ рахунки -> групи рахунків ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,6)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування кат.запитiв(банк) ********** ');
          --  Створюємо функцію Редагування кат.запитiв(банк)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування кат.запитiв(банк)',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 0 )',
                                                  p_rolename => 'ABS_ADMIN' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію VEGA - Адміністратор ********** ');
          --  Створюємо функцію VEGA - Адміністратор
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'VEGA - Адміністратор',
                                                  p_funcname => 'VEGA_Sel(hWndMDI,0,0,0,'''','''')',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (MAIN) - АРМ Адміністратора АБС  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappMAIN.sql =========*** En
PROMPT ===================================================================================== 
