PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_MBDK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_MBDK ***
  declare
    l_application_code varchar2(10 char) := '$RM_MBDK';
    l_application_name varchar2(300 char) := 'АРМ Портфель МБДК';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_MBDK створюємо (або оновлюємо) АРМ АРМ Портфель МБДК ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію МБДК: Введення угод ********** ');
          --  Створюємо функцію МБДК: Введення угод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'МБДК: Введення угод',
                                                  p_funcname => '/barsroot/Mbdk/Deal/Index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд/заповнення параметрiв угод КП Банки для резерву 351 ********** ');
          --  Створюємо функцію Перегляд/заповнення параметрiв угод КП Банки для резерву 351
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд/заповнення параметрiв угод КП Банки для резерву 351',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CCK_BN[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=Звiтна_дата 01.MM.ГГГГ>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування %% по портфелю угод МБДК ********** ');
          --  Створюємо функцію Нарахування %% по портфелю угод МБДК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування %% по портфелю угод МБДК',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=V_MBDK_INT_RECKONING&sPar=[PROC=>mbk.prepare_portfolio_interest(:product,:partner,:currency,:date_to)][PAR=>:product(SEM=Вид угоди,TYPE=C,REF=V_MBDK_PRODUCT),:currency(SEM=Код_Вал,TYPE=C),:partner(SEM=Партнер,TYPE=C,REF=V_MBDK_PARTNER),:date_to(SEM=Дата по,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION]',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію МБДК: Портфель угод ********** ');
          --  Створюємо функцію МБДК: Портфель угод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'МБДК: Портфель угод',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_PORTFOLIO&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>VIDD IN (SELECT VIDD FROM V_MBDK_PRODUCT WHERE TIPP = 2)]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію МБДК: Портфель – інші запозичення банку ********** ');
          --  Створюємо функцію МБДК: Портфель – інші запозичення банку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'МБДК: Портфель – інші запозичення банку',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_MBDK_PORTFOLIO&accessCode=2&sPar=[NSIFUNCTION][CONDITIONS=>VIDD IN (SELECT VIDD FROM V_MBDK_PRODUCT WHERE TIPP = 1)]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Архів угод МБДК ********** ');
          --  Створюємо функцію Архів угод МБДК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Архів угод МБДК',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=v_mbdk_archive&accessCode=1&sPar=[NSIFUNCTION]',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_MBDK) - АРМ Портфель МБДК  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_MBDK.sql =========**
PROMPT ===================================================================================== 
