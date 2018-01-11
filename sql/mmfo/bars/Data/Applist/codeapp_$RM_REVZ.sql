PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_REVZ.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_REVZ ***
  declare
    l_application_code varchar2(10 char) := '$RM_REVZ';
    l_application_name varchar2(300 char) := 'АРМ Управління ревізій та контролю';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_REVZ створюємо (або оновлюємо) АРМ АРМ Управління ревізій та контролю ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Види депозитів ФО ********** ');
          --  Створюємо функцію  Види депозитів ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Види депозитів ФО',
                                                  p_funcname => '/barsroot/DptAdm/DptAdm/DPTViddGrid',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Баланс-Рахунок-Документ ********** ');
          --  Створюємо функцію Баланс-Рахунок-Документ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Баланс-Рахунок-Документ',
                                                  p_funcname => '/barsroot/balansaccdoc/balans.aspx?par=9',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Баланс-Рахунок-Документ (рахунок)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Баланс-Рахунок-Документ (рахунок)',
															  p_funcname => '/barsroot/balansaccdoc/balansacc.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виписка по рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виписка по рахунку',
															  p_funcname => '/barsroot/customerlist/accextract.aspx?type=\d+&acc=\d+&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Баланс-Рахунок-Документ (виконавець)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Баланс-Рахунок-Документ (виконавець)',
															  p_funcname => '/barsroot/balansaccdoc/balansisp.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
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

      --  Створюємо дочірню функцію Баланс-Рахунок-Документ (валюта)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Баланс-Рахунок-Документ (валюта)',
															  p_funcname => '/barsroot/balansaccdoc/balansval.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок фінстану ЮО ********** ');
          --  Створюємо функцію Розрахунок фінстану ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок фінстану ЮО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Карточка форми
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*frm=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан розрахунок постанова 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Фінстан розрахунок постанова 351',
															  p_funcname => '/barsroot/credit/fin_nbu/credit_defolt_kons.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан ЮО print
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Фінстан ЮО print',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_list_conclusions.aspx?rnk=\S*nd=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка клієнта фінстан ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка клієнта фінстан ЮО',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан друк постанова 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Фінстан друк постанова 351',
															  p_funcname => '/barsroot/credit/fin_nbu/print_fin.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан розрахунок постанова 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Фінстан розрахунок постанова 351',
															  p_funcname => '/barsroot/credit/fin_nbu/credit_defolt.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_obu.aspx?okpo=\S*frm=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми2
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми2',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_p\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Контроль форми
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Контроль форми',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_k\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан розрахунок постанова 351 History
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Фінстан розрахунок постанова 351 History',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_list_dat.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан ЮО застава
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Фінстан ЮО застава',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_obu_pawn\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form.aspx?okpo=\S*frm=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан визначення КВЕД
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Фінстан визначення КВЕД',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_kved.aspx?okpo=\S*rnk=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка контролера фінстан ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка контролера фінстан ЮО',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kontr\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.Розбіжності. Інвентаризація та 9819 ********** ');
          --  Створюємо функцію 2.Розбіжності. Інвентаризація та 9819
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.Розбіжності. Інвентаризація та 9819',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_kp_inventar_4',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд КП ФО ********** ');
          --  Створюємо функцію Перегляд КП ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд КП ФО',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2812&mode=ro&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перегляд рахунків за кредитним договором
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків за кредитним договором',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=3&nd=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд договорів (Менеджер)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд договорів (Менеджер)',
															  p_funcname => '/barsroot/ins/deals.aspx?fid=mgrf&type=mgr&nd=\d+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд КП ЮО ********** ');
          --  Створюємо функцію Перегляд КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд КП ЮО',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2813&mode=RO&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перегляд рахунків за кредитним договором
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків за кредитним договором',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=3&nd=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд договорів (Менеджер)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд договорів (Менеджер)',
															  p_funcname => '/barsroot/ins/deals.aspx?fid=mgru&type=mgr&nd=\d+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Події по КП ********** ');
          --  Створюємо функцію Події по КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Події по КП',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=4692&mode=RW&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдображення на 9819* результатiв iнвентаризацiї ********** ');
          --  Створюємо функцію Вiдображення на 9819* результатiв iнвентаризацiї
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдображення на 9819* результатiв iнвентаризацiї',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>ICCK(3)][QST=>Виконати Вiдображення на 9819* результатiв iнвентаризацiї?][MSG=>Виконано!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд проводок ********** ');
          --  Створюємо функцію Перегляд проводок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд проводок',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=PAR_PROVODKI[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію «Овердрафт Холдингу». Портфель Робочих Дог. ********** ');
          --  Створюємо функцію «Овердрафт Холдингу». Портфель Робочих Дог.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '«Овердрафт Холдингу». Портфель Робочих Дог.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V1_OVRN[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Контроль помилкових помилкових ОБ22 ********** ');
          --  Створюємо функцію Контроль помилкових помилкових ОБ22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Контроль помилкових помилкових ОБ22',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_OB22_CONTROL[NSIFUNCTION]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель угод на ел. послуги (перегдял) ********** ');
          --  Створюємо функцію Портфель угод на ел. послуги (перегдял)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель угод на ел. послуги (перегдял)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=E_DEAL_META&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнвентаризацiя КП ФО(щомiсячна) ********** ');
          --  Створюємо функцію Iнвентаризацiя КП ФО(щомiсячна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнвентаризацiя КП ФО(щомiсячна)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=INV_FL&accessCode=1&sPar=[PROC=>P_INV_CCK_FL(:Param0,:Param1,1)][PAR=>:Param0(SEM=Дата,TYPE=D,REF=REZ_PROTOCOL),:Param1(SEM=Переформувати_Так_1 Нi_0,TYPE=N)][EXEC=>BEFORE][MSG=>Ок][CONDITIONS=>INV_FL.G00=TO_DATE(pul.get_mas_ini_val(''sFdat1''),''dd.mm.yyyy'')]',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3) Портфель РОБОЧИХ кредитів ЮО ********** ');
          --  Створюємо функцію 3) Портфель РОБОЧИХ кредитів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3) Портфель РОБОЧИХ кредитів ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_RU&accessCode=1&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Архів депозитів ЮО ********** ');
          --  Створюємо функцію DPU. Архів депозитів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Архів депозитів ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPU_ARCHIVE&accessCode=1&sPar=[PAR=>:A(SEM=Дата,TYPE=D),:B(SEM=Вид депозиту,TYPE=N,REF=DPU_VIDD),:C(SEM=Код підрозділу,TYPE=С,REF=OUR_BRANCH)][PROC=>DPU_RPT_UTIL.SET_ARCHV_CD(:A,:B,:C)][EXEC=>BEFORE][CONDITIONS=> VIDD_ID = nvl(DPU_RPT_UTIL.GET_VIDD_CD, VIDD_ID ) and BRANCH = nvl(DPU_RPT_UTIL.GET_BRANCH_CD, BRANCH)]',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звітність (до НБУ та внутрішня) ********** ');
          --  Створюємо функцію Звітність (до НБУ та внутрішня)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звітність (до НБУ та внутрішня)',
                                                  p_funcname => '/barsroot/reporting/nbu/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Журнал подій АБС ********** ');
          --  Створюємо функцію Журнал подій АБС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Журнал подій АБС',
                                                  p_funcname => '/barsroot/security/audit',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Депозитний портфель ЮО ********** ');
          --  Створюємо функцію Депозитний портфель ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Депозитний портфель ЮО',
                                                  p_funcname => '/barsroot/udeposit/default.aspx?mode=0&flt=null&v1.0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Стан депозитного договору ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Стан депозитного договору ЮО',
															  p_funcname => '/barsroot/udeposit/dptdealstate.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Виписка по рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виписка по рахунку',
															  p_funcname => '/barsroot/customerlist/accextract.aspx?type=\d+&acc=\d+&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Додаткові параметри депозиту
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Додаткові параметри депозиту',
															  p_funcname => '/barsroot/udeposit/dptcreateagreement.aspx?mode=\d&dpu_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Відкриття депозитного договору ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Відкриття депозитного договору ЮО',
															  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&vidd=\d+&vidname=\S*&type=\d&dpu_gen=\d*\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд рахунків за депозитним договором
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків за депозитним договором',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=4&rnk=\d+&acc=\d+\,\d+',
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

      --  Створюємо дочірню функцію Параметри депозитного договору ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Параметри депозитного договору ЮО',
															  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+&dpu_ad=\d*\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Веб-сервис /barsroot/udeposit/dptuservice.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Веб-сервис /barsroot/udeposit/dptuservice.asmx',
															  p_funcname => '/barsroot/udeposit/dptuservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Вікно вводу документів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Вікно вводу документів',
															  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
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

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_REVZ) - АРМ Управління ревізій та контролю  ');
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
umu.add_report2arm(11,'$RM_REVZ');
umu.add_report2arm(213,'$RM_REVZ');
umu.add_report2arm(320,'$RM_REVZ');
umu.add_report2arm(323,'$RM_REVZ');
umu.add_report2arm(480,'$RM_REVZ');
umu.add_report2arm(1000,'$RM_REVZ');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_REVZ.sql =========**
PROMPT ===================================================================================== 
