SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_WBPK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  WBPK ***
  declare
    l_application_code varchar2(10 char) := 'WBPK';
    l_application_name varchar2(300 char) := 'АРМ БПК';
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
     DBMS_OUTPUT.PUT_LINE(' WBPK створюємо (або оновлюємо) АРМ АРМ БПК ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Міграція картрахунків до Way4 ********** ');
          --  Створюємо функцію Міграція картрахунків до Way4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Міграція картрахунків до Way4',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.pkreopen',
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


      --  Створюємо дочірню функцію Iмпорт   : Розбiр документiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт   : Розбiр документiв',
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


      --  Створюємо дочірню функцію Iмпорт   : Розбiр документiв
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Iмпорт   : Розбiр документiв',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (WBPK) - АРМ БПК  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappWBPK.sql =========*** En
PROMPT ===================================================================================== 
