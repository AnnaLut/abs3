PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_OWAY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_OWAY ***
  declare
    l_application_code varchar2(10 char) := '$RM_OWAY';
    l_application_name varchar2(300 char) := 'АРМ Інтерфейс з OpenWay';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_OWAY створюємо (або оновлюємо) АРМ АРМ Інтерфейс з OpenWay ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запит на миттєві картки ********** ');
          --  Створюємо функцію Way4. Запит на миттєві картки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запит на миттєві картки',
                                                  p_funcname => '/barsroot/Way/InstantCards/InstantCards',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Портфель БПК (ФО) ********** ');
          --  Створюємо функцію Way4. Портфель БПК (ФО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Портфель БПК (ФО)',
                                                  p_funcname => '/barsroot/Way4Bpk/Way4Bpk',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Реквізити картки киянина
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Реквізити картки киянина',
															  p_funcname => '/barsroot/cardkiev/cardkievparams.aspx?\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4.productgrp
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4.productgrp',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.productgrp&formname=\S+',
															  p_rolename => 'OW' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довгострокове доручення на списання коштів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довгострокове доручення на списання коштів',
															  p_funcname => '/barsroot/w4/addregularpayment.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Редагування атрибутів рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редагування атрибутів рахунку',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд рахунків за договорами БПК
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків за договорами БПК',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=5&bpkw4nd=\d+&mod=ro',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Карткові рахунки з заборгованості БПК ********** ');
          --  Створюємо функцію Way4. Карткові рахунки з заборгованості БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Карткові рахунки з заборгованості БПК',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.debtacc',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Редактирование атрибутов счета
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редактирование атрибутов счета',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Редагування атрибутів рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редагування атрибутів рахунку',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Пакетне перебранчування ********** ');
          --  Створюємо функцію Way4. Пакетне перебранчування
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Пакетне перебранчування',
                                                  p_funcname => '/barsroot/bpkw4/batchbranching/index',
                                                  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2924*07*Надлишки в АТМ ********** ');
          --  Створюємо функцію 2924*07*Надлишки в АТМ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924*07*Надлишки в АТМ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_ATMREF07[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2924*08*Нестачі в АТМ ********** ');
          --  Створюємо функцію 2924*08*Нестачі в АТМ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924*08*Нестачі в АТМ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_ATMREF08[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запити до CardMake ********** ');
          --  Створюємо функцію Way4. Запити до CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запити до CardMake',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CM_REQUEST[NSIFUNCTION]',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2924.Ручна розшифровка ********** ');
          --  Створюємо функцію 2924.Ручна розшифровка
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924.Ручна розшифровка',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_KWT_RA_2924[NSIFUNCTION][showDialogWindow=>false][PROC=>PUL_DAT(:B,null)][PAR=>:B(SEM=Звітна_дата,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Звірка балансів(new) ********** ');
          --  Створюємо функцію Way4. Звірка балансів(new)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Звірка балансів(new)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_W4_BALANCE_TXT',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Встановлення %% ставок ********** ');
          --  Створюємо функцію Way4. Встановлення %% ставок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Встановлення %% ставок',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> bars_ow.set_accounts_rate(0)][QST=>Виконати встановлення %% ставок по БПК Way4?][MSG=>Виконано!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OW. Міжфілійні розрахунки ********** ');
          --  Створюємо функцію OW. Міжфілійні розрахунки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OW. Міжфілійні розрахунки',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>BARS_OW.CLIRING(0)][QST=>Виконати взаєморозрахунки з РУ?][MSG=>Виконано взаєморозрахунки з РУ.]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Зміна відділення за З/П проектом ********** ');
          --  Створюємо функцію Way4. Зміна відділення за З/П проектом
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Зміна відділення за З/П проектом',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>P_W4_CHANGE_BRANCH(:P,:B)][PAR=>:P(SEM=ЗП проект,REF=V_W4_PROECT_SAL),:B(SEM=Відділення,REF=BRANCH)][MSG=>Бранч змінено.]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Way4. Несквитовані документи (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. Несквитовані документи (web)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Синхронізація З/П проектів CardMake (web) ********** ');
          --  Створюємо функцію Way4. Синхронізація З/П проектів CardMake (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Синхронізація З/П проектів CardMake (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>bars_ow.cm_salary_sync(0)][QST=>Виконати синхронізацію  З/П проектів CardMake?][MSG=>Синхронізацію З/П проектів CardMake завершено!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Синхронізація З/П проектів CardMake ********** ');
          --  Створюємо функцію Way4. Синхронізація З/П проектів CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Синхронізація З/П проектів CardMake',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>bars_ow.cm_salary_sync(0)][QST=>Виконати синхронізацію З/П проектів?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Групове візування операцій OW6 ********** ');
          --  Створюємо функцію Групове візування операцій OW6
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Групове візування операцій OW6',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>visa_batch_ow6(97,100)][QST=>Виконати візування операцій по вільним реквізитам?][MSG=>Виконано!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2924:Календар квитовки ********** ');
          --  Створюємо функцію 2924:Календар квитовки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924:Календар квитовки',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=D_KWT_2924[NSIFUNCTION][PROC=>KWT_2924.MAX_DAT][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2924 з залишком. Квитовка по сумі ********** ');
          --  Створюємо функцію 2924 з залишком. Квитовка по сумі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924 з залишком. Квитовка по сумі',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_KWT_2924[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2924.Календар квитовки ********** ');
          --  Створюємо функцію 2924.Календар квитовки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2924.Календар квитовки',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_KWT_D_2924[NSIFUNCTION][PROC=>KWT_2924.MAX_DAT][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Помилки при обробці файлу СМ на зміну номеру тел. (web) ********** ');
          --  Створюємо функцію Way4. Помилки при обробці файлу СМ на зміну номеру тел. (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Помилки при обробці файлу СМ на зміну номеру тел. (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=OW_CL_INFO_DATA_ERROR&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Портфель договорів кредитів під БПК (web) ********** ');
          --  Створюємо функцію Way4. Портфель договорів кредитів під БПК (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Портфель договорів кредитів під БПК (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_BPK_CREDIT_DEAL&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Звітність Ощадного Банку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Звітність Ощадного Банку',
															  p_funcname => 'ShowFilesInt(hWndMDI)',
															  p_rolename => 'RPBN002' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запити від CardMake (web) ********** ');
          --  Створюємо функцію Way4. Запити від CardMake (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запити від CardMake (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CM_ACC_REQUEST&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Арештовані рахунки - історія (web) ********** ');
          --  Створюємо функцію Way4. Арештовані рахунки - історія (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Арештовані рахунки - історія (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_ACCHISTORY&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Арештовані рахунки до відправки (web) ********** ');
          --  Створюємо функцію Way4. Арештовані рахунки до відправки (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Арештовані рахунки до відправки (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_ACCQUE&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>sos=0]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Арештовані рахунки, що чекають квитовки (web) ********** ');
          --  Створюємо функцію Way4. Арештовані рахунки, що чекають квитовки (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Арештовані рахунки, що чекають квитовки (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_ACCQUE&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>sos=1]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Aрхів документів IIC (web) ********** ');
          --  Створюємо функцію Way4. Aрхів документів IIC (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Aрхів документів IIC (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_IICFILES&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Документи, що надійшли по системі «Клієнт банк» (web) ********** ');
          --  Створюємо функцію Way4. Документи, що надійшли по системі «Клієнт банк» (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Документи, що надійшли по системі «Клієнт банк» (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_KLBAD&accessCode=2',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Архів файлів OIC_LOCPAYREV (web) ********** ');
          --  Створюємо функцію Way4. Архів файлів OIC_LOCPAYREV (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Архів файлів OIC_LOCPAYREV (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_OICREVFILES&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Документи до відправки (web) ********** ');
          --  Створюємо функцію Way4. Документи до відправки (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Документи до відправки (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 0]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Несквитовані документи (web) ********** ');
          --  Створюємо функцію Way4. Несквитовані документи (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Несквитовані документи (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Way4. Протокол обробки файлів від ПЦ (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. Протокол обробки файлів від ПЦ (web)',
															  p_funcname => '/barsroot/way/wayapp/index?type=protokol',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4. Документи, що надійшли по системі «Клієнт банк» (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. Документи, що надійшли по системі «Клієнт банк» (web)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_KLBAD&accessCode=2',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію SWIFT. Розподіл/Обробка прийнятих повідомлень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'SWIFT. Розподіл/Обробка прийнятих повідомлень',
															  p_funcname => '/barsroot/swift/swift?strPar02=&sUserF=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію  Проводки ПО по ОБ22 (валові)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => ' Проводки ПО по ОБ22 (валові)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NU_OB22_FUNU&accessCode=6&sPar=[NSIFUNCTION][PAR=>:Dat(SEM=Дата,TYPE=D)][PROC=> pack_nu.P_OB22NU_WEB(:Dat, :Dat)][EXEC=>BEFORE]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Динамічний макет - 3
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Динамічний макет - 3',
															  p_funcname => '/barsroot/dynamicLayout/dynamic_layout.aspx?type=3',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Динамічний макет - 2
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Динамічний макет - 2',
															  p_funcname => '/barsroot/dynamicLayout/dynamic_layout.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ZAY21. Візування введених угод (покупка)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ZAY21. Візування введених угод (покупка)',
															  p_funcname => '/barsroot/zay/currencybuysighting/index',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4. Встановлення %% ставок
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. Встановлення %% ставок',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> bars_ow.set_accounts_rate(0)][QST=>Виконати встановлення %% ставок по БПК Way4?][MSG=>Виконано!]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Додаткові параметри депозиту
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Додаткові параметри депозиту',
															  p_funcname => '/barsroot/udeposit/dptswiftdetails.aspx?mode=\d&dpu_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Редагування штрафів депозитного модуля ФО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редагування штрафів депозитного модуля ФО',
															  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=0&mod_cod="DPT"',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд штрафів депозитного модуля ФО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд штрафів депозитного модуля ФО',
															  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=1&mod_cod="DPT"',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію SWIFT. МВПС платежі на 191992, 3720, 1600, 2906
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'SWIFT. МВПС платежі на 191992, 3720, 1600, 2906',
															  p_funcname => '/barsroot/sep/seplockdocs/index?swt=swt',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Додаткові функції
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Додаткові функції',
															  p_funcname => '/barsroot/DptAdm/DptAdm/DPTAdditional',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ФМ: Корегування рівня ризику клієнтів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ: Корегування рівня ризику клієнтів',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CUST_R&accessCode=1&sPar=[NSIFUNCTION]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Додаткові параметри депозиту
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Додаткові параметри депозиту',
															  p_funcname => '/barsroot/udeposit/dptadditionaloptions.aspx?mode=\d&dpu_id=\d+&rnk=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд штрафів депозитного модуля ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд штрафів депозитного модуля ЮО',
															  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=1&mod_cod="DPU"',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Редагування штрафів депозитного модуля ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редагування штрафів депозитного модуля ЮО',
															  p_funcname => '/barsroot/DptAdm/EditFinesDFO/EditFinesDFO?read_only=0&mod_cod="DPU"',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Звірка балансів (web) ********** ');
          --  Створюємо функцію Way4. Звірка балансів (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Звірка балансів (web)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_W4_BALANCE&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Експорт файлів (web) ********** ');
          --  Створюємо функцію Way4. Експорт файлів (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Експорт файлів (web)',
                                                  p_funcname => '/barsroot/pc/pc/index',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт проектів на відкриття договорів БПК ********** ');
          --  Створюємо функцію Way4. Імпорт проектів на відкриття договорів БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт проектів на відкриття договорів БПК',
                                                  p_funcname => '/barsroot/w4/import_salary_file.aspx',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт та обробка файлів *.xml ********** ');
          --  Створюємо функцію Way4. Імпорт та обробка файлів *.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт та обробка файлів *.xml',
                                                  p_funcname => '/barsroot/way/wayapp/index?type=import',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Протокол обробки файлів від ПЦ (web) ********** ');
          --  Створюємо функцію Way4. Протокол обробки файлів від ПЦ (web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Протокол обробки файлів від ПЦ (web)',
                                                  p_funcname => '/barsroot/way/wayapp/index?type=protokol',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


	 DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Перелік зарезервованих номерів рахунків 2600, 2650 ********** ');
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік зарезервованих номерів рахунків 2600, 2650',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_TRANSFORM_LE_REPORT',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                               );

	 --  Створюємо функцію АРМ
	 DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Табл. прогнозу заміни рахунків фіз. осіб по МФО для сателітних систем ********** ');
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Табл. прогнозу заміни рахунків фіз. осіб по МФО для сателітних систем',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_TRANSFORM_FORECAST[CONDITIONS=>NBS=''2625''][NSIFUNCTION][EXCEL=>DISABLE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                               );

	 --  Створюємо функцію АРМ
	 DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Табл. прогнозу заміни рахунків юр. осіб по МФО для сателітних систем ********** ');
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Табл. прогнозу заміни рахунків юр. осіб по МФО для сателітних систем',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_TRANSFORM_FORECAST_LE[NSIFUNCTION][EXCEL=>DISABLE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                               );

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_OWAY) - АРМ Інтерфейс з OpenWay  ');
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
umu.add_report2arm(107,'$RM_OWAY');
umu.add_report2arm(678,'$RM_OWAY');
umu.add_report2arm(679,'$RM_OWAY');
umu.add_report2arm(764,'$RM_OWAY');
umu.add_report2arm(850,'$RM_OWAY');
umu.add_report2arm(2924,'$RM_OWAY');
umu.add_report2arm(3016,'$RM_OWAY');
umu.add_report2arm(3017,'$RM_OWAY');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_OWAY.sql =========**
PROMPT ===================================================================================== 
