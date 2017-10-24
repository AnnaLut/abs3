SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_OPER.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_OPER ***
  declare
    l_application_code varchar2(10 char) := '$RM_OPER';
    l_application_name varchar2(300 char) := 'АРМ Операціоніста (Бек)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_OPER створюємо (або оновлюємо) АРМ АРМ Операціоніста (Бек) ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію NL9 Картотека 2909 внутрібанк(тип NL9) ********** ');
          --  Створюємо функцію NL9 Картотека 2909 внутрібанк(тип NL9)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NL9 Картотека 2909 внутрібанк(тип NL9)',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_nl__kart&nls_tip=nl9',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію  
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => ' ',
                                                              p_funcname => '/barsroot/docinput/docinput.aspx?\S*',
                                                              p_rolename => 'START1' ,    
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

      --  Створюємо дочірню функцію Історія рахунку
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Історія рахунку',
                                                              p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
                                                              p_rolename => '' ,    
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Коригування СК за 35 днів ********** ');
          --  Створюємо функцію Коригування СК за 35 днів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Коригування СК за 35 днів',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=OPER_SK&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'START1' ,    
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Сховище.Оприбуткування монет та футлярiв ********** ');
          --  Створюємо функцію Сховище.Оприбуткування монет та футлярiв
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Сховище.Оприбуткування монет та футлярiв',
                                                  p_funcname => '/barsroot/coin/coin_invoice.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення дод. реквізитів - всі документи відділення(WEB) ********** ');
          --  Створюємо функцію Довведення дод. реквізитів - всі документи відділення(WEB)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення дод. реквізитів - всі документи відділення(WEB)',
                                                  p_funcname => '/barsroot/docinput/editprops.aspx?mode=0',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення дод. реквізитів - документи користувача(WEB) ********** ');
          --  Створюємо функцію Довведення дод. реквізитів - документи користувача(WEB)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення дод. реквізитів - документи користувача(WEB)',
                                                  p_funcname => '/barsroot/docinput/editprops.aspx?mode=1',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Створення розпорядження по вибору ********** ');
          --  Створюємо функцію Створення розпорядження по вибору
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Створення розпорядження по вибору',
                                                  p_funcname => '/barsroot/dynamicLayout/static_layout.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Way4. Несквитовані документи (web)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Way4. Несквитовані документи (web)',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Відбір документів [ВХІДНІ ДОКУМЕНТИ] ********** ');
          --  Створюємо функцію ФМ. Відбір документів [ВХІДНІ ДОКУМЕНТИ]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Відбір документів [ВХІДНІ ДОКУМЕНТИ]',
                                                  p_funcname => '/barsroot/finmon/doc.aspx?filter=input',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію NL9 Картотека надходжень на конс. бал/рахунок 2909 (тип NL9) межб. ********** ');
          --  Створюємо функцію NL9 Картотека надходжень на конс. бал/рахунок 2909 (тип NL9) межб.
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NL9 Картотека надходжень на конс. бал/рахунок 2909 (тип NL9) межб.',
                                                  p_funcname => '/barsroot/gl/nl/index?tip=nl9&tt=010',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію NL9 Картотека 2909 зарахування на картковi рахунки (тип NL9) ********** ');
          --  Створюємо функцію NL9 Картотека 2909 зарахування на картковi рахунки (тип NL9)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'NL9 Картотека 2909 зарахування на картковi рахунки (тип NL9)',
                                                  p_funcname => '/barsroot/gl/nl/index?tip=nl9&tt=PKR',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прийом MOPER ********** ');
          --  Створюємо функцію Прийом MOPER
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прийом MOPER',
                                                  p_funcname => '/barsroot/moper/default.aspx?int=I00&ext=I01',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування %% на залишки по рахункам ********** ');
          --  Створюємо функцію Нарахування %% на залишки по рахункам
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування %% на залишки по рахункам',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=V_NOTPORTFOLIO_INT_RECKONING&sPar=[PROC=>npi_ui.prepare_portfolio_interest(:p_nbs,:currency,:date_to)][PAR=>:p_nbs(SEM=Балансовий рахунок,TYPE=C,REF=V_NOTPORTFOLIO_NBS),:currency(SEM=Код_Вал,TYPE=C),:date_to(SEM=Дата по,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Незавізовані документи ********** ');
          --  Створюємо функцію Незавізовані документи
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Незавізовані документи',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DOC_NOT_VISA_REF&accessCode=1',
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка запитів ********** ');
          --  Створюємо функцію Обробка запитів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка запитів',
                                                  p_funcname => '/barsroot/requestsProcessing/requestsProcessing',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 4.1:Інше списание (tt=PKD) ********** ');
          --  Створюємо функцію Iмпорт 4.1:Інше списание (tt=PKD)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 4.1:Інше списание (tt=PKD)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik&config=imp_4_1',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт 4.3: Імпорт коригуючих (096) ********** ');
          --  Створюємо функцію Імпорт 4.3: Імпорт коригуючих (096)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт 4.3: Імпорт коригуючих (096)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik&config=imp_4_3',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3.1: Зарплатнi файли (tt=PKS,sk=84) ********** ');
          --  Створюємо функцію Iмпорт 3.1: Зарплатнi файли (tt=PKS,sk=84)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3.1: Зарплатнi файли (tt=PKS,sk=84)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_3_1',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3.2: Пенсiйнi файли (tt=PKX,sk=87) ********** ');
          --  Створюємо функцію Iмпорт 3.2: Пенсiйнi файли (tt=PKX,sk=87)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3.2: Пенсiйнi файли (tt=PKX,sk=87)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_3_2',
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт 4.2: Імпорт річних коригуючих ********** ');
          --  Створюємо функцію Імпорт 4.2: Імпорт річних коригуючих
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт 4.2: Імпорт річних коригуючих',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_4_2',
                                                  p_rolename => 'bars_access_defrole' ,    
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
                                                              p_funcname => '/barsroot/sberutls/importproced.aspx',
                                                              p_rolename => 'WR_XMLIMP' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Запити на уточ.рекв.по плат. з рах.Вiддiл.i пiдлег ********** ');
          --  Створюємо функцію Запити на уточ.рекв.по плат. з рах.Вiддiл.i пiдлег
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Запити на уточ.рекв.по плат. з рах.Вiддiл.i пiдлег',
                                                  p_funcname => '/barsroot/sep/septz/index?mode=depNUsers',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк документів по валютним платежам corp2 ********** ');
          --  Створюємо функцію Друк документів по валютним платежам corp2
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк документів по валютним платежам corp2',
                                                  p_funcname => '/barsroot/tools/Load_corp2_docs.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_OPER) - АРМ Операціоніста (Бек)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_OPER.sql =========**
PROMPT ===================================================================================== 
