SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_WGRT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  WGRT ***
  declare
    l_application_code varchar2(10 char) := 'WGRT';
    l_application_name varchar2(300 char) := 'АРМ Портфель договорів забезпечення';
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
     DBMS_OUTPUT.PUT_LINE(' WGRT створюємо (або оновлюємо) АРМ АРМ Портфель договорів забезпечення ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель договорів забезпечення ЮО ********** ');
          --  Створюємо функцію Портфель договорів забезпечення ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель договорів забезпечення ЮО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_portfolio&mode=2',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Движимое имущество
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Движимое имущество',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_vehicles&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Ценности
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Ценности',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_valuables&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд графіку подій
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд графіку подій',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dog_events&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Товары
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Товары',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_products&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Депозиты
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Депозиты',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_deposits&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Ипотека - земля
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Ипотека - земля',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage_land&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Ипотека
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Ипотека',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Пустая карта договора
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Пустая карта договора',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dual&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель договорів забезпечення ФО ********** ');
          --  Створюємо функцію Портфель договорів забезпечення ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель договорів забезпечення ФО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_portfolio&mode=3',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Движимое имущество
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Движимое имущество',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_vehicles&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Ценности
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Ценности',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_valuables&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд графіку подій
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд графіку подій',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dog_events&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Товары
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Товары',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_products&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Депозиты
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Депозиты',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_deposits&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Ипотека - земля
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Ипотека - земля',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage_land&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Ипотека
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Ипотека',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Пустая карта договора
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Пустая карта договора',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dual&deal_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Найближчі події ЮО ********** ');
          --  Створюємо функцію Найближчі події ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Найближчі події ЮО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_portfolio_warn&mode=2',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Виконання події за договором - іпотека
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - іпотека',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - цінності
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - цінності',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_valuables_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - товари
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - товари',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_products_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - гарантії
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - гарантії',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dual_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - депозит
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - депозит',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_deposits_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - іпотека(земля)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - іпотека(земля)',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage_land_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - ТЗ
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - ТЗ',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_vehicles_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Найближчі події ФО ********** ');
          --  Створюємо функцію Найближчі події ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Найближчі події ФО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_portfolio_warn&mode=3',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Виконання події за договором - іпотека
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - іпотека',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - цінності
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - цінності',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_valuables_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - товари
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - товари',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_products_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - гарантії
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - гарантії',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dual_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - депозит
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - депозит',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_deposits_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - іпотека(земля)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - іпотека(земля)',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage_land_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виконання події за договором - ТЗ
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виконання події за договором - ТЗ',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_vehicles_ev&deal_id=\d+&ev_id=\d+',
															  p_rolename => '' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (WGRT) - АРМ Портфель договорів забезпечення  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappWGRT.sql =========*** En
PROMPT ===================================================================================== 
