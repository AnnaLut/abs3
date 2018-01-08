PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_KREB.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_KREB ***
  declare
    l_application_code varchar2(10 char) := '$RM_KREB';
    l_application_name varchar2(300 char) := 'АРМ КП бухгалтера';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_KREB створюємо (або оновлюємо) АРМ АРМ КП бухгалтера ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Злиття та закриття рахунків ********** ');
          --  Створюємо функцію Злиття та закриття рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Злиття та закриття рахунків',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>RNK2RNK(:R1,:R2)][PAR=>:R1(SEM=Що_закривається_РНК,TYPE=N,REF=CUSTOMER),:R2(SEM=Діючий_РНК,TYPE=N,REF=CUSTOMER)][MSG=>Виконано!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вирівнювання залишків на 9129 по КП ФО ********** ');
          --  Створюємо функцію Вирівнювання залишків на 9129 по КП ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вирівнювання залишків на 9129 по КП ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.CC_9129(bankdate,0,3)][QST=>Виконати "Вирівнювання залишків на 9129 по КП ФО?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО ********** ');
          --  Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.cc_wdate(3,gl.bd,0)][QST=>Ви хочете винести на прострочку всі активи клієнта?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування відсотків,комісій,пені по КП ЮО ********** ');
          --  Створюємо функцію Нарахування відсотків,комісій,пені по КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування відсотків,комісій,пені по КП ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=INT_GL&sPar=[PROC=>PUL_DAT(to_char(:P,''dd/mm/yyyy''),null)][PAR=>:P(SEM=Дата,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][CONDITIONS=>NBS like ''20%'' AND ID = 0]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель НОВИХ кредитів ФО ********** ');
          --  Створюємо функцію Портфель НОВИХ кредитів ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель НОВИХ кредитів ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_V_0&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_KREB) - АРМ КП бухгалтера  ');
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
umu.add_report2arm(294,'$RM_KREB');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_KREB.sql =========**
PROMPT ===================================================================================== 
