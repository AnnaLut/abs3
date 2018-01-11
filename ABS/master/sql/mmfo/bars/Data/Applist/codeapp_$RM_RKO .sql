PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_RKO .sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_RKO  ***
  declare
    l_application_code varchar2(10 char) := '$RM_RKO ';
    l_application_name varchar2(300 char) := 'АРМ Плата за РО';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_RKO  створюємо (або оновлюємо) АРМ АРМ Плата за РО ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію RKO1.РОЗРАХУНОК сум комісії по ВСІХ рах. ********** ');
          --  Створюємо функцію RKO1.РОЗРАХУНОК сум комісії по ВСІХ рах.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'RKO1.РОЗРАХУНОК сум комісії по ВСІХ рах.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=[PROC=>RKO.ACR( 1, :A, null)][PAR=>:A(SEM=По_дату_включно,TYPE=D)][EXEC=>BEFORE][QST=>Виконати RKO1.РОЗРАХУНОК сум комісії по ВСІХ рах.?][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію RKO2.ГЕНЕРАЦІЯ проводок 3570->6110 по ВСІХ рах. ********** ');
          --  Створюємо функцію RKO2.ГЕНЕРАЦІЯ проводок 3570->6110 по ВСІХ рах.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'RKO2.ГЕНЕРАЦІЯ проводок 3570->6110 по ВСІХ рах.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=[PROC=>RKO.PAY( 1, gl.BD, null)][QST=>Виконати RKO2.ГЕНЕРАЦІЯ проводок 3570->6110 по ВСІХ рах.?][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію RKO3.Договірне СПИСАННЯ комісії 2600->357* по ВСІХ рах. ********** ');
          --  Створюємо функцію RKO3.Договірне СПИСАННЯ комісії 2600->357* по ВСІХ рах.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'RKO3.Договірне СПИСАННЯ комісії 2600->357* по ВСІХ рах.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=[PROC=>RKO.PAY( 2, gl.BD, '' a.acc not in (select acc from RKO_3570 ) '' )][QST=>Виконати RKO3.Договірне СПИСАННЯ комісії 2600->357* по ВСІХ рах.?][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію RKO4.Винесення на ПРОСТРОЧ несплаченої комісії 3579->3570 "06" числа ********** ');
          --  Створюємо функцію RKO4.Винесення на ПРОСТРОЧ несплаченої комісії 3579->3570 "06" числа
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'RKO4.Винесення на ПРОСТРОЧ несплаченої комісії 3579->3570 "06" числа',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=[PROC=>RKO.PAY( 3, gl.BD, null)][QST=>Виконати RKO4.Винесення на ПРОСТРОЧ несплаченої комісії 3579->3570 "06" числа?][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Плата за РО ********** ');
          --  Створюємо функцію Плата за РО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Плата за РО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_RKO_LST_FULL&accessCode=0&sPar=[NSIFUNCTION][CONDITIONS=>acc not in (select acc from rko_3570)][PAR=>:Dat(SEM=Дата нарахування плати за РКО,TYPE=D)][PROC=>PUL.PUT(''WDAT'',to_char(:Dat,''dd.mm.yyyy''))][EXEC=>BEFORE]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Плата за РО (рах. по яких тільки нарах. 3570) ********** ');
          --  Створюємо функцію Плата за РО (рах. по яких тільки нарах. 3570)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Плата за РО (рах. по яких тільки нарах. 3570)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_RKO_LST_FULL2&accessCode=0&sPar=[NSIFUNCTION][CONDITIONS=>acc in (select acc from rko_3570)][PAR=>:Dat(SEM=Дата нарахування плати за РКО,TYPE=D)][PROC=>PUL.PUT(''WDAT'',to_char(:Dat,''dd.mm.yyyy''))][EXEC=>BEFORE]',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Оплата SMS ********** ');
          --  Створюємо функцію Оплата SMS
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Оплата SMS',
                                                  p_funcname => '/barsroot/scs/cash_settlement_services.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_RKO ) - АРМ Плата за РО  ');
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
umu.add_report2arm(63,'$RM_RKO ');
umu.add_report2arm(335,'$RM_RKO ');
umu.add_report2arm(380,'$RM_RKO ');
umu.add_report2arm(412,'$RM_RKO ');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_RKO .sql =========**
PROMPT ===================================================================================== 
