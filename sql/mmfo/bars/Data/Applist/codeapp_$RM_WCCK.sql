SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WCCK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WCCK ***
  declare
    l_application_code varchar2(10 char) := '$RM_WCCK';
    l_application_name varchar2(300 char) := 'АРМ <<Кредити ФО>>';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WCCK створюємо (або оновлюємо) АРМ АРМ <<Кредити ФО>> ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1) Введення нового КД ФО ********** ');
          --  Створюємо функцію 1) Введення нового КД ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1) Введення нового КД ФО',
                                                  p_funcname => '/barsroot/CreditUi/NewCredit/?custtype=3',
                                                  p_rolename => 'START1' ,    
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прийняття файлу «Приналежність до працівників Банку» ********** ');
          --  Створюємо функцію Прийняття файлу «Приналежність до працівників Банку»
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прийняття файлу «Приналежність до працівників Банку»',
                                                  p_funcname => '/barsroot/credit/import_hits.aspx',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F0: Авторозбір рахунків погашення SG ********** ');
          --  Створюємо функцію КП F0: Авторозбір рахунків погашення SG
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F0: Авторозбір рахунків погашення SG',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK.CC_ASG (0)][QST=>Виконати "КП F0: Авторозбір рахунків погашення SG"?][MSG=>Виконано !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #4) КП F0_3: Авто-разбiр рахункiв погашення SG ФО ********** ');
          --  Створюємо функцію #4) КП F0_3: Авто-разбiр рахункiв погашення SG ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#4) КП F0_3: Авто-разбiр рахункiв погашення SG ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_ASG_SBER (3)][QST=>Виконати розбір рахунків погашення?][MSG=>Розбір рахункiв виконано !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш. ФО ********** ');
          --  Створюємо функцію #2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш. ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш. ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''3'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ФО ?][MSG=>Перенесення виканано !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Амортизація Дисконту/Премії ФО ********** ');
          --  Створюємо функцію Амортизація Дисконту/Премії ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Амортизація Дисконту/Премії ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(-11,bankdate,3)][QST=>Виконати амортизацію дисконту ФО?][MSG=>Готово!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Амортизація Дисконту/Премії ********** ');
          --  Створюємо функцію Амортизація Дисконту/Премії
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Амортизація Дисконту/Премії',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(0,bankdate,3)][QST=>Виконати амортизацію дисконту?][MSG=>Готово!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Амортизація дисконту, премії по одному КД ********** ');
          --  Створюємо функцію Амортизація дисконту, премії по одному КД
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Амортизація дисконту, премії по одному КД',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(:ND,gl.bd,3)][PAR=>:ND(SEM=Референс КД)][QST=>Виконаи амортизацію дисконту по КД?][MSG=>Виконано!]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Первинне (до)Наповнення даними з КП ********** ');
          --  Створюємо функцію Первинне (до)Наповнення даними з КП
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Первинне (до)Наповнення даними з КП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>ICCK(0)][QST=>Виконати Первинне (до)Наповнення даними з КП?][MSG=>Виконано!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдображення на 9819* результатiв iнвентаризацiї ********** ');
          --  Створюємо функцію Вiдображення на 9819* результатiв iнвентаризацiї
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдображення на 9819* результатiв iнвентаризацiї',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>ICCK(3)][QST=>Виконати Вiдображення на 9819* результатiв iнвентаризацiї?][MSG=>Виконано!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S8: Авто закриття договорів ФО ********** ');
          --  Створюємо функцію КП S8: Авто закриття договорів ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S8: Авто закриття договорів ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cc_close(3,bankdate)][QST=>Ви бажаєте виконати авто-закриття договорів ФО?][MSG=>Закриття виканано !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Крд.Портф. (Формування + Перегляд) ********** ');
          --  Створюємо функцію Аудит OB22 в Крд.Портф. (Формування + Перегляд)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Крд.Портф. (Формування + Перегляд)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=AUD_CCK&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довiдник ОБ22 в Крд.Портф. ЮО+ФО ********** ');
          --  Створюємо функцію Довiдник ОБ22 в Крд.Портф. ЮО+ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довiдник ОБ22 в Крд.Портф. ЮО+ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_OB22&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату ********** ');
          --  Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити, що мають прострочку на ПОТОЧНУ дату',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_PROBL&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Данi про реструктуризацiю КД ФО ********** ');
          --  Створюємо функцію Данi про реструктуризацiю КД ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Данi про реструктуризацiю КД ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_RESTR_V&accessCode=0&sPar=[CONDITIONS=>CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (11,12,13))]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстр проблемних кредитів фізичних осіб ********** ');
          --  Створюємо функцію Реєстр проблемних кредитів фізичних осіб
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстр проблемних кредитів фізичних осіб',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_DEAL_PROBL&accessCode=1&sPar=[PROC=>P_CCK_PROBL(:Par0,11)][PAR=>:Par0(SEM= На дату ,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Позика - Забезпечення - Депозит ********** ');
          --  Створюємо функцію Позика - Забезпечення - Депозит
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Позика - Забезпечення - Депозит',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_PAWN_DP&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію REAL-Міграція КД з РУ ********** ');
          --  Створюємо функцію REAL-Міграція КД з РУ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REAL-Міграція КД з РУ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_V&accessCode=1&sPar=[PROC=>MI_CCK(:L,:KF,:ND,1)][PAR=>:L(SEM=Имя_ДБ_Линка,TYPE=S),:KF(SEM=МФО_РУ,TYPE=S,REF=BANKS_RU),:ND(SEM=Реф_КД_в_РУ,TYPE=N)][EXEC=>BEFORE][MSG=>Виконано!][CONDITIONS=> CC_V.ND in (select new_val from MIGR_RU where TIP=''ND'')]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звіт про кількість кредитних угод по ФО за період ********** ');
          --  Створюємо функцію Звіт про кількість кредитних угод по ФО за період
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звіт про кількість кредитних угод по ФО за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=COUNT_CCK&accessCode=1&sPar=[PROC=>CCK_REPORT.COUNT_CCK(0,:F,:T)][PAR=>:F(SEM=Зв_Дата_З>,TYPE=D),:T(SEM=Зв_Дата_По>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнвентаризацiя КП ФО - Деталiзованi БПК - 23 Пост ********** ');
          --  Створюємо функцію Iнвентаризацiя КП ФО - Деталiзованi БПК - 23 Пост
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнвентаризацiя КП ФО - Деталiзованi БПК - 23 Пост',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_BPK_23&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнвентаризацiя КП ФО - 23 Пост ********** ');
          --  Створюємо функцію Iнвентаризацiя КП ФО - 23 Пост
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнвентаризацiя КП ФО - 23 Пост',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_FL_23&accessCode=1&sPar=[PROC=>P_INV_CCK_FL_23 (:Param0,1)][PAR=>:Param0(SEM=Дата,TYPE=D)][QST=>Переформувати інвентаризацію КП?][EXEC=>BEFORE][CONDITIONS=>INV_FL_23.G00=TO_DATE(pul.get_mas_ini_val(''sFdat1''),''dd.mm.yyyy'')]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнвентаризацiя КП ФО - Iншi - 23 Пост ********** ');
          --  Створюємо функцію Iнвентаризацiя КП ФО - Iншi - 23 Пост
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнвентаризацiя КП ФО - Iншi - 23 Пост',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_INSHI_23&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Таблиця КД та їх потоків ********** ');
          --  Створюємо функцію Таблиця КД та їх потоків
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Таблиця КД та їх потоків',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=PRVN_FLOW_DEALS&accessCode=2&sPar=[NSIFUNCTION][PROC=>PUL_DAT(:A,null)][PAR=>:A(SEM=Звiтна дата dd_mm_yyyy)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Протокол прийняття файлу «Приналежність до працівників Банку» ********** ');
          --  Створюємо функцію Протокол прийняття файлу «Приналежність до працівників Банку»
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Протокол прийняття файлу «Приналежність до працівників Банку»',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TMP_BANK_EMPLOYEE_PROT&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд параметрів для розпоряджень на видачу кредита ********** ');
          --  Створюємо функцію Перегляд параметрів для розпоряджень на видачу кредита
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд параметрів для розпоряджень на видачу кредита',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_DT_SS&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Помилкові входження рахунків до КД ********** ');
          --  Створюємо функцію Помилкові входження рахунків до КД
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Помилкові входження рахунків до КД',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_ERR_REL_ACC&accessCode=6&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2) Портфель НОВИХ кредитів ФО ********** ');
          --  Створюємо функцію 2) Портфель НОВИХ кредитів ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2) Портфель НОВИХ кредитів ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_NF&accessCode=1&sPar=[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити, що мають прострочку на Задану дату ********** ');
          --  Створюємо функцію Кредити, що мають прострочку на Задану дату
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити, що мають прострочку на Задану дату',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_PROBL_ON_DATE&accessCode=1&sPar=[PROC=>P_CCK_PROBL_ON_DATE(:SPAR,:KV,:BRANCH,:VID)][PAR=>:SPAR(SEM= На дату ,TYPE=D),:KV(SEM= Вал_0-всі ,TYPE=S),:BRANCH(SEM= Відділення_пусто-всі,TYPE=S,REF=BRANCH_VAR),:VID(SEM= 2-ЮО_3-ФО,TYPE=S) ][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит параметру R013 в КП ФО ********** ');
          --  Створюємо функцію Аудит параметру R013 в КП ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит параметру R013 в КП ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_R013&accessCode=1&sPar=[CONDITIONS=>vidd in(11,12,13)]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3) Портфель РОБОЧИХ кредитів ФО ********** ');
          --  Створюємо функцію 3) Портфель РОБОЧИХ кредитів ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3) Портфель РОБОЧИХ кредитів ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_RF&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Об-сал вiдомiсть за перiод по КП ФО ********** ');
          --  Створюємо функцію Об-сал вiдомiсть за перiод по КП ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Об-сал вiдомiсть за перiод по КП ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_SAL3&accessCode=1&sPar=[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM=Поч Дата перiоду dd_mm_yyyy>,TYPE=S),:Par2(SEM=Кiн Дата перiоду dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Перекриття  погашення кредитів Крим
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перекриття  погашення кредитів Крим',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,324,''PER_KRM'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ЮО ?][MSG=>Перенесення виканано !]',
                                                              p_rolename => 'bars_access_defrole' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перекриття по документу (Пр.пл. перв. док.)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перекриття по документу (Пр.пл. перв. док.)',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,77,''PER_INK_N'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                              p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік планових платежiв позичальникiв ФО по КД
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перелік планових платежiв позичальникiв ФО по КД',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_PAY1&accessCode=1&sPar=[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM= dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                              p_rolename => 'bars_access_defrole' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перекриття, перерахування ПДФО до бюджету
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перекриття, перерахування ПДФО до бюджету',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_PDFO[NSIFUNCTION][PROC=>PUL.PUT(''WDAT'',to_char(:P,''dd.mm.yyyy''))][PAR=>:P(SEM=Дата,TYPE=D)][EXEC=>BEFORE]',
                                                              p_rolename => 'bars_access_defrole' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Звіти по автоматичним функціям КП ЮО
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Звіти по автоматичним функціям КП ЮО',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_REP&accessCode=1&sPar=[PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=Вибір функції,TYPE=N,REF=V_CCK_REP_LIST_YL)][NSIFUNCTION][EXEC=>BEFORE][MSG=>Виконано!]',
                                                              p_rolename => 'bars_access_defrole' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Претенденты на реструктур (АТО) ********** ');
          --  Створюємо функцію Претенденты на реструктур (АТО)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Претенденты на реструктур (АТО)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_GRACE_ATO&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП: Нарахування щомiсячної комiсiї по КП ********** ');
          --  Створюємо функцію КП: Нарахування щомiсячної комiсiї по КП
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП: Нарахування щомiсячної комiсiї по КП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK&accessCode=1&sPar=[PROC=>p_interest_cck(null,5,:E)][PAR=>:E(SEM=Дата по,TYPE=D)][showDialogWindow=>false][DESCR=>КД: Нарах.%%][EXEC=>BEFORE][NSIFUNCTION]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік планових платежiв позичальникiв ФО по КД ********** ');
          --  Створюємо функцію Перелік планових платежiв позичальникiв ФО по КД
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік планових платежiв позичальникiв ФО по КД',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_PAY1&accessCode=1&sPar=[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM= dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_WCCK) - АРМ <<Кредити ФО>>  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WCCK.sql =========**
PROMPT ===================================================================================== 
