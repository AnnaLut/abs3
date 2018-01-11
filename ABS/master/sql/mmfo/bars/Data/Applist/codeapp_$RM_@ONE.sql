PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@ONE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@ONE ***
  declare
    l_application_code varchar2(10 char) := '$RM_@ONE';
    l_application_name varchar2(300 char) := 'АРМ Клiринг по платiжним системам';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@ONE створюємо (або оновлюємо) АРМ АРМ Клiринг по платiжним системам ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1-2. Перегляд Зведеного звiту "Клiринг" ********** ');
          --  Створюємо функцію 1-2. Перегляд Зведеного звiту "Клiринг"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1-2. Перегляд Зведеного звiту "Клiринг"',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=MONEXRI[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З_дати>,TYPE=S),:E(SEM=По_дату>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію 2-1. Клiринговий розрахунок з операторасми СТП
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '2-1. Клiринговий розрахунок з операторасми СТП',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.monexDS(:B,:E,:S)][PAR=>:B(SEM=З_дати>,TYPE=D),:E(SEM=По_дату>,TYPE=D),:S(SEM=Код_систем),TYPE=C)][QST=>Виконати клiринговий розрахунок?][MSG=>OK!]',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник запитів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довідник запитів',
															  p_funcname => '/barsroot/sto/contract/getdisclaimerlist\S*',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довгострокове доручення на списання коштів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довгострокове доручення на списання коштів',
															  p_funcname => '/barsroot/w4/addregularpayment.aspx\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію 1-3. Вилучити НЕоброблений файл з протоколу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '1-3. Вилучити НЕоброблений файл з протоколу',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.DEL_FILE(:D,:N)][PAR=>:D(SEM=За dd.mm.yyyy>,TYPE=D),:N(SEM=Код по НБУ,TYPE=S)][EXEC=>BEFORE][MSG=>Виконано!]',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1-3. Вилучити НЕоброблений файл з протоколу ********** ');
          --  Створюємо функцію 1-3. Вилучити НЕоброблений файл з протоколу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1-3. Вилучити НЕоброблений файл з протоколу',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.DEL_FILE(:D,:N)][PAR=>:D(SEM=За dd.mm.yyyy>,TYPE=D),:N(SEM=Код по НБУ,TYPE=S)][EXEC=>BEFORE][MSG=>Виконано!]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2-1. Клiринговий розрахунок з операторасми СТП ********** ');
          --  Створюємо функцію 2-1. Клiринговий розрахунок з операторасми СТП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2-1. Клiринговий розрахунок з операторасми СТП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.monexDS(:B,:E,:S)][PAR=>:B(SEM=З_дати>,TYPE=D),:E(SEM=По_дату>,TYPE=D),:S(SEM=Код_систем),TYPE=C)][QST=>Виконати клiринговий розрахунок?][MSG=>OK!]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2-2. Клiринговий розрахунок з Агентами ********** ');
          --  Створюємо функцію 2-2. Клiринговий розрахунок з Агентами
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2-2. Клiринговий розрахунок з Агентами',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>monex.monex_KL(0)][QST=> Виконати Кліринг з СТП][MSG=>OK!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію BRAG-2.Довідник «Віртуальних Бранчів» ЮО в СТП ********** ');
          --  Створюємо функцію BRAG-2.Довідник «Віртуальних Бранчів» ЮО в СТП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BRAG-2.Довідник «Віртуальних Бранчів» ЮО в СТП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=BRANCH_UO&accessCode=0',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 0.Системи переводiв(СП), що дiють в ОБ ********** ');
          --  Створюємо функцію 0.Системи переводiв(СП), що дiють в ОБ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '0.Системи переводiв(СП), що дiють в ОБ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEX0&accessCode=0',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1-1. Перегляд Звiту "Клiринг" ********** ');
          --  Створюємо функцію 1-1. Перегляд Звiту "Клiринг"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1-1. Перегляд Звiту "Клiринг"',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEXR&accessCode=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію BRAG-3.Зв`язки систем СТП та їх користувачів-ЮО ********** ');
          --  Створюємо функцію BRAG-3.Зв`язки систем СТП та їх користувачів-ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BRAG-3.Зв`язки систем СТП та їх користувачів-ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEX_MV_UO&accessCode=0',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію BRAG-1.Довідник ЮО, що працюють в СТП ********** ');
          --  Створюємо функцію BRAG-1.Довідник ЮО, що працюють в СТП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BRAG-1.Довідник ЮО, що працюють в СТП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEX_UO&accessCode=0',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Імпорт файлів клірингу ********** ');
          --  Створюємо функцію Імпорт файлів клірингу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Імпорт файлів клірингу',
                                                  p_funcname => '/barsroot/sberutls/import_transfers.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_@ONE) - АРМ Клiринг по платiжним системам  ');
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
umu.add_report2arm(167,'$RM_@ONE');
umu.add_report2arm(3031,'$RM_@ONE');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@ONE.sql =========**
PROMPT ===================================================================================== 
