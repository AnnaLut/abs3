SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_W4UO.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  W4UO ***
  declare
    l_application_code varchar2(10 char) := 'W4UO';
    l_application_name varchar2(300 char) := 'АРМ "БПК – Way4 (ЮО)"';
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
     DBMS_OUTPUT.PUT_LINE(' W4UO створюємо (або оновлюємо) АРМ АРМ "БПК – Way4 (ЮО)" ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Портфель БПК(ЮО) ********** ');
          --  Створюємо функцію Way4. Портфель БПК(ЮО)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Портфель БПК(ЮО)',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio_uo',
                                                  p_rolename => 'OW' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Way4.newdeal_uo
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Way4.newdeal_uo',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.newdeal_uo&rnk=\d+&proect_id=(\d+|-\d+)&card_code=\S+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4.product_uo
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Way4.product_uo',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.product_uo&formname=\S+&proect_id=(\d+|-\d+)&grp_code=\S+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4. rnk_uo
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Way4. rnk_uo',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.rnk_uo&proect_id=(\d+|-\d+)&card_code=\S+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Way4. customer_uo
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Way4. customer_uo',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.customer_uo&proect_id=(\d+|-\d+)&card_code=\S+&rnk=\d*&okpo=\S*&nmk=\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Підтвердження активації зарезервованих рахунків (ЮО) ********** ');
          --  Створюємо функцію Way4. Підтвердження активації зарезервованих рахунків (ЮО)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Підтвердження активації зарезервованих рахунків (ЮО)',
                                                  p_funcname => '/barsroot/bpkw4/ActivationReservedAccounts/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запит на миттєві картки ЮО ********** ');
          --  Створюємо функцію Way4. Запит на миттєві картки ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запит на миттєві картки ЮО',
                                                  p_funcname => '/barsroot/bpkw4/instantcard/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запити до CardMake ********** ');
          --  Створюємо функцію Way4. Запити до CardMake
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запити до CardMake',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CM_REQUEST[NSIFUNCTION]',
                                                  p_rolename => 'OW' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (W4UO) - АРМ "БПК – Way4 (ЮО)"  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappW4UO.sql =========*** En
PROMPT ===================================================================================== 
