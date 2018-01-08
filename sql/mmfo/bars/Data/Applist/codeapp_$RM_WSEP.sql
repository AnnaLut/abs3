PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WSEP.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WSEP ***
  declare
    l_application_code varchar2(10 char) := '$RM_WSEP';
    l_application_name varchar2(300 char) := 'Технолог СЕП';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WSEP створюємо (або оновлюємо) АРМ Технолог СЕП ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Повідомлення для релізу ********** ');
          --  Створюємо функцію Повідомлення для релізу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Повідомлення для релізу',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>p_message_for_release(:R)][PAR=>:R(SEM=Через скільки хвилин доставити повідомлення,TYPE=N)][EXEC=>BEFORE][MSG=>Повідомлення створене!]',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт курсів валют ********** ');
          --  Створюємо функцію Імпорт курсів валют
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт курсів валют',
                                                  p_funcname => '/barsroot/sberutls/import_rates.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Розбір нез'ясованих відповідних сум 3720 (ГРН) ********** ');
          --  Створюємо функцію СЕП. Розбір нез'ясованих відповідних сум 3720 (ГРН)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Розбір нез'ясованих відповідних сум 3720 (ГРН)',
                                                  p_funcname => '/barsroot/sep/sep3720/index?mode=hrivna',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Розбір 3720  (список документів)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720  (список документів)',
															  p_funcname => '/barsroot/sep/sep3720/getsep3720list\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720 (видалення документа)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720 (видалення документа)',
															  p_funcname => '/barsroot/sep/sep3720/deleterecord\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720  (отримати альтернативний рахунок)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720  (отримати альтернативний рахунок)',
															  p_funcname => '/barsroot/sep/sep3720/getaltaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720 (отримання рахунку)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720 (отримання рахунку)',
															  p_funcname => '/barsroot/sep/sep3720/getaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720 (виконати запит)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720 (виконати запит)',
															  p_funcname => '/barsroot/sep/sep3720/setrequest\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720  (на альтернативний рахунок)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720  (на альтернативний рахунок)',
															  p_funcname => '/barsroot/sep/sep3720/toaltaccounts\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Розбір нез'ясованих відповідних сум 3720 (ВАЛ) ********** ');
          --  Створюємо функцію СЕП. Розбір нез'ясованих відповідних сум 3720 (ВАЛ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Розбір нез'ясованих відповідних сум 3720 (ВАЛ)',
                                                  p_funcname => '/barsroot/sep/sep3720/index?mode=valuta',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Розбір 3720  (список документів)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720  (список документів)',
															  p_funcname => '/barsroot/sep/sep3720/getsep3720list\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720 (видалення документа)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720 (видалення документа)',
															  p_funcname => '/barsroot/sep/sep3720/deleterecord\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720  (отримати альтернативний рахунок)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720  (отримати альтернативний рахунок)',
															  p_funcname => '/barsroot/sep/sep3720/getaltaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720 (отримання рахунку)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720 (отримання рахунку)',
															  p_funcname => '/barsroot/sep/sep3720/getaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720 (виконати запит)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720 (виконати запит)',
															  p_funcname => '/barsroot/sep/sep3720/setrequest\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розбір 3720  (на альтернативний рахунок)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розбір 3720  (на альтернативний рахунок)',
															  p_funcname => '/barsroot/sep/sep3720/toaltaccounts\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Архів документів ********** ');
          --  Створюємо функцію СЕП. Архів документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Архів документів',
                                                  p_funcname => '/barsroot/sep/separcdocuments/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію СЕП. Архів документів (список документів) .
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'СЕП. Архів документів (список документів) .',
															  p_funcname => '/barsroot/sep/sepdocuments/getsepfiledocs\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію СЕП. Архів документів (відображення документів по обраній групі)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'СЕП. Архів документів (відображення документів по обраній групі)',
															  p_funcname => '/barsroot/sep/sepdocuments/getseppaymentstatedocs\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Блокувати/Розблокувати напрямки ********** ');
          --  Створюємо функцію СЕП. Блокувати/Розблокувати напрямки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Блокувати/Розблокувати напрямки',
                                                  p_funcname => '/barsroot/sep/sepdirection/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Блокувати/Розблокувати напрямкиБлок./Розблок.
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Блокувати/Розблокувати напрямкиБлок./Розблок.',
															  p_funcname => '/barsroot/sep/sepdirection/startdirection\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Інформація про файли ********** ');
          --  Створюємо функцію СЕП. Інформація про файли
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Інформація про файли',
                                                  p_funcname => '/barsroot/sep/sepfiles/index?mode=RW',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Документи з майбутньою датою валютування, що НЕ настала ********** ');
          --  Створюємо функцію СЕП. Документи з майбутньою датою валютування, що НЕ настала
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Документи з майбутньою датою валютування, що НЕ настала',
                                                  p_funcname => '/barsroot/sep/sepfuturedocs/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Документи з майбутньою датою валютування, що Не настала (Видал.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Документи з майбутньою датою валютування, що Не настала (Видал.)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/removesepfuturedoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Документи з майбутньою датою валютування, що Не настала (Рахунок)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Документи з майбутньою датою валютування, що Не настала (Рахунок)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/getsepfuturedocaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Документи з майбутньою датою валютування, що Не настала (Встанов.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Документи з майбутньою датою валютування, що Не настала (Встанов.)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/setsepfuturedoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Документи з майбутньою датою валютування, що Не настала (Документи)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Документи з майбутньою датою валютування, що Не настала (Документи)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/getsepfuturedoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Оновлення списку банків із S_UCH.DBF ********** ');
          --  Створюємо функцію СЕП. Оновлення списку банків із S_UCH.DBF
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Оновлення списку банків із S_UCH.DBF',
                                                  p_funcname => '/barsroot/sep/sepimportsuch/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи СЕП  ( Всі ) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи СЕП  ( Всі )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи СЕП  ( Всі )',
                                                  p_funcname => '/barsroot/sep/seplockdocs/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Заблоковані документи СЕП (Без контролю ВПС) (Документи)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Заблоковані документи СЕП (Без контролю ВПС) (Документи)',
															  p_funcname => '/barsroot/sep/seplockdocs/getseplockdoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Заблоковані документи СЕП (Без контролю ВПС)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Заблоковані документи СЕП (Без контролю ВПС)',
															  p_funcname => '/barsroot/sep/seplockdocs/index\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Заблоковані документи СЕП (Без контролю ВПС)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Заблоковані документи СЕП (Без контролю ВПС)',
															  p_funcname => '/barsroot/sep/seplockdocs/index?DefinedCode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію SWIFT. МВПС платежі на 191992, 3720, 1600, 2906 ********** ');
          --  Створюємо функцію SWIFT. МВПС платежі на 191992, 3720, 1600, 2906
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. МВПС платежі на 191992, 3720, 1600, 2906',
                                                  p_funcname => '/barsroot/sep/seplockdocs/index?swt=swt',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Стан платежів ********** ');
          --  Створюємо функцію СЕП. Стан платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Стан платежів',
                                                  p_funcname => '/barsroot/sep/seppaymentstate/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Стан платежів (групи платежів по станам)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Стан платежів (групи платежів по станам)',
															  p_funcname => '/barsroot/sep/seppaymentstate/getseppaymentstatelist\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відповіді ІПС ********** ');
          --  Створюємо функцію Відповіді ІПС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відповіді ІПС',
                                                  p_funcname => '/barsroot/sep/seprequestips/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Технологічні рахунки ********** ');
          --  Створюємо функцію СЕП. Технологічні рахунки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Технологічні рахунки',
                                                  p_funcname => '/barsroot/sep/septechaccounts/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Технологічні флаги ********** ');
          --  Створюємо функцію СЕП. Технологічні флаги
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Технологічні флаги',
                                                  p_funcname => '/barsroot/sep/septechflag/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Просмотр и редактирование справочников
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Просмотр и редактирование справочников',
															  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=\d+&mode=\S\S',
															  p_rolename => 'WR_REFREAD' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію СЕП. Інформаційні запити
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'СЕП. Інформаційні запити',
															  p_funcname => '/barsroot/sep/septz/',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування таблиць, що синхронізуються ********** ');
          --  Створюємо функцію Редагування таблиць, що синхронізуються
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування таблиць, що синхронізуються',
                                                  p_funcname => 'barsroot/SyncTablesEditor/SyncTablesEditor/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_WSEP) - Технолог СЕП  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WSEP.sql =========**
PROMPT ===================================================================================== 
