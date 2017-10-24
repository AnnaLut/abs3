SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_ALLA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  ALLA ***
  declare
    l_application_code varchar2(10 char) := 'ALLA';
    l_application_name varchar2(300 char) := 'Всі функції';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_CENTURA;
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
     DBMS_OUTPUT.PUT_LINE(' ALLA створюємо (або оновлюємо) АРМ Всі функції ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/AddSum.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель технічних рахунків підрозділу ********** ');
          --  Створюємо функцію Портфель технічних рахунків підрозділу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель технічних рахунків підрозділу',
                                                  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  /BarsWeb.TechAccounts/DocumentPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  /BarsWeb.TechAccounts/DocumentPrint.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/DocumentPrint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/DepositCoowner.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/AddSum.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/DepositTechAcc.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/Transfer.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/Transfer.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/Transfer.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx',
															  p_funcname => '/BarsWeb.TechAccounts/DocumentForm.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поповнення технічного рахунку ********** ');
          --  Створюємо функцію Поповнення технічного рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поповнення технічного рахунку',
                                                  p_funcname => '/BarsWeb.TechAccounts/Default.aspx?action=add',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Портфель технічних рахунків підрозділу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Портфель технічних рахунків підрозділу',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Закриття технічного рахунку ********** ');
          --  Створюємо функцію Закриття технічного рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Закриття технічного рахунку',
                                                  p_funcname => '/BarsWeb.TechAccounts/Default.aspx?action=close',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Портфель технічних рахунків підрозділу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Портфель технічних рахунків підрозділу',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перерахування коштів з технічного рахунку ********** ');
          --  Створюємо функцію Перерахування коштів з технічного рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перерахування коштів з технічного рахунку',
                                                  p_funcname => '/BarsWeb.TechAccounts/Default.aspx?action=pay',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Портфель технічних рахунків підрозділу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Портфель технічних рахунків підрозділу',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/DepositCoowner.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відкриття технічного рахунку ********** ');
          --  Створюємо функцію Відкриття технічного рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відкриття технічного рахунку',
                                                  p_funcname => '/BarsWeb.TechAccounts/DepositSearch.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Портфель технічних рахунків підрозділу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Портфель технічних рахунків підрозділу',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/DepositTechAcc.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/DocumentForm.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  /BarsWeb.TechAccounts/DocumentPrint.aspx ********** ');
          --  Створюємо функцію Сторінка  /BarsWeb.TechAccounts/DocumentPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  /BarsWeb.TechAccounts/DocumentPrint.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/DocumentPrint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поповнення технічного рахунку безготівкою ********** ');
          --  Створюємо функцію Поповнення технічного рахунку безготівкою
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поповнення технічного рахунку безготівкою',
                                                  p_funcname => '/BarsWeb.TechAccounts/GroupCommission.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Портфель технічних рахунків підрозділу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Портфель технічних рахунків підрозділу',
															  p_funcname => '/BarsWeb.TechAccounts/Default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/Transfer.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/Transfer.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/Transfer.aspx',
                                                  p_funcname => '/BarsWeb.TechAccounts/Transfer.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Пiдпис проводок для експорту (адміністратор) ********** ');
          --  Створюємо функцію Пiдпис проводок для експорту (адміністратор)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Пiдпис проводок для експорту (адміністратор)',
                                                  p_funcname => '/DocInput/DocExport.aspx?type=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування КОРИСТУВАЧІВ ********** ');
          --  Створюємо функцію Адміністрування КОРИСТУВАЧІВ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування КОРИСТУВАЧІВ',
                                                  p_funcname => '/barsroot/admin/adminusers.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Налаштування системи ********** ');
          --  Створюємо функцію Налаштування системи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Налаштування системи',
                                                  p_funcname => '/barsroot/admin/globaloptions.aspx',
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
                                                  p_rolename => 'WEB_BALANS' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Історія рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Історія рахунку',
															  p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Баланс-Рахунок-Документ(валюта)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Баланс-Рахунок-Документ(валюта)',
															  p_funcname => '/barsroot/balansaccdoc/balansval.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Баланс-Рахунок-Документ(виконавець)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Баланс-Рахунок-Документ(виконавець)',
															  p_funcname => '/barsroot/balansaccdoc/balansisp.aspx?\S+',
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

      --  Створюємо дочірню функцію Баланс-Рахунок-Документ(рахунок)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Баланс-Рахунок-Документ(рахунок)',
															  p_funcname => '/barsroot/balansaccdoc/balansacc.aspx?\S+',
															  p_rolename => 'WEB_BALANS' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Баланс-Рахунок-Документ(рахунок) ********** ');
          --  Створюємо функцію Баланс-Рахунок-Документ(рахунок)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Баланс-Рахунок-Документ(рахунок)',
                                                  p_funcname => '/barsroot/balansaccdoc/balansacc.aspx?\S+',
                                                  p_rolename => 'WEB_BALANS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Баланс-Рахунок-Документ(виконавець) ********** ');
          --  Створюємо функцію Баланс-Рахунок-Документ(виконавець)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Баланс-Рахунок-Документ(виконавець)',
                                                  p_funcname => '/barsroot/balansaccdoc/balansisp.aspx?\S+',
                                                  p_rolename => 'WEB_BALANS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Баланс-Рахунок-Документ(валюта) ********** ');
          --  Створюємо функцію Баланс-Рахунок-Документ(валюта)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Баланс-Рахунок-Документ(валюта)',
                                                  p_funcname => '/barsroot/balansaccdoc/balansval.aspx?\S+',
                                                  p_rolename => 'WEB_BALANS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторнування документів по валютообмінних операціях ********** ');
          --  Створюємо функцію Сторнування документів по валютообмінних операціях
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторнування документів по валютообмінних операціях',
                                                  p_funcname => '/barsroot/barsweb/dynamic.aspx?title=none&proc=ret_pay&p1type=n&p1=ref',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель БПК ********** ');
          --  Створюємо функцію Портфель БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель БПК',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpk.frm.portfolio',
                                                  p_rolename => 'WR_CREDIT' ,
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

      --  Створюємо дочірню функцію БПК. Реєстрація нової угоди
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'БПК. Реєстрація нової угоди',
															  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpk.frm.newdeal',
															  p_rolename => 'WR_CREDIT' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд та редагування довідників ********** ');
          --  Створюємо функцію Перегляд та редагування довідників
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд та редагування довідників',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?(tabname=\S)|(tabid=\d+)&mode=\S\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перегляд "вложенных" довідників
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд "вложенных" довідників',
															  p_funcname => '/barsroot/barsweb/references/refbook.aspx?(tabname=\S)|(tabid=\d+)&mode=ro&force=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд "вложенных" довідників ********** ');
          --  Створюємо функцію Перегляд "вложенных" довідників
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд "вложенных" довідників',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?(tabname=\S)|(tabid=\d+)&mode=ro&force=\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Підготовка КП для завантаження ********** ');
          --  Створюємо функцію Підготовка КП для завантаження
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Підготовка КП для завантаження',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2101&mode=w&force=1',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату ********** ');
          --  Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити, що мають прострочку на ПОТОЧНУ дату',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2545&mode=ro&force=1',
                                                  p_rolename => 'WR_REFREAD' ,
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


      --  Створюємо дочірню функцію Перегляд договорів (Менеджер)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд договорів (Менеджер)',
															  p_funcname => '/barsroot/ins/deals.aspx?fid=mgru&type=mgr&nd=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд рахунків за кредитним договором
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків за кредитним договором',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=3&nd=\d+',
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


      --  Створюємо дочірню функцію Погашення кредиту гот?вкою
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Погашення кредиту гот?вкою',
															  p_funcname => '/barsroot/credit/repayment.aspx?ccid=\S+&dat1=\d+',
															  p_rolename => 'WR_CREDIT' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Договора на рег.платежi ********** ');
          --  Створюємо функцію Договора на рег.платежi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Договора на рег.платежi',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=3267&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію /barsroot/tools/sto/sto_calendar.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/tools/sto/sto_calendar.aspx',
															  p_funcname => '/barsroot/tools/sto/sto_calendar.aspx\S*',
															  p_rolename => 'PYOD001' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Внести данi про ДАТИ довiреностей ********** ');
          --  Створюємо функцію Внести данi про ДАТИ довiреностей
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Внести данi про ДАТИ довiреностей',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=3329&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Дошка об`яв ********** ');
          --  Створюємо функцію Дошка об`яв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Дошка об`яв',
                                                  p_funcname => '/barsroot/barsweb/welcome.aspx',
                                                  p_rolename => 'BASIC_INFO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування  відсотків (К) ********** ');
          --  Створюємо функцію Нарахування  відсотків (К)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування  відсотків (К)',
                                                  p_funcname => '/barsroot/basicfunctions/acrint.aspx?par=k&flt=null',
                                                  p_rolename => 'WR_ACRINT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Друк звіту про нарахування відсотків
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк звіту про нарахування відсотків',
															  p_funcname => '/barsroot/basicfunctions/reports/printreport.aspx?key=\d+',
															  p_rolename => 'WR_ACRINT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Веб-сервіс /BarsWeb.BasicFunctions/BasicService.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Веб-сервіс /BarsWeb.BasicFunctions/BasicService.asmx',
															  p_funcname => '/barsroot/basicfunctions/basicservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Відсоткова картка рахунка
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Відсоткова картка рахунка',
															  p_funcname => '/barsroot/basicfunctions/procaccounts.aspx?acc=\d+',
															  p_rolename => 'WR_ACRINT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування  відсотків (S) ********** ');
          --  Створюємо функцію Нарахування  відсотків (S)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування  відсотків (S)',
                                                  p_funcname => '/barsroot/basicfunctions/acrint.aspx?par=s&flt=null',
                                                  p_rolename => 'WR_ACRINT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Друк звіту про нарахування відсотків
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк звіту про нарахування відсотків',
															  p_funcname => '/barsroot/basicfunctions/reports/printreport.aspx?key=\d+',
															  p_rolename => 'WR_ACRINT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Веб-сервіс /BarsWeb.BasicFunctions/BasicService.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Веб-сервіс /BarsWeb.BasicFunctions/BasicService.asmx',
															  p_funcname => '/barsroot/basicfunctions/basicservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Відсоткова картка рахунка
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Відсоткова картка рахунка',
															  p_funcname => '/barsroot/basicfunctions/procaccounts.aspx?acc=\d+',
															  p_rolename => 'WR_ACRINT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Веб-сервіс /BarsWeb.BasicFunctions/BasicService.asmx ********** ');
          --  Створюємо функцію Веб-сервіс /BarsWeb.BasicFunctions/BasicService.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Веб-сервіс /BarsWeb.BasicFunctions/BasicService.asmx',
                                                  p_funcname => '/barsroot/basicfunctions/basicservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відсоткова картка рахунка ********** ');
          --  Створюємо функцію Відсоткова картка рахунка
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відсоткова картка рахунка',
                                                  p_funcname => '/barsroot/basicfunctions/procaccounts.aspx?acc=\d+',
                                                  p_rolename => 'WR_ACRINT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звіту про нарахування відсотків ********** ');
          --  Створюємо функцію Друк звіту про нарахування відсотків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звіту про нарахування відсотків',
                                                  p_funcname => '/barsroot/basicfunctions/reports/printreport.aspx?key=\d+',
                                                  p_rolename => 'WR_ACRINT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи блокованi при оплатi ********** ');
          --  Створюємо функцію Документи блокованi при оплатi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи блокованi при оплатi',
                                                  p_funcname => '/barsroot/blkdocs/default.aspx',
                                                  p_rolename => 'WR_BLKDOCS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адмiнiстрування дошки об`яв ********** ');
          --  Створюємо функцію Адмiнiстрування дошки об`яв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адмiнiстрування дошки об`яв',
                                                  p_funcname => '/barsroot/board/admin/',
                                                  p_rolename => 'WR_BOARD' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Видалення повідомлення дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Видалення повідомлення дошки оголошень',
															  p_funcname => '/barsroot/board/delete/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Адміністрування повідомлень дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Адміністрування повідомлень дошки оголошень',
															  p_funcname => '/barsroot/board/admin/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Редагування повідомлення дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редагування повідомлення дошки оголошень',
															  p_funcname => '/barsroot/board/edit/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Створення повідомлення дошки оголошень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Створення повідомлення дошки оголошень',
															  p_funcname => '/barsroot/board/add/\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів NEW ********** ');
          --  Створюємо функцію Друк звітів NEW
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів NEW',
                                                  p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів NEW ********** ');
          --  Створюємо функцію Друк звітів NEW
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів NEW',
                                                  p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію TextBoxRefer - Справочник
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'TextBoxRefer - Справочник',
															  p_funcname => '/barsroot/credit/usercontrols/dialogs/textboxrefer_show.aspx?refdatasid=\S+&rnd=\S*',
															  p_rolename => 'WR_REFREAD' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositContract.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositContractInfo.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositContractInfo.aspx',
															  p_funcname => '/barsroot/deposit/depositcontractinfo.aspx\S*',
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
                                                  p_rolename => 'WR_CHCKINNR_SELF' ,
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
                                                  p_rolename => 'WR_CHCKINNR_TOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Візування операцій відділення
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Візування операцій відділення',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=2&grpid=\w+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Верифікація вводу ********** ');
          --  Створюємо функцію Верифікація вводу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Верифікація вводу',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=3',
                                                  p_rolename => 'WR_VERIFDOC' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка верифікації вводу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка верифікації вводу',
															  p_funcname => '/barsroot/checkinner/verifdoc.aspx?grpid=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій свого та дочірніх відділень ********** ');
          --  Створюємо функцію Візування операцій свого та дочірніх відділень
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій свого та дочірніх відділень',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=4',
                                                  p_rolename => 'WR_CHCKINNR_SUBTOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Візування операцій свого та дочірніх відділень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Візування операцій свого та дочірніх відділень',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=4&grpid=\w+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування касових операцій ********** ');
          --  Створюємо функцію Візування касових операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування касових операцій',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=5',
                                                  p_rolename => 'WR_CHCKINNR_CASH' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Візування касових операцій
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Візування касових операцій',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=5&grpid=\w+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування "своїх" операцій ********** ');
          --  Створюємо функцію Візування "своїх" операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування "своїх" операцій',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=0&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію /BarsWeb.CheckInner/Documents.aspx ********** ');
          --  Створюємо функцію /BarsWeb.CheckInner/Documents.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '/BarsWeb.CheckInner/Documents.aspx',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=1&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій відділення ********** ');
          --  Створюємо функцію Візування операцій відділення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій відділення',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=2&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій свого та дочірніх відділень ********** ');
          --  Створюємо функцію Візування операцій свого та дочірніх відділень
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій свого та дочірніх відділень',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=4&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування касових операцій ********** ');
          --  Створюємо функцію Візування касових операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування касових операцій',
                                                  p_funcname => '/barsroot/checkinner/documents.aspx?type=5&grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сервіс додатку BarsWeb.CheckInner ********** ');
          --  Створюємо функцію Сервіс додатку BarsWeb.CheckInner
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сервіс додатку BarsWeb.CheckInner',
                                                  p_funcname => '/barsroot/checkinner/service.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію /BarsWeb.CheckInner/StornoReason.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/BarsWeb.CheckInner/StornoReason.aspx',
															  p_funcname => '/barsroot/checkinner/stornoreason.aspx?type=\d',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію /BarsWeb.CheckInner/StornoReason.aspx ********** ');
          --  Створюємо функцію /BarsWeb.CheckInner/StornoReason.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '/BarsWeb.CheckInner/StornoReason.aspx',
                                                  p_funcname => '/barsroot/checkinner/stornoreason.aspx?type=\d',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка верифікації вводу ********** ');
          --  Створюємо функцію Сторінка верифікації вводу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка верифікації вводу',
                                                  p_funcname => '/barsroot/checkinner/verifdoc.aspx?grpid=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
                                                  p_rolename => 'WR_CUSTREG' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/defaultwebservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/dialogs/dialogfulladr.aspx?pars=\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/organdoclist.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/picturefile.aspx?id=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/registration.aspx?(readonly=\d+)*(client=\w+)|(rnk=\d+)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/tab_dop_inf.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/tab_linked_custs.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка клієнта
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка клієнта',
															  p_funcname => '/barsroot/clientregister/tab_custs_segments.aspx?rnk=\d*&client=\w*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/tab_main_rekv.aspx?rezid=\d*&spd=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/tab_ek_norm.aspx?spd=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/tab_client_rekv_corp.aspx?rnk=\d*&readonly=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка клієнта
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка клієнта',
															  p_funcname => '/barsroot/clientregister/tab_custs_segments_capacity.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/tab_rekv_nalogoplat.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/tab_client_rekv_person.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/defaultwebservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/tab_client_rekv_bank.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/organdoclist.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/tab_dop_rekv.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/picturefile.aspx?id=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_client_rekv_bank.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_client_rekv_corp.aspx?rnk=\d*&readonly=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_client_rekv_person.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_dop_inf.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_dop_rekv.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_ek_norm.aspx?spd=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_linked_custs.aspx?rnk=\d*&client=\w*&spd=\d*&rezid=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_linked_custs_seal_img.aspx?mode=\S*&id=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_main_rekv.aspx?rezid=\d*&spd=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/dialogs/dialogfulladr.aspx?pars=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка контрагента ********** ');
          --  Створюємо функцію Картка контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка контрагента',
                                                  p_funcname => '/barsroot/clientregister/tab_rekv_nalogoplat.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків  (ЮО) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків  (ЮО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків  (ЮО)',
                                                  p_funcname => '/barsroot/clients/customers/index/?custtype=corp',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків  (ФО) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків  (ФО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків  (ФО)',
                                                  p_funcname => '/barsroot/clients/customers/index/?custtype=person',
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перегляд рахунків контрагенту
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків контрагенту',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення комунальних платежів ********** ');
          --  Створюємо функцію Введення комунальних платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення комунальних платежів',
                                                  p_funcname => '/barsroot/communalpayment/default.aspx',
                                                  p_rolename => 'WR_KP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка CommunalPayment/Tab_Single.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка CommunalPayment/Tab_Single.aspx',
															  p_funcname => '/barsroot/communalpayment/tab_single.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка CommunalPayment/Service.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка CommunalPayment/Service.asmx',
															  p_funcname => '/barsroot/communalpayment/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка CommunalPayment/Tab_Groups.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка CommunalPayment/Tab_Groups.aspx',
															  p_funcname => '/barsroot/communalpayment/tab_groups.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка CommunalPayment/Tab_Main.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка CommunalPayment/Tab_Main.aspx',
															  p_funcname => '/barsroot/communalpayment/tab_main.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка CommunalPayment/Tab_Contracts.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка CommunalPayment/Tab_Contracts.aspx',
															  p_funcname => '/barsroot/communalpayment/tab_contracts.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Пачки комунальних платежів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Пачки комунальних платежів',
															  p_funcname => '/barsroot/communalpayment/folder.aspx\S*',
															  p_rolename => 'WR_KP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Пачки комунальних платежів ********** ');
          --  Створюємо функцію Пачки комунальних платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Пачки комунальних платежів',
                                                  p_funcname => '/barsroot/communalpayment/folder.aspx\S*',
                                                  p_rolename => 'WR_KP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка CommunalPayment/Service.asmx ********** ');
          --  Створюємо функцію Сторінка CommunalPayment/Service.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка CommunalPayment/Service.asmx',
                                                  p_funcname => '/barsroot/communalpayment/service.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка CommunalPayment/Tab_Contracts.aspx ********** ');
          --  Створюємо функцію Сторінка CommunalPayment/Tab_Contracts.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка CommunalPayment/Tab_Contracts.aspx',
                                                  p_funcname => '/barsroot/communalpayment/tab_contracts.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка CommunalPayment/Tab_Groups.aspx ********** ');
          --  Створюємо функцію Сторінка CommunalPayment/Tab_Groups.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка CommunalPayment/Tab_Groups.aspx',
                                                  p_funcname => '/barsroot/communalpayment/tab_groups.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка CommunalPayment/Tab_Main.aspx ********** ');
          --  Створюємо функцію Сторінка CommunalPayment/Tab_Main.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка CommunalPayment/Tab_Main.aspx',
                                                  p_funcname => '/barsroot/communalpayment/tab_main.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка CommunalPayment/Tab_Single.aspx ********** ');
          --  Створюємо функцію Сторінка CommunalPayment/Tab_Single.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка CommunalPayment/Tab_Single.aspx',
                                                  p_funcname => '/barsroot/communalpayment/tab_single.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розмiщення заявки на кредит ********** ');
          --  Створюємо функцію Розмiщення заявки на кредит
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розмiщення заявки на кредит',
                                                  p_funcname => '/barsroot/credit/cck_zay.aspx?prod=\d+&name=\S*&custtype=\d+',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнформацiйна довідка (залежна) ********** ');
          --  Створюємо функцію Iнформацiйна довідка (залежна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнформацiйна довідка (залежна)',
                                                  p_funcname => '/barsroot/credit/info.aspx?keep=\d+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Заведення нового кредиту ********** ');
          --  Створюємо функцію Заведення нового кредиту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Заведення нового кредиту',
                                                  p_funcname => '/barsroot/credit/new.aspx',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Інформаційна довiдка
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Інформаційна довiдка',
															  p_funcname => '/barsroot/credit/info.aspx',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Iнформацiйна довідка (залежна)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iнформацiйна довідка (залежна)',
															  p_funcname => '/barsroot/credit/info.aspx?keep=\d+',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розрахунок чистого прибутку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розрахунок чистого прибутку',
															  p_funcname => '/barsroot/credit/salarydetail.aspx?sid=\d*',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Розрахунок чистого прибутку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розрахунок чистого прибутку',
															  p_funcname => '/barsroot/credit/salarydetail.aspx?sid=\d*&rand=\S*',
															  p_rolename => 'WR_CREDIT' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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


      --  Створюємо дочірню функцію Вікно вводу документів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Вікно вводу документів',
															  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок чистого прибутку ********** ');
          --  Створюємо функцію Розрахунок чистого прибутку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок чистого прибутку',
                                                  p_funcname => '/barsroot/credit/salarydetail.aspx?sid=\d*',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок чистого прибутку ********** ');
          --  Створюємо функцію Розрахунок чистого прибутку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок чистого прибутку',
                                                  p_funcname => '/barsroot/credit/salarydetail.aspx?sid=\d*&rand=\S*',
                                                  p_rolename => 'WR_CREDIT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Пошук договору ********** ');
          --  Створюємо функцію Пошук договору
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Пошук договору',
                                                  p_funcname => '/barsroot/credit/search.aspx?stype=\S+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію TextBoxRefer - Справочник ********** ');
          --  Створюємо функцію TextBoxRefer - Справочник
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'TextBoxRefer - Справочник',
                                                  p_funcname => '/barsroot/credit/usercontrols/dialogs/textboxrefer_show.aspx?refdatasid=\S+&rnd=\S*',
                                                  p_rolename => 'WR_REFREAD' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виписка по рахунку ********** ');
          --  Створюємо функцію Виписка по рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виписка по рахунку',
                                                  p_funcname => '/barsroot/customerlist/accextract.aspx?type=\d+&acc=\d+&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
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

      --  Створюємо дочірню функцію Сервіс додатку CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд рахунків контрагенту ********** ');
          --  Створюємо функцію Перегляд рахунків контрагенту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд рахунків контрагенту',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
                                                  p_rolename => '' ,
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

      --  Створюємо дочірню функцію Редагування атрибутів рахунку(закритого)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Редагування атрибутів рахунку(закритого)',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=2',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
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

      --  Створюємо дочірню функцію Перегляд атрибутів рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд атрибутів рахунку',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
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

      --  Створюємо дочірню функцію Перегляд атрибутів рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд атрибутів рахунку',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд рахунків за кредитним договором ********** ');
          --  Створюємо функцію Перегляд рахунків за кредитним договором
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд рахунків за кредитним договором',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=3&nd=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

      --  Створюємо дочірню функцію Перегляд атрибутів рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд атрибутів рахунку',
															  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
															  p_rolename => 'WR_VIEWACC' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд рахунків  по депозитному договору ********** ');
          --  Створюємо функцію Перегляд рахунків  по депозитному договору
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд рахунків  по депозитному договору',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=4&acc=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд рахунків за депозитним договором ********** ');
          --  Створюємо функцію Перегляд рахунків за депозитним договором
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд рахунків за депозитним договором',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=4&rnk=\d+&acc=\d+\,\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

      --  Створюємо дочірню функцію Сервіс додатку CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Історія змін параметрів рахунків/контрагентів ********** ');
          --  Створюємо функцію Історія змін параметрів рахунків/контрагентів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Історія змін параметрів рахунків/контрагентів',
                                                  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
                                                  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Історія змін параметрів рахунку\контрагента ********** ');
          --  Створюємо функцію Історія змін параметрів рахунку\контрагента
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Історія змін параметрів рахунку\контрагента',
                                                  p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+&type=\d+',
                                                  p_rolename => '' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сервіс додатку CustomerList ********** ');
          --  Створюємо функцію Сервіс додатку CustomerList
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сервіс додатку CustomerList',
                                                  p_funcname => '/barsroot/customerlist/custservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Розрахунок процентів для активних залишків
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Розрахунок процентів для активних залишків',
															  p_funcname => '/barsroot/tools/int_statement.aspx\S*',
															  p_rolename => 'BASIC_INFO' ,
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
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перегляд рахунків контрагенту
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків контрагенту',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків  (Банки)  ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків  (Банки) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків  (Банки) ',
                                                  p_funcname => '/barsroot/customerlist/default.aspx?custtype=1',
                                                  p_rolename => 'WR_CUSTLIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перегляд рахунків контрагенту
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків контрагенту',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=0&rnk=\d+(&mod=ro)*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка контрагента
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка контрагента',
															  p_funcname => '/barsroot/clientregister/default.aspx?client=\w+',
															  p_rolename => 'WR_CUSTREG' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Історія рахунку ********** ');
          --  Створюємо функцію Історія рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Історія рахунку',
                                                  p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Виписка по рахунку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Виписка по рахунку',
															  p_funcname => '/barsroot/customerlist/accextract.aspx?type=\d+&acc=\d+&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку CustomerList
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку CustomerList',
															  p_funcname => '/barsroot/customerlist/custservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/Ask.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/Ask.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/Ask.aspx',
                                                  p_funcname => '/barsroot/deposit/ask.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/cmd.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/cmd.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/cmd.aspx',
                                                  p_funcname => '/barsroot/deposit/cmd.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/Default.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/Default.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/Default.aspx',
                                                  p_funcname => '/barsroot/deposit/default.aspx\S*',
                                                  p_rolename => '' ,
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

      --  Створюємо дочірню функцію Сторінка  deposit/Ask.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Ask.aspx',
															  p_funcname => '/barsroot/deposit/ask.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositAgreementBeneficiary.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositAgreementBeneficiary.aspx',
															  p_funcname => '/barsroot/deposit/depositagreementbeneficiary.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositEditComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositEditComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositeditcomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositSelectTrustee.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositSelectTrustee.aspx',
															  p_funcname => '/barsroot/deposit/depositselecttrustee.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /barsroot/deposit/depositpartial.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /barsroot/deposit/depositpartial.aspx',
															  p_funcname => '/barsroot/deposit/depositpartial.aspx\S*',
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

      --  Створюємо дочірню функцію Сторінка  deposit/DepositAgreement.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositAgreement.aspx',
															  p_funcname => '/barsroot/deposit/depositagreement.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositCancelAgreement.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositCancelAgreement.aspx',
															  p_funcname => '/barsroot/deposit/depositcancelagreement.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositLettersPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositLettersPrint.aspx',
															  p_funcname => '/barsroot/deposit/depositlettersprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositPrintContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositPrintContract.aspx',
															  p_funcname => '/barsroot/deposit/depositprintcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositSearch.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositSearch.aspx',
															  p_funcname => '/barsroot/deposit/depositsearch.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositTermRateEdit.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositTermRateEdit.aspx',
															  p_funcname => '/barsroot/deposit/deposittermrateedit.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /deposit/dialog/DepositContractSelect.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /deposit/dialog/DepositContractSelect.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositcontractselect.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /deposit/dialog/DptField.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /deposit/dialog/DptField.aspx',
															  p_funcname => '/barsroot/deposit/dialog/dptfield.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/deposit/dialog/depositwornoutbills.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/deposit/dialog/depositwornoutbills.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositwornoutbills.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/deposit/transfer.aspx\S*
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '/barsroot/deposit/transfer.aspx\S*',
															  p_funcname => '/barsroot/deposit/transfer.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositAddSum.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositAddSum.aspx',
															  p_funcname => '/barsroot/deposit/depositaddsum.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositLetters.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositLetters.aspx',
															  p_funcname => '/barsroot/deposit/depositletters.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositPrint.aspx',
															  p_funcname => '/barsroot/deposit/depositprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositReturn.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositReturn.aspx',
															  p_funcname => '/barsroot/deposit/depositreturn.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /deposit/dialog/DepositSignDialog.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /deposit/dialog/DepositSignDialog.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositsigndialog.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositChangeFrequency
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositChangeFrequency',
															  p_funcname => '/barsroot/deposit/depositchangefrequency.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
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

      --  Створюємо дочірню функцію Сторінка deposit/cmd.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/cmd.aspx',
															  p_funcname => '/barsroot/deposit/cmd.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositAccount.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositAccount.aspx',
															  p_funcname => '/barsroot/deposit/depositaccount.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositCloseComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositCloseComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositclosecomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositSelectTT.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositSelectTT.aspx',
															  p_funcname => '/barsroot/deposit/depositselecttt.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/SearchResults.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/SearchResults.aspx',
															  p_funcname => '/barsroot/deposit/searchresults.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/SelectCountry.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/SelectCountry.aspx',
															  p_funcname => '/barsroot/deposit/selectcountry.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.Survey/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.Survey/Default.aspx',
															  p_funcname => '/barsroot/survey/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositAgreementPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositAgreementPrint.aspx',
															  p_funcname => '/barsroot/deposit/depositagreementprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositAgreementTemplate.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositAgreementTemplate.aspx',
															  p_funcname => '/barsroot/deposit/depositagreementtemplate.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositContract.aspx',
															  p_funcname => '/barsroot/deposit/depositcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /deposit/DepositFile.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /deposit/DepositFile.aspx',
															  p_funcname => '/barsroot/deposit/depositfile.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositHistory.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositHistory.aspx',
															  p_funcname => '/barsroot/deposit/deposithistory.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositPercentPay.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositPercentPay.aspx',
															  p_funcname => '/barsroot/deposit/depositpercentpay.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositPercentPayComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositPercentPayComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositpercentpaycomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositProlongation.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositProlongation.aspx',
															  p_funcname => '/barsroot/deposit/depositprolongation.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /deposit/DepositRateEdit.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /deposit/DepositRateEdit.aspx',
															  p_funcname => '/barsroot/deposit/depositrateedit.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Страница deposit/depositcommissionquest.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Страница deposit/depositcommissionquest.aspx',
															  p_funcname => '/barsroot/deposit/depositcommissionquest.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositAddSumComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositAddSumComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositaddsumcomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositClosePayIt.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositClosePayIt.aspx',
															  p_funcname => '/barsroot/deposit/depositclosepayit.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositDelete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositDelete.aspx',
															  p_funcname => '/barsroot/deposit/depositdelete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositEditAccount.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositEditAccount.aspx',
															  p_funcname => '/barsroot/deposit/depositeditaccount.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositReturnComplete.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositReturnComplete.aspx',
															  p_funcname => '/barsroot/deposit/depositreturncomplete.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /deposit/dialog/DepositContractTemplate.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /deposit/dialog/DepositContractTemplate.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositcontracttemplate.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /barsroot/deposit/depositfile_ext.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /barsroot/deposit/depositfile_ext.aspx',
															  p_funcname => '/barsroot/deposit/depositfile_ext.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
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

      --  Створюємо дочірню функцію Сторінка  deposit/DepositCardAcc.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositCardAcc.aspx',
															  p_funcname => '/barsroot/deposit/depositcardacc.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositClient.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositClient.aspx',
															  p_funcname => '/barsroot/deposit/depositclient.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка  deposit/DepositContractInfo.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/DepositContractInfo.aspx',
															  p_funcname => '/barsroot/deposit/depositcontractinfo.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /deposit/DepositFileShow.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /deposit/DepositFileShow.aspx',
															  p_funcname => '/barsroot/deposit/depositfileshow.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/DepositShowClients.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/DepositShowClients.aspx',
															  p_funcname => '/barsroot/deposit/depositshowclients.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /deposit/dialog/DepositBFRowCorrection.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /deposit/dialog/DepositBFRowCorrection.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositbfrowcorrection.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка deposit/depositbonus.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка deposit/depositbonus.aspx',
															  p_funcname => '/barsroot/deposit/depositbonus.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx',
															  p_funcname => '/barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositAccount.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositAccount.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositAccount.aspx',
                                                  p_funcname => '/barsroot/deposit/depositaccount.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositAddSum.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositAddSum.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositAddSum.aspx',
                                                  p_funcname => '/barsroot/deposit/depositaddsum.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositAddSumComplete.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositAddSumComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositAddSumComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositaddsumcomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositAgreement.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositAgreement.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositAgreement.aspx',
                                                  p_funcname => '/barsroot/deposit/depositagreement.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositAgreementBeneficiary.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositAgreementBeneficiary.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositAgreementBeneficiary.aspx',
                                                  p_funcname => '/barsroot/deposit/depositagreementbeneficiary.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositAgreementPrint.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositAgreementPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositAgreementPrint.aspx',
                                                  p_funcname => '/barsroot/deposit/depositagreementprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositAgreementTemplate.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositAgreementTemplate.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositAgreementTemplate.aspx',
                                                  p_funcname => '/barsroot/deposit/depositagreementtemplate.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/depositbonus.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/depositbonus.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/depositbonus.aspx',
                                                  p_funcname => '/barsroot/deposit/depositbonus.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositCancelAgreement.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositCancelAgreement.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositCancelAgreement.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcancelagreement.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositCardAcc.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositCardAcc.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositCardAcc.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcardacc.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1. Відкриття нового вкладу ********** ');
          --  Створюємо функцію 1. Відкриття нового вкладу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1. Відкриття нового вкладу',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 7. Інформація про вкладника ********** ');
          --  Створюємо функцію 7. Інформація про вкладника
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '7. Інформація про вкладника',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx?customer=1',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відкриття нового вкладу (зі спрощеною реєстрацією) ********** ');
          --  Створюємо функцію Відкриття нового вкладу (зі спрощеною реєстрацією)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відкриття нового вкладу (зі спрощеною реєстрацією)',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx?simplify=true',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositClient.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositClient.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositClient.aspx',
                                                  p_funcname => '/barsroot/deposit/depositclient.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositCloseComplete.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositCloseComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositCloseComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositclosecomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositClosePayIt.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositClosePayIt.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositClosePayIt.aspx',
                                                  p_funcname => '/barsroot/deposit/depositclosepayit.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Страница deposit/depositcommissionquest.aspx ********** ');
          --  Створюємо функцію Страница deposit/depositcommissionquest.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Страница deposit/depositcommissionquest.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcommissionquest.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositContract.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositContract.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositContract.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcontract.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка  deposit/DepositContractInfo.aspx ********** ');
          --  Створюємо функцію Сторінка  deposit/DepositContractInfo.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка  deposit/DepositContractInfo.aspx',
                                                  p_funcname => '/barsroot/deposit/depositcontractinfo.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositDelete.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositDelete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositDelete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositdelete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositEditAccount.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositEditAccount.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositEditAccount.aspx',
                                                  p_funcname => '/barsroot/deposit/depositeditaccount.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositEditComplete.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositEditComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositEditComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositeditcomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /deposit/DepositFile.aspx ********** ');
          --  Створюємо функцію Сторінка /deposit/DepositFile.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /deposit/DepositFile.aspx',
                                                  p_funcname => '/barsroot/deposit/depositfile.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /barsroot/deposit/depositfile_ext.aspx ********** ');
          --  Створюємо функцію Сторінка /barsroot/deposit/depositfile_ext.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /barsroot/deposit/depositfile_ext.aspx',
                                                  p_funcname => '/barsroot/deposit/depositfile_ext.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт та обробка файлів зарахувань ********** ');
          --  Створюємо функцію Імпорт та обробка файлів зарахувань
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт та обробка файлів зарахувань',
                                                  p_funcname => '/barsroot/deposit/depositfileshow.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /deposit/DepositFileShow.aspx ********** ');
          --  Створюємо функцію Сторінка /deposit/DepositFileShow.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /deposit/DepositFileShow.aspx',
                                                  p_funcname => '/barsroot/deposit/depositfileshow.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт та обробка файлів зарахувань (новий формат) ********** ');
          --  Створюємо функцію Імпорт та обробка файлів зарахувань (новий формат)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт та обробка файлів зарахувань (новий формат)',
                                                  p_funcname => '/barsroot/deposit/depositfileshow_ext.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Видалення файлів зарахувань (новий формат) ********** ');
          --  Створюємо функцію Видалення файлів зарахувань (новий формат)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Видалення файлів зарахувань (новий формат)',
                                                  p_funcname => '/barsroot/deposit/depositfileshow_ext.aspx?delete=enable',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт та обробка файлів зарахувань (новий формат) - Головний банк ********** ');
          --  Створюємо функцію Імпорт та обробка файлів зарахувань (новий формат) - Головний банк
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт та обробка файлів зарахувань (новий формат) - Головний банк',
                                                  p_funcname => '/barsroot/deposit/depositfileshow_ext.aspx?gb=true',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositHistory.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositHistory.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositHistory.aspx',
                                                  p_funcname => '/barsroot/deposit/deposithistory.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію C. Листи та повідомлення ********** ');
          --  Створюємо функцію C. Листи та повідомлення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'C. Листи та повідомлення',
                                                  p_funcname => '/barsroot/deposit/depositletters.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositLetters.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositLetters.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositLetters.aspx',
                                                  p_funcname => '/barsroot/deposit/depositletters.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositLettersPrint.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositLettersPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositLettersPrint.aspx',
                                                  p_funcname => '/barsroot/deposit/depositlettersprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /barsroot/deposit/depositpartial.aspx ********** ');
          --  Створюємо функцію Сторінка /barsroot/deposit/depositpartial.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /barsroot/deposit/depositpartial.aspx',
                                                  p_funcname => '/barsroot/deposit/depositpartial.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositPercentPay.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositPercentPay.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositPercentPay.aspx',
                                                  p_funcname => '/barsroot/deposit/depositpercentpay.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositPercentPayComplete.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositPercentPayComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositPercentPayComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositpercentpaycomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositPrint.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositPrint.aspx',
                                                  p_funcname => '/barsroot/deposit/depositprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositPrintContract.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositPrintContract.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositPrintContract.aspx',
                                                  p_funcname => '/barsroot/deposit/depositprintcontract.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositProlongation.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositProlongation.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositProlongation.aspx',
                                                  p_funcname => '/barsroot/deposit/depositprolongation.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /deposit/DepositRateEdit.aspx ********** ');
          --  Створюємо функцію Сторінка /deposit/DepositRateEdit.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /deposit/DepositRateEdit.aspx',
                                                  p_funcname => '/barsroot/deposit/depositrateedit.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositReturn.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositReturn.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositReturn.aspx',
                                                  p_funcname => '/barsroot/deposit/depositreturn.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositReturnComplete.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositReturnComplete.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositReturnComplete.aspx',
                                                  p_funcname => '/barsroot/deposit/depositreturncomplete.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2. Створення додаткових угод ********** ');
          --  Створюємо функцію 2. Створення додаткових угод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2. Створення додаткових угод',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=agreement&extended=0',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 5. Дострокове розторгнення ********** ');
          --  Створюємо функцію 5. Дострокове розторгнення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. Дострокове розторгнення',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=close&extended=0',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3. Виплата вкладу ********** ');
          --  Створюємо функцію 3. Виплата вкладу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3. Виплата вкладу',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=deposit&extended=0',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію B. Перегляд історії ********** ');
          --  Створюємо функцію B. Перегляд історії
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'B. Перегляд історії',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=history&extended=0',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4. Виплата відсотків ********** ');
          --  Створюємо функцію 4. Виплата відсотків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4. Виплата відсотків',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=percent&extended=0',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію A. Друк договорів ********** ');
          --  Створюємо функцію A. Друк договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'A. Друк договорів',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=print',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6. Пролонгація вкладів ********** ');
          --  Створюємо функцію 6. Пролонгація вкладів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6. Пролонгація вкладів',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=prolongation',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 9. Пошук договорів ********** ');
          --  Створюємо функцію 9. Пошук договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '9. Пошук договорів',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=show',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 8. Реєстрація свідоцтв про право на спадок ********** ');
          --  Створюємо функцію 8. Реєстрація свідоцтв про право на спадок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '8. Реєстрація свідоцтв про право на спадок',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx?action=testament',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка  deposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка  deposit/Default.aspx',
															  p_funcname => '/barsroot/deposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositSearch.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositSearch.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositSearch.aspx',
                                                  p_funcname => '/barsroot/deposit/depositsearch.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositSelectTrustee.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositSelectTrustee.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositSelectTrustee.aspx',
                                                  p_funcname => '/barsroot/deposit/depositselecttrustee.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositSelectTT.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositSelectTT.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositSelectTT.aspx',
                                                  p_funcname => '/barsroot/deposit/depositselecttt.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositShowClients.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositShowClients.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositShowClients.aspx',
                                                  p_funcname => '/barsroot/deposit/depositshowclients.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/DepositTermRateEdit.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/DepositTermRateEdit.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/DepositTermRateEdit.aspx',
                                                  p_funcname => '/barsroot/deposit/deposittermrateedit.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /deposit/dialog/DepositBFRowCorrection.aspx ********** ');
          --  Створюємо функцію Сторінка /deposit/dialog/DepositBFRowCorrection.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /deposit/dialog/DepositBFRowCorrection.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositbfrowcorrection.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx ********** ');
          --  Створюємо функцію Сторінка /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositbfrowcorrection_ext.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /deposit/dialog/DepositContractSelect.aspx ********** ');
          --  Створюємо функцію Сторінка /deposit/dialog/DepositContractSelect.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /deposit/dialog/DepositContractSelect.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositcontractselect.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /deposit/dialog/DepositContractTemplate.aspx ********** ');
          --  Створюємо функцію Сторінка /deposit/dialog/DepositContractTemplate.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /deposit/dialog/DepositContractTemplate.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositcontracttemplate.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /deposit/dialog/DepositSignDialog.aspx ********** ');
          --  Створюємо функцію Сторінка /deposit/dialog/DepositSignDialog.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /deposit/dialog/DepositSignDialog.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositsigndialog.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію /barsroot/deposit/dialog/depositwornoutbills.aspx ********** ');
          --  Створюємо функцію /barsroot/deposit/dialog/depositwornoutbills.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '/barsroot/deposit/dialog/depositwornoutbills.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/depositwornoutbills.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /deposit/dialog/DptField.aspx ********** ');
          --  Створюємо функцію Сторінка /deposit/dialog/DptField.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /deposit/dialog/DptField.aspx',
                                                  p_funcname => '/barsroot/deposit/dialog/dptfield.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/SearchResults.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/SearchResults.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/SearchResults.aspx',
                                                  p_funcname => '/barsroot/deposit/searchresults.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка deposit/SelectCountry.aspx ********** ');
          --  Створюємо функцію Сторінка deposit/SelectCountry.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка deposit/SelectCountry.aspx',
                                                  p_funcname => '/barsroot/deposit/selectcountry.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію /barsroot/deposit/transfer.aspx\S* ********** ');
          --  Створюємо функцію /barsroot/deposit/transfer.aspx\S*
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '/barsroot/deposit/transfer.aspx\S*',
                                                  p_funcname => '/barsroot/deposit/transfer.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Пiдпис проводок для експорту (адміністратор) ********** ');
          --  Створюємо функцію Пiдпис проводок для експорту (адміністратор)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Пiдпис проводок для експорту (адміністратор)',
                                                  p_funcname => '/barsroot/docinput/docexport.aspx?type=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вікно вводу документа c параметром qdoc ********** ');
          --  Створюємо функцію Вікно вводу документа c параметром qdoc
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вікно вводу документа c параметром qdoc',
                                                  p_funcname => '/barsroot/docinput/docinput.aspx?qdoc=\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію СЕП. Iнформацiйнi запити з параметром
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'СЕП. Iнформацiйнi запити з параметром',
															  p_funcname => '/barsroot/qdocs/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вікно вводу документів ********** ');
          --  Створюємо функцію Вікно вводу документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вікно вводу документів',
                                                  p_funcname => '/barsroot/docinput/docinput.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку DocInput
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку DocInput',
															  p_funcname => '/barsroot/docinput/docservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сервіс додатку DocInput ********** ');
          --  Створюємо функцію Сервіс додатку DocInput
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сервіс додатку DocInput',
                                                  p_funcname => '/barsroot/docinput/docservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення курсів купівлі/продажу валют ********** ');
          --  Створюємо функцію Встановлення курсів купівлі/продажу валют
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення курсів купівлі/продажу валют',
                                                  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1',
                                                  p_rolename => 'WR_RATES' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Встановлення курсів купівлі/продажу валют - без арiхву
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Встановлення курсів купівлі/продажу валют - без арiхву',
															  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1&archive=0',
															  p_rolename => 'WR_RATES' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Встановлення курсів купівлі/продажу валют - архiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Встановлення курсів купівлі/продажу валют - архiв',
															  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1&archive=1',
															  p_rolename => 'WR_RATES' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення курсів купівлі/продажу валют - без арiхву ********** ');
          --  Створюємо функцію Встановлення курсів купівлі/продажу валют - без арiхву
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення курсів купівлі/продажу валют - без арiхву',
                                                  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1&archive=0',
                                                  p_rolename => 'WR_RATES' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення курсів купівлі/продажу валют - архiв ********** ');
          --  Створюємо функцію Встановлення курсів купівлі/продажу валют - архiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення курсів купівлі/продажу валют - архiв',
                                                  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=1&archive=1',
                                                  p_rolename => 'WR_RATES' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування курсів купівлі/продажу валют ********** ');
          --  Створюємо функцію Візування курсів купівлі/продажу валют
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування курсів купівлі/продажу валют',
                                                  p_funcname => '/barsroot/docinput/setcurratesbase.aspx?mode=2',
                                                  p_rolename => 'WR_RATES' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення документів ********** ');
          --  Створюємо функцію Введення документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення документів',
                                                  p_funcname => '/barsroot/docinput/ttsinput.aspx',
                                                  p_rolename => 'WR_DOC_INPUT' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд документів відділення ********** ');
          --  Створюємо функцію Перегляд документів відділення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд документів відділення',
                                                  p_funcname => '/barsroot/documentsview/default.aspx?type=0',
                                                  p_rolename => 'WR_DOCLIST_TOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перелік отриманих документів відділення за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів відділення за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&date=\d{2}\.\d{2}\.\d{4}',
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

      --  Створюємо дочірню функцію Перегляд картки документу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд картки документу',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд документів користувача ********** ');
          --  Створюємо функцію Перегляд документів користувача
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд документів користувача',
                                                  p_funcname => '/barsroot/documentsview/default.aspx?type=1',
                                                  p_rolename => 'WR_DOCLIST_USER' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перелік усіх документів користувача  за період
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів користувача  за період',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів користувача  за період
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів користувача  за період',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
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

      --  Створюємо дочірню функцію Перелік усіх документів користувача за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів користувача за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&date=\d{2}\.\d{2}\.\d{4}',
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

      --  Створюємо дочірню функцію Перелік отриманих документів користувача за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів користувача за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд документів клієнта ********** ');
          --  Створюємо функцію Перегляд документів клієнта
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд документів клієнта',
                                                  p_funcname => '/barsroot/documentsview/default.aspx?type=2',
                                                  p_rolename => 'WR_DOCLIST_SALDO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перелік отриманих документів клієнта за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів клієнта за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=11',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=21&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів клієнта за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів клієнта за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=22&date=\d{2}\.\d{2}\.\d{4}',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік усіх документів за сьогодні ********** ');
          --  Створюємо функцію Перелік усіх документів за сьогодні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік усіх документів за сьогодні',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=11',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік отриманих документів відділення за сьогодні ********** ');
          --  Створюємо функцію Перелік отриманих документів відділення за сьогодні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік отриманих документів відділення за сьогодні',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=12',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік усіх документів за дату ********** ');
          --  Створюємо функцію Перелік усіх документів за дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік усіх документів за дату',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік отриманих документів відділення за дату ********** ');
          --  Створюємо функцію Перелік отриманих документів відділення за дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік отриманих документів відділення за дату',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік усіх документів користувача за сьогодні ********** ');
          --  Створюємо функцію Перелік усіх документів користувача за сьогодні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік усіх документів користувача за сьогодні',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=11',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік отриманих документів користувача за сьогодні ********** ');
          --  Створюємо функцію Перелік отриманих документів користувача за сьогодні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік отриманих документів користувача за сьогодні',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=12',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік усіх документів користувача за дату ********** ');
          --  Створюємо функцію Перелік усіх документів користувача за дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік усіх документів користувача за дату',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік отриманих документів користувача за дату ********** ');
          --  Створюємо функцію Перелік отриманих документів користувача за дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік отриманих документів користувача за дату',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=22&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.DocumentsView
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.DocumentsView',
															  p_funcname => '/barsroot/documentsview/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік усіх документів за сьогодні ********** ');
          --  Створюємо функцію Перелік усіх документів за сьогодні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік усіх документів за сьогодні',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=11',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік отриманих документів клієнта за сьогодні ********** ');
          --  Створюємо функцію Перелік отриманих документів клієнта за сьогодні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік отриманих документів клієнта за сьогодні',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=12',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік усіх документів за дату ********** ');
          --  Створюємо функцію Перелік усіх документів за дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік усіх документів за дату',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=21&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перелік отриманих документів клієнта за дату ********** ');
          --  Створюємо функцію Перелік отриманих документів клієнта за дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перелік отриманих документів клієнта за дату',
                                                  p_funcname => '/barsroot/documentsview/documents.aspx?type=2&par=22&date=\d{2}\.\d{2}\.\d{4}',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сервіс додатку BarsWeb.DocumentsView ********** ');
          --  Створюємо функцію Сервіс додатку BarsWeb.DocumentsView
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сервіс додатку BarsWeb.DocumentsView',
                                                  p_funcname => '/barsroot/documentsview/service.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка документу: біси ********** ');
          --  Створюємо функцію Картка документу: біси
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка документу: біси',
                                                  p_funcname => '/barsroot/documentview/bis.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка документу: бух. модель ********** ');
          --  Створюємо функцію Картка документу: бух. модель
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка документу: бух. модель',
                                                  p_funcname => '/barsroot/documentview/buhmodel.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд картки документу ********** ');
          --  Створюємо функцію Перегляд картки документу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд картки документу',
                                                  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Картка документу: основні реквізити
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка документу: основні реквізити',
															  p_funcname => '/barsroot/documentview/document.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка документу: додаткові реквізити
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка документу: додаткові реквізити',
															  p_funcname => '/barsroot/documentview/doprekv.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку documentview
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку documentview',
															  p_funcname => '/barsroot/documentview/docservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка документу: бух. модель
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка документу: бух. модель',
															  p_funcname => '/barsroot/documentview/buhmodel.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка документу: S.W.I.F.T повідомлення
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка документу: S.W.I.F.T повідомлення',
															  p_funcname => '/barsroot/documentview/swift.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка документу: віза
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка документу: віза',
															  p_funcname => '/barsroot/documentview/visa.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка документу: біси
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка документу: біси',
															  p_funcname => '/barsroot/documentview/bis.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка документу: технічні реквізити
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Картка документу: технічні реквізити',
															  p_funcname => '/barsroot/documentview/techrecv.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сервіс додатку documentview ********** ');
          --  Створюємо функцію Сервіс додатку documentview
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сервіс додатку documentview',
                                                  p_funcname => '/barsroot/documentview/docservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка документу: основні реквізити ********** ');
          --  Створюємо функцію Картка документу: основні реквізити
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка документу: основні реквізити',
                                                  p_funcname => '/barsroot/documentview/document.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка документу: додаткові реквізити ********** ');
          --  Створюємо функцію Картка документу: додаткові реквізити
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка документу: додаткові реквізити',
                                                  p_funcname => '/barsroot/documentview/doprekv.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка документу: S.W.I.F.T повідомлення ********** ');
          --  Створюємо функцію Картка документу: S.W.I.F.T повідомлення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка документу: S.W.I.F.T повідомлення',
                                                  p_funcname => '/barsroot/documentview/swift.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка документу: технічні реквізити ********** ');
          --  Створюємо функцію Картка документу: технічні реквізити
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка документу: технічні реквізити',
                                                  p_funcname => '/barsroot/documentview/techrecv.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картка документу: віза ********** ');
          --  Створюємо функцію Картка документу: віза
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картка документу: віза',
                                                  p_funcname => '/barsroot/documentview/visa.aspx?ref=\d+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт файлів платежів ********** ');
          --  Створюємо функцію Імпорт файлів платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт файлів платежів',
                                                  p_funcname => '/barsroot/exchange/default.aspx?inttt=imi&exttt=ime',
                                                  p_rolename => 'WR_IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Результат оплати файла(дочірня сторінка)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Результат оплати файла(дочірня сторінка)',
															  p_funcname => '/barsroot/exchange/success.aspx?fn=\S+&burl=\S+',
															  p_rolename => 'WR_IMPEXP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Імпорт платежів із файла(дочірня сторінка)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Імпорт платежів із файла(дочірня сторінка)',
															  p_funcname => '/barsroot/exchange/payments.aspx',
															  p_rolename => 'WR_IMPEXP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Експорт платежів в файл ********** ');
          --  Створюємо функцію Експорт платежів в файл
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Експорт платежів в файл',
                                                  p_funcname => '/barsroot/exchange/export.aspx',
                                                  p_rolename => 'WR_IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт платежів із файла(дочірня сторінка) ********** ');
          --  Створюємо функцію Імпорт платежів із файла(дочірня сторінка)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт платежів із файла(дочірня сторінка)',
                                                  p_funcname => '/barsroot/exchange/payments.aspx',
                                                  p_rolename => 'WR_IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Результат оплати файла(дочірня сторінка) ********** ');
          --  Створюємо функцію Результат оплати файла(дочірня сторінка)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Результат оплати файла(дочірня сторінка)',
                                                  p_funcname => '/barsroot/exchange/success.aspx?fn=\S+&burl=\S+',
                                                  p_rolename => 'WR_IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.InfoQuery/Default.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.InfoQuery/Default.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.InfoQuery/Default.aspx',
                                                  p_funcname => '/barsroot/infoquery/default.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /BarsWeb.InfoQuery/QueryService.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.InfoQuery/QueryService.asmx',
															  p_funcname => '/barsroot/infoquery/queryservice.asmx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.InfoQuery/QueryResult.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.InfoQuery/QueryResult.aspx',
															  p_funcname => '/barsroot/infoquery/queryresult.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію D. Виплата в іншому відділенні: Створення запитів ********** ');
          --  Створюємо функцію D. Виплата в іншому відділенні: Створення запитів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'D. Виплата в іншому відділенні: Створення запитів',
                                                  p_funcname => '/barsroot/infoquery/query.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /BarsWeb.InfoQuery/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.InfoQuery/Default.aspx',
															  p_funcname => '/barsroot/infoquery/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію E. Виплата в іншому відділенні: Перегляд запитів ********** ');
          --  Створюємо функцію E. Виплата в іншому відділенні: Перегляд запитів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'E. Виплата в іншому відділенні: Перегляд запитів',
                                                  p_funcname => '/barsroot/infoquery/queryanswer.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /BarsWeb.InfoQuery/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.InfoQuery/Default.aspx',
															  p_funcname => '/barsroot/infoquery/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.InfoQuery/QueryResult.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.InfoQuery/QueryResult.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.InfoQuery/QueryResult.aspx',
                                                  p_funcname => '/barsroot/infoquery/queryresult.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.InfoQuery/QueryService.asmx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.InfoQuery/QueryService.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.InfoQuery/QueryService.asmx',
                                                  p_funcname => '/barsroot/infoquery/queryservice.asmx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Свої транзакції поповнення рахунку за сьогодні ********** ');
          --  Створюємо функцію Свої транзакції поповнення рахунку за сьогодні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Свої транзакції поповнення рахунку за сьогодні',
                                                  p_funcname => '/barsroot/mobinet/mytrans.aspx?act=0',
                                                  p_rolename => 'MOBINET' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Свої транзакції поповнення рахунку за період ********** ');
          --  Створюємо функцію Свої транзакції поповнення рахунку за період
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Свої транзакції поповнення рахунку за період',
                                                  p_funcname => '/barsroot/mobinet/reqperiod.aspx?act=1',
                                                  p_rolename => 'MOBINET' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Тест производительности ********** ');
          --  Створюємо функцію Тест производительности
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Тест производительности',
                                                  p_funcname => '/barsroot/perfom/default.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Інформаційні запити ********** ');
          --  Створюємо функцію СЕП. Інформаційні запити
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Інформаційні запити',
                                                  p_funcname => '/barsroot/qdocs/default.aspx',
                                                  p_rolename => 'WR_QDOCS' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Діалог додатку "СЕП. Інформаційні запити"
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Діалог додатку "СЕП. Інформаційні запити"',
															  p_funcname => '/barsroot/qdocs/qdialog.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Вікно вводу документа c параметром qdoc
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Вікно вводу документа c параметром qdoc',
															  p_funcname => '/barsroot/docinput/docinput.aspx?qdoc=\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Iнформацiйнi запити з параметром ********** ');
          --  Створюємо функцію СЕП. Iнформацiйнi запити з параметром
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Iнформацiйнi запити з параметром',
                                                  p_funcname => '/barsroot/qdocs/default.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Діалог додатку "СЕП. Інформаційні запити" ********** ');
          --  Створюємо функцію Діалог додатку "СЕП. Інформаційні запити"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Діалог додатку "СЕП. Інформаційні запити"',
                                                  p_funcname => '/barsroot/qdocs/qdialog.aspx\S*',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструктор регулярних платежів (всі групи) ********** ');
          --  Створюємо функцію Конструктор регулярних платежів (всі групи)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструктор регулярних платежів (всі групи)',
                                                  p_funcname => '/barsroot/regularpay/default.aspx?grp=0',
                                                  p_rolename => 'WR_REGPAY' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виконання регулярних платежів ********** ');
          --  Створюємо функцію Виконання регулярних платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виконання регулярних платежів',
                                                  p_funcname => '/barsroot/regularpay/execpay.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Синхронізація баз ********** ');
          --  Створюємо функцію Синхронізація баз
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Синхронізація баз',
                                                  p_funcname => '/barsroot/replication/replication.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /BarsWeb.Replication/Service.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.Replication/Service.asmx',
															  p_funcname => '/barsroot/replication/service.asmx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.Replication/Service.asmx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.Replication/Service.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.Replication/Service.asmx',
                                                  p_funcname => '/barsroot/replication/service.asmx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт документів із зовнішніх задач - ФУНКЦІЯ ВЖЕ НЕ ПРАЦЮЄ ********** ');
          --  Створюємо функцію Імпорт документів із зовнішніх задач - ФУНКЦІЯ ВЖЕ НЕ ПРАЦЮЄ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт документів із зовнішніх задач - ФУНКЦІЯ ВЖЕ НЕ ПРАЦЮЄ',
                                                  p_funcname => '/barsroot/sberutls/import.aspx',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 2: КОМУНАЛЬНI ПЛАТЕЖI - ФУНКЦІЯ ВЖЕ НЕ ПРАЦЮЄ ********** ');
          --  Створюємо функцію Iмпорт 2: КОМУНАЛЬНI ПЛАТЕЖI - ФУНКЦІЯ ВЖЕ НЕ ПРАЦЮЄ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 2: КОМУНАЛЬНI ПЛАТЕЖI - ФУНКЦІЯ ВЖЕ НЕ ПРАЦЮЄ',
                                                  p_funcname => '/barsroot/sberutls/import.aspx?imptype=kp',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 1: ЛОКАЛЬНI ЗАДАЧI (ЩОДЕННИК) -ФУНКЦІЯ ВЖЕ НЕ ПРАЦЮЄ ********** ');
          --  Створюємо функцію Iмпорт 1: ЛОКАЛЬНI ЗАДАЧI (ЩОДЕННИК) -ФУНКЦІЯ ВЖЕ НЕ ПРАЦЮЄ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 1: ЛОКАЛЬНI ЗАДАЧI (ЩОДЕННИК) -ФУНКЦІЯ ВЖЕ НЕ ПРАЦЮЄ',
                                                  p_funcname => '/barsroot/sberutls/import.aspx?imptype=lz',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 4: Файли інкасації ********** ');
          --  Створюємо функцію Iмпорт 4: Файли інкасації
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 4: Файли інкасації',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Iмпорт   : Розбiр документiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт   : Розбiр документiв',
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


      --  Створюємо дочірню функцію Iмпорт   : Розбiр документiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт   : Розбiр документiв',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 1: ЛОКАЬНI ЗАДАЧI(ЩОДЕННИК) ********** ');
          --  Створюємо функцію Iмпорт 1: ЛОКАЬНI ЗАДАЧI(ЩОДЕННИК)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 1: ЛОКАЬНI ЗАДАЧI(ЩОДЕННИК)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=lz',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Iмпорт   : Розбiр документiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт   : Розбiр документiв',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3: ЗАРПЛАТНІ ФАЙЛИ ********** ');
          --  Створюємо функцію Iмпорт 3: ЗАРПЛАТНІ ФАЙЛИ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3: ЗАРПЛАТНІ ФАЙЛИ',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Iмпорт   : Розбiр документiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт   : Розбiр документiв',
															  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт   : Розбiр документiв ********** ');
          --  Створюємо функцію Iмпорт   : Розбiр документiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт   : Розбiр документiв',
                                                  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Iмпорт  : Редагування iмпортованого документа
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт  : Редагування iмпортованого документа',
															  p_funcname => '/barsroot/sberutls/importproced.aspx',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт   : Розбiр всiх вiдкладених документiв ********** ');
          --  Створюємо функцію Імпорт   : Розбiр всiх вiдкладених документiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт   : Розбiр всiх вiдкладених документiв',
                                                  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=2',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт  : Редагування iмпортованого документа ********** ');
          --  Створюємо функцію Iмпорт  : Редагування iмпортованого документа
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт  : Редагування iмпортованого документа',
                                                  p_funcname => '/barsroot/sberutls/importproced.aspx',
                                                  p_rolename => 'WR_XMLIMP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /barsroot/socialdeposit/addsum.aspx ********** ');
          --  Створюємо функцію Сторінка /barsroot/socialdeposit/addsum.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /barsroot/socialdeposit/addsum.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/addsum.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відкриття договору ********** ');
          --  Створюємо функцію Відкриття договору
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відкриття договору',
                                                  p_funcname => '/barsroot/socialdeposit/default.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositAgreement.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositAgreement.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositagreement.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/Default.aspx',
															  p_funcname => '/barsroot/socialdeposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/SocialServices.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/SocialServices.asmx',
															  p_funcname => '/barsroot/socialdeposit/socialservices.asmx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcancelagreement.aspx\S*',
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

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositagreementprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositShowClients.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositShowClients.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositshowclients.aspx\S*',
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

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/SearchResults.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/SearchResults.aspx',
															  p_funcname => '/barsroot/socialdeposit/searchresults.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx',
															  p_funcname => '/barsroot/socialdeposit/dialogs/depositcontractselect.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositContract.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositPrint.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositprint.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositagreementtemplate.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositContractTemplate.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositContractTemplate.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcontracttemplate.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositPrintContract.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositPrintContract.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositprintcontract.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx',
															  p_funcname => '/barsroot/socialdeposit/dialogs/selectcountry.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositselecttrustee.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/PrintButton.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/PrintButton.aspx',
															  p_funcname => '/barsroot/socialdeposit/printbutton.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відкриття нового соц. договору (зі спрощеною реєстрацією) ********** ');
          --  Створюємо функцію Відкриття нового соц. договору (зі спрощеною реєстрацією)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відкриття нового соц. договору (зі спрощеною реєстрацією)',
                                                  p_funcname => '/barsroot/socialdeposit/default.aspx?simplify=true',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/Default.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/Default.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/Default.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/default.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /barsroot/socialdeposit/addsum.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /barsroot/socialdeposit/addsum.aspx',
															  p_funcname => '/barsroot/socialdeposit/addsum.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /barsroot/socialdeposit/depositcoowner.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /barsroot/socialdeposit/depositcoowner.aspx',
															  p_funcname => '/barsroot/socialdeposit/depositcoowner.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /barsroot/socialdeposit/transfer.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /barsroot/socialdeposit/transfer.aspx',
															  p_funcname => '/barsroot/socialdeposit/transfer.aspx\S*',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositAgreement.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositAgreement.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositAgreement.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositagreement.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositAgreementPrint.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositagreementprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositAgreementTemplate.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositagreementtemplate.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositCancelAgreement.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositcancelagreement.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositContract.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositContract.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositContract.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositcontract.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositContractTemplate.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositContractTemplate.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositContractTemplate.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositcontracttemplate.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /barsroot/socialdeposit/depositcoowner.aspx ********** ');
          --  Створюємо функцію Сторінка /barsroot/socialdeposit/depositcoowner.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /barsroot/socialdeposit/depositcoowner.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositcoowner.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositPrint.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositPrint.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositprint.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositPrintContract.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositPrintContract.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositPrintContract.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositprintcontract.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель договорів пенсіонерів і безробітних ********** ');
          --  Створюємо функцію Портфель договорів пенсіонерів і безробітних
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель договорів пенсіонерів і безробітних',
                                                  p_funcname => '/barsroot/socialdeposit/depositsearch.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Відкриття договору
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Відкриття договору',
															  p_funcname => '/barsroot/socialdeposit/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поповнення ********** ');
          --  Створюємо функцію Поповнення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поповнення',
                                                  p_funcname => '/barsroot/socialdeposit/depositsearch.aspx?action=add',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/Default.aspx',
															  p_funcname => '/barsroot/socialdeposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Закриття договорів пенсіонерів і безробітних ********** ');
          --  Створюємо функцію Закриття договорів пенсіонерів і безробітних
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Закриття договорів пенсіонерів і безробітних',
                                                  p_funcname => '/barsroot/socialdeposit/depositsearch.aspx?action=close',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Відкриття договору
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Відкриття договору',
															  p_funcname => '/barsroot/socialdeposit/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виплата коштів ********** ');
          --  Створюємо функцію Виплата коштів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виплата коштів',
                                                  p_funcname => '/barsroot/socialdeposit/depositsearch.aspx?action=pay',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /BarsWeb.SocialDeposit/Default.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.SocialDeposit/Default.aspx',
															  p_funcname => '/barsroot/socialdeposit/default.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositSelectTrustee.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositselecttrustee.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositShowClients.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/DepositShowClients.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/DepositShowClients.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/depositshowclients.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/Dialogs/DepositContractSelect.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/dialogs/depositcontractselect.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/Dialogs/SelectCountry.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/dialogs/selectcountry.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/PrintButton.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/PrintButton.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/PrintButton.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/printbutton.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/SearchResults.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/SearchResults.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/SearchResults.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/searchresults.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідник органів соціального захисту ********** ');
          --  Створюємо функцію Довідник органів соціального захисту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідник органів соціального захисту',
                                                  p_funcname => '/barsroot/socialdeposit/socialagencies.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.SocialDeposit/SocialServices.asmx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.SocialDeposit/SocialServices.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.SocialDeposit/SocialServices.asmx',
                                                  p_funcname => '/barsroot/socialdeposit/socialservices.asmx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /barsroot/socialdeposit/transfer.aspx ********** ');
          --  Створюємо функцію Сторінка /barsroot/socialdeposit/transfer.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /barsroot/socialdeposit/transfer.aspx',
                                                  p_funcname => '/barsroot/socialdeposit/transfer.aspx\S*',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.Survey/Default.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.Survey/Default.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.Survey/Default.aspx',
                                                  p_funcname => '/barsroot/survey/default.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /BarsWeb.Survey/SurveyService.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.Survey/SurveyService.asmx',
															  p_funcname => '/barsroot/survey/surveyservice.asmx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.Survey/Survey.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.Survey/Survey.aspx',
															  p_funcname => '/barsroot/survey/survey.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.Survey/Survey.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.Survey/Survey.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.Survey/Survey.aspx',
                                                  p_funcname => '/barsroot/survey/survey.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.Survey/SurveyService.asmx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.Survey/SurveyService.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.Survey/SurveyService.asmx',
                                                  p_funcname => '/barsroot/survey/surveyservice.asmx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx',
                                                  p_funcname => '/barsroot/techaccounts/addsum.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель технічних рахунків підрозділу ********** ');
          --  Створюємо функцію Портфель технічних рахунків підрозділу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель технічних рахунків підрозділу',
                                                  p_funcname => '/barsroot/techaccounts/default.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx',
															  p_funcname => '/barsroot/techaccounts/depositcoowner.aspx\S*',
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

      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx',
															  p_funcname => '/barsroot/techaccounts/addsum.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx',
															  p_funcname => '/barsroot/techaccounts/documentprint.aspx\S*',
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

      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx',
															  p_funcname => '/barsroot/techaccounts/documentform.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx',
															  p_funcname => '/barsroot/techaccounts/deposittechacc.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поповнення технічного рахунку ********** ');
          --  Створюємо функцію Поповнення технічного рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поповнення технічного рахунку',
                                                  p_funcname => '/barsroot/techaccounts/default.aspx?action=add',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Портфель технічних рахунків підрозділу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Портфель технічних рахунків підрозділу',
															  p_funcname => '/barsroot/techaccounts/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Закриття технічного рахунку ********** ');
          --  Створюємо функцію Закриття технічного рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Закриття технічного рахунку',
                                                  p_funcname => '/barsroot/techaccounts/default.aspx?action=close',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Портфель технічних рахунків підрозділу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Портфель технічних рахунків підрозділу',
															  p_funcname => '/barsroot/techaccounts/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/DepositCoowner.aspx',
                                                  p_funcname => '/barsroot/techaccounts/depositcoowner.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відкриття технічного рахунку ********** ');
          --  Створюємо функцію Відкриття технічного рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відкриття технічного рахунку',
                                                  p_funcname => '/barsroot/techaccounts/depositsearch.aspx',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Портфель технічних рахунків підрозділу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Портфель технічних рахунків підрозділу',
															  p_funcname => '/barsroot/techaccounts/default.aspx',
															  p_rolename => 'DPT_ROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/DepositTechAcc.aspx',
                                                  p_funcname => '/barsroot/techaccounts/deposittechacc.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentForm.aspx',
                                                  p_funcname => '/barsroot/techaccounts/documentform.aspx\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx ********** ');
          --  Створюємо функцію Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сторінка /BarsWeb.TechAccounts/DocumentPrint.aspx',
                                                  p_funcname => '/barsroot/techaccounts/documentprint.aspx\S*',
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


      --  Створюємо дочірню функцію Веб-сервис /barsroot/udeposit/dptuservice.asmx
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Веб-сервис /barsroot/udeposit/dptuservice.asmx',
															  p_funcname => '/barsroot/udeposit/dptuservice.asmx',
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

      --  Створюємо дочірню функцію Перегляд рахунків за депозитним договором
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд рахунків за депозитним договором',
															  p_funcname => '/barsroot/customerlist/custacc.aspx?type=4&rnk=\d+&acc=\d+\,\d+',
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

      --  Створюємо дочірню функцію Відкриття депозитного договору ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Відкриття депозитного договору ЮО',
															  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&vidd=\d+&vidname=\S*&type=\d&dpu_gen=\d*\S*',
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

      --  Створюємо дочірню функцію Стан депозитного договору ЮО
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Стан депозитного договору ЮО',
															  p_funcname => '/barsroot/udeposit/dptdealstate.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+\S*',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Параметри депозитного договору ЮО ********** ');
          --  Створюємо функцію Параметри депозитного договору ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Параметри депозитного договору ЮО',
                                                  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+&dpu_ad=\d*\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відкриття депозитного договору ЮО ********** ');
          --  Створюємо функцію Відкриття депозитного договору ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відкриття депозитного договору ЮО',
                                                  p_funcname => '/barsroot/udeposit/dptdealparams.aspx?mode=\d&dpu_id=\d+&vidd=\d+&vidname=\S*&type=\d&dpu_gen=\d*\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стан депозитного договору ЮО ********** ');
          --  Створюємо функцію Стан депозитного договору ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Стан депозитного договору ЮО',
                                                  p_funcname => '/barsroot/udeposit/dptdealstate.aspx?mode=\d&dpu_id=\d+&type=\d&dpu_gen=\d+\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Веб-сервис /barsroot/udeposit/dptuservice.asmx ********** ');
          --  Створюємо функцію Веб-сервис /barsroot/udeposit/dptuservice.asmx
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Веб-сервис /barsroot/udeposit/dptuservice.asmx',
                                                  p_funcname => '/barsroot/udeposit/dptuservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Фін. реквізити(перегляд) ********** ');
          --  Створюємо функцію Атрибути рахунку: Фін. реквізити(перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Фін. реквізити(перегляд)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_financial.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Фін. реквізити (редагування) ********** ');
          --  Створюємо функцію Атрибути рахунку: Фін. реквізити (редагування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Фін. реквізити (редагування)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_financial.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Осн. реквізити(перегляд) ********** ');
          --  Створюємо функцію Атрибути рахунку: Осн. реквізити(перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Осн. реквізити(перегляд)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_general.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Осн. реквізити (редагування) ********** ');
          --  Створюємо функцію Атрибути рахунку: Осн. реквізити (редагування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Осн. реквізити (редагування)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_general.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Відсотки (перегляд) ********** ');
          --  Створюємо функцію Атрибути рахунку: Відсотки (перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Відсотки (перегляд)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_percent.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Проценти (редагування) ********** ');
          --  Створюємо функцію Атрибути рахунку: Проценти (редагування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Проценти (редагування)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_percent.aspx?acc=\d+&accessmode=1\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Тарифи(перегляд) ********** ');
          --  Створюємо функцію Атрибути рахунку: Тарифи(перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Тарифи(перегляд)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_rates.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Тарифи (редагування) ********** ');
          --  Створюємо функцію Атрибути рахунку: Тарифи (редагування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Тарифи (редагування)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_rates.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Права доступу (перегляд) ********** ');
          --  Створюємо функцію Атрибути рахунку: Права доступу (перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Права доступу (перегляд)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_rights.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Права доступу (редагування) ********** ');
          --  Створюємо функцію Атрибути рахунку: Права доступу (редагування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Права доступу (редагування)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_rights.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Графік подій(перегляд) ********** ');
          --  Створюємо функцію Атрибути рахунку: Графік подій(перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Графік подій(перегляд)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_sob.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Графік подій (редагування) ********** ');
          --  Створюємо функцію Атрибути рахунку: Графік подій (редагування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Графік подій (редагування)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_sob.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Спецпараметри(перегляд) ********** ');
          --  Створюємо функцію Атрибути рахунку: Спецпараметри(перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Спецпараметри(перегляд)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_sp.aspx?acc=\d+&accessmode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Атрибути рахунку: Спецпараметри (редагування) ********** ');
          --  Створюємо функцію Атрибути рахунку: Спецпараметри (редагування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Атрибути рахунку: Спецпараметри (редагування)',
                                                  p_funcname => '/barsroot/viewaccounts/acc_sp.aspx?acc=\d+&accessmode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд атрибутів рахунку ********** ');
          --  Створюємо функцію Перегляд атрибутів рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд атрибутів рахунку',
                                                  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
                                                  p_rolename => 'WR_VIEWACC' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Список валют
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Список валют',
															  p_funcname => '/barsroot/viewaccounts/listvaluts.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Тарифи(перегляд)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Тарифи(перегляд)',
															  p_funcname => '/barsroot/viewaccounts/acc_rates.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію План рахунків
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'План рахунків',
															  p_funcname => '/barsroot/viewaccounts/listnbs.aspx?rnk=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Друк
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк',
															  p_funcname => '/barsroot/viewaccounts/print.aspx?acc=\d+&id=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Відсотки (перегляд)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Відсотки (перегляд)',
															  p_funcname => '/barsroot/viewaccounts/acc_percent.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Графік подій(перегляд)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Графік подій(перегляд)',
															  p_funcname => '/barsroot/viewaccounts/acc_sob.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Права доступу (перегляд)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Права доступу (перегляд)',
															  p_funcname => '/barsroot/viewaccounts/acc_rights.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Фін. реквізити(перегляд)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Фін. реквізити(перегляд)',
															  p_funcname => '/barsroot/viewaccounts/acc_financial.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Спецпараметри(перегляд)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Спецпараметри(перегляд)',
															  p_funcname => '/barsroot/viewaccounts/acc_sp.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Осн. реквізити(перегляд)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Осн. реквізити(перегляд)',
															  p_funcname => '/barsroot/viewaccounts/acc_general.aspx?acc=\d+&accessmode=0',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку ViewAccounts
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку ViewAccounts',
															  p_funcname => '/barsroot/viewaccounts/accservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування атрибутів рахунку ********** ');
          --  Створюємо функцію Редагування атрибутів рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування атрибутів рахунку',
                                                  p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=1\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Список валют
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Список валют',
															  p_funcname => '/barsroot/viewaccounts/listvaluts.aspx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Фін. реквізити (редагування)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Фін. реквізити (редагування)',
															  p_funcname => '/barsroot/viewaccounts/acc_financial.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Спецпараметри (редагування)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Спецпараметри (редагування)',
															  p_funcname => '/barsroot/viewaccounts/acc_sp.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію План рахунків
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'План рахунків',
															  p_funcname => '/barsroot/viewaccounts/listnbs.aspx?rnk=\d*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Друк
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк',
															  p_funcname => '/barsroot/viewaccounts/print.aspx?acc=\d+&id=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Тарифи (редагування)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Тарифи (редагування)',
															  p_funcname => '/barsroot/viewaccounts/acc_rates.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Проценти (редагування)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Проценти (редагування)',
															  p_funcname => '/barsroot/viewaccounts/acc_percent.aspx?acc=\d+&accessmode=1\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Графік подій (редагування)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Графік подій (редагування)',
															  p_funcname => '/barsroot/viewaccounts/acc_sob.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Осн. реквізити (редагування)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Осн. реквізити (редагування)',
															  p_funcname => '/barsroot/viewaccounts/acc_general.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку ViewAccounts
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку ViewAccounts',
															  p_funcname => '/barsroot/viewaccounts/accservice.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Атрибути рахунку: Права доступу (редагування)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Атрибути рахунку: Права доступу (редагування)',
															  p_funcname => '/barsroot/viewaccounts/acc_rights.aspx?acc=\d+&accessmode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сервіс додатку ViewAccounts ********** ');
          --  Створюємо функцію Сервіс додатку ViewAccounts
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сервіс додатку ViewAccounts',
                                                  p_funcname => '/barsroot/viewaccounts/accservice.asmx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію План рахунків ********** ');
          --  Створюємо функцію План рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'План рахунків',
                                                  p_funcname => '/barsroot/viewaccounts/listnbs.aspx?rnk=\d*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Список валют ********** ');
          --  Створюємо функцію Список валют
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Список валют',
                                                  p_funcname => '/barsroot/viewaccounts/listvaluts.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк ********** ');
          --  Створюємо функцію Друк
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк',
                                                  p_funcname => '/barsroot/viewaccounts/print.aspx?acc=\d+&id=\w+',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Підтвердження прав користувачів ********** ');
          --  Створюємо функцію Підтвердження прав користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Підтвердження прав користувачів',
                                                  p_funcname => 'ApproveUserAccess()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП : Разное ********** ');
          --  Створюємо функцію КП : Разное
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП : Разное',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 0, 701, 0 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ЮЛ: Кред + Бухг + Зал ********** ');
          --  Створюємо функцію КП ЮЛ: Кред + Бухг + Зал
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ЮЛ: Кред + Бухг + Зал',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 02, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Кред + Бухг + Зал ********** ');
          --  Створюємо функцію КП ФЛ: Кред + Бухг + Зал
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Кред + Бухг + Зал',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 03, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ЮЛ: Кредитчик ********** ');
          --  Створюємо функцію КП ЮЛ: Кредитчик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ЮЛ: Кредитчик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 12, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Кредитчик ********** ');
          --  Створюємо функцію КП ФЛ: Кредитчик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Кредитчик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 13, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ЮЛ: Бухгалтер ********** ');
          --  Створюємо функцію КП ЮЛ: Бухгалтер
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ЮЛ: Бухгалтер',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 22, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Бухгалтер ********** ');
          --  Створюємо функцію КП ФЛ: Бухгалтер
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Бухгалтер',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 23, 0, 5)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ЮЛ: Залоговик ********** ');
          --  Створюємо функцію КП ЮЛ: Залоговик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ЮЛ: Залоговик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 32, 0, 3)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Залоговик ********** ');
          --  Створюємо функцію КП ФЛ: Залоговик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Залоговик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 33, 0, 5)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Авторизація ********** ');
          --  Створюємо функцію КП ФЛ: Авторизація
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Авторизація',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 83, 0,77  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Аналіз ********** ');
          --  Створюємо функцію КП ФЛ: Аналіз
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Аналіз',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 93, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ГАР ФЛ: Кред + Бухг + Зал ********** ');
          --  Створюємо функцію ГАР ФЛ: Кред + Бухг + Зал
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ГАР ФЛ: Кред + Бухг + Зал',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 95, 0, 0 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ГАР ФЛ: Кредитчик ********** ');
          --  Створюємо функцію ГАР ФЛ: Кредитчик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ГАР ФЛ: Кредитчик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 95, 1, 0 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ГАР ФЛ: Залоговик ********** ');
          --  Створюємо функцію ГАР ФЛ: Залоговик
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ГАР ФЛ: Залоговик',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 95, 3, 0 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Аналіз ГП% ********** ');
          --  Створюємо функцію КП ФЛ: Аналіз ГП%
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Аналіз ГП%',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 97, 03, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Аналіз ГПК ********** ');
          --  Створюємо функцію КП ФЛ: Аналіз ГПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Аналіз ГПК',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 98, 03, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Аналіз (Петроком) ********** ');
          --  Створюємо функцію КП ФЛ: Аналіз (Петроком)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Аналіз (Петроком)',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 99, 00, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Забезпечення <-> Рискові активи ********** ');
          --  Створюємо функцію Забезпечення <-> Рискові активи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Забезпечення <-> Рискові активи',
                                                  p_funcname => 'CC_INKRE(hWndMDI, NUMBER_Null , 0, 0) ',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення  КД  згідно шаблона ********** ');
          --  Створюємо функцію Введення  КД  згідно шаблона
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення  КД  згідно шаблона',
                                                  p_funcname => 'CC_INKRE(hWndMDI, NUMBER_Null, 298, NUMBER_Null )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок резерву (без проводок) ********** ');
          --  Створюємо функцію Розрахунок резерву (без проводок)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок резерву (без проводок)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,101,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок резерву (Відсотки) ********** ');
          --  Створюємо функцію Розрахунок резерву (Відсотки)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок резерву (Відсотки)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,101,1820,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок резерву (Фіз. особи) ********** ');
          --  Створюємо функцію Розрахунок резерву (Фіз. особи)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок резерву (Фіз. особи)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,101,6901,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок резерву (Юр. особи) ********** ');
          --  Створюємо функцію Розрахунок резерву (Юр. особи)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок резерву (Юр. особи)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,101,6902,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок резерву  (з проводками)  ********** ');
          --  Створюємо функцію Розрахунок резерву  (з проводками) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок резерву  (з проводками) ',
                                                  p_funcname => 'CC_INKRE(hWndMDI,102,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок-2 резерву (з проводками) ********** ');
          --  Створюємо функцію Розрахунок-2 резерву (з проводками)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок-2 резерву (з проводками)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,104,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок резерву - Приріст ********** ');
          --  Створюємо функцію Розрахунок резерву - Приріст
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок резерву - Приріст',
                                                  p_funcname => 'CC_INKRE(hWndMDI,106,0,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Договори зі страховими компаніями (СК) ********** ');
          --  Створюємо функцію Договори зі страховими компаніями (СК)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Договори зі страховими компаніями (СК)',
                                                  p_funcname => 'CC_INKRE(hWndMDI,3,297,0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiн.стан ТЕСТ-позичальника ЮО ( Свої ) ********** ');
          --  Створюємо функцію Фiн.стан ТЕСТ-позичальника ЮО ( Свої )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiн.стан ТЕСТ-позичальника ЮО ( Свої )',
                                                  p_funcname => 'DEPO( hWndMDI, 60, 11 )',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiн.стан ТЕСТ-позичальника ФО ( Свої ) ********** ');
          --  Створюємо функцію Фiн.стан ТЕСТ-позичальника ФО ( Свої )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiн.стан ТЕСТ-позичальника ФО ( Свої )',
                                                  p_funcname => 'DEPO( hWndMDI, 63, 11 )',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiнансовий стан позичальника ЮО ********** ');
          --  Створюємо функцію Фiнансовий стан позичальника ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiнансовий стан позичальника ЮО',
                                                  p_funcname => 'DEPO(hWndMDI,60,0)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiнансовий стан ТЕСТ-позичальника ЮО ********** ');
          --  Створюємо функцію Фiнансовий стан ТЕСТ-позичальника ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiнансовий стан ТЕСТ-позичальника ЮО',
                                                  p_funcname => 'DEPO(hWndMDI,60,1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiнансовий стан позичальника ФО ********** ');
          --  Створюємо функцію Фiнансовий стан позичальника ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiнансовий стан позичальника ФО',
                                                  p_funcname => 'DEPO(hWndMDI,63, 0 )',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiнансовий стан ТЕСТ-позичальника ФО ********** ');
          --  Створюємо функцію Фiнансовий стан ТЕСТ-позичальника ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiнансовий стан ТЕСТ-позичальника ФО',
                                                  p_funcname => 'DEPO(hWndMDI,63,1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Стан платежів ********** ');
          --  Створюємо функцію СЕП. Стан платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Стан платежів',
                                                  p_funcname => 'DOC_PROC(TRUE)',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Архів документів ********** ');
          --  Створюємо функцію СЕП. Архів документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Архів документів',
                                                  p_funcname => 'DocViewListArc(hWndMDI,'''', '''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи по рахунках відділення ********** ');
          --  Створюємо функцію Документи по рахунках відділення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи по рахунках відділення',
                                                  p_funcname => 'DocViewListInt(hWndMDI,'' a.ref in (select p.ref from opldok p, accounts a where a.acc=p.acc and a.TOBO=tobopack.GetTobo)'', ''Документи по рах. відділення'' )',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Документи, підготовлені для ПЦ ********** ');
          --  Створюємо функцію ПЦ. Документи, підготовлені для ПЦ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Документи, підготовлені для ПЦ',
                                                  p_funcname => 'DocViewListInt(hWndMDI,'' a.ref in (select ref from pkk_que where sos=0) and a.sos>=0'', ''Документи для ПЦ'' )',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи з датою валютування, що настала, але не оплачені на старті ********** ');
          --  Створюємо функцію Документи з датою валютування, що настала, але не оплачені на старті
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи з датою валютування, що настала, але не оплачені на старті',
                                                  p_funcname => 'DocViewListPayLog( hWndMDI, "", "" )',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити, що мають прострочку на ЗАДАНУ дату ********** ');
          --  Створюємо функцію Кредити, що мають прострочку на ЗАДАНУ дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити, що мають прострочку на ЗАДАНУ дату',
                                                  p_funcname => 'ExportCatQuery(10,'''',8,'''',TRUE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт АСВО6.3 --> АБС БАРС (сверка 1) ********** ');
          --  Створюємо функцію Импорт АСВО6.3 --> АБС БАРС (сверка 1)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт АСВО6.3 --> АБС БАРС (сверка 1)',
                                                  p_funcname => 'ExportCatQuery(3082,'''',8,'''',FALSE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування  Cddmm.dbf  файлу для ПФУ  ********** ');
          --  Створюємо функцію Формування  Cddmm.dbf  файлу для ПФУ 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування  Cddmm.dbf  файлу для ПФУ ',
                                                  p_funcname => 'ExportCatQuery(55,'''',1,'''',TRUE)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Проводки по стартовій ПЕНІ ********** ');
          --  Створюємо функцію Проводки по стартовій ПЕНІ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Проводки по стартовій ПЕНІ',
                                                  p_funcname => 'F1_Select ( 12, " PAY_SN8 ( 2 ) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Finis/Реал.Курс.Різниця (по Щоденникам) ********** ');
          --  Створюємо функцію Finis/Реал.Курс.Різниця (по Щоденникам)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Finis/Реал.Курс.Різниця (по Щоденникам)',
                                                  p_funcname => 'F1_Select ( 12, " PVP_RRR ( DAT ) " )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прием курсов НБУ(#99) + ЦА(KURSK___.val) ********** ');
          --  Створюємо функцію Прием курсов НБУ(#99) + ЦА(KURSK___.val)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прием курсов НБУ(#99) + ЦА(KURSK___.val)',
                                                  p_funcname => 'F1_Select ( 99, "")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Деп.Портф.  (Формування ) ********** ');
          --  Створюємо функцію Аудит OB22 в Деп.Портф.  (Формування )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Деп.Портф.  (Формування )',
                                                  p_funcname => 'F1_Select( 12, " P_AUD_DPT ( 0, ''/'') " ) ',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F/ПЦ: Погашення рахунків тех. overdraft`а 2200 ********** ');
          --  Створюємо функцію F/ПЦ: Погашення рахунків тех. overdraft`а 2200
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/ПЦ: Погашення рахунків тех. overdraft`а 2200',
                                                  p_funcname => 'F1_Select( 12, ''PK_OVR(2200, DAT)'' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F/ПЦ: Розгортання невикорист. лімітів на рахунках 9 класу ********** ');
          --  Створюємо функцію F/ПЦ: Розгортання невикорист. лімітів на рахунках 9 класу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/ПЦ: Розгортання невикорист. лімітів на рахунках 9 класу',
                                                  p_funcname => 'F1_Select( 12, ''PK_OVR(9, DAT)'' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Журнал задач(виконання) ********** ');
          --  Створюємо функцію Журнал задач(виконання)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Журнал задач(виконання)',
                                                  p_funcname => 'F1_Select(101,'''')',
                                                  p_rolename => 'TASK_LIST' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз клієнтів (оперативний розрахунок) ********** ');
          --  Створюємо функцію Аналіз клієнтів (оперативний розрахунок)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз клієнтів (оперативний розрахунок)',
                                                  p_funcname => 'F1_Select(115,"")',
                                                  p_rolename => 'AN_KL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз клієнтів (з архіву) ********** ');
          --  Створюємо функцію Аналіз клієнтів (з архіву)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз клієнтів (з архіву)',
                                                  p_funcname => 'F1_Select(116,"")',
                                                  p_rolename => 'AN_KL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F0: Авто-разбір рахунків погашення SG ********** ');
          --  Створюємо функцію КП F0: Авто-разбір рахунків погашення SG
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F0: Авто-разбір рахунків погашення SG',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASG ( 0, 1)"  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S. Авто-просрочка рахунків боргу SS -  ЮЛ ********** ');
          --  Створюємо функцію S. Авто-просрочка рахунків боргу SS -  ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S. Авто-просрочка рахунків боргу SS -  ЮЛ',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( -1, 1 ) "  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S. Авто-просрочка рахунків боргу SS -  ФЛ ********** ');
          --  Створюємо функцію S. Авто-просрочка рахунків боргу SS -  ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S. Авто-просрочка рахунків боргу SS -  ФЛ',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( -11, 1 ) "  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #1) КП S2: Авто-просрочка рахунків боргу SS ********** ');
          --  Створюємо функцію #1) КП S2: Авто-просрочка рахунків боргу SS
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#1) КП S2: Авто-просрочка рахунків боргу SS',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( 0, 1 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F1: Вирівнювання залишків на 9129 по КП ********** ');
          --  Створюємо функцію КП F1: Вирівнювання залишків на 9129 по КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F1: Вирівнювання залишків на 9129 по КП',
                                                  p_funcname => 'F1_Select(12, " cck.CC_9129( DAT, 0, 0 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F/Невикористаний овердрафт (DK-9129) ********** ');
          --  Створюємо функцію F/Невикористаний овердрафт (DK-9129)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/Невикористаний овердрафт (DK-9129)',
                                                  p_funcname => 'F1_Select(12, "P_OVR8z(91, 0)" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Погашення заборг.за Розрах.обслуг. (2600 - 3570) ********** ');
          --  Створюємо функцію Погашення заборг.за Розрах.обслуг. (2600 - 3570)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Погашення заборг.за Розрах.обслуг. (2600 - 3570)',
                                                  p_funcname => 'F1_Select(12, "RKO_FINIS(DAT)") ',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #0) КП S1: Установить лим.по графику ********** ');
          --  Створюємо функцію #0) КП S1: Установить лим.по графику
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#0) КП S1: Установить лим.по графику',
                                                  p_funcname => 'F1_Select(12, "cck.CC_DAY_LIM ( DAT , 0) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Відкриття/погашення овердрафту ********** ');
          --  Створюємо функцію ПЦ. Відкриття/погашення овердрафту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Відкриття/погашення овердрафту',
                                                  p_funcname => 'F1_Select(12, ''OBPC.PK_OVR(2)'')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Врегулювання невик. лімітів в 9 класі ********** ');
          --  Створюємо функцію ПЦ. Врегулювання невик. лімітів в 9 класі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Врегулювання невик. лімітів в 9 класі',
                                                  p_funcname => 'F1_Select(12, ''OBPC.PK_OVR(9)'')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Стягнення % в останiй день  ********** ');
          --  Створюємо функцію OVR:  Стягнення % в останiй день 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Стягнення % в останiй день ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(1,0,0,0)'' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Стягнення % по просрочцi  ********** ');
          --  Створюємо функцію OVR:  Стягнення % по просрочцi 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Стягнення % по просрочцi ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(11,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Перенесення на просрочку  ********** ');
          --  Створюємо функцію OVR:  Перенесення на просрочку 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Перенесення на просрочку ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(2,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Погасити максимум % ********** ');
          --  Створюємо функцію OVR:  Погасити максимум %
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Погасити максимум %',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(3,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Погашення усiх боргiв ********** ');
          --  Створюємо функцію OVR:  Погашення усiх боргiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Погашення усiх боргiв',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(33,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Погашення просрочки   ********** ');
          --  Створюємо функцію OVR:  Погашення просрочки  
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Погашення просрочки  ',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(4,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Нарах.комiсiї за одноденний овердрафт ********** ');
          --  Створюємо функцію OVR:  Нарах.комiсiї за одноденний овердрафт
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Нарах.комiсiї за одноденний овердрафт',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(62,0,0,0)''  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Невикористаний овердрафт 9129 ********** ');
          --  Створюємо функцію OVR:  Невикористаний овердрафт 9129
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Невикористаний овердрафт 9129',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(91,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Перенесення просроченої заборг. на сумнiвну ********** ');
          --  Створюємо функцію OVR:  Перенесення просроченої заборг. на сумнiвну
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Перенесення просроченої заборг. на сумнiвну',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(96,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Закриття коригуючих проводок 6,7 кл. за грудень   ********** ');
          --  Створюємо функцію Закриття коригуючих проводок 6,7 кл. за грудень  
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Закриття коригуючих проводок 6,7 кл. за грудень  ',
                                                  p_funcname => 'F1_Select(12, ''Perek_kp( 0)''  ) ',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття рахунків 6,7 класів на (5040/5041)  - закриття фін. року  ********** ');
          --  Створюємо функцію Перекриття рахунків 6,7 класів на (5040/5041)  - закриття фін. року 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття рахунків 6,7 класів на (5040/5041)  - закриття фін. року ',
                                                  p_funcname => 'F1_Select(12, ''Perekgod( 0)''  ) ',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Чискта журналiв ЗДК ********** ');
          --  Створюємо функцію Чискта журналiв ЗДК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Чискта журналiв ЗДК',
                                                  p_funcname => 'F1_Select(12, ''bars_cash.clear_cash_journals(DAT-3)'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Чистка журналів імпорту ********** ');
          --  Створюємо функцію Чистка журналів імпорту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Чистка журналів імпорту',
                                                  p_funcname => 'F1_Select(12, ''bars_xmlklb_imp.clear_import_journals(DAT)'')',
                                                  p_rolename => 'FLSTAPI' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Заключнi виписки на офф. вiддiлення ********** ');
          --  Створюємо функцію Заключнi виписки на офф. вiддiлення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Заключнi виписки на офф. вiддiлення',
                                                  p_funcname => 'F1_Select(12, ''bars_xmlklb_ref.postvp_for_all(DAT)'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Чискта журналiв ОФФЛАЙН ********** ');
          --  Створюємо функцію Чискта журналiв ОФФЛАЙН
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Чискта журналiв ОФФЛАЙН',
                                                  p_funcname => 'F1_Select(12, ''bars_xmlklb_utl.clear_all_journals(DAT-30, DAT-30)'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F/Розрахунок SPOT-курсу за результатами дня ********** ');
          --  Створюємо функцію F/Розрахунок SPOT-курсу за результатами дня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/Розрахунок SPOT-курсу за результатами дня',
                                                  p_funcname => 'F1_Select(12," SPOT_P ( 0, DAT) " ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F/Формування журналу та накопичення платежів по експ-імп.контрактам ********** ');
          --  Створюємо функцію F/Формування журналу та накопичення платежів по експ-імп.контрактам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/Формування журналу та накопичення платежів по експ-імп.контрактам',
                                                  p_funcname => 'F1_Select(12,''P_CONTRACT_JRNL_UNI(DAT)'')',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F/Заповнення спецпараметрів OB22 для депозитних рахунків Фіз.Осіб ********** ');
          --  Створюємо функцію F/Заповнення спецпараметрів OB22 для депозитних рахунків Фіз.Осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/Заповнення спецпараметрів OB22 для депозитних рахунків Фіз.Осіб',
                                                  p_funcname => 'F1_Select(12,''P_DPT_OB22(DAT)'')',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Протокол невиконаних автопроводок по овердр. ********** ');
          --  Створюємо функцію OVR:  Протокол невиконаних автопроводок по овердр.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Протокол невиконаних автопроводок по овердр.',
                                                  p_funcname => 'F1_Select(122, '' '' )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію   Вiдновлення зв`язку ПО (закриття року)  ********** ');
          --  Створюємо функцію   Вiдновлення зв`язку ПО (закриття року) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '  Вiдновлення зв`язку ПО (закриття року) ',
                                                  p_funcname => 'F1_Select(13,  "NU_RESTORE(0);Вiдновити зв`язок ПО?;Вiдновлення завершено!"  ) ',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Згортання рахунків ПОД. обліку на ПОЧАТОК РОКУ ********** ');
          --  Створюємо функцію  Згортання рахунків ПОД. обліку на ПОЧАТОК РОКУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Згортання рахунків ПОД. обліку на ПОЧАТОК РОКУ',
                                                  p_funcname => 'F1_Select(13, "NAL8_0_OB22(DAT);Виконати згортання рахунк_в ПО на початок року?;Згортання завершено!"  ) ',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1. Виконання операції "Закриття непоповнених вкладів" ********** ');
          --  Створюємо функцію 1. Виконання операції "Закриття непоповнених вкладів"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1. Виконання операції "Закриття непоповнених вкладів"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_BLNK'',NUMBER_Null);Виконати <Закриття непоповнених вкладів?>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2. Виконання операції "Закриття вкладів після закінчення строку дії" ********** ');
          --  Створюємо функцію 2. Виконання операції "Закриття вкладів після закінчення строку дії"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2. Виконання операції "Закриття вкладів після закінчення строку дії"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_CLOS'',NUMBER_Null);Виконати <Закриття вкладів після закінчення строку дії>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію B. Виконання операції "Автопереоформлення вкладів" ********** ');
          --  Створюємо функцію B. Виконання операції "Автопереоформлення вкладів"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'B. Виконання операції "Автопереоформлення вкладів"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_EXTN'',NUMBER_Null);Виконати <Автопереоформлення вкладів>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4. Виконання операції "Остаточне нарахування відсотків" ********** ');
          --  Створюємо функцію 4. Виконання операції "Остаточне нарахування відсотків"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4. Виконання операції "Остаточне нарахування відсотків"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_INTF'',NUMBER_Null);Виконати <Остаточне нарахування відсотків>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію X. Виконання операції "Нарахування відсотків по вчорашній день" ********** ');
          --  Створюємо функцію X. Виконання операції "Нарахування відсотків по вчорашній день"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'X. Виконання операції "Нарахування відсотків по вчорашній день"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_INTX'',NUMBER_Null);Виконати <Нарахування відсотків по вчорашній день>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 5. Виконання операції "Перерахування вкладу та %% в кінці строку дії" ********** ');
          --  Створюємо функцію 5. Виконання операції "Перерахування вкладу та %% в кінці строку дії"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5. Виконання операції "Перерахування вкладу та %% в кінці строку дії"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_MATU'',NUMBER_Null);Виконати <Перерахування вкладу та %% в кінці строку дії>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6. Виконання операції "Нарахування відсотків в кінці місяця" ********** ');
          --  Створюємо функцію 6. Виконання операції "Нарахування відсотків в кінці місяця"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6. Виконання операції "Нарахування відсотків в кінці місяця"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_MINT'',0);Виконати <Нарахування %% по вкладах в останній день міс>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3. Виконання операції "Зміна відсоткової ставки на 0 по закінч.строку" ********** ');
          --  Створюємо функцію 3. Виконання операції "Зміна відсоткової ставки на 0 по закінч.строку"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3. Виконання операції "Зміна відсоткової ставки на 0 по закінч.строку"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_RAT0'',NUMBER_Null);Виконати <Зміна відсоткової ставки на 0 по закінч.строку>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 8. Виконання операції "Нарахування відсотків по рах.пенсіонерів" ********** ');
          --  Створюємо функцію 8. Виконання операції "Нарахування відсотків по рах.пенсіонерів"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '8. Виконання операції "Нарахування відсотків по рах.пенсіонерів"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_SCDI'',0);Виконати <Нарахування %% по соц.вкл.в останній день міс>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 9. Виконання операції "Виплата відсотків по рах.пенсіонерів" ********** ');
          --  Створюємо функцію 9. Виконання операції "Виплата відсотків по рах.пенсіонерів"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '9. Виконання операції "Виплата відсотків по рах.пенсіонерів"',
                                                  p_funcname => 'F1_Select(13, "dpt_execute_job(''JOB_SCDP'',NUMBER_Null);Виконати <Виплата відсотків по поточних рах.пенсіонерів>?;Виконано!")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Экспорт операций ********** ');
          --  Створюємо функцію ФМ. Экспорт операций
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Экспорт операций',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.export_auto_op(DATETIME_Null);Выполнить экспорт операций?;Экспорт завершен'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Импорт файла стран FATF ********** ');
          --  Створюємо функцію ФМ. Импорт файла стран FATF
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Импорт файла стран FATF',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.import_file("FATF");Выполнить импорт файла стран?;Импорт завершен'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Импорт файла В_домост_ про операц_ї, що стали об'єктом ФМ ********** ');
          --  Створюємо функцію ФМ. Импорт файла В_домост_ про операц_ї, що стали об'єктом ФМ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Импорт файла В_домост_ про операц_ї, що стали об'єктом ФМ',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.import_file("OPDATA");Выполнить импорт файла запросов?;Импорт завершен'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Импорт файла правил отбора операций в ФМ ********** ');
          --  Створюємо функцію ФМ. Импорт файла правил отбора операций в ФМ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Импорт файла правил отбора операций в ФМ',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.import_file("RULES");Выполнить импорт файла правил отбора операций в ФМ?;Импорт завершен'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Импорт файла террористов ********** ');
          --  Створюємо функцію ФМ. Импорт файла террористов
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Импорт файла террористов',
                                                  p_funcname => 'F1_Select(13, ''fm_impexp.import_file("TRR");Выполнить импорт файла террористов?;Импорт завершен'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S32: Авто-просрочка рахунків нарах.% SN ЮЛ ********** ');
          --  Створюємо функцію КП S32: Авто-просрочка рахунків нарах.% SN ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S32: Авто-просрочка рахунків нарах.% SN ЮЛ',
                                                  p_funcname => 'F1_Select(13,"CCK.CC_ASPN (2, 0, 1 );Вы хотите вынести на просрочку % клиента ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S33: Авто-просрочка рахунків нарах.% SN ФЛ ********** ');
          --  Створюємо функцію КП S33: Авто-просрочка рахунків нарах.% SN ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S33: Авто-просрочка рахунків нарах.% SN ФЛ',
                                                  p_funcname => 'F1_Select(13,"CCK.CC_ASPN (3, 0, 1 );Вы хотите вынести на просрочку % клиента ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F4: Виконати актуалізацію потоків ********** ');
          --  Створюємо функцію КП F4: Виконати актуалізацію потоків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F4: Виконати актуалізацію потоків',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY(0,DAT,0);Вы хотите вып.Актуализацию потоков ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S7: Амортизація Диск/Прем ********** ');
          --  Створюємо функцію КП S7: Амортизація Диск/Прем
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S7: Амортизація Диск/Прем',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY_PET(0,DAT,3);Ви хочете вик. Амортізацію Дисконту?; Виконано!" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 0.Резервний Фонд по БРАНЧАМ - РОЗформування ********** ');
          --  Створюємо функцію 0.Резервний Фонд по БРАНЧАМ - РОЗформування
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '0.Резервний Фонд по БРАНЧАМ - РОЗформування',
                                                  p_funcname => 'F1_Select(13,"REZ_BRA (0,0); Ви бажаєте виконати <<РОЗформування Резервного Фонду по БРАНЧАМ>> ?; Виконано !" )',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Резервний Фонд по БРАНЧАМ - Формування ********** ');
          --  Створюємо функцію 1.Резервний Фонд по БРАНЧАМ - Формування
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Резервний Фонд по БРАНЧАМ - Формування',
                                                  p_funcname => 'F1_Select(13,"REZ_BRA (1,0); Ви бажаєте виконати <<Формування Резервного Фонду по БРАНЧАМ>> ?; Виконано !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Синхронізация накопичення балансу ********** ');
          --  Створюємо функцію Синхронізация накопичення балансу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Синхронізация накопичення балансу',
                                                  p_funcname => 'F1_Select(13,"bars_accm_sync.sync_snap(''BALANCE'',GetBankDate(), 0);Виконати накопичення балансу?;Накопичення балансу за поточний банківській день виконано")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S8: Авто закриття договорів ЮО ********** ');
          --  Створюємо функцію КП S8: Авто закриття договорів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S8: Авто закриття договорів ЮО',
                                                  p_funcname => 'F1_Select(13,"cc_close(2,DAT);Вы хотите вып. авто закрытие дог. ЮЛ ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S8: Авто закриття договорів ФО ********** ');
          --  Створюємо функцію КП S8: Авто закриття договорів ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S8: Авто закриття договорів ФО',
                                                  p_funcname => 'F1_Select(13,"cc_close(3,DAT);Вы хотите вып. авто закрытие дог. ФЛ ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО ********** ');
          --  Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(2,DAT,0);Вы хотите вынести на просрочку все активы клиента ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО ********** ');
          --  Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(3,DAT,0);Вы хотите вынести на просрочку все активы клиента ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-закриття рах.2620 з підтвердженням ********** ');
          --  Створюємо функцію Авто-закриття рах.2620 з підтвердженням
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-закриття рах.2620 з підтвердженням',
                                                  p_funcname => 'F1_Select(2,"  and a.nbs=2620  ")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Start+Finish: Переоцiнка вал.зал.(техн) ********** ');
          --  Створюємо функцію Start+Finish: Переоцiнка вал.зал.(техн)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start+Finish: Переоцiнка вал.зал.(техн)',
                                                  p_funcname => 'F1_Select(5,'''')',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування переліку функцій при Відкритті/Закритті дня ********** ');
          --  Створюємо функцію Редагування переліку функцій при Відкритті/Закритті дня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування переліку функцій при Відкритті/Закритті дня',
                                                  p_funcname => 'FListEdit(hWndMDI,0)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виконання списку функцій при Відкритті дня ********** ');
          --  Створюємо функцію Виконання списку функцій при Відкритті дня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виконання списку функцій при Відкритті дня',
                                                  p_funcname => 'FListRun(0, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виконання списку функцій при Закритті дня ********** ');
          --  Створюємо функцію Виконання списку функцій при Закритті дня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виконання списку функцій при Закритті дня',
                                                  p_funcname => 'FListRun(1, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ-4. Комплексне виконання овердрафту ********** ');
          --  Створюємо функцію ПЦ-4. Комплексне виконання овердрафту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ-4. Комплексне виконання овердрафту',
                                                  p_funcname => 'FListRun(4, FALSE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Ручна квітовка/вилучення документів ПЦ з черги на відправку ********** ');
          --  Створюємо функцію ПЦ. Ручна квітовка/вилучення документів ПЦ з черги на відправку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Ручна квітовка/вилучення документів ПЦ з черги на відправку',
                                                  p_funcname => 'FOBPC_Select(10,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель БПК ********** ');
          --  Створюємо функцію Портфель БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель БПК',
                                                  p_funcname => 'FOBPC_Select(11, '''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Прийом зарплатних файлів (txt, dbf) ********** ');
          --  Створюємо функцію ПЦ. Прийом зарплатних файлів (txt, dbf)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Прийом зарплатних файлів (txt, dbf)',
                                                  p_funcname => 'FOBPC_Select(14,'''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Ручне коректування документів для ПЦ ********** ');
          --  Створюємо функцію ПЦ. Ручне коректування документів для ПЦ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Ручне коректування документів для ПЦ',
                                                  p_funcname => 'FOBPC_Select(16,'''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Поповнення карт. рахунків (по карт. рахунку) ********** ');
          --  Створюємо функцію ПЦ. Поповнення карт. рахунків (по карт. рахунку)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Поповнення карт. рахунків (по карт. рахунку)',
                                                  p_funcname => 'FOBPC_Select(17,'''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд внутр. не відправлених документів ********** ');
          --  Створюємо функцію ПЦ. Перегляд внутр. не відправлених документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд внутр. не відправлених документів',
                                                  p_funcname => 'FOBPC_Select(2,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд внутр. не заквитованих  документів ********** ');
          --  Створюємо функцію ПЦ. Перегляд внутр. не заквитованих  документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд внутр. не заквитованих  документів',
                                                  p_funcname => 'FOBPC_Select(3,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд зовніш. не відправлених документів ********** ');
          --  Створюємо функцію ПЦ. Перегляд зовніш. не відправлених документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд зовніш. не відправлених документів',
                                                  p_funcname => 'FOBPC_Select(4,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд зовніш. не заквитованих  документів ********** ');
          --  Створюємо функцію ПЦ. Перегляд зовніш. не заквитованих  документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд зовніш. не заквитованих  документів',
                                                  p_funcname => 'FOBPC_Select(5,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прийом файлів з локальних задач ********** ');
          --  Створюємо функцію Прийом файлів з локальних задач
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прийом файлів з локальних задач',
                                                  p_funcname => 'FOBPC_Select(7,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Архівація файлів прийнятих від ПЦ ********** ');
          --  Створюємо функцію ПЦ. Архівація файлів прийнятих від ПЦ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Архівація файлів прийнятих від ПЦ',
                                                  p_funcname => 'FOBPC_Select(9,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи ВСІХ користувачів ********** ');
          --  Створюємо функцію Документи ВСІХ користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи ВСІХ користувачів',
                                                  p_funcname => 'F_Ctrl_D(TRUE)',
                                                  p_rolename => 'CHCK002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виконання ВАК-операцій (Вилучити операцію) ********** ');
          --  Створюємо функцію Виконання ВАК-операцій (Вилучити операцію)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виконання ВАК-операцій (Вилучити операцію)',
                                                  p_funcname => 'F_Pay_Bck( hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій (свого відділення) ********** ');
          --  Створюємо функцію Візування операцій (свого відділення)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій (свого відділення)',
                                                  p_funcname => 'FunCheckDocumentsEx(hWndMDI, " a.TOBO = tobopack.GetTobo ")',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій (свого відділ. і Підлеглих) ********** ');
          --  Створюємо функцію Візування операцій (свого відділ. і Підлеглих)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій (свого відділ. і Підлеглих)',
                                                  p_funcname => 'FunCheckDocumentsEx(hWndMDI, " a.TOBO like tobopack.GetTobo || ''%'' ")',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування "своїх" операцій ********** ');
          --  Створюємо функцію Візування "своїх" операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування "своїх" операцій',
                                                  p_funcname => 'FunCheckDocumentsSel(1,''a.userid=''||Str(GetUserId()),'''',1,0)',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перевірка ЕЦП на візах ********** ');
          --  Створюємо функцію Перевірка ЕЦП на візах
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перевірка ЕЦП на візах',
                                                  p_funcname => 'FunCheckDocumentsSel(99,'''','''',1,0)',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування БазиМетаДанних ********** ');
          --  Створюємо функцію Редагування БазиМетаДанних
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування БазиМетаДанних',
                                                  p_funcname => 'FunMetaBaseEdit()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT5 Формування звiту для ПФ "Рах,по яким НЕ отрим.персiонери" ********** ');
          --  Створюємо функцію DPT5 Формування звiту для ПФ "Рах,по яким НЕ отрим.персiонери"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT5 Формування звiту для ПФ "Рах,по яким НЕ отрим.персiонери"',
                                                  p_funcname => 'FunNSIEdit("[PROC=>PF_NOT_PAY(:Param0,:Param1)][PAR=>:Param0(SEM=Звiтна дата,TYPE=D),:Param1(SEM=Звiтний перiод/мiс,TYPE=N)][MSG=>Виконано!]")',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Справочник параметров ********** ');
          --  Створюємо функцію ФМ. Справочник параметров
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Справочник параметров',
                                                  p_funcname => 'FunNSIEdit(''FM_PARAMS'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Крд.Портф.  (Формування + Перегляд) ********** ');
          --  Створюємо функцію Аудит OB22 в Крд.Портф.  (Формування + Перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Крд.Портф.  (Формування + Перегляд)',
                                                  p_funcname => 'FunNSIEditF("AUD_CCK",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Деп.портфелях ЮО ********** ');
          --  Створюємо функцію Аудит OB22 в Деп.портфелях ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Деп.портфелях ЮО',
                                                  p_funcname => 'FunNSIEditF("AUD_DPU",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довiдник ОБ22 в Крд.Портф. ЮО+ФО ********** ');
          --  Створюємо функцію Довiдник ОБ22 в Крд.Портф. ЮО+ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довiдник ОБ22 в Крд.Портф. ЮО+ФО',
                                                  p_funcname => 'FunNSIEditF("CCK_OB22",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату ********** ');
          --  Створюємо функцію Кредити, що мають прострочку на ПОТОЧНУ дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити, що мають прострочку на ПОТОЧНУ дату',
                                                  p_funcname => 'FunNSIEditF("CCK_PROBL" , 1 | 0x0010)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування  CC_DEAL ********** ');
          --  Створюємо функцію Редагування  CC_DEAL
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування  CC_DEAL',
                                                  p_funcname => 'FunNSIEditF("CC_DEAL",2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iсторизацiя змiн ком.курсiв валют ********** ');
          --  Створюємо функцію Iсторизацiя змiн ком.курсiв валют
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iсторизацiя змiн ком.курсiв валют',
                                                  p_funcname => 'FunNSIEditF("CUR_RATE_KOM_UPD",1 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довiдник ОБ22 в Деп.Портф. ФО ********** ');
          --  Створюємо функцію Довiдник ОБ22 в Деп.Портф. ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довiдник ОБ22 в Деп.Портф. ФО',
                                                  p_funcname => 'FunNSIEditF("DPT_OB22",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнвентаризацiя КП ЮО ********** ');
          --  Створюємо функцію Iнвентаризацiя КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнвентаризацiя КП ЮО',
                                                  p_funcname => 'FunNSIEditF("INV_CCK_UL[PROC=>P_INV_CCK_UL(:Param0,:Param1)][PAR=>:Param0(SEM=Звiтна дата,TYPE=D,REF=REZ_PROTOCOL),:Param1(SEM=Переформувати?Так->1/Нi->0,TYPE=N)][EXEC=>BEFORE][MSG=>Виконано!]", 2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Коригування дод.параметру OB40 за останні 30 днів ********** ');
          --  Створюємо функцію Коригування дод.параметру OB40 за останні 30 днів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Коригування дод.параметру OB40 за останні 30 днів',
                                                  p_funcname => 'FunNSIEditF("OPER_OB40",2 )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Архів показників файлу #04 ********** ');
          --  Створюємо функцію Архів показників файлу #04
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Архів показників файлу #04',
                                                  p_funcname => 'FunNSIEditF("RNBU_HISTORY",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію --Аналіз рахунків ПО (ПО+стиснення по 8кл) на ДАТУ ********** ');
          --  Створюємо функцію --Аналіз рахунків ПО (ПО+стиснення по 8кл) на ДАТУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '--Аналіз рахунків ПО (ПО+стиснення по 8кл) на ДАТУ',
                                                  p_funcname => 'FunNSIEditF("SB_NAL3",1)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію --8. Рахунки 8 класу, НЕ пов'язані з Декларацією ********** ');
          --  Створюємо функцію --8. Рахунки 8 класу, НЕ пов'язані з Декларацією
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '--8. Рахунки 8 класу, НЕ пов'язані з Декларацією',
                                                  p_funcname => 'FunNSIEditF("SB_NAL8",1)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд спецпараметрів рахунка (НБУ) ********** ');
          --  Створюємо функцію Перегляд спецпараметрів рахунка (НБУ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд спецпараметрів рахунка (НБУ)',
                                                  p_funcname => 'FunNSIEditF("SPEC1",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд спецпараметрів ОБ ********** ');
          --  Створюємо функцію Перегляд спецпараметрів ОБ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд спецпараметрів ОБ',
                                                  p_funcname => 'FunNSIEditF("SPEC1_INT",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Ручна установка спецпараметрів ОБ  ********** ');
          --  Створюємо функцію Ручна установка спецпараметрів ОБ 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Ручна установка спецпараметрів ОБ ',
                                                  p_funcname => 'FunNSIEditF("SPEC1_INT",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Ручна установка спецпараметрів ОБ  Подат.Облік ********** ');
          --  Створюємо функцію  Ручна установка спецпараметрів ОБ  Подат.Облік
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Ручна установка спецпараметрів ОБ  Подат.Облік',
                                                  p_funcname => 'FunNSIEditF("SPEC1_INT_PO",2)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ---- Аналіз |  8-ПО, ФО, P080, OB22 ********** ');
          --  Створюємо функцію ---- Аналіз |  8-ПО, ФО, P080, OB22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '---- Аналіз |  8-ПО, ФО, P080, OB22',
                                                  p_funcname => 'FunNSIEditF("SSB_NAL88",1)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Деп.Портф. (Перегляд) ********** ');
          --  Створюємо функцію Аудит OB22 в Деп.Портф. (Перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Деп.Портф. (Перегляд)',
                                                  p_funcname => 'FunNSIEditF("TEST_AUD_DPT",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Исправл.несоотвия видов вкладов БАРС и кодов картотек АСВО ********** ');
          --  Створюємо функцію Исправл.несоотвия видов вкладов БАРС и кодов картотек АСВО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Исправл.несоотвия видов вкладов БАРС и кодов картотек АСВО',
                                                  p_funcname => 'FunNSIEditF("TEST_DPT_ERR_OB22" ,2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зарахування по Альтер.рах.(АСВО) ********** ');
          --  Створюємо функцію Зарахування по Альтер.рах.(АСВО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зарахування по Альтер.рах.(АСВО)',
                                                  p_funcname => 'FunNSIEditF("VPAY_ALT",0)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Просморт КД с дисконтом в потоках ********** ');
          --  Створюємо функцію Просморт КД с дисконтом в потоках
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Просморт КД с дисконтом в потоках',
                                                  p_funcname => 'FunNSIEditF("V_CC_SDI" ,1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Подготовка к внедр.КП ********** ');
          --  Створюємо функцію Подготовка к внедр.КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Подготовка к внедр.КП',
                                                  p_funcname => 'FunNSIEditF("V_CC_START",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перенесення строк.вкладів на вклади до запит.зг.Пост.НБУ № 159 ********** ');
          --  Створюємо функцію Перенесення строк.вкладів на вклади до запит.зг.Пост.НБУ № 159
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перенесення строк.вкладів на вклади до запит.зг.Пост.НБУ № 159',
                                                  p_funcname => 'FunNSIEditF("V_DPT_159[PROC=>dpt_159(:DPTID,:Param0)][PAR=>:Param0(SEM=Операція,TYPE=C,DEF=АСВ,REF=TTS)][QST=>Виконати перенесення строкових вкладів на вклади до запитання?][MSG=>Виконано!]", 1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT6 Внести данi про ДАТИ довiреностей ********** ');
          --  Створюємо функцію DPT6 Внести данi про ДАТИ довiреностей
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT6 Внести данi про ДАТИ довiреностей',
                                                  p_funcname => 'FunNSIEditF("V_DPT_AGR_DAT",2|0x0010)',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Невiдповiднiсть ОР їх розмiщенню по рiвням бранчiв ********** ');
          --  Створюємо функцію Невiдповiднiсть ОР їх розмiщенню по рiвням бранчiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Невiдповiднiсть ОР їх розмiщенню по рiвням бранчiв',
                                                  p_funcname => 'FunNSIEditF("V_NBS_BRANCH",1 | 0x0010)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Зв язок рахунків ФО та ПО по SB_P0853 ********** ');
          --  Створюємо функцію  Зв язок рахунків ФО та ПО по SB_P0853
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Зв язок рахунків ФО та ПО по SB_P0853',
                                                  p_funcname => 'FunNSIEditF("V_OB22NU",2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Рахунки 6 класу,     НЕ пов'язані з Декларацією ********** ');
          --  Створюємо функцію  Рахунки 6 класу,     НЕ пов'язані з Декларацією
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Рахунки 6 класу,     НЕ пов'язані з Декларацією',
                                                  p_funcname => 'FunNSIEditF("V_OB22_N6",1 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Рахунки 7 класу,     НЕ пов'язані з Декларацією ********** ');
          --  Створюємо функцію  Рахунки 7 класу,     НЕ пов'язані з Декларацією
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Рахунки 7 класу,     НЕ пов'язані з Декларацією',
                                                  p_funcname => 'FunNSIEditF("V_OB22_N7",1 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Рахунки ФінОбліку  , НЕ пов'язані з Декларацією(по R020_FA) ********** ');
          --  Створюємо функцію  Рахунки ФінОбліку  , НЕ пов'язані з Декларацією(по R020_FA)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Рахунки ФінОбліку  , НЕ пов'язані з Декларацією(по R020_FA)',
                                                  p_funcname => 'FunNSIEditF("V_OB22_NN",2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Таблиця - Матриця рахунків ВП-ЕВП-НКР-РКР ********** ');
          --  Створюємо функцію Таблиця - Матриця рахунків ВП-ЕВП-НКР-РКР
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Таблиця - Матриця рахунків ВП-ЕВП-НКР-РКР',
                                                  p_funcname => 'FunNSIEditF("V_VPLIST",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відновлення записів ********** ');
          --  Створюємо функцію Відновлення записів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відновлення записів',
                                                  p_funcname => 'FunNSIEditF('''',20)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Банківські дати підрозділів ********** ');
          --  Створюємо функцію Банківські дати підрозділів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Банківські дати підрозділів',
                                                  p_funcname => 'FunNSIEditF(''BRANCH_BANKDATES_VIEW'',1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Данi про реструктуризацiю договорів, що відсутні в КД ********** ');
          --  Створюємо функцію Данi про реструктуризацiю договорів, що відсутні в КД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Данi про реструктуризацiю договорів, що відсутні в КД',
                                                  p_funcname => 'FunNSIEditF(''CCK_RESTR_ACC'',0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Данi про реструктуризацiю КД ********** ');
          --  Створюємо функцію Данi про реструктуризацiю КД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Данi про реструктуризацiю КД',
                                                  p_funcname => 'FunNSIEditF(''CCK_RESTR_V'',0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiн.Стан: Стан Даних по Реальних ФО ********** ');
          --  Створюємо функцію Фiн.Стан: Стан Даних по Реальних ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiн.Стан: Стан Даних по Реальних ФО',
                                                  p_funcname => 'FunNSIEditF(''FIN_vR_FL'',1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiн.Стан: Стан Даних по Реальних ЮО ********** ');
          --  Створюємо функцію Фiн.Стан: Стан Даних по Реальних ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiн.Стан: Стан Даних по Реальних ЮО',
                                                  p_funcname => 'FunNSIEditF(''FIN_vR_UL'',1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiн.Стан: Стан Даних по Тестових ФО  ********** ');
          --  Створюємо функцію Фiн.Стан: Стан Даних по Тестових ФО 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiн.Стан: Стан Даних по Тестових ФО ',
                                                  p_funcname => 'FunNSIEditF(''FIN_vT_FL'',1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiн.Стан: Стан Даних по Тестових ЮО  ********** ');
          --  Створюємо функцію Фiн.Стан: Стан Даних по Тестових ЮО 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiн.Стан: Стан Даних по Тестових ЮО ',
                                                  p_funcname => 'FunNSIEditF(''FIN_vT_UL'',1)',
                                                  p_rolename => 'R_FIN2' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Наличие документов Клиент-Банк ********** ');
          --  Створюємо функцію Наличие документов Клиент-Банк
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Наличие документов Клиент-Банк',
                                                  p_funcname => 'FunNSIEditF(''KLPEOM'',1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд невідповідностей рахунків ПЦ і банка ********** ');
          --  Створюємо функцію ПЦ. Перегляд невідповідностей рахунків ПЦ і банка
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд невідповідностей рахунків ПЦ і банка',
                                                  p_funcname => 'FunNSIEditF(''OBPC_BAD_ACC'', 2 | 0x0010)',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд невідповідностей залишків ПЦ і банка ********** ');
          --  Створюємо функцію ПЦ. Перегляд невідповідностей залишків ПЦ і банка
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд невідповідностей залишків ПЦ і банка',
                                                  p_funcname => 'FunNSIEditF(''OBPC_BAD_OST'', 2 | 0x0010)',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Коригування символу СК за останні 35 днів ********** ');
          --  Створюємо функцію Коригування символу СК за останні 35 днів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Коригування символу СК за останні 35 днів',
                                                  p_funcname => 'FunNSIEditF(''OPER_SK'',2 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП: Затримка доплат по T00. ********** ');
          --  Створюємо функцію СЕП: Затримка доплат по T00.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП: Затримка доплат по T00.',
                                                  p_funcname => 'FunNSIEditF(''OPL4'', 2 | 0x0010)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд,сторно ручних пров.: <PO1> за останнi 30 днiв ********** ');
          --  Створюємо функцію Перегляд,сторно ручних пров.: <PO1> за останнi 30 днiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд,сторно ручних пров.: <PO1> за останнi 30 днiв',
                                                  p_funcname => 'FunNSIEditF(''PROVNU_PO1'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд,сторно автопроводок:<PO3+знятi> за останнi 5 днiв ********** ');
          --  Створюємо функцію Перегляд,сторно автопроводок:<PO3+знятi> за останнi 5 днiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд,сторно автопроводок:<PO3+знятi> за останнi 5 днiв',
                                                  p_funcname => 'FunNSIEditF(''PROVNU_PO3'',2 | 0x0010)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Проводки, що включаються в звiт про лотореї ********** ');
          --  Створюємо функцію Проводки, що включаються в звiт про лотореї
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Проводки, що включаються в звiт про лотореї',
                                                  p_funcname => 'FunNSIEditF(''PROV_LOT'', 2 | 0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довiдник Бранчiв та їх  типiв ********** ');
          --  Створюємо функцію Довiдник Бранчiв та їх  типiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довiдник Бранчiв та їх  типiв',
                                                  p_funcname => 'FunNSIEditF(''V_BRANCH_TIP'', 2 | 0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Данi про реструктуризацiю КД ЮО ********** ');
          --  Створюємо функцію Данi про реструктуризацiю КД ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Данi про реструктуризацiю КД ЮО',
                                                  p_funcname => 'FunNSIEditFFiltered(''CCK_RESTR_V'',0,''CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (1,2,3))'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Данi про реструктуризацiю КД ФО ********** ');
          --  Створюємо функцію Данi про реструктуризацiю КД ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Данi про реструктуризацiю КД ФО',
                                                  p_funcname => 'FunNSIEditFFiltered(''CCK_RESTR_V'',0,''CCK_RESTR_V.ND IN (SELECT ND FROM CC_V WHERE VIDD IN (11,12,13))'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію IMPEXP: Імпорт DBF файлів ********** ');
          --  Створюємо функцію IMPEXP: Імпорт DBF файлів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'IMPEXP: Імпорт DBF файлів',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,0,10,"","")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію IMPEXP: Експорт даних таблиць в DBF файл ********** ');
          --  Створюємо функцію IMPEXP: Експорт даних таблиць в DBF файл
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'IMPEXP: Експорт даних таблиць в DBF файл',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,0,110,"","")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт   : Розбір документів ********** ');
          --  Створюємо функцію Iмпорт   : Розбір документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт   : Розбір документів',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 0, '''','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 1: Локальнi задачi(щоденник) ********** ');
          --  Створюємо функцію Iмпорт 1: Локальнi задачi(щоденник)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 1: Локальнi задачi(щоденник)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''1'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 2: КОМУНАЛЬНІ ПЛАТЕЖІ ********** ');
          --  Створюємо функцію Iмпорт 2: КОМУНАЛЬНІ ПЛАТЕЖІ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 2: КОМУНАЛЬНІ ПЛАТЕЖІ',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''2'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3: Зарплатнi файли ********** ');
          --  Створюємо функцію Iмпорт 3: Зарплатнi файли
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3: Зарплатнi файли',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''3'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 4: Файли інкасації ********** ');
          --  Створюємо функцію Iмпорт 4: Файли інкасації
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 4: Файли інкасації',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''4'','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт   : Розбір всіх відкладених документів ********** ');
          --  Створюємо функцію Iмпорт   : Розбір всіх відкладених документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт   : Розбір всіх відкладених документів',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 3, '''','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ------Синхронізація довідників НБУ ********** ');
          --  Створюємо функцію ------Синхронізація довідників НБУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '------Синхронізація довідників НБУ',
                                                  p_funcname => 'ImpOper(hWndMDI, 5)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт DBF-таблиць ********** ');
          --  Створюємо функцію Імпорт DBF-таблиць
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт DBF-таблиць',
                                                  p_funcname => 'Imp_Dbf_New (hWndMDI,2,0, '''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт АСВО6.3 --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт АСВО6.3 --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт АСВО6.3 --> АБС БАРС',
                                                  p_funcname => 'ImportDataAsvo63()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт СКАРБ --> АБС БАРС ********** ');
          --  Створюємо функцію Импорт СКАРБ --> АБС БАРС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт СКАРБ --> АБС БАРС',
                                                  p_funcname => 'ImportDataSkarb()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Робота з документами "електронних" клієнтів ********** ');
          --  Створюємо функцію 1.Робота з документами "електронних" клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Робота з документами "електронних" клієнтів',
                                                  p_funcname => 'KLOP(0,''KL1'',''KL2'',''KLI'')',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Робота с документами "електронних" клієнтів ********** ');
          --  Створюємо функцію 1.Робота с документами "електронних" клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Робота с документами "електронних" клієнтів',
                                                  p_funcname => 'KLOP(0,''KL1'',''KL2'',''KLI'')',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Робота с документами "електронних" клієнтів ********** ');
          --  Створюємо функцію 1.Робота с документами "електронних" клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Робота с документами "електронних" клієнтів',
                                                  p_funcname => 'KLOP(0,''KL1'',''KL2'',''KLI'')',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відбір підсумкових (проміжних) виписок (E) поточного дня (SBB) ********** ');
          --  Створюємо функцію Відбір підсумкових (проміжних) виписок (E) поточного дня (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відбір підсумкових (проміжних) виписок (E) поточного дня (SBB)',
                                                  p_funcname => 'KliTex(1,hWndMDI,"")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F/Відбір виписок "електронним" клієнтам ********** ');
          --  Створюємо функцію F/Відбір виписок "електронним" клієнтам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/Відбір виписок "електронним" клієнтам',
                                                  p_funcname => 'KliTex(2, hWndMDI, "")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відбір закл. виписок поточного дня (SBB) ********** ');
          --  Створюємо функцію Відбір закл. виписок поточного дня (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відбір закл. виписок поточного дня (SBB)',
                                                  p_funcname => 'KliTex(4,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S/Відбір закл. виписок поточного дня (SBB) ********** ');
          --  Створюємо функцію S/Відбір закл. виписок поточного дня (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/Відбір закл. виписок поточного дня (SBB)',
                                                  p_funcname => 'KliTex(4,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відбір закл. виписок поточного дня + курси (SBB) ********** ');
          --  Створюємо функцію Відбір закл. виписок поточного дня + курси (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відбір закл. виписок поточного дня + курси (SBB)',
                                                  p_funcname => 'KliTex(5,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S/Відбір закл. виписок поточного дня + курси (SBB) ********** ');
          --  Створюємо функцію S/Відбір закл. виписок поточного дня + курси (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/Відбір закл. виписок поточного дня + курси (SBB)',
                                                  p_funcname => 'KliTex(5,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдбiр ЗАКЛ. виписок по елекр. кл.(ТЕСТ) ********** ');
          --  Створюємо функцію Вiдбiр ЗАКЛ. виписок по елекр. кл.(ТЕСТ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдбiр ЗАКЛ. виписок по елекр. кл.(ТЕСТ)',
                                                  p_funcname => 'KliTex(6,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Делегування прав користувачів ********** ');
          --  Створюємо функцію Делегування прав користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Делегування прав користувачів',
                                                  p_funcname => 'MakeSubstitutes()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Оновлення ТОК ********** ');
          --  Створюємо функцію СЕП. Оновлення ТОК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Оновлення ТОК',
                                                  p_funcname => 'ModyTok()',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію * 2.Побудова податкового обліку з установкою залишків ********** ');
          --  Створюємо функцію * 2.Побудова податкового обліку з установкою залишків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* 2.Побудова податкового обліку з установкою залишків',
                                                  p_funcname => 'NAL_DEC(101)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію * Стан ПОДАТКОВОЇ декларації ********** ');
          --  Створюємо функцію * Стан ПОДАТКОВОЇ декларації
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* Стан ПОДАТКОВОЇ декларації',
                                                  p_funcname => 'NAL_DEC(102)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію * Побудова ПО без установки залишків  ********** ');
          --  Створюємо функцію * Побудова ПО без установки залишків 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* Побудова ПО без установки залишків ',
                                                  p_funcname => 'NAL_DEC(107)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію * Стан ПОДАТКОВОЇ декларації по вик за період ********** ');
          --  Створюємо функцію * Стан ПОДАТКОВОЇ декларації по вик за період
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* Стан ПОДАТКОВОЇ декларації по вик за період',
                                                  p_funcname => 'NAL_DEC(112)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.Стан  ПОДАТКОВОЇ декларації (по вик) ********** ');
          --  Створюємо функцію 2.Стан  ПОДАТКОВОЇ декларації (по вик)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.Стан  ПОДАТКОВОЇ декларації (по вик)',
                                                  p_funcname => 'NAL_DEC(12)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію * Відкриття рахунків ПО ВИБОРУ згідно шаблону ********** ');
          --  Створюємо функцію * Відкриття рахунків ПО ВИБОРУ згідно шаблону
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '* Відкриття рахунків ПО ВИБОРУ згідно шаблону',
                                                  p_funcname => 'NAL_DEC(155)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Проводки в ПО по ОБ22 (валові) ********** ');
          --  Створюємо функцію Проводки в ПО по ОБ22 (валові)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Проводки в ПО по ОБ22 (валові)',
                                                  p_funcname => 'NAL_DEC(22)',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1_ПБ. Дод.реквізити документів ********** ');
          --  Створюємо функцію 1_ПБ. Дод.реквізити документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1_ПБ. Дод.реквізити документів',
                                                  p_funcname => 'PB1(hWndMDI)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1_ПБ. Формування звіту ********** ');
          --  Створюємо функцію 1_ПБ. Формування звіту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1_ПБ. Формування звіту',
                                                  p_funcname => 'PBF(hWndMDI)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S/Оплата документів за вимогою ********** ');
          --  Створюємо функцію S/Оплата документів за вимогою
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/Оплата документів за вимогою',
                                                  p_funcname => 'PayStartDay(GetBankDate())',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Start+Finish: Переоцiнка вал.поз.(бухг) ********** ');
          --  Створюємо функцію Start+Finish: Переоцiнка вал.поз.(бухг)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start+Finish: Переоцiнка вал.поз.(бухг)',
                                                  p_funcname => 'Pereocenka_VP()',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S/ВПС. Обновление ТОК ВЕГА на старте дня ********** ');
          --  Створюємо функцію S/ВПС. Обновление ТОК ВЕГА на старте дня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/ВПС. Обновление ТОК ВЕГА на старте дня',
                                                  p_funcname => 'PrestartVegaTOKUpdate()',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.Динаміка ек. показників нашого банку ********** ');
          --  Створюємо функцію 2.Динаміка ек. показників нашого банку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.Динаміка ек. показників нашого банку',
                                                  p_funcname => 'RunATime(hWndMDI)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вихідні та свята ********** ');
          --  Створюємо функцію Вихідні та свята
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вихідні та свята',
                                                  p_funcname => 'RunHoliday(hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Профілі користувачів ********** ');
          --  Створюємо функцію Профілі користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Профілі користувачів',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, 3)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Повноваження користувачів АБС ********** ');
          --  Створюємо функцію Повноваження користувачів АБС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Повноваження користувачів АБС',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування КОРИСТУВАЧІВ ********** ');
          --  Створюємо функцію Адміністрування КОРИСТУВАЧІВ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування КОРИСТУВАЧІВ',
                                                  p_funcname => 'RunUserManager_O(hWndMDI, TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструктор АРМ-ів ********** ');
          --  Створюємо функцію Конструктор АРМ-ів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструктор АРМ-ів',
                                                  p_funcname => 'Run_Arms( hWndMDI, 0 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зв'язок об'єктів адміністрування ********** ');
          --  Створюємо функцію Зв'язок об'єктів адміністрування
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зв'язок об'єктів адміністрування',
                                                  p_funcname => 'Run_Arms(hWndMDI,77)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S/СЕП. Переформування "нічних" файлів платежів ********** ');
          --  Створюємо функцію S/СЕП. Переформування "нічних" файлів платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/СЕП. Переформування "нічних" файлів платежів',
                                                  p_funcname => 'SEPFiles_Reform()',
                                                  p_rolename => 'NOCHNYE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Передача и возврат полномочий пользователей по КЛИЕНТ-БАНК ********** ');
          --  Створюємо функцію Передача и возврат полномочий пользователей по КЛИЕНТ-БАНК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Передача и возврат полномочий пользователей по КЛИЕНТ-БАНК',
                                                  p_funcname => 'Sel000(hWndMDI,10,0,"","")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення додаткових реквізитів за всі дні - документи всіх ********** ');
          --  Створюємо функцію Довведення додаткових реквізитів за всі дні - документи всіх
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення додаткових реквізитів за всі дні - документи всіх',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) ","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення  додаткових реквізитів за сьогодні ********** ');
          --  Створюємо функцію Довведення  додаткових реквізитів за сьогодні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення  додаткових реквізитів за сьогодні',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) and oper.userid=USER_ID and oper.vdat=BANKDATE","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення додаткових реквізитів за всі дні (користувача) ********** ');
          --  Створюємо функцію Довведення додаткових реквізитів за всі дні (користувача)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення додаткових реквізитів за всі дні (користувача)',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) and oper.userid=USER_ID","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Конвертація проводок по ЗО в ПО ********** ');
          --  Створюємо функцію  Конвертація проводок по ЗО в ПО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Конвертація проводок по ЗО в ПО',
                                                  p_funcname => 'Sel000(hWndMDI,13, 8199599,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт різноіменних файлів в форматі MOPER ********** ');
          --  Створюємо функцію Імпорт різноіменних файлів в форматі MOPER
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт різноіменних файлів в форматі MOPER',
                                                  p_funcname => 'Sel000(hWndMDI,21, 0, "", "" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд документів, переданих на ОПЛАТУ (КЛІЄНТ-БАНК) ********** ');
          --  Створюємо функцію Перегляд документів, переданих на ОПЛАТУ (КЛІЄНТ-БАНК)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд документів, переданих на ОПЛАТУ (КЛІЄНТ-БАНК)',
                                                  p_funcname => 'Sel000(hWndMDI,4,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S/Очистка CUSTCOUNT для КЛІЄНТ-БАНК (SBB) ********** ');
          --  Створюємо функцію S/Очистка CUSTCOUNT для КЛІЄНТ-БАНК (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/Очистка CUSTCOUNT для КЛІЄНТ-БАНК (SBB)',
                                                  p_funcname => 'Sel000(hWndMDI,8,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель угод на ел. послуги (повний доступ) ********** ');
          --  Створюємо функцію Портфель угод на ел. послуги (повний доступ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель угод на ел. послуги (повний доступ)',
                                                  p_funcname => 'Sel001( hWndMDI, 0, 16, "", "" )',
                                                  p_rolename => 'ELT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель угод на ел. послуги (тільки інспектора) ********** ');
          --  Створюємо функцію Портфель угод на ел. послуги (тільки інспектора)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель угод на ел. послуги (тільки інспектора)',
                                                  p_funcname => 'Sel001( hWndMDI, 1, 16, "","" )',
                                                  p_rolename => 'ELT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз клієнтів (накопичення в архів) ********** ');
          --  Створюємо функцію Аналіз клієнтів (накопичення в архів)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз клієнтів (накопичення в архів)',
                                                  p_funcname => 'Sel001( hWndMDI, 114, 0, "", "" )',
                                                  p_rolename => 'AN_KL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель угод на ел. послуги (тільки Перегляд ********** ');
          --  Створюємо функцію Портфель угод на ел. послуги (тільки Перегляд
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель угод на ел. послуги (тільки Перегляд',
                                                  p_funcname => 'Sel001( hWndMDI, 3, 99, "", "" )',
                                                  p_rolename => 'ELT' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Плата за РО   ********** ');
          --  Створюємо функцію Плата за РО  
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Плата за РО  ',
                                                  p_funcname => 'Sel002(hWndMDI,0,0,"0111", "  and a.ACC not in (Select ACC from RKO_3570)")',
                                                  p_rolename => 'RKO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Плата за РО  (тільки нарах. на 3570) ********** ');
          --  Створюємо функцію Плата за РО  (тільки нарах. на 3570)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Плата за РО  (тільки нарах. на 3570)',
                                                  p_funcname => 'Sel002(hWndMDI,0,0,''0101'', " and  a.ACC  in (select ACC from RKO_3570) ")',
                                                  p_rolename => 'RKO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію STO: Конструктор регулярних платежiв (ВСІ гр.) ********** ');
          --  Створюємо функцію STO: Конструктор регулярних платежiв (ВСІ гр.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'STO: Конструктор регулярних платежiв (ВСІ гр.)',
                                                  p_funcname => 'Sel002(hWndMDI,1,0," "," ")',
                                                  p_rolename => 'STO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію STO: Конструктор регулярних платежiв (гр.3) ********** ');
          --  Створюємо функцію STO: Конструктор регулярних платежiв (гр.3)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'STO: Конструктор регулярних платежiв (гр.3)',
                                                  p_funcname => 'Sel002(hWndMDI,1,3," "," ")',
                                                  p_rolename => 'STO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію STO: Конструктор регулярних платежiв (гр.4) ********** ');
          --  Створюємо функцію STO: Конструктор регулярних платежiв (гр.4)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'STO: Конструктор регулярних платежiв (гр.4)',
                                                  p_funcname => 'Sel002(hWndMDI,1,4," "," ")',
                                                  p_rolename => 'STO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Операції з цінностями ********** ');
          --  Створюємо функцію Операції з цінностями
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Операції з цінностями',
                                                  p_funcname => 'Sel002(hWndMDI,13,0," ob22 not in ( ''981902'',''981903'',''981979'',''981983'', ''9819B8'') ","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд проводок ********** ');
          --  Створюємо функцію Перегляд проводок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд проводок',
                                                  p_funcname => 'Sel002(hWndMDI,14,0," "," ")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сховище. Оприбуткування монет та футлярiв ********** ');
          --  Створюємо функцію Сховище. Оприбуткування монет та футлярiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сховище. Оприбуткування монет та футлярiв',
                                                  p_funcname => 'Sel002(hWndMDI,15,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію STO: Виконання регулярних платежiв ********** ');
          --  Створюємо функцію STO: Виконання регулярних платежiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'STO: Виконання регулярних платежiв',
                                                  p_funcname => 'Sel002(hWndMDI,2,0," "," ")',
                                                  p_rolename => 'STO' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU0 Види депозитних договорів юр.осіб ********** ');
          --  Створюємо функцію DPU0 Види депозитних договорів юр.осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU0 Види депозитних договорів юр.осіб',
                                                  p_funcname => 'Sel006(hWndForm,0,0,''''," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Архів депозитних договорів ЮО ********** ');
          --  Створюємо функцію DPU. Архів депозитних договорів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Архів депозитних договорів ЮО',
                                                  p_funcname => 'Sel006(hWndForm,4,0,''''," ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Депозитний портфель ЮО ********** ');
          --  Створюємо функцію DPU. Депозитний портфель ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Депозитний портфель ЮО',
                                                  p_funcname => 'Sel006(hWndForm,5,0,''''," ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Картотека надходжень на комбіновані договори ЮО ********** ');
          --  Створюємо функцію DPU. Картотека надходжень на комбіновані договори ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Картотека надходжень на комбіновані договори ЮО',
                                                  p_funcname => 'Sel006(hWndForm,6,0,''NL9''," ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Робота з договорами ЮО ********** ');
          --  Створюємо функцію DPU. Робота з договорами ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Робота з договорами ЮО',
                                                  p_funcname => 'Sel006(hWndMDI,1,30,"11",'''')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ (тільки перегляд) ********** ');
          --  Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ (тільки перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Портфель ОВЕРДРАФТІВ (тільки перегляд)',
                                                  p_funcname => 'Sel009(hWndMDI,0,0,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ (Бухгалтер) ********** ');
          --  Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ (Бухгалтер)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Портфель ОВЕРДРАФТІВ (Бухгалтер)',
                                                  p_funcname => 'Sel009(hWndMDI,0,2,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ (Інспектор, Залоговик) ********** ');
          --  Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ (Інспектор, Залоговик)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Портфель ОВЕРДРАФТІВ (Інспектор, Залоговик)',
                                                  p_funcname => 'Sel009(hWndMDI,0,5,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ  (Всі) ********** ');
          --  Створюємо функцію OVR:  Портфель ОВЕРДРАФТІВ  (Всі)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Портфель ОВЕРДРАФТІВ  (Всі)',
                                                  p_funcname => 'Sel009(hWndMDI,0,7,"MDATE","2600;2620;2650")',
                                                  p_rolename => 'BARS009' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перерахування % за залишки 2560, 2600-2650 ********** ');
          --  Створюємо функцію Перерахування % за залишки 2560, 2600-2650
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перерахування % за залишки 2560, 2600-2650',
                                                  p_funcname => 'Sel010( hWndMDI, 1, 1,  " and s.NBS in (''2560'',''2565'')  and  i.ID=1 and  i.NLSB is not null ", "1" ) ',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перерахування % за залишки 3902,3903 ********** ');
          --  Створюємо функцію Перерахування % за залишки 3902,3903
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перерахування % за залишки 3902,3903',
                                                  p_funcname => 'Sel010( hWndMDI, 1, 1,  " and s.NBS in (''3902'',''3903'') and i.NLSB is not null ", "1" ) ',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування % за залишки  3902,3903 ********** ');
          --  Створюємо функцію Нарахування % за залишки  3902,3903
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування % за залишки  3902,3903',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and  s.NBS in (''3902'', ''3903'')  ", ''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування %  по  2635 БПК ********** ');
          --  Створюємо функцію Нарахування %  по  2635 БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування %  по  2635 БПК',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and  s.NBS=''2635''  and  s.NMS like ''%БПК%''  and  i.ID=1 ", ''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування % по Портфелю Овердрафтiв (2600,2067,3600) ********** ');
          --  Створюємо функцію Нарахування % по Портфелю Овердрафтiв (2600,2067,3600)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування % по Портфелю Овердрафтiв (2600,2067,3600)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and (s.ACC in (Select ACCO from ACC_OVER) or s.ACC in (Select ACC_3600 from ACC_OVER) or s.ACC in (Select ACC_9129 from ACC_OVER)) and not (s.NBS=''2600'' and i.ID=1)", ''SA'')',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування % по Портфелю Овердрафтiв (2600,2067,3600) ********** ');
          --  Створюємо функцію Нарахування % по Портфелю Овердрафтiв (2600,2067,3600)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування % по Портфелю Овердрафтiв (2600,2067,3600)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and (s.ACC in (Select ACCO from ACC_OVER) or s.ACC in (Select ACC_3600 from ACC_OVER) or s.ACC in (Select ACC_9129 from ACC_OVER)) and not (s.NBS=''2600'' and i.ID=1)", ''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Нарахування % за залишки  2560-2600-2650 ********** ');
          --  Створюємо функцію 1.Нарахування % за залишки  2560-2600-2650
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Нарахування % за залишки  2560-2600-2650',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," AND (s.NBS in (''2560'',''2565'',''2600'',''2603'',''2604'',''2650'') or s.NBS=''2620'' and s.ACC in (select ACC from Specparam_INT where OB22=''07'') ) AND s.ACC not in (Select ACC from DPU_DEAL) AND i.ID=1",''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F12: Щомiсячне Нарахування %% по всім дог. у КП ЮО ********** ');
          --  Створюємо функцію КП F12: Щомiсячне Нарахування %% по всім дог. у КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F12: Щомiсячне Нарахування %% по всім дог. у КП ЮО',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (1,2,3))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО ********** ');
          --  Створюємо функцію #5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (11,12,13))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S52: Нарахування %%  по простроченим дог. у КП ЮЛ ********** ');
          --  Створюємо функцію КП S52: Нарахування %%  по простроченим дог. у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S52: Нарахування %%  по простроченим дог. у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SP '') and i.acra is not null and i.acrb is not null",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S42: Нарахування %%  по поточним платіж. датам у КП ЮЛ ********** ');
          --  Створюємо функцію КП S42: Нарахування %%  по поточним платіж. датам у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S42: Нарахування %%  по поточним платіж. датам у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SS '',''SP '') and i.acra is not null and i.acrb is not null and exists (select 1 from cc_lim where acc=s.accc and fdat=gl.bd  and sumo>0 and not_sn is null)",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S53: Нарахування %%  по простроченим дог. у КП ФЛ ********** ');
          --  Створюємо функцію КП S53: Нарахування %%  по простроченим дог. у КП ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S53: Нарахування %%  по простроченим дог. у КП ФЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''22%'' and s.tip in (''SP '') and i.acra is not null and i.acrb is not null",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ЮЛ ********** ');
          --  Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F40: Нарахування комісії на 9129 у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''9129%'' and s.tip in (''CR9'') and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc n,cc_deal d where n.nd=d.nd and d.vidd in (1,2,3) and n.acc=s.acc)",''A'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ФЛ ********** ');
          --  Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F40: Нарахування комісії на 9129 у КП ФЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''9129%'' and s.tip in (''CR9'') and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc n,cc_deal d where n.nd=d.nd and d.vidd in (11,12,13) and n.acc=s.acc)",''A'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #3) КП S43: Нарахування %% по пл. датам у КП ФЛ (АНУЇТЕТ) ********** ');
          --  Створюємо функцію #3) КП S43: Нарахування %% по пл. датам у КП ФЛ (АНУЇТЕТ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#3) КП S43: Нарахування %% по пл. датам у КП ФЛ (АНУЇТЕТ)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.tip in(''SS '',''SP '')  and s.acc in (select N.acc from nd_acc n, cc_v d  where d.GPK=4 and n.nd=d.nd and d.vidd=11  and cck.PAY_GPK(gl.bd,D.ND,null)=1)","SAN")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F23: Щомiсячне Нарахування комісіїї по ФЛ. ********** ');
          --  Створюємо функцію КП F23: Щомiсячне Нарахування комісіїї по ФЛ.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F23: Щомiсячне Нарахування комісіїї по ФЛ.',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=2 and i.metr in (95,96,97,98) and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc nn,cc_deal dd where nn.nd=dd.nd and dd.vidd in (11,12,13) and nn.acc=s.acc) ",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування комісіїї по КП ********** ');
          --  Створюємо функцію Нарахування комісіїї по КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування комісіїї по КП',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.METR>90 and i.acra is not null and i.acrb is not null","SA")',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S62: Нарахування Пенi  у КП ЮЛ ********** ');
          --  Створюємо функцію КП S62: Нарахування Пенi  у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S62: Нарахування Пенi  у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''20%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs2 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S63: Нарахування Пенi  у КП ФЛ ********** ');
          --  Створюємо функцію КП S63: Нарахування Пенi  у КП ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S63: Нарахування Пенi  у КП ФЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''22%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs1 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування % (загальне) ********** ');
          --  Створюємо функцію Нарахування % (загальне)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування % (загальне)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,'''',''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП: Нарахування щомiсячнiй комiсiї по КП ********** ');
          --  Створюємо функцію КП: Нарахування щомiсячнiй комiсiї по КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП: Нарахування щомiсячнiй комiсiї по КП',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,''and i.metr>90'',''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Історія змін базових % ставок ********** ');
          --  Створюємо функцію Історія змін базових % ставок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Історія змін базових % ставок',
                                                  p_funcname => 'Sel010(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення зведених МО ********** ');
          --  Створюємо функцію Введення зведених МО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення зведених МО',
                                                  p_funcname => 'Sel011(hWndMDI,0,1,'''','''')',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення документів ********** ');
          --  Створюємо функцію Введення документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення документів',
                                                  p_funcname => 'Sel011(hWndMDI,2,1,'''','''')',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Встановлення лімітів прямим учасникам ********** ');
          --  Створюємо функцію СЕП. Встановлення лімітів прямим учасникам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Встановлення лімітів прямим учасникам',
                                                  p_funcname => 'Sel014( hWndMDI, 9, 1, '''' ,'''')',
                                                  p_rolename => 'SETLIM01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Блоковані документи СЕП (перегляд) ********** ');
          --  Створюємо функцію СЕП. Блоковані документи СЕП (перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Блоковані документи СЕП (перегляд)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"00",'''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи  (початковий Міжбанк) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи  (початковий Міжбанк)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи  (початковий Міжбанк)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11","arc_rrp.BLK =11")',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи  (ВСІ) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи  (ВСІ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи  (ВСІ)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",'''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи  (BLK=2) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи  (BLK=2)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи  (BLK=2)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",''arc_rrp.BLK=2'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи  (BLK=3)  ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи  (BLK=3) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи  (BLK=3) ',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",''arc_rrp.BLK=3'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи  (BLK=4) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи  (BLK=4)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи  (BLK=4)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",''arc_rrp.BLK=4'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Документи з майбутньою датою валютування, що НЕ настала ********** ');
          --  Створюємо функцію СЕП. Документи з майбутньою датою валютування, що НЕ настала
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Документи з майбутньою датою валютування, що НЕ настала',
                                                  p_funcname => 'Sel014(hWndMDI,11,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відповіді ІПС ********** ');
          --  Створюємо функцію Відповіді ІПС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відповіді ІПС',
                                                  p_funcname => 'Sel014(hWndMDI,12,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Розбір 3720  (ВАЛ) ********** ');
          --  Створюємо функцію СЕП. Розбір 3720  (ВАЛ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Розбір 3720  (ВАЛ)',
                                                  p_funcname => 'Sel014(hWndMDI,2,0,'''',''a.kv<>980'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Розбір 3720  (ГРН) ********** ');
          --  Створюємо функцію СЕП. Розбір 3720  (ГРН)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Розбір 3720  (ГРН)',
                                                  p_funcname => 'Sel014(hWndMDI,2,0,'''',''a.kv=980'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Одержані інф-ні  на рах.  . . . ? . . . ********** ');
          --  Створюємо функцію СЕП. Одержані інф-ні  на рах.  . . . ? . . .
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Одержані інф-ні  на рах.  . . . ? . . .',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''', " mfoa<>:TZ.sBankMfo   AND  accounts.NLS='' . . . ?  . . . '' ")',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах з рах.Вiддiлення ********** ');
          --  Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах з рах.Вiддiлення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Одержанi iнф-нi: Запити на уточ.рекв.по платежах з рах.Вiддiлення',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',"mfoA<>:TZ.sBankMfo  AND  (accounts.TOBO=tobopack.GetTobo  or  length(tobopack.GetTobo)=8 and accounts.TOBO like ''%000000%'')")',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах всього Банку ********** ');
          --  Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах всього Банку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Одержанi iнф-нi: Запити на уточ.рекв.по платежах всього Банку',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',''mfoA<>:TZ.sBankMfo  AND mfoB=:TZ.sBankMfo'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах з рах.Вiддiл.i пiдлег ********** ');
          --  Створюємо функцію Одержанi iнф-нi: Запити на уточ.рекв.по платежах з рах.Вiддiл.i пiдлег
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Одержанi iнф-нi: Запити на уточ.рекв.по платежах з рах.Вiддiл.i пiдлег',
                                                  p_funcname => 'Sel014(hWndMDI,4,0,'''',''mfoa<>:TZ.sBankMfo  AND tobopack.GetTobo=substr(accounts.tobo,1,length(tobopack.GetTobo))'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Інформація про файли (перегляд) ********** ');
          --  Створюємо функцію СЕП. Інформація про файли (перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Інформація про файли (перегляд)',
                                                  p_funcname => 'Sel014(hWndMDI,5,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Інформація про файли ********** ');
          --  Створюємо функцію СЕП. Інформація про файли
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Інформація про файли',
                                                  p_funcname => 'Sel014(hWndMDI,5,1,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструювання схем перекриття/розщіплення(3-х віконне) ********** ');
          --  Створюємо функцію Конструювання схем перекриття/розщіплення(3-х віконне)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструювання схем перекриття/розщіплення(3-х віконне)',
                                                  p_funcname => 'Sel015(hWndMDI,0,0,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Перекриття в БЮДЖЕТ ********** ');
          --  Створюємо функцію 1.Перекриття в БЮДЖЕТ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Перекриття в БЮДЖЕТ',
                                                  p_funcname => 'Sel015(hWndMDI,1,1,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Перекрития 2902-2600 ********** ');
          --  Створюємо функцію 1.Перекрития 2902-2600
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Перекрития 2902-2600',
                                                  p_funcname => 'Sel015(hWndMDI,1,2, ''S'',''a.isp=''||Str(GetUserId()) )',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Виконання БУДЬ-ЯКИХ схем перекриття/розщіплення ********** ');
          --  Створюємо функцію 1.Виконання БУДЬ-ЯКИХ схем перекриття/розщіплення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Виконання БУДЬ-ЯКИХ схем перекриття/розщіплення',
                                                  p_funcname => 'Sel015(hWndMDI,11,0,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів Пенсійного Фонду ********** ');
          --  Створюємо функцію Перекриття платежів Пенсійного Фонду
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів Пенсійного Фонду',
                                                  p_funcname => 'Sel015(hWndMDI,11,1,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів по інкасації ********** ');
          --  Створюємо функцію Перекриття платежів по інкасації
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів по інкасації',
                                                  p_funcname => 'Sel015(hWndMDI,11,10,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів з комісією за перерахування коштів ********** ');
          --  Створюємо функцію Перекриття платежів з комісією за перерахування коштів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів з комісією за перерахування коштів',
                                                  p_funcname => 'Sel015(hWndMDI,11,3,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів на Рівнеенерго ********** ');
          --  Створюємо функцію Перекриття платежів на Рівнеенерго
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів на Рівнеенерго',
                                                  p_funcname => 'Sel015(hWndMDI,11,4,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів  РОД ВАТ НАСК "Оранта" ********** ');
          --  Створюємо функцію Перекриття платежів  РОД ВАТ НАСК "Оранта"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів  РОД ВАТ НАСК "Оранта"',
                                                  p_funcname => 'Sel015(hWndMDI,11,5028,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів  "Велта" ********** ');
          --  Створюємо функцію Перекриття платежів  "Велта"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів  "Велта"',
                                                  p_funcname => 'Sel015(hWndMDI,11,6,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів РФ АТ "Укр.пожежно-страхова компанія" ********** ');
          --  Створюємо функцію Перекриття платежів РФ АТ "Укр.пожежно-страхова компанія"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів РФ АТ "Укр.пожежно-страхова компанія"',
                                                  p_funcname => 'Sel015(hWndMDI,11,7,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів РФ ДП "Документ" ********** ');
          --  Створюємо функцію Перекриття платежів РФ ДП "Документ"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів РФ ДП "Документ"',
                                                  p_funcname => 'Sel015(hWndMDI,11,8488,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструювання схем перекриття/розщіплення(2-х віконне) ********** ');
          --  Створюємо функцію Конструювання схем перекриття/розщіплення(2-х віконне)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструювання схем перекриття/розщіплення(2-х віконне)',
                                                  p_funcname => 'Sel015(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструювання схем перекриття/розщіплення(з SPS) ********** ');
          --  Створюємо функцію Конструювання схем перекриття/розщіплення(з SPS)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструювання схем перекриття/розщіплення(з SPS)',
                                                  p_funcname => 'Sel015(hWndMDI,2,1,"1","")',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів з комісією зг.тарифу 46 ********** ');
          --  Створюємо функцію Перекриття платежів з комісією зг.тарифу 46
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів з комісією зг.тарифу 46',
                                                  p_funcname => 'Sel015(hWndMDI,3,0,"","")',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Схеми перекриття: редагування ********** ');
          --  Створюємо функцію Схеми перекриття: редагування
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Схеми перекриття: редагування',
                                                  p_funcname => 'Sel015(hWndMDI,4,1,''1'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вклади. Контролер-операціоніст ********** ');
          --  Створюємо функцію Вклади. Контролер-операціоніст
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вклади. Контролер-операціоніст',
                                                  p_funcname => 'Sel016(hWndMDI,1,12,"DP1DP4","DP5DP6 ")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT2 Депозитний портфель фізичних осіб ********** ');
          --  Створюємо функцію DPT2 Депозитний портфель фізичних осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT2 Депозитний портфель фізичних осіб',
                                                  p_funcname => 'Sel016f(hWndMDI,0,0,""," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію REQ2 Перегляд розподілу пільг по видах вкладів ********** ');
          --  Створюємо функцію REQ2 Перегляд розподілу пільг по видах вкладів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ2 Перегляд розподілу пільг по видах вкладів',
                                                  p_funcname => 'Sel016f(hWndMDI,13,0,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розподіл пільг по видах депозитних договорів ********** ');
          --  Створюємо функцію Розподіл пільг по видах депозитних договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розподіл пільг по видах депозитних договорів',
                                                  p_funcname => 'Sel016f(hWndMDI,13,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію REQ1 Обробка запитів на отримання пільг ********** ');
          --  Створюємо функцію REQ1 Обробка запитів на отримання пільг
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ1 Обробка запитів на отримання пільг',
                                                  p_funcname => 'Sel016f(hWndMDI,14,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію REQ3 Обробка запитів на відміну комісії за оформлення дод.угод ********** ');
          --  Створюємо функцію REQ3 Обробка запитів на відміну комісії за оформлення дод.угод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ3 Обробка запитів на відміну комісії за оформлення дод.угод',
                                                  p_funcname => 'Sel016f(hWndMDI,15,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію REQ6 Перегляд запитів на зміну відсотк.ставки по договорах ********** ');
          --  Створюємо функцію REQ6 Перегляд запитів на зміну відсотк.ставки по договорах
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ6 Перегляд запитів на зміну відсотк.ставки по договорах',
                                                  p_funcname => 'Sel016f(hWndMDI,16,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію REQ4 Формування інд.запитів на зміну відсотк.ставки по договорах ********** ');
          --  Створюємо функцію REQ4 Формування інд.запитів на зміну відсотк.ставки по договорах
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ4 Формування інд.запитів на зміну відсотк.ставки по договорах',
                                                  p_funcname => 'Sel016f(hWndMDI,17,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію REQ5 Формування груп.запитів на зміну відсотк.ставки по договорах ********** ');
          --  Створюємо функцію REQ5 Формування груп.запитів на зміну відсотк.ставки по договорах
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'REQ5 Формування груп.запитів на зміну відсотк.ставки по договорах',
                                                  p_funcname => 'Sel016f(hWndMDI,18,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT0 Види депозитів фізичних осіб ********** ');
          --  Створюємо функцію DPT0 Види депозитів фізичних осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 Види депозитів фізичних осіб',
                                                  p_funcname => 'Sel016f(hWndMDI,2,1,""," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вклади. Архів депозитів ФО по доступу ********** ');
          --  Створюємо функцію Вклади. Архів депозитів ФО по доступу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вклади. Архів депозитів ФО по доступу',
                                                  p_funcname => 'Sel016f(hWndMDI,6,0,"v_dpt_portfolio_access"," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT1 Архів депозитів фізичних осіб ********** ');
          --  Створюємо функцію DPT1 Архів депозитів фізичних осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT1 Архів депозитів фізичних осіб',
                                                  p_funcname => 'Sel016f(hWndMDI,6,0,"v_dpt_s"," ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT0 Коррекція строку вкладу ********** ');
          --  Створюємо функцію DPT0 Коррекція строку вкладу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 Коррекція строку вкладу',
                                                  p_funcname => 'Sel016f(hWndMDI,8,1,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Депозитні сейфи ********** ');
          --  Створюємо функцію Депозитні сейфи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Депозитні сейфи',
                                                  p_funcname => 'Sel022(hWndMDI,1,4,"","")',
                                                  p_rolename => 'DEP_SKRN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Депозитні сейфи (перегляд) ********** ');
          --  Створюємо функцію Депозитні сейфи (перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Депозитні сейфи (перегляд)',
                                                  p_funcname => 'Sel022(hWndMDI,1,4,"1","/333368/")',
                                                  p_rolename => 'DEP_SKRN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію NL3 Картотека "Компенсація вкл.СРСР УкрПошта" ********** ');
          --  Створюємо функцію NL3 Картотека "Компенсація вкл.СРСР УкрПошта"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NL3 Картотека "Компенсація вкл.СРСР УкрПошта"',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NL3","004")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картотека надходжень на конс. балансовий рахунок 2909 (тип NL9) ********** ');
          --  Створюємо функцію Картотека надходжень на конс. балансовий рахунок 2909 (тип NL9)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картотека надходжень на конс. балансовий рахунок 2909 (тип NL9)',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NL9","024")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію NLA Картотека  "Компенсація вкл.СРСР" ********** ');
          --  Створюємо функцію NLA Картотека  "Компенсація вкл.СРСР"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NLA Картотека  "Компенсація вкл.СРСР"',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NLA","TOS")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію NLP Картотека "Компенсація вкл.СРСР на поховання"  ********** ');
          --  Створюємо функцію NLP Картотека "Компенсація вкл.СРСР на поховання" 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NLP Картотека "Компенсація вкл.СРСР на поховання" ',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NLP","TOS")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Картотека касових операцій ********** ');
          --  Створюємо функцію ПЦ. Картотека касових операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Картотека касових операцій',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,''NLS'',''PKL'')',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU. Картотека надходжень на рахунки-ген.угоди депозитів ЮО ********** ');
          --  Створюємо функцію DPU. Картотека надходжень на рахунки-ген.угоди депозитів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU. Картотека надходжень на рахунки-ген.угоди депозитів ЮО',
                                                  p_funcname => 'Sel022(hWndMDI,14,0,"NL8","DU0")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Погашення кредиту ФО готівкою ********** ');
          --  Створюємо функцію Погашення кредиту ФО готівкою
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Погашення кредиту ФО готівкою',
                                                  p_funcname => 'Sel025( hWndMDI,297, 0, "CCK", "KK2" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Установка курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО ********** ');
          --  Створюємо функцію Установка курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Установка курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО',
                                                  p_funcname => 'Sel025( hWndMDI,96, 0, " ", "0" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО ********** ');
          --  Створюємо функцію Перегляд курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО',
                                                  p_funcname => 'Sel025( hWndMDI,96, 1, " ", "0" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зведений приб/видат. позабалансовий ордеров 96-98(P1P,P1M) ********** ');
          --  Створюємо функцію Зведений приб/видат. позабалансовий ордеров 96-98(P1P,P1M)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зведений приб/видат. позабалансовий ордеров 96-98(P1P,P1M)',
                                                  p_funcname => 'Sel025( hWndMDI,98, 0, "P1P", "P1M" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування ієрархії підрозділів ********** ');
          --  Створюємо функцію Редагування ієрархії підрозділів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування ієрархії підрозділів',
                                                  p_funcname => 'Sel028(hWndMDI, 0, 1, "/", "")',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення торгових курсів купівлі/продажу валют підрозділів банку ********** ');
          --  Створюємо функцію Встановлення торгових курсів купівлі/продажу валют підрозділів банку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення торгових курсів купівлі/продажу валют підрозділів банку',
                                                  p_funcname => 'Sel028(hWndMDI,1,1,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Управління списком завдань ********** ');
          --  Створюємо функцію Управління списком завдань
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Управління списком завдань',
                                                  p_funcname => 'Sel028(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: файли обмiну ********** ');
          --  Створюємо функцію ТВБВ: файли обмiну
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: файли обмiну',
                                                  p_funcname => 'Sel029(hWndMDI,0,0,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: параметри обміну ********** ');
          --  Створюємо функцію ТВБВ: параметри обміну
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: параметри обміну',
                                                  p_funcname => 'Sel029(hWndMDI,1,0,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: реєстрація нових відділень ********** ');
          --  Створюємо функцію ТВБВ: реєстрація нових відділень
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: реєстрація нових відділень',
                                                  p_funcname => 'Sel029(hWndMDI,10,1,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: технологічні роботи ********** ');
          --  Створюємо функцію ТВБВ: технологічні роботи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: технологічні роботи',
                                                  p_funcname => 'Sel029(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: ORA STREAMS: Довiдники ********** ');
          --  Створюємо функцію ТВБВ: ORA STREAMS: Довiдники
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: ORA STREAMS: Довiдники',
                                                  p_funcname => 'Sel029(hWndMDI,3,1,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: ORA STREAMS: Пiдписчики ********** ');
          --  Створюємо функцію ТВБВ: ORA STREAMS: Пiдписчики
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: ORA STREAMS: Пiдписчики',
                                                  p_funcname => 'Sel029(hWndMDI,3,2,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: ORA STREAMS: Монiторинг ********** ');
          --  Створюємо функцію ТВБВ: ORA STREAMS: Монiторинг
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: ORA STREAMS: Монiторинг',
                                                  p_funcname => 'Sel029(hWndMDI,3,3,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: ORA STREAMS: Рахунки ********** ');
          --  Створюємо функцію ТВБВ: ORA STREAMS: Рахунки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: ORA STREAMS: Рахунки',
                                                  p_funcname => 'Sel029(hWndMDI,3,4,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: синхронiзаця повна ********** ');
          --  Створюємо функцію ТВБВ: синхронiзаця повна
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: синхронiзаця повна',
                                                  p_funcname => 'Sel029(hWndMDI,9,1,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: синхронiзацiя по параметрам ********** ');
          --  Створюємо функцію ТВБВ: синхронiзацiя по параметрам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: синхронiзацiя по параметрам',
                                                  p_funcname => 'Sel029(hWndMDI,9,2,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: синхронiзацiя виписки ********** ');
          --  Створюємо функцію ТВБВ: синхронiзацiя виписки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: синхронiзацiя виписки',
                                                  p_funcname => 'Sel029(hWndMDI,9,3,'''','''')',
                                                  p_rolename => 'KLBX' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-1. Аналіз вiдповiдностi АКТ-ПАС ********** ');
          --  Створюємо функцію ANI-1. Аналіз вiдповiдностi АКТ-ПАС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-1. Аналіз вiдповiдностi АКТ-ПАС',
                                                  p_funcname => 'Sel030(hWndMDI,1,700,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-10. Аналіз вiдповiдностi Проц.АКТ-ПАС ********** ');
          --  Створюємо функцію ANI-10. Аналіз вiдповiдностi Проц.АКТ-ПАС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-10. Аналіз вiдповiдностi Проц.АКТ-ПАС',
                                                  p_funcname => 'Sel030(hWndMDI,1,800,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналiз балансу за перiод ********** ');
          --  Створюємо функцію Аналiз балансу за перiод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналiз балансу за перiод',
                                                  p_funcname => 'Sel030(hWndMDI,22,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI   - резерв ********** ');
          --  Створюємо функцію ANI   - резерв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI   - резерв',
                                                  p_funcname => 'Sel030(hWndMDI,3,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-31. Номенклатура та значення трансф.цiн на проц.АКТ,ПАС ********** ');
          --  Створюємо функцію ANI-31. Номенклатура та значення трансф.цiн на проц.АКТ,ПАС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-31. Номенклатура та значення трансф.цiн на проц.АКТ,ПАС',
                                                  p_funcname => 'Sel030(hWndMDI,31,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-32. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi ********** ');
          --  Створюємо функцію ANI-32. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi',
                                                  p_funcname => 'Sel030(hWndMDI,32,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-32n. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi ********** ');
          --  Створюємо функцію ANI-32n. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32n. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi',
                                                  p_funcname => 'Sel030(hWndMDI,32,1,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ОБ-БЮДЖЕТ в стуктурi показникiв (б/р 6-7 кл) ********** ');
          --  Створюємо функцію ОБ-БЮДЖЕТ в стуктурi показникiв (б/р 6-7 кл)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ОБ-БЮДЖЕТ в стуктурi показникiв (б/р 6-7 кл)',
                                                  p_funcname => 'Sel030(hWndMDI,4,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-5. Концентрацiя ресурсiв (SNAP) ********** ');
          --  Створюємо функцію ANI-5. Концентрацiя ресурсiв (SNAP)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-5. Концентрацiя ресурсiв (SNAP)',
                                                  p_funcname => 'Sel030(hWndMDI,5,7,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-6.Var-аналiз ********** ');
          --  Створюємо функцію ANI-6.Var-аналiз
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-6.Var-аналiз',
                                                  p_funcname => 'Sel030(hWndMDI,6,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-7. Фондування по Бал.рахунках ********** ');
          --  Створюємо функцію ANI-7. Фондування по Бал.рахунках
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-7. Фондування по Бал.рахунках',
                                                  p_funcname => 'Sel030(hWndMDI,7,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Адміністрування комунальних платежів ********** ');
          --  Створюємо функцію Адміністрування комунальних платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Адміністрування комунальних платежів',
                                                  p_funcname => 'Sel031(hWndMDI,0,0,"","")',
                                                  p_rolename => 'R_KP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення комунальних платежів ********** ');
          --  Створюємо функцію Введення комунальних платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення комунальних платежів',
                                                  p_funcname => 'Sel031(hWndMDI,297,0,"","")',
                                                  p_rolename => 'R_KP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Архівація даних ********** ');
          --  Створюємо функцію Архівація даних
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Архівація даних',
                                                  p_funcname => 'Sel033(hWndMDI,0,0,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструктор анкет ********** ');
          --  Створюємо функцію Конструктор анкет
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструктор анкет',
                                                  p_funcname => 'Sel037(hWndMDI,0,0,"","")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-(до)вiдкр.рiзних рах.для 1-го бранчу ********** ');
          --  Створюємо функцію Авто-(до)вiдкр.рiзних рах.для 1-го бранчу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-(до)вiдкр.рiзних рах.для 1-го бранчу',
                                                  p_funcname => 'Sel040( hWndMDI, 21, 0 , "" ,"" )',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Контроль ПОМИЛКОВИХ спец.парам. OB22 ********** ');
          --  Створюємо функцію Контроль ПОМИЛКОВИХ спец.парам. OB22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Контроль ПОМИЛКОВИХ спец.парам. OB22',
                                                  p_funcname => 'Sel040( hWndMDI, 22, 0 , "" ,"" )',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вивантаження довідника банків СЕП (S_UCH.DBF) ********** ');
          --  Створюємо функцію Вивантаження довідника банків СЕП (S_UCH.DBF)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вивантаження довідника банків СЕП (S_UCH.DBF)',
                                                  p_funcname => 'Selector(hWndMDI,1)',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд всіх рахунків ********** ');
          --  Створюємо функцію Перегляд всіх рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд всіх рахунків',
                                                  p_funcname => 'ShowAllAccounts(hWndMDI)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Журнал відвідин ********** ');
          --  Створюємо функцію Журнал відвідин
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Журнал відвідин',
                                                  p_funcname => 'ShowAttendance(0)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Допуск користувачів ********** ');
          --  Створюємо функцію Допуск користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Допуск користувачів',
                                                  p_funcname => 'ShowBAXTA(hWndMDI, TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз структури балансів  (розріз - Валюта) ********** ');
          --  Створюємо функцію Аналіз структури балансів  (розріз - Валюта)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз структури балансів  (розріз - Валюта)',
                                                  p_funcname => 'ShowBal(hWndMDI, 1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ODB. Закрити банківський день ********** ');
          --  Створюємо функцію ODB. Закрити банківський день
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ODB. Закрити банківський день',
                                                  p_funcname => 'ShowCloseBankDay()',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Печать анкет ********** ');
          --  Створюємо функцію ФМ. Печать анкет
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Печать анкет',
                                                  p_funcname => 'ShowCustomers(ACCESS_READONLY , 1)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд паспорта Клієнта і картки рахунку  (загальна) ********** ');
          --  Створюємо функцію Перегляд паспорта Клієнта і картки рахунку  (загальна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд паспорта Клієнта і картки рахунку  (загальна)',
                                                  p_funcname => 'ShowCustomers(ACCESS_READONLY, 3)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків  (загальна) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків  (загальна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків  (загальна)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,0,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків (ЮО) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків (ЮО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків (ЮО)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,2,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків (ФО) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків (ФО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків (ФО)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,3,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз балансів банку в динаміці ********** ');
          --  Створюємо функцію Аналіз балансів банку в динаміці
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз балансів банку в динаміці',
                                                  p_funcname => 'ShowDin(hWndMDI)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Блокувати/Розблокувати напрямки ********** ');
          --  Створюємо функцію СЕП. Блокувати/Розблокувати напрямки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Блокувати/Розблокувати напрямки',
                                                  p_funcname => 'ShowDirection()',
                                                  p_rolename => 'TECH007' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звітність Ощадного Банку ********** ');
          --  Створюємо функцію Звітність Ощадного Банку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звітність Ощадного Банку',
                                                  p_funcname => 'ShowFilesInt(hWndMDI)',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстр рахунків @F ********** ');
          --  Створюємо функцію Реєстр рахунків @F
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстр рахунків @F',
                                                  p_funcname => 'ShowFilesNIByID(hWndMDI,''@F,@K'')',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звітність в НБУ ********** ');
          --  Створюємо функцію Звітність в НБУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звітність в НБУ',
                                                  p_funcname => 'ShowFilesNbu(hWndMDI) ',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд доступу до рахунків ********** ');
          --  Створюємо функцію Перегляд доступу до рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд доступу до рахунків',
                                                  p_funcname => 'ShowGroups(hWndMDI,0)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу до рахунків ( 3 режима) ********** ');
          --  Створюємо функцію Встановлення доступу до рахунків ( 3 режима)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу до рахунків ( 3 режима)',
                                                  p_funcname => 'ShowGroups(hWndMDI,1)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу до рахунків  ********** ');
          --  Створюємо функцію Встановлення доступу до рахунків 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу до рахунків ',
                                                  p_funcname => 'ShowGroups(hWndMDI,3)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу [ групи користувачів -> групи рахунків ] ********** ');
          --  Створюємо функцію Встановлення доступу [ групи користувачів -> групи рахунків ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу [ групи користувачів -> групи рахунків ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,4)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу [ групи рахунків -> групи користувачів ] ********** ');
          --  Створюємо функцію Встановлення доступу [ групи рахунків -> групи користувачів ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу [ групи рахунків -> групи користувачів ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,5)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення доступу [ рахунки -> групи рахунків ] ********** ');
          --  Створюємо функцію Встановлення доступу [ рахунки -> групи рахунків ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення доступу [ рахунки -> групи рахунків ]',
                                                  p_funcname => 'ShowGroups(hWndMDI,6)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Импорт  БАРС  == > АБС БАРС-98 ********** ');
          --  Створюємо функцію Импорт  БАРС  == > АБС БАРС-98
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Импорт  БАРС  == > АБС БАРС-98',
                                                  p_funcname => 'ShowImportData()',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.НЕЗАВІЗОВАНІ документи-2 ********** ');
          --  Створюємо функцію 1.НЕЗАВІЗОВАНІ документи-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.НЕЗАВІЗОВАНІ документи-2',
                                                  p_funcname => 'ShowNotPayDok(0)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.НЕЗАВІЗОВАНІ документи ********** ');
          --  Створюємо функцію 1.НЕЗАВІЗОВАНІ документи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.НЕЗАВІЗОВАНІ документи',
                                                  p_funcname => 'ShowNotPayDok(1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ODB. Відкрити банківський день ********** ');
          --  Створюємо функцію ODB. Відкрити банківський день
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ODB. Відкрити банківський день',
                                                  p_funcname => 'ShowOpenBankDay()',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструктор операцій ********** ');
          --  Створюємо функцію Конструктор операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструктор операцій',
                                                  p_funcname => 'ShowOperEditor( hWndMDI, 9)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів ********** ');
          --  Створюємо функцію Друк звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -1)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування таблиць, що синхронізуються ********** ');
          --  Створюємо функцію Редагування таблиць, що синхронізуються
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування таблиць, що синхронізуються',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 1 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування каталогізованих запитів(розр) ********** ');
          --  Створюємо функцію Редагування каталогізованих запитів(розр)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування каталогізованих запитів(розр)',
                                                  p_funcname => 'ShowQueryEditor( hWndMDI, 3 )',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Заповнення позабалансових символів касплану ********** ');
          --  Створюємо функцію Заповнення позабалансових символів касплану
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Заповнення позабалансових символів касплану',
                                                  p_funcname => 'ShowRef(hWndMDI, 3,0,'''','''')',
                                                  p_rolename => 'RPBN002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Таблиця рахунків ВП, ЕВП, НКР ********** ');
          --  Створюємо функцію Таблиця рахунків ВП, ЕВП, НКР
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Таблиця рахунків ВП, ЕВП, НКР',
                                                  p_funcname => 'ShowRefCur(''RW'')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідники ********** ');
          --  Створюємо функцію Довідники
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідники',
                                                  p_funcname => 'ShowRefList(hWndMDI)',
                                                  p_rolename => 'REF0000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Журнал подій в АБС ********** ');
          --  Створюємо функцію Журнал подій в АБС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Журнал подій в АБС',
                                                  p_funcname => 'ShowSecurity()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ВПС. Повідомлення учасникам ВПС ********** ');
          --  Створюємо функцію ВПС. Повідомлення учасникам ВПС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ВПС. Повідомлення учасникам ВПС',
                                                  p_funcname => 'ShowSendMessage()',
                                                  p_rolename => 'TECH019' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Технологічні флаги ********** ');
          --  Створюємо функцію СЕП. Технологічні флаги
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Технологічні флаги',
                                                  p_funcname => 'ShowSetTechFlags()',
                                                  p_rolename => 'TOSS' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Технологічні рахунки ********** ');
          --  Створюємо функцію СЕП. Технологічні рахунки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Технологічні рахунки',
                                                  p_funcname => 'ShowTechAccountsEx(0)',
                                                  p_rolename => 'TECH001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Оновлення списку банків із S_UCH.DBF ********** ');
          --  Створюємо функцію СЕП. Оновлення списку банків із S_UCH.DBF
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Оновлення списку банків із S_UCH.DBF',
                                                  p_funcname => 'ShowUpdateBanks()',
                                                  p_rolename => 'TECH020' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поточний стан залучень та резерву на грн-3900 ********** ');
          --  Створюємо функцію Поточний стан залучень та резерву на грн-3900
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поточний стан залучень та резерву на грн-3900',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI, 3 )',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ по доступу ********** ');
          --  Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ по доступу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БАЛАНС-РАХУНОК-ДОКУМЕНТ по доступу',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,189)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ поточний BRANCH ********** ');
          --  Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ поточний BRANCH
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БАЛАНС-РАХУНОК-ДОКУМЕНТ поточний BRANCH',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,91893)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Перегляд Активних Користувачів ********** ');
          --  Створюємо функцію 1.Перегляд Активних Користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Перегляд Активних Користувачів',
                                                  p_funcname => 'Show_USERS(hWndMDI , FALSE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Активні користувачі ********** ');
          --  Створюємо функцію Активні користувачі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Активні користувачі',
                                                  p_funcname => 'Show_USERS(hWndMDI ,TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Активні користувачі ********** ');
          --  Створюємо функцію Активні користувачі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Активні користувачі',
                                                  p_funcname => 'Show_USERS(hWndMDI ,TRUE)',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Врегулювання нарах.% по еф.%-ній ставці по КП ********** ');
          --  Створюємо функцію Врегулювання нарах.% по еф.%-ній ставці по КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Врегулювання нарах.% по еф.%-ній ставці по КП',
                                                  p_funcname => 'SqlPrepareAndExecute(hSql(),"declare r_ int; BEGIN cck.cc_irr(''IRR'',0,bankdate-1, r_);COMMIT;END;")',
                                                  p_rolename => 'BARS010' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Управління доступом до банківських днів ********** ');
          --  Створюємо функцію Управління доступом до банківських днів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Управління доступом до банківських днів',
                                                  p_funcname => 'StatBankDay()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію VEGA - Адміністратор ********** ');
          --  Створюємо функцію VEGA - Адміністратор
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'VEGA - Адміністратор',
                                                  p_funcname => 'VEGA_Sel(hWndMDI,0,0,0,'''','''')',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка запитів ********** ');
          --  Створюємо функцію Обробка запитів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка запитів',
                                                  p_funcname => 'ZAPROS(hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Счета. Редактирование шаблонов договоров ********** ');
          --  Створюємо функцію Счета. Редактирование шаблонов договоров
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Счета. Редактирование шаблонов договоров',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''ACC%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Клієнти. Редагування шаблонів анкет фін.моніторингу ********** ');
          --  Створюємо функцію Клієнти. Редагування шаблонів анкет фін.моніторингу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Клієнти. Редагування шаблонів анкет фін.моніторингу',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''CUST%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPT0 Редагування шаблонів депозитних договорів фіз.осіб ********** ');
          --  Створюємо функцію DPT0 Редагування шаблонів депозитних договорів фіз.осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPT0 Редагування шаблонів депозитних договорів фіз.осіб',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''DPT%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію DPU1 Редагування шаблонів договорів юр.осіб ********** ');
          --  Створюємо функцію DPU1 Редагування шаблонів договорів юр.осіб
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'DPU1 Редагування шаблонів договорів юр.осіб',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''DPU%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити. Редагування шаблонів договорів ********** ');
          --  Створюємо функцію Кредити. Редагування шаблонів договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити. Редагування шаблонів договорів',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''KD%''  or id like ''CCK%''")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Ред. шаблонів договорів деп. сейфів ********** ');
          --  Створюємо функцію Ред. шаблонів договорів деп. сейфів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Ред. шаблонів договорів деп. сейфів',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''SKRN%'' ")',
                                                  p_rolename => 'CC_DOC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Редагування шаблонів договорів ********** ');
          --  Створюємо функцію Редагування шаблонів договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Редагування шаблонів договорів',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, "")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Справочник параметров (Филиал) ********** ');
          --  Створюємо функцію ФМ. Справочник параметров (Филиал)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Справочник параметров (Филиал)',
                                                  p_funcname => 's',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (ALLA) - Всі функції  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappALLA.sql =========*** En
PROMPT ===================================================================================== 
