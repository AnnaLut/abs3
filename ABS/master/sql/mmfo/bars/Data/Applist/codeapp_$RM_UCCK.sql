PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_UCCK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_UCCK ***
  declare
    l_application_code varchar2(10 char) := '$RM_UCCK';
    l_application_name varchar2(300 char) := 'АРМ <<Кредити ЮО>>';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_UCCK створюємо (або оновлюємо) АРМ АРМ <<Кредити ЮО>> ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1) Введення нового КД ЮО ********** ');
          --  Створюємо функцію 1) Введення нового КД ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1) Введення нового КД ЮО',
                                                  p_funcname => '/barsroot/CreditUi/NewCredit/?custtype=2',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування звітів ********** ');
          --  Створюємо функцію Формування звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування звітів',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_UCCK',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Start/ Авто-просрочка рахунків боргу SS - ЮО ********** ');
          --  Створюємо функцію Start/ Авто-просрочка рахунків боргу SS - ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start/ Авто-просрочка рахунків боргу SS - ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> CCK.CC_ASP ( -1,1)][QST=>Виконати Start/ Авто-просрочка рахунків боргу SS - ЮО?][MSG=>Виконано!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F0: Авторозбір рахунків погашення SG ********** ');
          --  Створюємо функцію КП F0: Авторозбір рахунків погашення SG
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F0: Авторозбір рахунків погашення SG',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK.CC_ASG (0)][QST=>Виконати "КП F0: Авторозбір рахунків погашення SG"?][MSG=>Виконано !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S32: Авто-просрочка рахунків нарах.% SN ЮО ********** ');
          --  Створюємо функцію КП S32: Авто-просрочка рахунків нарах.% SN ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S32: Авто-просрочка рахунків нарах.% SN ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK.CC_ASPN(2,0,1)][QST=>Ви бажаєте виконати винесення на прострочку процентів клієнта?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО ********** ');
          --  Створюємо функцію Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ЮО ?][MSG=>Перенесення виканано !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка КП ЮО - виноси на прострочку(на старті) ********** ');
          --  Створюємо функцію Обробка КП ЮО - виноси на прострочку(на старті)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка КП ЮО - виноси на прострочку(на старті)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCT.StartI(0)][QST=>Ви бажаєте виконати винесення на прострочку(на старті)?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Амортизація Дисконту/Премії ЮО ********** ');
          --  Створюємо функцію Амортизація Дисконту/Премії ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Амортизація Дисконту/Премії ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(-1,bankdate,3)][QST=>Виконати амортизацію дисконту ЮО?][MSG=>Готово!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Амортизація Дисконту/Премії ********** ');
          --  Створюємо функцію Амортизація Дисконту/Премії
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Амортизація Дисконту/Премії',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(0,bankdate,3)][QST=>Виконати амортизацію дисконту?][MSG=>Готово!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Первинне (до)Наповнення даними з КП ********** ');
          --  Створюємо функцію Первинне (до)Наповнення даними з КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Первинне (до)Наповнення даними з КП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>ICCK(0)][QST=>Виконати Первинне (до)Наповнення даними з КП?][MSG=>Виконано!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдображення на 9819* результатiв iнвентаризацiї ********** ');
          --  Створюємо функцію Вiдображення на 9819* результатiв iнвентаризацiї
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдображення на 9819* результатiв iнвентаризацiї',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>ICCK(3)][QST=>Виконати Вiдображення на 9819* результатiв iнвентаризацiї?][MSG=>Виконано!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Проводки по стартовій ПЕНІ ********** ');
          --  Створюємо функцію Проводки по стартовій ПЕНІ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Проводки по стартовій ПЕНІ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>PAY_SN8(2)][QST=>Ви бажаєте виконати згортання пені?][MSG=>Проводки виканано !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S8: Авто закриття договорів ЮО ********** ');
          --  Створюємо функцію КП S8: Авто закриття договорів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S8: Авто закриття договорів ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cc_close(2,bankdate)][QST=>Ви бажаєте виконати авто-закриття договорів ЮО?][MSG=>Закриття виканано !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вирівнювання залишків на 9129 по КП ЮО ********** ');
          --  Створюємо функцію Вирівнювання залишків на 9129 по КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вирівнювання залишків на 9129 по КП ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.CC_9129(bankdate,0,2) ][QST=>Виконати "Вирівнювання залишків на 9129 по КП ЮО"?][MSG=>Виконано !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Крд.Портф. (Формування + Перегляд) ********** ');
          --  Створюємо функцію Аудит OB22 в Крд.Портф. (Формування + Перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Крд.Портф. (Формування + Перегляд)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=AUD_CCK&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довiдник ОБ22 в Крд.Портф. ЮО+ФО ********** ');
          --  Створюємо функцію Довiдник ОБ22 в Крд.Портф. ЮО+ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довiдник ОБ22 в Крд.Портф. ЮО+ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_OB22&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату ********** ');
          --  Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити, що мають прострочку на ПОТОЧНУ дату',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_PROBL&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Данi про реструктуризацiю КД ЮО ********** ');
          --  Створюємо функцію Данi про реструктуризацiю КД ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Данi про реструктуризацiю КД ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CCK_RESTR_V&accessCode=0&sPar=[CONDITIONS=>CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (1,2,3))]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Позика - Забезпечення - Депозит ********** ');
          --  Створюємо функцію Позика - Забезпечення - Депозит
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Позика - Забезпечення - Депозит',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_PAWN_DP&accessCode=2',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SNO-0) Претенденты на реструктур: SPN => (SNO+GPP) ********** ');
          --  Створюємо функцію SNO-0) Претенденты на реструктур: SPN => (SNO+GPP)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SNO-0) Претенденты на реструктур: SPN => (SNO+GPP)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V0_SNO&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>V0_SNO.vidd in (1,2,3)]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SNO-1) Претенденты на ГПП : SNO => GPP ********** ');
          --  Створюємо функцію SNO-1) Претенденты на ГПП : SNO => GPP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SNO-1) Претенденты на ГПП : SNO => GPP',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V1_SNO&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>V1_SNO.vidd in (1,2,3)]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SNO-2) Портфель : SNO + GPP ********** ');
          --  Створюємо функцію SNO-2) Портфель : SNO + GPP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SNO-2) Портфель : SNO + GPP',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V2_SNO&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>V2_SNO.vidd in (1,2,3)]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд параметрів для розпоряджень на видачу кредита ********** ');
          --  Створюємо функцію Перегляд параметрів для розпоряджень на видачу кредита
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд параметрів для розпоряджень на видачу кредита',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_DT_SS&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Помилкові входження рахунків до КД ********** ');
          --  Створюємо функцію Помилкові входження рахунків до КД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Помилкові входження рахунків до КД',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_ERR_REL_ACC&accessCode=6&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2) Портфель НОВИХ кредитів ЮО ********** ');
          --  Створюємо функцію 2) Портфель НОВИХ кредитів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2) Портфель НОВИХ кредитів ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_NU&accessCode=1&sPar=[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит параметру R013 в КП ЮО ********** ');
          --  Створюємо функцію Аудит параметру R013 в КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит параметру R013 в КП ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_R013&accessCode=1&sPar=[CONDITIONS=>vidd in(1,2,3)]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3) Портфель РОБОЧИХ кредитів ЮО ********** ');
          --  Створюємо функцію 3) Портфель РОБОЧИХ кредитів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3) Портфель РОБОЧИХ кредитів ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_RU&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Об-сал вiдомiсть за перiод по КП ЮО ********** ');
          --  Створюємо функцію Об-сал вiдомiсть за перiод по КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Об-сал вiдомiсть за перiод по КП ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_SAL2&accessCode=1&sPar=[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM=Поч Дата перiоду dd_mm_yyyy>,TYPE=S),:Par2(SEM=Кiн Дата перiоду dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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

      --  Створюємо дочірню функцію Перекриття, перерахування ПДФО до бюджету
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перекриття, перерахування ПДФО до бюджету',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_PDFO[NSIFUNCTION][PROC=>PUL.PUT(''WDAT'',to_char(:P,''dd.mm.yyyy''))][PAR=>:P(SEM=Дата,TYPE=D)][EXEC=>BEFORE]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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

      --  Створюємо дочірню функцію Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ЮО ?][MSG=>Перенесення виканано !]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік планових платежiв позичальникiв ФО по КД
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік планових платежiв позичальникiв ФО по КД',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_PAY1&accessCode=1&sPar=[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM= dd_mm_yyyy>,TYPE=S)][EXEC=>BEFORE]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Звіти по автоматичним функціям КП ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Звіти по автоматичним функціям КП ЮО',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_REP&accessCode=1&sPar=[PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=Вибір функції,TYPE=N,REF=V_CCK_REP_LIST_YL)][NSIFUNCTION][EXEC=>BEFORE][MSG=>Виконано!]',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_UCCK) - АРМ <<Кредити ЮО>>  ');
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
umu.add_report2arm(11,'$RM_UCCK');
umu.add_report2arm(18,'$RM_UCCK');
umu.add_report2arm(27,'$RM_UCCK');
umu.add_report2arm(30,'$RM_UCCK');
umu.add_report2arm(31,'$RM_UCCK');
umu.add_report2arm(43,'$RM_UCCK');
umu.add_report2arm(61,'$RM_UCCK');
umu.add_report2arm(78,'$RM_UCCK');
umu.add_report2arm(119,'$RM_UCCK');
umu.add_report2arm(125,'$RM_UCCK');
umu.add_report2arm(173,'$RM_UCCK');
umu.add_report2arm(189,'$RM_UCCK');
umu.add_report2arm(190,'$RM_UCCK');
umu.add_report2arm(194,'$RM_UCCK');
umu.add_report2arm(218,'$RM_UCCK');
umu.add_report2arm(232,'$RM_UCCK');
umu.add_report2arm(235,'$RM_UCCK');
umu.add_report2arm(252,'$RM_UCCK');
umu.add_report2arm(261,'$RM_UCCK');
umu.add_report2arm(262,'$RM_UCCK');
umu.add_report2arm(263,'$RM_UCCK');
umu.add_report2arm(264,'$RM_UCCK');
umu.add_report2arm(265,'$RM_UCCK');
umu.add_report2arm(294,'$RM_UCCK');
umu.add_report2arm(309,'$RM_UCCK');
umu.add_report2arm(375,'$RM_UCCK');
umu.add_report2arm(415,'$RM_UCCK');
umu.add_report2arm(416,'$RM_UCCK');
umu.add_report2arm(426,'$RM_UCCK');
umu.add_report2arm(429,'$RM_UCCK');
umu.add_report2arm(479,'$RM_UCCK');
umu.add_report2arm(490,'$RM_UCCK');
umu.add_report2arm(491,'$RM_UCCK');
umu.add_report2arm(495,'$RM_UCCK');
umu.add_report2arm(674,'$RM_UCCK');
umu.add_report2arm(805,'$RM_UCCK');
umu.add_report2arm(3002,'$RM_UCCK');
umu.add_report2arm(3003,'$RM_UCCK');
umu.add_report2arm(3099,'$RM_UCCK');
umu.add_report2arm(4011,'$RM_UCCK');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_UCCK.sql =========**
PROMPT ===================================================================================== 
