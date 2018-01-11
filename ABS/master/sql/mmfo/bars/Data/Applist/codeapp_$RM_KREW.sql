PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_KREW.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_KREW ***
  declare
    l_application_code varchar2(10 char) := '$RM_KREW';
    l_application_name varchar2(300 char) := 'АРМ Кредитного iнспектора';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_KREW створюємо (або оновлюємо) АРМ АРМ Кредитного iнспектора ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сховище. Оприбуткування цінностей по КД з дороги ********** ');
          --  Створюємо функцію Сховище. Оприбуткування цінностей по КД з дороги
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сховище. Оприбуткування цінностей по КД з дороги',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_cc_989917',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок Значення показника ризику Бюджетних установ ********** ');
          --  Створюємо функцію Розрахунок Значення показника ризику Бюджетних установ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок Значення показника ризику Бюджетних установ',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust_bd',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Карточка клієнта фінстан ФО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка клієнта фінстан ФО',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_bd\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*rnk=\S*frm=\S*dat=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми 351',
															  p_funcname => '/barsroot/credit/fin_nbu/credit_defolt_bud.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок Значення показника ризику ФО ********** ');
          --  Створюємо функцію Розрахунок Значення показника ризику ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок Значення показника ризику ФО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust_fl',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Карточка форми 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми 351',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_pd_fo.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка клієнта фінстан ФО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка клієнта фінстан ФО',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_fl\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*rnk=\S*frm=\S*dat=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок Значення показника ризику ФО-СПД ********** ');
          --  Створюємо функцію Розрахунок Значення показника ризику ФО-СПД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок Значення показника ризику ФО-СПД',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust_spd',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Карточка форми 351
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми 351',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_pd_fo.aspx?\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка клієнта фінстан ФО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка клієнта фінстан ФО',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_fl\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Карточка форми',
															  p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*rnk=\S*frm=\S*dat=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію *Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ФО ********** ');
          --  Створюємо функцію *Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ФО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_s080_fo',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію *Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ЮО ********** ');
          --  Створюємо функцію *Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '*Претенденти на змiну кат.ризику по Пост.НБУ № 279 п.6.2.ЮО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_s080_uo',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Разові комісії за кредити ********** ');
          --  Створюємо функцію Разові комісії за кредити
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Разові комісії за кредити',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_v_cc_komis',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Вибір комісії по кредиту
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Вибір комісії по кредиту',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_cc_prod_komis&prod=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Заявки на кредит для ФО ********** ');
          --  Створюємо функцію Заявки на кредит для ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Заявки на кредит для ФО',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2810&mode=ro&force=1',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Розмiщення заявки на кредит
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розмiщення заявки на кредит',
															  p_funcname => '/barsroot/credit/cck_zay.aspx?prod=\d+&name=\S*&custtype=\d+',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Заявки на кредит для ЮО ********** ');
          --  Створюємо функцію Заявки на кредит для ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Заявки на кредит для ЮО',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2811&mode=ro&force=1',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Розмiщення заявки на кредит
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розмiщення заявки на кредит',
															  p_funcname => '/barsroot/credit/cck_zay.aspx?prod=\d+&name=\S*&custtype=\d+',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Первинна видача кредиту ********** ');
          --  Створюємо функцію Первинна видача кредиту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Первинна видача кредиту',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2815&mode=RO&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Облiк цiнностей по КД ********** ');
          --  Створюємо функцію Облiк цiнностей по КД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Облiк цiнностей по КД',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=4161&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Дострокове погашення тіла кредиту(перебудова ГПК) ********** ');
          --  Створюємо функцію Дострокове погашення тіла кредиту(перебудова ГПК)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Дострокове погашення тіла кредиту(перебудова ГПК)',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=CC_VP_DOSR&mode=RO&force=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Дострокове погашення тіла кредиту/перебудова ГПК
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Дострокове погашення тіла кредиту/перебудова ГПК',
															  p_funcname => '/barsroot/credit/repayment_dostr.aspx?ccid=\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Інформаційна довiдка ********** ');
          --  Створюємо функцію Інформаційна довiдка
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Інформаційна довiдка',
                                                  p_funcname => '/barsroot/credit/info.aspx',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Пошук договору
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Пошук договору',
															  p_funcname => '/barsroot/credit/search.aspx?stype=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Список планових платежів позичальників ФО по КД (WEB) ********** ');
          --  Створюємо функцію Список планових платежів позичальників ФО по КД (WEB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Список планових платежів позичальників ФО по КД (WEB)',
                                                  p_funcname => '/barsroot/credit/overdue_loans.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_KREW) - АРМ Кредитного iнспектора  ');
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
umu.add_report2arm(494,'$RM_KREW');
umu.add_report2arm(605,'$RM_KREW');
umu.add_report2arm(799,'$RM_KREW');
umu.add_report2arm(5007,'$RM_KREW');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_KREW.sql =========**
PROMPT ===================================================================================== 
