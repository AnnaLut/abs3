SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_BUHG.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_BUHG ***
  declare
    l_application_code varchar2(10 char) := '$RM_BUHG';
    l_application_name varchar2(300 char) := 'АРМ Головний Бухгалтер';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_BUHG створюємо (або оновлюємо) АРМ АРМ Головний Бухгалтер ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поточний стан рахунку 9760 ********** ');
          --  Створюємо функцію Поточний стан рахунку 9760
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поточний стан рахунку 9760',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=3791&mode=ro&force=1',
                                                  p_rolename => 'SALGL' ,    
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Оновлення рахунків(по доступу) ********** ');
          --  Створюємо функцію Оновлення рахунків(по доступу)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Оновлення рахунків(по доступу)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=2&t=1',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT ********** ');
          --  Створюємо функцію Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[NSIFUNCTION][PROC=> NLK_AUTO(''NL9'',''2909'',''56'')][QST=>Виконати .<Авто-разбор:Д.NL9/2909/56 -К/2620> ?][EXEC=>BEFORE][MSG=>Виконано!]',
                                                  p_rolename => '' ,    
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картотека ВПС-платежiв з проблемних РУ ********** ');
          --  Створюємо функцію Картотека ВПС-платежiв з проблемних РУ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картотека ВПС-платежiв з проблемних РУ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>P_KRYM_SEP(0,:R,''373960203017'',980)][PAR=>:R(SEM=REF1_або_ПУСТО,TYPE=N)][QST=>Виконати переадресацiю ?][MSG=>OK]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Незавізовані документи - 2  ********** ');
          --  Створюємо функцію Незавізовані документи - 2 
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Незавізовані документи - 2 ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DOC_NOT_VISA&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,    
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' *** Створюємо функцію "Обробка запитів" ***' );
    -- Створюємо функцію "Обробка запитів"
    l := l + 1;
    l_function_ids.extend(l);
    l_function_ids(l) := ABS_UTILS.ADD_FUNC( p_name     => 'Обробка запитів',
                                             p_funcname => '/barsroot/requestsProcessing/requestsProcessing',
                                             p_rolename => '',
                                             p_frontend => l_application_type_id
                                             );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' *** Створюємо функцію "Управління доступом до минулої банківської дати" ***' );
    -- Створюємо функцію "Управління доступом до минулої банківської дати"
    l := l + 1;
    l_function_ids.extend(l);
    l_function_ids(l) := ABS_UTILS.ADD_FUNC( p_name     => 'Управління доступом до минулої банківської дати'
                                           , p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FDAT_KF&accessCode=2'
                                           , p_rolename => null
                                           , p_frontend => l_application_type_id
                                           );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' *** Створюємо функцію "Перегляд неоплачених документів минулих днів" ***' );
    -- Створюємо функцію "Перегляд неоплачених документів минулих днів"
    l := l + 1;
    l_function_ids.extend(l);
    l_function_ids(l) := ABS_UTILS.ADD_FUNC( p_name     => 'Перегляд неоплачених документів минулих днів'
                                           , p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_NOT_PAID_DOCS[NSIFUNCTION]'
                                           , p_rolename => null
                                           , p_frontend => l_application_type_id
                                           );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' *** Створюємо функцію "Реанімація рахунків" ***' );
    -- Створюємо функцію "Реанімація рахунків"
    l := l + 1;
    l_function_ids.extend(l);
    l_function_ids(l) := ABS_UTILS.ADD_FUNC( p_name     => 'Реанімація рахунків'
                                           , p_funcname => '/barsroot/AccountRestore/AccountRestore/index'
                                           , p_rolename => null
                                           , p_frontend => l_application_type_id
                                           );

    DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||' Прикріпляємо ресурси функцій до даного АРМу ($RM_BUHG) - АРМ Головний Бухгалтер' );
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null)
    loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;

    DBMS_OUTPUT.PUT_LINE(' Bидані функції можливо потребують підтвердження - автоматично підтверджуємо їх ');
    for i in (select a.id
                from adm_resource_activity a
               where a.grantee_type_id = l_arm_resource_type_id and
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_BUHG.sql =========**
PROMPT ===================================================================================== 
