SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_CDNT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  CDNT ***
  declare
    l_application_code varchar2(10 char) := 'CDNT';
    l_application_name varchar2(300 char) := 'Нотаріуси';
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
     DBMS_OUTPUT.PUT_LINE(' CDNT створюємо (або оновлюємо) АРМ Нотаріуси ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідник нотаріусів ********** ');
          --  Створюємо функцію Довідник нотаріусів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідник нотаріусів',
                                                  p_funcname => '/barsroot/cdnt/notary/?mode=RU',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Довідник нотаріусів (головна довідника)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник нотаріусів (головна довідника)',
															  p_funcname => '/barsroot/cdnt/notary/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (оборты нотаріуса)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник нотаріусів (оборты нотаріуса)',
															  p_funcname => '/barsroot/cdnt/notary/transactiondata\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (состояния акредитаций)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник нотаріусів (состояния акредитаций)',
															  p_funcname => '/barsroot/cdnt/notary/accreditationstates\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (головна довідника)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник нотаріусів (головна довідника)',
															  p_funcname => '/barsroot/cdnt/notary\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (бизнесы)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник нотаріусів (бизнесы)',
															  p_funcname => '/barsroot/cdnt/notary/getlistofbusiness\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (акредитации нотаріуса)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник нотаріусів (акредитации нотаріуса)',
															  p_funcname => '/barsroot/cdnt/notary/accreditationdata\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (джерело даних довідника)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник нотаріусів (джерело даних довідника)',
															  p_funcname => '/barsroot/cdnt/notary/indexdata\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (типы акредитаций)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник нотаріусів (типы акредитаций)',
															  p_funcname => '/barsroot/cdnt/notary/accreditationtypes\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (бранчи)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник нотаріусів (бранчи)',
															  p_funcname => '/barsroot/cdnt/notary/getbranches\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (CDNT) - Нотаріуси  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappCDNT.sql =========*** En
PROMPT ===================================================================================== 
