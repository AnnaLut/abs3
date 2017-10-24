SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_BRON.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_BRON ***
  declare
    l_application_code varchar2(10 char) := '$RM_BRON';
    l_application_name varchar2(300 char) := 'АРМ Бронювання коштів на рахунках СГ';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_BRON створюємо (або оновлюємо) АРМ АРМ Бронювання коштів на рахунках СГ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Бронювання коштів: Ввод,Погодження ********** ');
          --  Створюємо функцію 1.Бронювання коштів: Ввод,Погодження
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Бронювання коштів: Ввод,Погодження',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=V_BROW_0[CONDITIONS=>V_BROW_0.SOS=0]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3.Бронювання коштів: Супровід ********** ');
          --  Створюємо функцію 3.Бронювання коштів: Супровід
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.Бронювання коштів: Супровід',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=V_BROW_10[NSIFUNCTION][CONDITIONS=>V_BROW_10.SOS=10]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4.Бронювання коштів: Архів ********** ');
          --  Створюємо функцію 4.Бронювання коштів: Архів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.Бронювання коштів: Архів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=V_BROW_15[CONDITIONS=>V_BROW_15.SOS>=14]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.Бронювання коштів: Активація ********** ');
          --  Створюємо функцію 2.Бронювання коштів: Активація
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.Бронювання коштів: Активація',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=V_BROW_6[CONDITIONS=>V_BROW_6.SOS=6]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію BRO%: Нарахування бонус-відсотків по довільну дату ********** ');
          --  Створюємо функцію BRO%: Нарахування бонус-відсотків по довільну дату
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'BRO%: Нарахування бонус-відсотків по довільну дату',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>BRO.INT_BRO(:D)][PAR=>:D(SEM=По дату включно,TYPE=D)][MSG=>Виконано !]")',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію "Корпоративний залишок"(cen) ********** ');
          --  Створюємо функцію "Корпоративний залишок"(cen)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"Корпоративний залишок"(cen)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V1_BRO&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_BRON) - АРМ Бронювання коштів на рахунках СГ  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_BRON.sql =========**
PROMPT ===================================================================================== 
