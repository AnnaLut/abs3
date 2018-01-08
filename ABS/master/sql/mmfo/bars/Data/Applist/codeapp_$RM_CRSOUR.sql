PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_CRSOUR.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_CRSOUR ***
  declare
    l_application_code varchar2(10 char) := '$RM_CRSOUR';
    l_application_name varchar2(300 char) := 'АРМ Кредитні ресурси';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_CRSOUR створюємо (або оновлюємо) АРМ АРМ Кредитні ресурси ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування "своїх" операцій ********** ');
          --  Створюємо функцію Візування "своїх" операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування "своїх" операцій',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Візування "своїх" операцій
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Візування "своїх" операцій',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=0&grpid=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.CheckInner
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.CheckInner',
															  p_funcname => '/barsroot/checkinner/service.asmx',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення угоди ********** ');
          --  Створюємо функцію Введення угоди
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення угоди',
                                                  p_funcname => '/barsroot/crsour/dealmonitor/CreditAgreement/?isReadOnly=0',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків (Банки)  ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків (Банки) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків (Банки) ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=1',
                                                  p_rolename => 'WR_CUSTLIST' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення документів ********** ');
          --  Створюємо функцію Введення документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення документів',
                                                  p_funcname => '/barsroot/docinput/ttsinput.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Вікно вводу документів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Вікно вводу документів',
															  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування %% по портфелю Кредитних ресурсів ********** ');
          --  Створюємо функцію Нарахування %% по портфелю Кредитних ресурсів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування %% по портфелю Кредитних ресурсів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_CRSOUR_INT_RECKONING&sPar=[PROC=>cdb_mediator.prepare_portfolio_interest(:product,:partner,:currency,:deal_expiry_date,:deal_rest,:date_to)][PAR=>:product(SEM=Вид угоди,TYPE=C,REF=V_CRSOUR_PRODUCT),:partner(SEM=Партнер,TYPE=C,REF=V_CRSOUR_PARTNER),:currency(SEM=Код_Вал,TYPE=C),:deal_expiry_date(SEM=Дата завершення угоди,TYPE=D),:deal_rest(SEM=Залишок рахунку),:date_to(SEM=Дата по,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виплата %% по депозитах(Кредитні ресурси) ********** ');
          --  Створюємо функцію Виплата %% по депозитах(Кредитні ресурси)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виплата %% по депозитах(Кредитні ресурси)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_PAY_INTEREST_CRSOUR&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Архів угод ********** ');
          --  Створюємо функцію Архів угод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Архів угод',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CRSOUR_ARCHIVE&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель угод кредитних ресурсів ********** ');
          --  Створюємо функцію Портфель угод кредитних ресурсів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель угод кредитних ресурсів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CRSOUR_PORTFOLIO&accessCode=1&sPar=[NSIFUNCTION]',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_CRSOUR) - АРМ Кредитні ресурси  ');
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
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_CRSOUR.sql =========
PROMPT ===================================================================================== 
