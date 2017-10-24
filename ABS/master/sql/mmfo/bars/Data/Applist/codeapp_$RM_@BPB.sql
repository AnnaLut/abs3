SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@BPB.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@BPB ***
  declare
    l_application_code varchar2(10 char) := '$RM_@BPB';
    l_application_name varchar2(300 char) := 'АРМ 1_ПБ';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@BPB створюємо (або оновлюємо) АРМ АРМ 1_ПБ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Автозаміна коду призначення у нез`ясованих платежах РУ (для 1ПБ) ********** ');
          --  Створюємо функцію Автозаміна коду призначення у нез`ясованих платежах РУ (для 1ПБ)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Автозаміна коду призначення у нез`ясованих платежах РУ (для 1ПБ)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_CIM_1PB_DOC[PROC=>p_cim_1pb_synk(:A,:B)][PAR=>:A(SEM=Звітна дата у форматі ДД/ММ/РРРР, TYPE=S),:B(SEM=Автозаміна Незясованих 2 Відмічених 1 Пусто 0 Не_виконувати,TYPE=S))][CONDITIONS=>vdat between trunc(last_day(add_months(to_date(:A, ''dd/mm/yyyy''),-2))+1) and trunc(last_day(add_months(to_date(:A, ''dd/mm/yyyy''),-1))+1)][EXEC=>BEFORE][EDIT_MODE=>MULTI_EDIT,CARRIAGE_RALLBACK]
',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1_ПБ. Додреквізити документів ********** ');
          --  Створюємо функцію 1_ПБ. Додреквізити документів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1_ПБ. Додреквізити документів',
                                                  p_funcname => '/barsroot/pb1/pb1/addrequisites',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1_ПБ. Формування звіту ********** ');
          --  Створюємо функцію 1_ПБ. Формування звіту
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1_ПБ. Формування звіту',
                                                  p_funcname => '/barsroot/pb1/pb1/formingreport',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_@BPB) - АРМ 1_ПБ  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@BPB.sql =========**
PROMPT ===================================================================================== 
