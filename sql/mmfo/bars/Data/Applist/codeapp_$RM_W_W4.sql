SET SERVEROUTPUT ON 

SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_W_W4.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_W_W4 ***
  declare
    l_application_code varchar2(10 char) := '$RM_W_W4';
    l_application_name varchar2(300 char) := 'АРМ "БПК – Way4"';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_W_W4 створюємо (або оновлюємо) АРМ АРМ "БПК – Way4" ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт проектів на відкриття карток киянина ********** ');
          --  Створюємо функцію Імпорт проектів на відкриття карток киянина
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт проектів на відкриття карток киянина',
                                                  p_funcname => '/barsroot/BpkW4/ImportKievCard/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Портфель БПК (ФО)********** ');
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
--      l := l +1;
--      l_function_ids.extend(l);      
--      l_function_ids(l)   :=   abs_utils.add_func(
--                                                  p_name     => 'Way4. Портфель БПК(ЮО)',
--                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio_uo',
--                                                  p_rolename => 'OW' ,    
--                                                  p_frontend => l_application_type_id
--                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Друк договорів ********** ');
          --  Створюємо функцію Way4. Друк договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Друк договорів',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.print.proect',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Претенденти на зміну бранчу для 2625/22 ********** ');
          --  Створюємо функцію Претенденти на зміну бранчу для 2625/22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Претенденти на зміну бранчу для 2625/22',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_crv2_change_branch',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Підтвердження активації зарезервованих рахунків (ЮО) ********** ');
          --  Створюємо функцію Way4. Підтвердження активації зарезервованих рахунків (ЮО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Підтвердження активації зарезервованих рахунків (ЮО)',
                                                  p_funcname => '/barsroot/bpkw4/ActivationReservedAccounts/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Приєднання клієнта до ДКБО ********** ');
          --  Створюємо функцію Приєднання клієнта до ДКБО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Приєднання клієнта до ДКБО',
                                                  p_funcname => '/barsroot/bpkw4/checkdkbo/index',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запит на миттєві картки ЮО ********** ');
          --  Створюємо функцію Way4. Запит на миттєві картки ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запит на миттєві картки ЮО',
                                                  p_funcname => '/barsroot/bpkw4/instantcard/index',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд рахунків відділення ********** ');
          --  Створюємо функцію Перегляд рахунків відділення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд рахунків відділення',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=2',
                                                  p_rolename => 'WR_TOBO_ACCOUNTS_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Історія змін параметрів рахунків/контрагентів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Історія змін параметрів рахунків/контрагентів',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Обороти по рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Обороти по рахунку',
															  p_funcname => '/barsroot/customerlist/turn4day.aspx',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Історія рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Історія рахунку',
															  p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Підсумки по валютам
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Підсумки по валютам',
															  p_funcname => '/barsroot/customerlist/total_currency.aspx',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Історія змін параметрів рахунку\контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Історія змін параметрів рахунку\контрагента',
															  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+&type=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд атрибутів рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд атрибутів рахунку',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків  ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд рахунків контрагенту
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків контрагенту',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію A. Друк договорів ********** ');
          --  Створюємо функцію A. Друк договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A. Друк договорів',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=print',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Заповнення коду страхової компанії ********** ');
          --  Створюємо функцію Way4. Заповнення коду страхової компанії
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Заповнення коду страхової компанії',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>SET_BPK_STR(0)][QST=>Заповнити код страхової компані?][MSG=>Виконано.]',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 4.1:Інше списание (tt=PKD) ********** ');
          --  Створюємо функцію Iмпорт 4.1:Інше списание (tt=PKD)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 4.1:Інше списание (tt=PKD)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik&config=imp_4_1',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт проектів електронний студентський квиток ********** ');
          --  Створюємо функцію Way4. Імпорт проектів електронний студентський квиток
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт проектів електронний студентський квиток',
                                                  p_funcname => '/barsroot/w4/import_esk_file.aspx',
                                                  p_rolename => 'OW' ,
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

	DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Заява на видалення тікету ********** ');
          --  Створюємо функцію Way4. Заява на видалення тікету
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Заява на видалення тікету',
                                                  p_funcname => '/barsroot/bpkw4/AutoOfficialNote/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Портфель БПК(ЮО) ********** ');
          --  Створюємо функцію Way4. Портфель БПК(ЮО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Портфель БПК(ЮО)',
                                                  p_funcname => '/barsroot/way4bpk/way4bpk?custtype=2',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );
          --  Створюємо функцію Way4. Пакетне відкриття карток
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Пакетне відкриття карток',
                                                  p_funcname => '/barsroot/BatchOpeningCardAccounts/BatchOpeningCardAccounts',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );												  


      --  Створюємо дочірню функцію Way4.newdeal_uo
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4.newdeal_uo',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.newdeal_uo&rnk=\d+&proect_id=(\d+|-\d+)&card_code=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4.product_uo
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4.product_uo',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.product_uo&formname=\S+&proect_id=(\d+|-\d+)&grp_code=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4. rnk_uo
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. rnk_uo',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.rnk_uo&proect_id=(\d+|-\d+)&card_code=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4. customer_uo
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. customer_uo',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.customer_uo&proect_id=(\d+|-\d+)&card_code=\S+&rnk=\d*&okpo=\S*&nmk=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);
				
      --  Створюємо дочірню функцію Портфель договорів Інстолмент
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Портфель договорів Інстолмент',
															  p_funcname => '/barsroot/Way/Installment/Index',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_W_W4) - АРМ "БПК – Way4"  ');
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
umu.add_report2arm(11,'$RM_W_W4');
umu.add_report2arm(110,'$RM_W_W4');
umu.add_report2arm(263,'$RM_W_W4');
umu.add_report2arm(607,'$RM_W_W4');
umu.add_report2arm(678,'$RM_W_W4');
umu.add_report2arm(679,'$RM_W_W4');
umu.add_report2arm(685,'$RM_W_W4');
umu.add_report2arm(708,'$RM_W_W4');
umu.add_report2arm(778,'$RM_W_W4');
umu.add_report2arm(3022,'$RM_W_W4');
umu.add_report2arm(3041,'$RM_W_W4');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_W_W4.sql =========**
PROMPT ===================================================================================== 
