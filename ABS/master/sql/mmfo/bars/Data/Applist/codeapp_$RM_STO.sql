PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_STO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_STO ***
  declare
    l_application_code varchar2(10 char) := '$RM_STO';
    l_application_name varchar2(300 char) := 'STO АРМ Регулярні платежі (бек-офіс)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_STO створюємо (або оновлюємо) АРМ STO АРМ Регулярні платежі (бек-офіс) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Регулярні платежі (підтвердження) ********** ');
          --  Створюємо функцію Регулярні платежі (підтвердження)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Регулярні платежі (підтвердження)',
                                                  p_funcname => '/barsroot/sto/contract/index?mode=admin',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Довідник груп
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник груп',
															  p_funcname => '/barsroot/sto/contract/getgrouplist\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Договора
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Договора',
															  p_funcname => '/barsroot/sto/contract/getcontractlist',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Запити
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Запити',
															  p_funcname => '/barsroot/sto/contract/getclaim\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Деталі договору
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Деталі договору',
															  p_funcname => '/barsroot/sto/contract/getdetlistrowinfo',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник запитів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник запитів',
															  p_funcname => '/barsroot/sto/contract/getdisclaimerlist\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Договора, інфо по договору
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Договора, інфо по договору',
															  p_funcname => '/barsroot/sto/contract/getcontractdetlist',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Договора на регулярні платежі (операціоніст) ********** ');
          --  Створюємо функцію Договора на регулярні платежі (операціоніст)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Договора на регулярні платежі (операціоніст)',
                                                  p_funcname => '/barsroot/sto/contract/index?mode=user',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Довідник груп
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник груп',
															  p_funcname => '/barsroot/sto/contract/getgrouplist\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Договора
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Договора',
															  p_funcname => '/barsroot/sto/contract/getcontractlist',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Запити
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Запити',
															  p_funcname => '/barsroot/sto/contract/getclaim\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Деталі договору
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Деталі договору',
															  p_funcname => '/barsroot/sto/contract/getdetlistrowinfo',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник запитів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник запитів',
															  p_funcname => '/barsroot/sto/contract/getdisclaimerlist\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Договора, інфо по договору
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Договора, інфо по договору',
															  p_funcname => '/barsroot/sto/contract/getcontractdetlist',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_STO) - STO АРМ Регулярні платежі (бек-офіс)  ');
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
umu.add_report2arm(14000,'$RM_STO');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_STO.sql =========***
PROMPT ===================================================================================== 
