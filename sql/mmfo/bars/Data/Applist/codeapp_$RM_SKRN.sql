SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_SKRN.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_SKRN ***
  declare
    l_application_code varchar2(10 char) := '$RM_SKRN';
    l_application_name varchar2(300 char) := 'АРМ Депозитні сейфи';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_SKRN створюємо (або оновлюємо) АРМ АРМ Депозитні сейфи ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Амортизація ********** ');
          --  Створюємо функцію Амортизація
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Амортизація',
                                                  p_funcname => '/barsroot/safe-deposit/safeamort.aspx',
                                                  p_rolename => 'DEP_SKRN' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель депозитных сейфов ********** ');
          --  Створюємо функцію Портфель депозитных сейфов
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель депозитных сейфов',
                                                  p_funcname => '/barsroot/safe-deposit/safeportfolio.aspx',
                                                  p_rolename => 'DEP_SKRN' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію /barsroot/safe-deposit/safedealprint.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/safedealprint.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/safedealprint.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/safeportfolio.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/safeportfolio.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/safeportfolio.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/safedocinput.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/safedocinput.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/safedocinput.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/dialog/extraproperties.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/dialog/extraproperties.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/dialog/extraproperties.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/dialog/createsafe.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/dialog/createsafe.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/dialog/createsafe.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/dialog/binddocuments.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/dialog/binddocuments.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/dialog/binddocuments.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/safedeposit.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/safedeposit.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/safedeposit.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/dialog/custtype.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/dialog/custtype.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/dialog/custtype.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/dialog/safe_opendeal.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/dialog/safe_opendeal.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/dialog/safe_opendeal.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/safevisit.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/safevisit.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/safevisit.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Амортизація
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Амортизація',
                                                              p_funcname => '/barsroot/safe-deposit/safeamort.aspx',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію /barsroot/safe-deposit/safedealdocs.aspx
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '/barsroot/safe-deposit/safedealdocs.aspx',
                                                              p_funcname => '/barsroot/safe-deposit/safedealdocs.aspx\S*',
                                                              p_rolename => 'DEP_SKRN' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_SKRN) - АРМ Депозитні сейфи  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_SKRN.sql =========**
PROMPT ===================================================================================== 
