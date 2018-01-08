SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_MAIN.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_MAIN ***
  declare
    l_application_code varchar2(10 char) := '$RM_MAIN';
    l_application_name varchar2(300 char) := 'АРМ Адміністратора АБС ';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_MAIN створюємо (або оновлюємо) АРМ АРМ Адміністратора АБС  ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу [ рахунки -> групи рахунків ] ********** ');
          --  Створюємо функцію Встановлення доступу [ рахунки -> групи рахунків ]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу [ рахунки -> групи рахунків ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccGroups/AccGroups',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу [ групи рахунків -> групи користувачів ] ********** ');
          --  Створюємо функцію Встановлення доступу [ групи рахунків -> групи користувачів ]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу [ групи рахунків -> групи користувачів ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccessToAccounts/accounts',
                                                  p_rolename => 'ABS_ADMIN' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу [ групи користувачів -> групи рахунків ] ********** ');
          --  Створюємо функцію Встановлення доступу [ групи користувачів -> групи рахунків ]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу [ групи користувачів -> групи рахунків ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccessToAccountsUsers/Users',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зв`язок об`єктів адміністрування ********** ');
          --  Створюємо функцію Зв`язок об`єктів адміністрування
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зв`язок об`єктів адміністрування',
                                                  p_funcname => '/barsroot/Admin/CommunicationObject/Index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд документів відділення ********** ');
          --  Створюємо функцію Перегляд документів відділення
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд документів відділення',
                                                  p_funcname => '/barsroot/DocView/Docs/DocumentDateFilter?type=0',
                                                  p_rolename => 'WR_DOCLIST_TOBO' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Перелік усіх документів за дату
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перелік усіх документів за дату',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&date=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів відділення за період
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перелік отриманих документів відділення за період',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів відділення за період
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перелік усіх документів відділення за період',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перелік усіх документів за сьогодні',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=11',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд картки документу
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перегляд картки документу',
                                                              p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів відділення за дату
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перелік отриманих документів відділення за дату',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&date=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів відділення за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перелік отриманих документів відділення за сьогодні',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=12',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструктор АРМів ********** ');
          --  Створюємо функцію Конструктор АРМів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструктор АРМів',
                                                  p_funcname => '/barsroot/admin/adm/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію 8
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '8',
                                                              p_funcname => '/barsroot/admin/adm/editadm\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію 6
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '6',
                                                              p_funcname => '/barsroot/admin/adm/createadm\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Встановлення режиму доступу до ресурсу
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Встановлення режиму доступу до ресурсу',
                                                              p_funcname => '/barsroot/admin/adm/setadmresourceaccessmode\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію 2
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '2',
                                                              p_funcname => '/barsroot/admin/adm/getadmlist\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування користувачів ********** ');
          --  Створюємо функцію Адміністрування користувачів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування користувачів',
                                                  p_funcname => '/barsroot/admin/admu/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Закриття користувача АБС
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Закриття користувача АБС',
                                                              p_funcname => '/barsroot/admin/admu/closeuser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Отримання дерева бранчів
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Отримання дерева бранчів',
                                                              p_funcname => '/barsroot/admin/admu/getbranchlookups\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію 13
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '13',
                                                              p_funcname => '/barsroot/admin/admu/getbranchlist\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Відміна делегування прав користувача
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Відміна делегування прав користувача',
                                                              p_funcname => '/barsroot/admin/admu/cenceldelegateuserrights\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Делегування прав користувача іншому користувачу
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Делегування прав користувача іншому користувачу',
                                                              p_funcname => '/barsroot/admin/admu/delegateuserrights\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Створення нового користувача
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Створення нового користувача',
                                                              p_funcname => '/barsroot/admin/admu/createuser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Отримання даних по користувачу
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Отримання даних по користувачу',
                                                              p_funcname => '/barsroot/admin/admu/getuserdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію 10
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '10',
                                                              p_funcname => '/barsroot/admin/admu/edituser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Отримання списку ролей користувача Оракл
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Отримання списку ролей користувача Оракл',
                                                              p_funcname => '/barsroot/admin/admu/getoraroleslookups\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію 19
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '19',
                                                              p_funcname => '/barsroot/admin/admu/unlockuser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію 18
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '18',
                                                              p_funcname => '/barsroot/admin/admu/lockuser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Встановлення технічного паролю користувач АБС
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Встановлення технічного паролю користувач АБС',
                                                              p_funcname => '/barsroot/admin/admu/changeabsuserpassword\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію 2
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '2',
                                                              p_funcname => '/barsroot/admin/admu/getadmulist\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Зміна паролю користувача Оракл
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Зміна паролю користувача Оракл',
                                                              p_funcname => '/barsroot/admin/admu/changeorauserpassword\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію 8
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '8',
                                                              p_funcname => '/barsroot/admin/admu/getuserroles\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Отримання списку ролей
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Отримання списку ролей',
                                                              p_funcname => '/barsroot/admin/admu/getrolelookups\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Черга повідомлень для синхронізаціх з ЕА ********** ');
          --  Створюємо функцію Черга повідомлень для синхронізаціх з ЕА
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Черга повідомлень для синхронізаціх з ЕА',
                                                  p_funcname => '/barsroot/admin/ead_sync_queue.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Налаштування системи ********** ');
          --  Створюємо функцію Налаштування системи
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Налаштування системи',
                                                  p_funcname => '/barsroot/admin/globaloptions.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування списку функцій відкриття/закриття дня ********** ');
          --  Створюємо функцію Редагування списку функцій відкриття/закриття дня
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування списку функцій відкриття/закриття дня',
                                                  p_funcname => '/barsroot/admin/listset/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Дані таблиці сетів
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Дані таблиці сетів',
                                                              p_funcname => '/barsroot/admin/listset/getlistsetdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Функції сету
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Функції сету',
                                                              p_funcname => '/barsroot/admin/listset/getlistfuncsetdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Доступні операції
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Доступні операції',
                                                              p_funcname => '/barsroot/admin/listset/getoperlisthandbookdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструктор операцій ********** ');
          --  Створюємо функцію Конструктор операцій
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструктор операцій',
                                                  p_funcname => '/barsroot/admin/oper/index',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування ролей ********** ');
          --  Створюємо функцію Адміністрування ролей
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування ролей',
                                                  p_funcname => '/barsroot/admin/roles/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Блокування ролі користувачів АБС
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Блокування ролі користувачів АБС',
                                                              p_funcname => '/barsroot/admin/roles/lockrole\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Встановлення режиму доступу до ресурсу ролі
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Встановлення режиму доступу до ресурсу ролі',
                                                              p_funcname => '/barsroot/admin/roles/setresourceaccessmode\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Створення ролі користувачів АБС
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Створення ролі користувачів АБС',
                                                              p_funcname => '/barsroot/admin/roles/createrole\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розблокування ролі користувачів АБС
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Розблокування ролі користувачів АБС',
                                                              p_funcname => '/barsroot/admin/roles/unlockrole\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Редагування ролі користувачів АБС
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Редагування ролі користувачів АБС',
                                                              p_funcname => '/barsroot/admin/roles/editrole\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування задач відкладеного запуску ********** ');
          --  Створюємо функцію Адміністрування задач відкладеного запуску
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування задач відкладеного запуску',
                                                  p_funcname => '/barsroot/async/admin/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Запущені задачі ********** ');
          --  Створюємо функцію Запущені задачі
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Запущені задачі',
                                                  p_funcname => '/barsroot/async/tasks/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Знайти процедуру відкладеного запуску
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Знайти процедуру відкладеного запуску',
                                                              p_funcname => '/barsroot/async/tasks/start\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування користувачів ********** ');
          --  Створюємо функцію Редагування користувачів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування користувачів',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=6304&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'CUST001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Дошка об`яв ********** ');
          --  Створюємо функцію Дошка об`яв
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Дошка об`яв',
                                                  p_funcname => '/barsroot/barsweb/welcome.aspx',
                                                  p_rolename => 'BASIC_INFO' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адмiнiстрування дошки об`яв ********** ');
          --  Створюємо функцію Адмiнiстрування дошки об`яв
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адмiнiстрування дошки об`яв',
                                                  p_funcname => '/barsroot/board/admin/',
                                                  p_rolename => 'WR_BOARD' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Видалення повідомлення дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Видалення повідомлення дошки оголошень',
                                                              p_funcname => '/barsroot/board/delete/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування повідомлень дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Адміністрування повідомлень дошки оголошень',
                                                              p_funcname => '/barsroot/board/admin/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Створення повідомлення дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Створення повідомлення дошки оголошень',
                                                              p_funcname => '/barsroot/board/add/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Редагування повідомлення дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Редагування повідомлення дошки оголошень',
                                                              p_funcname => '/barsroot/board/edit/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Оновлення рахунків(по доступу) ********** ');
          --  Створюємо функцію Оновлення рахунків(по доступу)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Оновлення рахунків(по доступу)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=2&t=1',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування рекламних повідомлень ********** ');
          --  Створюємо функцію Адміністрування рекламних повідомлень
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування рекламних повідомлень',
                                                  p_funcname => '/barsroot/doc/advertising/index/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(API)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Адміністрування рекламних повідомлень(API)',
                                                              p_funcname => '/barsroot/api/doc/advertising\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(Головна)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Адміністрування рекламних повідомлень(Головна)',
                                                              p_funcname => '/barsroot/doc/advertising/index\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(перегляд картинки)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Адміністрування рекламних повідомлень(перегляд картинки)',
                                                              p_funcname => '/barsroot/doc/advertising/image\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(детальна інф.)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Адміністрування рекламних повідомлень(детальна інф.)',
                                                              p_funcname => '/barsroot/doc/advertising/detail\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(завантаження картинки)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Адміністрування рекламних повідомлень(завантаження картинки)',
                                                              p_funcname => '/barsroot/doc/advertising/fileupload\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(редагування)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Адміністрування рекламних повідомлень(редагування)',
                                                              p_funcname => '/barsroot/doc/advertising/edit\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування рекламних повідомлень(редагування картинки)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Адміністрування рекламних повідомлень(редагування картинки)',
                                                              p_funcname => '/barsroot/doc/advertising/imageeditor\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення дод. реквізитів - всі документи відділення(WEB) ********** ');
          --  Створюємо функцію Довведення дод. реквізитів - всі документи відділення(WEB)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення дод. реквізитів - всі документи відділення(WEB)',
                                                  p_funcname => '/barsroot/docinput/editprops.aspx?mode=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Довведення дод. реквізитів по реф.(WEB)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довведення дод. реквізитів по реф.(WEB)',
                                                              p_funcname => '/barsroot/docinput/editprops.aspx?ref=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування звітів ********** ');
          --  Створюємо функцію Формування звітів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування звітів',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_MAIN',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виплата %% по депозитах(група Пасиви) ********** ');
          --  Створюємо функцію Виплата %% по депозитах(група Пасиви)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виплата %% по депозитах(група Пасиви)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_PAY_INTEREST_DEPOS&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Повідомлення для релізу ********** ');
          --  Створюємо функцію Повідомлення для релізу
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Повідомлення для релізу',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>p_message_for_release(:R)][PAR=>:R(SEM=Через скільки хвилин доставити повідомлення,TYPE=N)][EXEC=>BEFORE][MSG=>Повідомлення створене!]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вихідні та свята ********** ');
          --  Створюємо функцію Вихідні та свята
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вихідні та свята',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=HOLIDAY&accessCode=7&sPar=[NSIFUNCTION][CONDITIONS=>kv=980]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зміна банківського дня ********** ');
          --  Створюємо функцію Зміна банківського дня
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зміна банківського дня',
                                                  p_funcname => '/barsroot/opencloseday/openclose/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Тест производительности ********** ');
          --  Створюємо функцію Тест производительности
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Тест производительности',
                                                  p_funcname => '/barsroot/perfom/default.aspx',
                                                  p_rolename => '' ,    
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка запитів ********** ');
          --  Створюємо функцію Обробка запитів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка запитів',
                                                  p_funcname => '/barsroot/requestsProcessing/requestsProcessing',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт довідника монет ********** ');
          --  Створюємо функцію Імпорт довідника монет
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт довідника монет',
                                                  p_funcname => '/barsroot/sberutls/import_spr_mon.aspx',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прийом VIP ********** ');
          --  Створюємо функцію Прийом VIP
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прийом VIP',
                                                  p_funcname => '/barsroot/sberutls/import_vip.aspx',
                                                  p_rolename => 'TECH005' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Завантаження DBF-таблиць ********** ');
          --  Створюємо функцію Завантаження DBF-таблиць
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Завантаження DBF-таблиць',
                                                  p_funcname => '/barsroot/sberutls/load_dbf.aspx',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Журнал подій АБС ********** ');
          --  Створюємо функцію Журнал подій АБС
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Журнал подій АБС',
                                                  p_funcname => '/barsroot/security/audit',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Активні сесії користувачів ********** ');
          --  Створюємо функцію Активні сесії користувачів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Активні сесії користувачів',
                                                  p_funcname => '/barsroot/security/usersession',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Інформація про файли ********** ');
          --  Створюємо функцію СЕП. Інформація про файли
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Інформація про файли',
                                                  p_funcname => '/barsroot/sep/sepfiles/index?mode=RW',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи СЕП  ( Всі ) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи СЕП  ( Всі )
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи СЕП  ( Всі )',
                                                  p_funcname => '/barsroot/sep/seplockdocs/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Заблоковані документи СЕП (Без контролю ВПС) (Документи)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Заблоковані документи СЕП (Без контролю ВПС) (Документи)',
                                                              p_funcname => '/barsroot/sep/seplockdocs/getseplockdoc\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Заблоковані документи СЕП (Без контролю ВПС)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Заблоковані документи СЕП (Без контролю ВПС)',
                                                              p_funcname => '/barsroot/sep/seplockdocs/index\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Заблоковані документи СЕП (Без контролю ВПС)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Заблоковані документи СЕП (Без контролю ВПС)',
                                                              p_funcname => '/barsroot/sep/seplockdocs/index?DefinedCode=1',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_MAIN) - АРМ Адміністратора АБС   ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_MAIN.sql =========**
PROMPT ===================================================================================== 
