SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_W_CP.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_W_CP ***
  declare
    l_application_code varchar2(10 char) := '$RM_W_CP';
    l_application_name varchar2(300 char) := 'АРМ Цінні папери';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_W_CP створюємо (або оновлюємо) АРМ АРМ Цінні папери ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію МБДК: Введення угод ********** ');
          --  Створюємо функцію МБДК: Введення угод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'МБДК: Введення угод',
                                                  p_funcname => '/barsroot/Mbdk/Deal/Index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій відділення ********** ');
          --  Створюємо функцію Візування операцій відділення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій відділення',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=2',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.CheckInner
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.CheckInner',
															  p_funcname => '/barsroot/checkinner/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Візування операцій відділення
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Візування операцій відділення',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=2&grpid=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Депозитарій ЦП ********** ');
          --  Створюємо функцію Депозитарій ЦП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Депозитарій ЦП',
                                                  p_funcname => '/barsroot/dcp/depositary/acceptpfiles?nPar=3',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );
      /*ця функція вже давно існує, але чомусь тільки вона на проді з OPERLIST.runable is null
        який не модифікуэться  abs_utils.add_func
      */
     update OPERLIST set runable = 1 where  codeoper = l_function_ids(l) and runable is null;
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП. Неотримані купони > 30 днів (WEB)  ********** ');
          --  Створюємо функцію ЦП. Неотримані купони > 30 днів (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП. Неотримані купони > 30 днів (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TMP_CP_PRGN[PROC=>CP_KUP_PROGNOZ(:Param2,:RNK,:REG)][PAR=>:Param2(SEM=Дата по,TYPE=D),:RNK(SEM=РНК кл-та,TYPE=N),:REG(SEM=режим,TYPE=N))][CONDITIONS=>u_id=user_id][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Перегляд графіка купонних періодів ********** ');
          --  Створюємо функцію ЦП: Перегляд графіка купонних періодів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Перегляд графіка купонних періодів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DAT',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП. Фiнiш. Авто-завершення купонного перiоду (WEB)  ********** ');
          --  Створюємо функцію ЦП. Фiнiш. Авто-завершення купонного перiоду (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП. Фiнiш. Авто-завершення купонного перiоду (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DOK_DNK[PROC=>CP.DOK_DNK(bankdate)][EXEC=>BEFORE][QST=>Виконати ?][MSG=>Готово!]',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП. Фiнiш. Авто-завершення купонного перiоду (WEB)  ********** ');
          --  Створюємо функцію ЦП. Фiнiш. Авто-завершення купонного перiоду (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП. Фiнiш. Авто-завершення купонного перiоду (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DOK_DNK[PROC=>CP.DOK_DNK(bankdate)][EXEC=>BEFORE][QST=>Виконати?][MSG=>Готово!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Переформування Форми KALENDAR Y/H/Q/M/D  WEB ********** ');
          --  Створюємо функцію ЦП: Переформування Форми KALENDAR Y/H/Q/M/D  WEB
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Переформування Форми KALENDAR Y/H/Q/M/D  WEB',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_KALENDAR[PROC=>CP_KALENDAR(0,:B,:E,:Z,:F,:P)][PAR=>:B(SEM=дата з <dd.mm.yyyy>,TYPE=D),:E(SEM=дата по <dd.mm.yyyy>,TYPE=D),:Z(SEM=ПереФормувати так/ні =1/0,TYPE=N),:F(SEM=Форма куплено/продано KLB/KLS,TYPE=C),:P(SEM=період=Y/H/Q/M/D,TYPE=C)][EXEC=>BEFORE][QST=>Виконати ЦП: Переформування Форми KALENDAR ?][MSG=>Виконано !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Перегляд Форми KALENDAR (придбання) Фільтр Y/H/Q/M/D  WEB ********** ');
          --  Створюємо функцію ЦП: Перегляд Форми KALENDAR (придбання) Фільтр Y/H/Q/M/D  WEB
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Перегляд Форми KALENDAR (придбання) Фільтр Y/H/Q/M/D  WEB',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_KALENDAR_BUY][CONDITIONS=> frm=''KLB'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Перегляд Форми KALENDAR (продаж/погашення) Фільтр Y/H/Q/M/D  WEB ********** ');
          --  Створюємо функцію ЦП: Перегляд Форми KALENDAR (продаж/погашення) Фільтр Y/H/Q/M/D  WEB
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Перегляд Форми KALENDAR (продаж/погашення) Фільтр Y/H/Q/M/D  WEB',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_KALENDAR_SALE][CONDITIONS=> frm=''KLS'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз ціни портфеля ********** ');
          --  Створюємо функцію Аналіз ціни портфеля
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз ціни портфеля',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_PRICES',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: (OLD)Формування Форми DGP_F007 за період (Y/H/Q/D) ********** ');
      delete from list_funcset where  func_id  in (select codeoper from operlist a where  a.name = 'ЦП: (OLD)Формування Форми DGP_F007 за період (Y/H/Q/D)');
      delete from operlist a where  a.name = 'ЦП: (OLD)Формування Форми DGP_F007 за період (Y/H/Q/D)';
/*          --  Створюємо функцію ЦП: Формування Форми DGP_F007 за період (Y/H/Q/D)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: (OLD)Формування Форми DGP_F007 за період (Y/H/Q/D)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV7K[PROC=>CP_ZV_D(0,:B,:E,:Z,''7'',:P)][PAR=>:B(SEM=дата з <dd.mm.yyyy>,TYPE=D),:E(SEM=дата по <dd.mm.yyyy>,TYPE=D),:Z(SEM=ПереФормувати так/ні =1/0,TYPE=N),:P(SEM=період=Y/H/Q/D,TYPE=C)][EXEC=>BEFORE][QST=>Відкрити діалог для Форми DGP_F007 ?][MSG=>Виконано !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Формування Форми DGP_007 за період ********** ');
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Формування Форми DGP_F007 за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DGP007[PROC=>cp_rep_dgp.prepare_dgp(:B,:E, 7)][PAR=>:B(SEM=дата з <dd.mm.yyyy>,TYPE=D),:E(SEM=дата по <dd.mm.yyyy>,TYPE=D)][EXEC=>BEFORE][QST=>Відкрити діалог для Форми DGP_F007 ("Ні" - показати данні з попереднього формуваня)?][MSG=>Виконано !][showDialogWindow=>false][CONDITIONS=>user_id = user_id()]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );


--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: (OLD)Формування Форми DGP_F008 за період (Y/H/Q/D) ********** ');
      delete from operlist a where  a.name = 'ЦП: (OLD)Формування Форми DGP_F008 за період (Y/H/Q/D)';
/*
          --  Створюємо функцію ЦП: Формування Форми DGP_F008 за період (Y/H/Q/D)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: (OLD)Формування Форми DGP_F008 за період (Y/H/Q/D)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV8K[PROC=>CP_ZV_D(0,:B,:E,:Z,''8'',:P)][PAR=>:B(SEM=дата з <dd.mm.yyyy>,TYPE=D),:E(SEM=дата по <dd.mm.yyyy>,TYPE=D),:Z(SEM=ПереФормувати так/ні =1/0,TYPE=N),:P(SEM=період=Y/H/Q/D,TYPE=C)][EXEC=>BEFORE][QST=>Відкрити діалог для Форми DGP_F008 ?][MSG=>Виконано !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Формування Форми DGP_008 за період ********** ');
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Формування Форми DGP_F008 за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DGP008[PROC=>cp_rep_dgp.prepare_dgp(:B,:E, 8)][PAR=>:B(SEM=дата з <dd.mm.yyyy>,TYPE=D),:E(SEM=дата по <dd.mm.yyyy>,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][QST=>Відкрити діалог для Форми DGP_F008 ("Ні" - показати данні з попереднього формуваня)?][MSG=>Виконано !][showDialogWindow=>false][CONDITIONS=>user_id = user_id()]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Формування Форми DGP_F009 за період (Y/H/Q/D) ********** ');
          --  Створюємо функцію ЦП: Формування Форми DGP_F009 за період (Y/H/Q/D)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Формування Форми DGP_F009 за період (Y/H/Q/D)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV9K[PROC=>CP_ZV_D(0,:B,:E,:Z,''9'',:P)][PAR=>:B(SEM=дата з <dd.mm.yyyy>,TYPE=D),:E(SEM=дата по <dd.mm.yyyy>,TYPE=D),:Z(SEM=ПереФормувати так/ні =1/0,TYPE=N),:P(SEM=період=Y/H/Q/D,TYPE=C)][EXEC=>BEFORE][QST=>Відкрити діалог для Форми DGP_F009 ?][MSG=>Виконано !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Перегляд форми DGP_F007 (Q-квартальна) ********** ');
      delete from operlist a where  a.name = 'ЦП: Перегляд форми DGP_F007 (Q-квартальна)';
/*          --  Створюємо функцію ЦП: Перегляд форми DGP_F007 (Q-квартальна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Перегляд форми DGP_F007 (Q-квартальна)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV[CONDITIONS=>period=''Q'' and frm=''7'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/

--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Перегляд форми DGP_F008 (Q-квартальна) ********** ');
      delete from operlist a where  a.name = 'ЦП: Перегляд форми DGP_F008 (Q-квартальна)';
/*          --  Створюємо функцію ЦП: Перегляд форми DGP_F008 (Q-квартальна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Перегляд форми DGP_F008 (Q-квартальна)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV[CONDITIONS=>period=''Q'' and frm=''8'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/

--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Перегляд форми DGP_F008 (Y-річна) ********** ');
      delete from operlist a where  a.name = 'ЦП: Перегляд форми DGP_F008 (Y-річна)';
/*          --  Створюємо функцію ЦП: Перегляд форми DGP_F008 (Y-річна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Перегляд форми DGP_F008 (Y-річна)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV[CONDITIONS=>period=''Y'' and frm=''8'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП. Модифікація грошових потоків по ЦП (WEB)  ********** ');
          --  Створюємо функцію ЦП. Модифікація грошових потоків по ЦП (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП. Модифікація грошових потоків по ЦП (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CP.RMANY_ALL(bankdate)][QST=>Виконати ?][MSG=>Готово!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП. Автозакриття несистемних рахунків та договору (WEB)  ********** ');
          --  Створюємо функцію ЦП. Автозакриття несистемних рахунків та договору (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП. Автозакриття несистемних рахунків та договору (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CP_CLOSE(1,bankdate)][QST=>Виконати ?][MSG=>Готово!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Дозаповнення спец.параметрів по рахунках з портфеля ЦП ********** ');
          --  Створюємо функцію ЦП: Дозаповнення спец.параметрів по рахунках з портфеля ЦП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Дозаповнення спец.параметрів по рахунках з портфеля ЦП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CP_SPEC(bankdate,5)][QST=>Виконати ?][MSG=>Готово!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Спец.параметри рахунків по ЦП (ручне встановлення) ********** ');
          --  Створюємо функцію ЦП: Спец.параметри рахунків по ЦП (ручне встановлення)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Спец.параметри рахунків по ЦП (ручне встановлення)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=SPECPARAM_CP_V',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Форма для погашення простроченої заборгованості ********** ');
          --  Створюємо функцію ЦП: Форма для погашення простроченої заборгованості
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Форма для погашення простроченої заборгованості',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_CPDEAL_EXPPAY',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Перегляд/Редагування дод-х реквізитів угод (V_CP_REFW) ********** ');
          --  Створюємо функцію ЦП: Перегляд/Редагування дод-х реквізитів угод (V_CP_REFW)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Перегляд/Редагування дод-х реквізитів угод (V_CP_REFW)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_CP_REFW',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Показники рівней ієрархії за період ********** ');
          --  Створюємо функцію ЦП: Показники рівней ієрархії за період
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Показники рівней ієрархії за період',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=CP_HIERARCHY_IDS&sPar=[PROC=>p_cp_levels_ids(:dat1,:dat2)][PAR=>:dat1(SEM=з >,TYPE=D),:dat2(SEM=по>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Показники рівней ієрархії за період (Референси проводок) ********** ');
          --  Створюємо функцію ЦП: Показники рівней ієрархії за період (Референси проводок)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Показники рівней ієрархії за період (Референси проводок)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=CP_HIERARCHY_IDSREFS',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Консолідований звіт за ієрархіями ********** ');
          --  Створюємо функцію ЦП: Консолідований звіт за ієрархіями
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Консолідований звіт за ієрархіями',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=CP_HIERARCHY_LEVELS&sPar=[PROC=>p_cp_levels(:dat1,:dat2)][PAR=>:dat1(SEM=з >,TYPE=D),:dat2(SEM=по>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Переформування Форм DGP_F... (V_CP_ZV) Y/H/Q/M/D ********** ');
      delete from list_funcset where  func_id  in (select codeoper from operlist a where  a.name = 'ЦП: Переформування Форм DGP_F... (V_CP_ZV) Y/H/Q/M/D');
      delete from operlist a where  a.name = 'ЦП: Переформування Форм DGP_F... (V_CP_ZV) Y/H/Q/M/D';
/*          --  Створюємо функцію ЦП: Переформування Форм DGP_F... (V_CP_ZV) Y/H/Q/M/D
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Переформування Форм DGP_F... (V_CP_ZV) Y/H/Q/M/D',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=5&sPar=V_CP_ZV[PROC=>CP_ZV_D(0,:B,:E,:Z,:F,:P)][PAR=>:B(SEM=дата з <dd.mm.yyyy>,TYPE=D),:E(SEM=дата по <dd.mm.yyyy>,TYPE=D),:Z(SEM=ПереФормувати так/ні =1/0,TYPE=N),:F(SEM=Форма=7/8/9,TYPE=C),:P(SEM=період=Y/H/Q/M/D,TYPE=C)][EXEC=>BEFORE][QST=>Виконати ЦП: Переформування Форм DGP_F... ?][MSG=>Виконано !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Форма для розр-ку переоцінки (CP_PEREOC_V) ********** ');
          --  Створюємо функцію ЦП: Форма для розр-ку переоцінки (CP_PEREOC_V)
      --дропнути стару версію (бо зміна p_funcname)
      delete from operlist a where  a.funcname = '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CP_PEREOC_V&accessCode=2&sPar=[PROC=>CP_PEREOC_P(0,:VOB)][PAR=>:VOB(SEM=Корректирующими VOB=96,TYPE=N)][DESCR=>Переоцінка][EXEC=>ONCE][QST=>Виконати Переоцiнку ?][MSG=>Виконано!]';
      --кінець делітушмеліту

      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Форма для розр-ку переоцінки (CP_PEREOC_V)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CP_PEREOC_V&accessCode=2&sPar=[PROC=>CP_PEREOC_P(0,:VOB)][PAR=>:VOB(SEM=Корректирующими VOB=96,TYPE=N)][DESCR=>Переоцінка][EXEC=>ONCE][QST=>Виконати Переоцiнку ?][MSG=>Виконано!][SAVE_COLUMNS=>BY_DEFAULT]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП (14*), що знаходяться в заставi ********** ');
          --  Створюємо функцію ЦП (14*), що знаходяться в заставi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП (14*), що знаходяться в заставi',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CP_V_ZAL_WEB&accessCode=2&sPar=[NSIFUNCTION][PROC=>PUL.PUT(''DAT_ZAL'',to_char(:Par0,''dd.mm.yyyy''))][PAR=>:Par0(SEM=Дата на <dd.mm.yyyy>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прогноз доходу за місяць по борговим ЦП ********** ');
          --  Створюємо функцію Прогноз доходу за місяць по борговим ЦП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прогноз доходу за місяць по борговим ЦП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TMP_CP_REP_DOX&accessCode=1&sPar=[PROC=>CP_revenue_forecast(0,:B)][PAR=>:B(SEM=Прогноз-дата>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП - Архів угод ВАЛ ********** ');
      delete from operlist a where  a.name = 'ЦП - Архів угод ВАЛ';
/*          --  Створюємо функцію ЦП - Архів угод ВАЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП - Архів угод ВАЛ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_ARCH_META&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=> kv != 980]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/

--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП - Архів угод ГРН ********** ');
      delete from operlist a where  a.name = 'ЦП - Архів угод ГРН';
/*          --  Створюємо функцію ЦП - Архів угод ГРН
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП - Архів угод ГРН',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_ARCH_META&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=> kv = 980]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );

*/
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Додатковi реквiзити до портфелю ЦП ********** ');
          --  Створюємо функцію Додатковi реквiзити до портфелю ЦП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Додатковi реквiзити до портфелю ЦП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_EMI&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд/формування V_CP_UA (ЦП UA форма 25) ********** ');
          --  Створюємо функцію Перегляд/формування V_CP_UA (ЦП UA форма 25)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд/формування V_CP_UA (ЦП UA форма 25)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_UA&accessCode=1&sPar=[PROC=>CP_F25(:Param1,:Param2,:ISIN)][PAR=>:Param1(SEM=Дата ''з'',TYPE=D),:Param2(SEM=Дата ''по'',TYPE=D),:ISIN(SEM=Режим/Код ЦП,TYPE=C))][EXEC=>BEFORE][MSG=>OK!][CONDITIONS=>frm=25]',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП Портфель Загальний ********** ');
          --  Створюємо функцію ЦП Портфель Загальний
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП Портфель Загальний',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=1&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП Портфель Власної емісії ********** ');
      delete from operlist a where  a.name = 'ЦП Портфель Власної емісії';
/*          --  Створюємо функцію ЦП Портфель Власної емісії
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП Портфель Власної емісії',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=5&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/

--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП Портфель. Інші емітенти ********** ');
      delete from operlist a where  a.name = 'ЦП Портфель. Інші емітенти';
/*          --  Створюємо функцію ЦП Портфель. Інші емітенти
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП Портфель. Інші емітенти',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=6&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/

--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП Портфель ГРН ********** ');
      delete from operlist a where  a.name = 'ЦП Портфель ГРН';
/*          --  Створюємо функцію ЦП Портфель ГРН
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП Портфель ГРН',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=7&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/


--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП Портфель ВАЛ ********** ');
          --  Створюємо функцію ЦП Портфель ВАЛ
      delete from operlist a where  a.name = 'ЦП Портфель ВАЛ';
/*
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП Портфель ВАЛ',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=8&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/

--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо ТИМЧАСОВО функцію ЦП Нарахування дивидентів по угоді ********** ');
    --
    delete from operlist a where  a.name = 'ЦП Нарахування дивидентів по угоді (тимчасово)';
          --  Створюємо функцію ЦП 
/*
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП Нарахування дивидентів по угоді (тимчасово)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_CP_INT_DIVIDENTS[NSIFUNCTION][PROC=>value_paper.make_int_dividends_prepare(:A)][PAR=>:A(SEM=REF угоди,TYPE=N)][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/
--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо ТИМЧАСОВО функцію ЦП Переміщення по угодам (МСФЗ9) ********** ');

    delete from operlist a where  a.name = 'ЦП Переміщення угод МСФЗ9 (тимчасово)';
          --  Створюємо функцію ЦП 

/*      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП Переміщення угод МСФЗ9 (тимчасово)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_MOVE_MSFZ9[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/



   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_W_CP) - АРМ Цінні папери  ');
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
umu.add_report2arm(365,'$RM_W_CP');
umu.add_report2arm(1005,'$RM_W_CP');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_W_CP.sql =========**
PROMPT ===================================================================================== 
