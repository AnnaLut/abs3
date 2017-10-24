SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_W_W4.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  W_W4 ***
  declare
    l_application_code varchar2(10 char) := 'W_W4';
    l_application_name varchar2(300 char) := 'АРМ БПК-Way4';
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
     DBMS_OUTPUT.PUT_LINE(' W_W4 створюємо (або оновлюємо) АРМ АРМ БПК-Way4 ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запити до CardMake ********** ');
          --  Створюємо функцію Way4. Запити до CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запити до CardMake',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.cmrequest',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


      --  Створюємо дочірню функцію Редагування атрибутів рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редагування атрибутів рахунку',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4. accounts
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. accounts',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.ndacc&nd=\d+',
															  p_rolename => 'OW' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Портфель БПК ********** ');
          --  Створюємо функцію Way4. Портфель БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Портфель БПК',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Редагування атрибутів рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редагування атрибутів рахунку',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Реквізити картки киянина
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Реквізити картки киянина',
															  p_funcname => '/barsroot/cardkiev/cardkievparams.aspx?\S*',
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

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Портфель БПК(ЮО) ********** ');
          --  Створюємо функцію Way4. Портфель БПК(ЮО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Портфель БПК(ЮО)',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio_uo',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Друк договорів ********** ');
          --  Створюємо функцію Way4. Друк договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Друк договорів',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.print.proect',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Way4.print.accounts
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4.print.accounts',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.print.accounts&proect_okpo=\S+&proect_name=\S+',
															  p_rolename => 'OW' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів NEW ********** ');
          --  Створюємо функцію Друк звітів NEW
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів NEW',
                                                  p_funcname => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
                                                  p_rolename => 'WR_CBIREP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Друк звітів NEW
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк звітів NEW',
															  p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Друк звітів NEW
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк звітів NEW',
															  p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій(Вільні реквіз.) ********** ');
          --  Створюємо функцію Візування операцій(Вільні реквіз.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій(Вільні реквіз.)',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=7',
                                                  p_rolename => 'WR_CHCKINNR_ALL' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Пакетне відкриття карток ********** ');
          --  Створюємо функцію Way4. Пакетне відкриття карток
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Пакетне відкриття карток',
                                                  p_funcname => '/barsroot/BatchOpeningCardAccounts/BatchOpeningCardAccounts',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );												  


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (W_W4) - АРМ БПК-Way4  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappW_W4.sql =========*** En
PROMPT ===================================================================================== 
