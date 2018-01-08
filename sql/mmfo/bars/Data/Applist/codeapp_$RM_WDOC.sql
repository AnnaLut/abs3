PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WDOC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WDOC ***
  declare
    l_application_code varchar2(10 char) := '$RM_WDOC';
    l_application_name varchar2(300 char) := 'АРМ Операціоніста (Фронт)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WDOC створюємо (або оновлюємо) АРМ АРМ Операціоніста (Фронт) ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт .dbf файла (Енергоринок)  ********** ');
          --  Створюємо функцію Імпорт .dbf файла (Енергоринок) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт .dbf файла (Енергоринок) ',
                                                  p_funcname => '/barsroot/ImportDbf',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Імпорт .dbf файла (Енергоринок)  (головна сторінка імпорту)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Імпорт .dbf файла (Енергоринок)  (головна сторінка імпорту)',
															  p_funcname => '/barsroot/importdbf\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Імпорт .dbf файла (Енергоринок)  (розбір іморту)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Імпорт .dbf файла (Енергоринок)  (розбір іморту)',
															  p_funcname => '/barsroot/sberutls/importproc.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдкриття каси ********** ');
          --  Створюємо функцію Вiдкриття каси
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдкриття каси',
                                                  p_funcname => '/barsroot/admin/cash_open.aspx',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зарахування на БПК ********** ');
          --  Створюємо функцію Зарахування на БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зарахування на БПК',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_alt_bpk',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Облік операцій по вкладах АСВО ********** ');
          --  Створюємо функцію Облік операцій по вкладах АСВО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Облік операцій по вкладах АСВО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_dep_odb1',
                                                  p_rolename => 'START1' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд інформаційних документів ********** ');
          --  Створюємо функцію Перегляд інформаційних документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд інформаційних документів',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_docum_inf',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Повернення суми виплат компенсації 2012 ********** ');
          --  Створюємо функцію Повернення суми виплат компенсації 2012
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Повернення суми виплат компенсації 2012',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ret_2012',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виплата з 2625/22 через касу ********** ');
          --  Створюємо функцію Виплата з 2625/22 через касу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виплата з 2625/22 через касу',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ussr2_pay_bpk',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Повернення суми виплат на поховання NEW ********** ');
          --  Створюємо функцію Повернення суми виплат на поховання NEW
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Повернення суми виплат на поховання NEW',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_v_ret_pox',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<Розповсюдження/сплата виграшів  по лотереях>> ********** ');
          --  Створюємо функцію <<Розповсюдження/сплата виграшів  по лотереях>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<Розповсюдження/сплата виграшів  по лотереях>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2481&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<ФО:Комiсiя за послуги>> ********** ');
          --  Створюємо функцію <<ФО:Комiсiя за послуги>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<ФО:Комiсiя за послуги>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2482&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<Купівля-продаж БМ та інвестиційних монет>> ********** ');
          --  Створюємо функцію <<Купівля-продаж БМ та інвестиційних монет>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<Купівля-продаж БМ та інвестиційних монет>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2483&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виплати МО,МВС,СБУ,ДПА,ДДзВП + СК+Фонди ********** ');
          --  Створюємо функцію Виплати МО,МВС,СБУ,ДПА,ДДзВП + СК+Фонди
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виплати МО,МВС,СБУ,ДПА,ДДзВП + СК+Фонди',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2484&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<Монети>> ********** ');
          --  Створюємо функцію <<Монети>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<Монети>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2485&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<Компенсацiї>> ********** ');
          --  Створюємо функцію <<Компенсацiї>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<Компенсацiї>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2686&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<Нерухомi>> ********** ');
          --  Створюємо функцію <<Нерухомi>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<Нерухомi>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2787&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Погашення кредиту готiвкою свого ТВБВ ********** ');
          --  Створюємо функцію Погашення кредиту готiвкою свого ТВБВ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Погашення кредиту готiвкою свого ТВБВ',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2814&mode=ro&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Погашення кредиту готівкою
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Погашення кредиту готівкою',
															  p_funcname => '/barsroot/credit/repayment.aspx?ccid=\S+&dat1=\d+',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<ЮО:Комiсiя за послуги>> ********** ');
          --  Створюємо функцію <<ЮО:Комiсiя за послуги>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<ЮО:Комiсiя за послуги>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=3787&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розбiр внутрi-регiональних компенсацiйних переказiв 9760 ********** ');
          --  Створюємо функцію Розбiр внутрi-регiональних компенсацiйних переказiв 9760
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розбiр внутрi-регiональних компенсацiйних переказiв 9760',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=4095&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<ФО:Комісія за послуги по Депозитним ячейкам >> ********** ');
          --  Створюємо функцію <<ФО:Комісія за послуги по Депозитним ячейкам >>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<ФО:Комісія за послуги по Депозитним ячейкам >>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=7338&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію "Корпоративний залишок"(web) ********** ');
          --  Створюємо функцію "Корпоративний залишок"(web)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"Корпоративний залишок"(web)',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V1_BRO&mode=RO&force=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Роздрiбнi операцiї з ЦП ********** ');
          --  Створюємо функцію Роздрiбнi операцiї з ЦП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Роздрiбнi операцiї з ЦП',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_CP_RETEIL&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<Продаж інвестиційних монет без поп.оплати>> ********** ');
          --  Створюємо функцію <<Продаж інвестиційних монет без поп.оплати>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<Продаж інвестиційних монет без поп.оплати>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_METALS_KP_IM&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<Монети без номіналу>> ********** ');
          --  Створюємо функцію <<Монети без номіналу>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<Монети без номіналу>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_MON3&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <<Монети,передані НБУ на реал. без попередн.оплати>> ********** ');
          --  Створюємо функцію <<Монети,передані НБУ на реал. без попередн.оплати>>
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<Монети,передані НБУ на реал. без попередн.оплати>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_MON4&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Повернення суми виплат на поховання ********** ');
          --  Створюємо функцію Повернення суми виплат на поховання
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Повернення суми виплат на поховання',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_RET_POX&mode=RW&force=1',
                                                  p_rolename => 'PYOD001' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк документів по валютним платежам ********** ');
          --  Створюємо функцію Друк документів по валютним платежам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк документів по валютним платежам',
                                                  p_funcname => '/barsroot/corp2/export_docs.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Погашення кредиту готівкою в т.ч. 2620 ********** ');
          --  Створюємо функцію Погашення кредиту готівкою в т.ч. 2620
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Погашення кредиту готівкою в т.ч. 2620',
                                                  p_funcname => '/barsroot/credit/repayment.aspx',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перегляд картки документу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд картки документу',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд рахунків по доступу(за межами відділення) ********** ');
          --  Створюємо функцію Перегляд рахунків по доступу(за межами відділення)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд рахунків по доступу(за межами відділення)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=1',
                                                  p_rolename => 'WR_USER_ACCOUNTS_LIST' ,
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

      --  Створюємо дочірню функцію Історія рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Історія рахунку',
															  p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
															  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Операції з цінностями ********** ');
          --  Створюємо функцію Операції з цінностями
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Операції з цінностями',
                                                  p_funcname => '/barsroot/docinput/depository.aspx',
                                                  p_rolename => 'WR_DOC_INPUT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зарахування по Альтер.рах.(АСВО) ********** ');
          --  Створюємо функцію Зарахування по Альтер.рах.(АСВО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зарахування по Альтер.рах.(АСВО)',
                                                  p_funcname => '/barsroot/docinput/doc_alt.aspx',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення дод. реквізитів за сьогодні (WEB) ********** ');
          --  Створюємо функцію Довведення дод. реквізитів за сьогодні (WEB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення дод. реквізитів за сьогодні (WEB)',
                                                  p_funcname => '/barsroot/docinput/editprops.aspx?mode=2',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Довведення дод. реквізитів по реф.(WEB)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довведення дод. реквізитів по реф.(WEB)',
															  p_funcname => '/barsroot/docinput/editprops.aspx?ref=\d+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Просмотр документов пользователя ********** ');
          --  Створюємо функцію Просмотр документов пользователя
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Просмотр документов пользователя',
                                                  p_funcname => '/barsroot/documentsview/default.aspx?type=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перелік отриманих документів користувача  за період
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів користувача  за період',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів користувача за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів користувача за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів користувача за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів користувача за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів користувача за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів користувача за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=22&date=\d{2}\.\d{2}\.\d{4}',
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

      --  Створюємо дочірню функцію Перелік усіх документів користувача за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів користувача за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=11',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів користувача  за період
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів користувача  за період',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування звітів ********** ');
          --  Створюємо функцію Формування звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування звітів',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_WDOC',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Відбір документів [ВСІ ДОКУМЕНТИ] ********** ');
          --  Створюємо функцію ФМ. Відбір документів [ВСІ ДОКУМЕНТИ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Відбір документів [ВСІ ДОКУМЕНТИ]',
                                                  p_funcname => '/barsroot/finmon/doc.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію ФМ. Фільтр кокументів по статусам
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Фільтр кокументів по статусам',
															  p_funcname => '/barsroot/finmon/docstatusfilter.aspx?rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ФМ. Довідник терористів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Довідник терористів',
															  p_funcname => '/barsroot/finmon/ref_terorist.aspx?otm=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ФМ. Перегляд і вибір документів(фільтр)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Перегляд і вибір документів(фільтр)',
															  p_funcname => '/barsroot/finmon/docfilter.aspx?rnd=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ФМ. Параметри
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Параметри',
															  p_funcname => '/barsroot/finmon/docparams.aspx?ref=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію ФМ. Довідник статусів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'ФМ. Довідник статусів',
															  p_funcname => '/barsroot/finmon/docstatus.aspx?ref=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Відбір документів [СВОЇ ДОКУМЕНТИ] ********** ');
          --  Створюємо функцію ФМ. Відбір документів [СВОЇ ДОКУМЕНТИ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Відбір документів [СВОЇ ДОКУМЕНТИ]',
                                                  p_funcname => '/barsroot/finmon/doc.aspx?filter=user',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сальдiвка по виробам з БМ (110*) ********** ');
          --  Створюємо функцію Сальдiвка по виробам з БМ (110*)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сальдiвка по виробам з БМ (110*)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_BM_COUNT[NSIFUNCTION]',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 4: ФАЙЛИ ІНКАСАЦІЇ ********** ');
          --  Створюємо функцію Iмпорт 4: ФАЙЛИ ІНКАСАЦІЇ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 4: ФАЙЛИ ІНКАСАЦІЇ',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Iмпорт : Розбiр документiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт : Розбiр документiв',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 2: КОМУНАЛЬНI ПЛАТЕЖI ********** ');
          --  Створюємо функцію Iмпорт 2: КОМУНАЛЬНI ПЛАТЕЖI
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 2: КОМУНАЛЬНI ПЛАТЕЖI',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=kp',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Iмпорт : Розбiр документiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт : Розбiр документiв',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 1: ЛОКАЛЬНI ЗАДАЧI (ЩОДЕННИК) ********** ');
          --  Створюємо функцію Iмпорт 1: ЛОКАЛЬНI ЗАДАЧI (ЩОДЕННИК)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 1: ЛОКАЛЬНI ЗАДАЧI (ЩОДЕННИК)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=lz',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Iмпорт : Розбiр документiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт : Розбiр документiв',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт файлу DBF-Файл(BARS) Укрзалізниця ********** ');
          --  Створюємо функцію Імпорт файлу DBF-Файл(BARS) Укрзалізниця
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт файлу DBF-Файл(BARS) Укрзалізниця',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ukrrail',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3.3: Iншi зарахувння (tt=PKR,sk=88) ********** ');
          --  Створюємо функцію Iмпорт 3.3: Iншi зарахувння (tt=PKR,sk=88)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3.3: Iншi зарахувння (tt=PKR,sk=88)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_3_3',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт : Розбiр документiв ********** ');
          --  Створюємо функцію Iмпорт : Розбiр документiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт : Розбiр документiв',
                                                  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Iмпорт : Редагування iмпортованого документа
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт : Редагування iмпортованого документа',
															  p_funcname => '/barsroot/sberutls/importproced.aspx\S*',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Iмпорт : Редагування iмпортованого документа
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт : Редагування iмпортованого документа',
															  p_funcname => '/barsroot/sberutls/importproced.aspx',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт "Зарплата"-XML ********** ');
          --  Створюємо функцію Імпорт "Зарплата"-XML
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт "Зарплата"-XML',
                                                  p_funcname => '/barsroot/sberutls/importsalary.aspx',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Інформаційні запити ********** ');
          --  Створюємо функцію СЕП. Інформаційні запити
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Інформаційні запити',
                                                  p_funcname => '/barsroot/sep/septz/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Запити на уточ.рекв.по плат.з рах.Відділ.і підлег. (сформ. реєстр)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Запити на уточ.рекв.по плат.з рах.Відділ.і підлег. (сформ. реєстр)',
															  p_funcname => '/barsroot/sep/septz/getreport\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Запити на уточ.рекв.по плат.з рах.Відділ.і підлег. (видал. запис)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Запити на уточ.рекв.по плат.з рах.Відділ.і підлег. (видал. запис)',
															  p_funcname => '/barsroot/sep/septz/deleterow\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Запити на уточ.рекв.по платежах всього Банку (док.інф.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Запити на уточ.рекв.по платежах всього Банку (док.інф.)',
															  p_funcname => '/barsroot/sep/septz/getrowref\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Запити на уточ.рекв.по плат.з рах.Відділ.і підлег. (уточ. рекв.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Запити на уточ.рекв.по плат.з рах.Відділ.і підлег. (уточ. рекв.)',
															  p_funcname => '/barsroot/sep/septz/rowreply\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Запити на уточ.рекв.по плат.з рах.Відділ.і підлег. (список док-ів)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Запити на уточ.рекв.по плат.з рах.Відділ.і підлег. (список док-ів)',
															  p_funcname => '/barsroot/sep/septz/getseptzlist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Запити на уточ.рекв.по плат.з рах.Відділ.і підлег.
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Запити на уточ.рекв.по плат.з рах.Відділ.і підлег.',
															  p_funcname => '/barsroot/sep/septz/getzaga\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_WDOC) - АРМ Операціоніста (Фронт)  ');
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
umu.add_report2arm(7,'$RM_WDOC');
umu.add_report2arm(8,'$RM_WDOC');
umu.add_report2arm(11,'$RM_WDOC');
umu.add_report2arm(16,'$RM_WDOC');
umu.add_report2arm(17,'$RM_WDOC');
umu.add_report2arm(54,'$RM_WDOC');
umu.add_report2arm(63,'$RM_WDOC');
umu.add_report2arm(73,'$RM_WDOC');
umu.add_report2arm(74,'$RM_WDOC');
umu.add_report2arm(116,'$RM_WDOC');
umu.add_report2arm(119,'$RM_WDOC');
umu.add_report2arm(136,'$RM_WDOC');
umu.add_report2arm(147,'$RM_WDOC');
umu.add_report2arm(171,'$RM_WDOC');
umu.add_report2arm(185,'$RM_WDOC');
umu.add_report2arm(187,'$RM_WDOC');
umu.add_report2arm(202,'$RM_WDOC');
umu.add_report2arm(205,'$RM_WDOC');
umu.add_report2arm(210,'$RM_WDOC');
umu.add_report2arm(243,'$RM_WDOC');
umu.add_report2arm(247,'$RM_WDOC');
umu.add_report2arm(253,'$RM_WDOC');
umu.add_report2arm(260,'$RM_WDOC');
umu.add_report2arm(261,'$RM_WDOC');
umu.add_report2arm(262,'$RM_WDOC');
umu.add_report2arm(263,'$RM_WDOC');
umu.add_report2arm(264,'$RM_WDOC');
umu.add_report2arm(265,'$RM_WDOC');
umu.add_report2arm(282,'$RM_WDOC');
umu.add_report2arm(283,'$RM_WDOC');
umu.add_report2arm(296,'$RM_WDOC');
umu.add_report2arm(320,'$RM_WDOC');
umu.add_report2arm(323,'$RM_WDOC');
umu.add_report2arm(331,'$RM_WDOC');
umu.add_report2arm(335,'$RM_WDOC');
umu.add_report2arm(336,'$RM_WDOC');
umu.add_report2arm(345,'$RM_WDOC');
umu.add_report2arm(346,'$RM_WDOC');
umu.add_report2arm(347,'$RM_WDOC');
umu.add_report2arm(348,'$RM_WDOC');
umu.add_report2arm(349,'$RM_WDOC');
umu.add_report2arm(375,'$RM_WDOC');
umu.add_report2arm(376,'$RM_WDOC');
umu.add_report2arm(377,'$RM_WDOC');
umu.add_report2arm(380,'$RM_WDOC');
umu.add_report2arm(412,'$RM_WDOC');
umu.add_report2arm(440,'$RM_WDOC');
umu.add_report2arm(441,'$RM_WDOC');
umu.add_report2arm(449,'$RM_WDOC');
umu.add_report2arm(490,'$RM_WDOC');
umu.add_report2arm(491,'$RM_WDOC');
umu.add_report2arm(542,'$RM_WDOC');
umu.add_report2arm(546,'$RM_WDOC');
umu.add_report2arm(547,'$RM_WDOC');
umu.add_report2arm(588,'$RM_WDOC');
umu.add_report2arm(591,'$RM_WDOC');
umu.add_report2arm(684,'$RM_WDOC');
umu.add_report2arm(701,'$RM_WDOC');
umu.add_report2arm(702,'$RM_WDOC');
umu.add_report2arm(703,'$RM_WDOC');
umu.add_report2arm(766,'$RM_WDOC');
umu.add_report2arm(1000,'$RM_WDOC');
umu.add_report2arm(1009,'$RM_WDOC');
umu.add_report2arm(3022,'$RM_WDOC');
umu.add_report2arm(3043,'$RM_WDOC');
umu.add_report2arm(3044,'$RM_WDOC');
umu.add_report2arm(3102,'$RM_WDOC');
umu.add_report2arm(3119,'$RM_WDOC');
umu.add_report2arm(5611,'$RM_WDOC');
umu.add_report2arm(5700,'$RM_WDOC');
umu.add_report2arm(5701,'$RM_WDOC');
umu.add_report2arm(5702,'$RM_WDOC');
umu.add_report2arm(5703,'$RM_WDOC');
umu.add_report2arm(5706,'$RM_WDOC');
umu.add_report2arm(6262,'$RM_WDOC');
umu.add_report2arm(6264,'$RM_WDOC');
umu.add_report2arm(100260,'$RM_WDOC');
umu.add_report2arm(100375,'$RM_WDOC');
umu.add_report2arm(100502,'$RM_WDOC');
umu.add_report2arm(100566,'$RM_WDOC');
umu.add_report2arm(100953,'$RM_WDOC');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WDOC.sql =========**
PROMPT ===================================================================================== 
