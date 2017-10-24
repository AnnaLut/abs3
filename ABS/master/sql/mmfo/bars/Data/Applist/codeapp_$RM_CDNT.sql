SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_CDNT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_CDNT ***
  declare
    l_application_code varchar2(10 char) := '$RM_CDNT';
    l_application_name varchar2(300 char) := 'АРМ Нотаріуси';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_CDNT створюємо (або оновлюємо) АРМ АРМ Нотаріуси ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідник нотаріусів ********** ');
          --  Створюємо функцію Довідник нотаріусів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідник нотаріусів',
                                                  p_funcname => '/barsroot/cdnt/notary/?mode=CA',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Довідник нотаріусів (редакт. акредитации)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (редакт. акредитации)',
                                                              p_funcname => '/barsroot/cdnt/notary/editaccreditation\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (создание акредитации)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (создание акредитации)',
                                                              p_funcname => '/barsroot/cdnt/notary/createaccreditation\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (створення нотаріуса)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (створення нотаріуса)',
                                                              p_funcname => '/barsroot/cdnt/notary/createnotary\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (оборты нотаріуса)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (оборты нотаріуса)',
                                                              p_funcname => '/barsroot/cdnt/notary/transactiondata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (вилучення нотаріуса)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (вилучення нотаріуса)',
                                                              p_funcname => '/barsroot/cdnt/notary/deletenotary\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (зміна нотаріуса)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (зміна нотаріуса)',
                                                              p_funcname => '/barsroot/cdnt/notary/editnotary\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (бизнесы)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (бизнесы)',
                                                              p_funcname => '/barsroot/cdnt/notary/getlistofbusiness\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (бранчи)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (бранчи)',
                                                              p_funcname => '/barsroot/cdnt/notary/getmfolist\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (головна довідника)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (головна довідника)',
                                                              p_funcname => '/barsroot/cdnt/notary/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (головна довідника)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (головна довідника)',
                                                              p_funcname => '/barsroot/cdnt/notary\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (закрыт. акредитации)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (закрыт. акредитации)',
                                                              p_funcname => '/barsroot/cdnt/notary/getnotarytypes\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (типы транзакций)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (типы транзакций)',
                                                              p_funcname => '/barsroot/cdnt/notary/transactiontypes\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (джерело даних довідника)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (джерело даних довідника)',
                                                              p_funcname => '/barsroot/cdnt/notary/indexdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (закрыт. акредитации)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (закрыт. акредитации)',
                                                              p_funcname => '/barsroot/cdnt/notary/closeaccreditation\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (акредитации нотаріуса)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (акредитации нотаріуса)',
                                                              p_funcname => '/barsroot/cdnt/notary/accreditationdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (типы акредитаций)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (типы акредитаций)',
                                                              p_funcname => '/barsroot/cdnt/notary/accreditationtypes\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (проксі метод екпорту в ексель)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (проксі метод екпорту в ексель)',
                                                              p_funcname => '/barsroot/notary/exporttoexcel\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (бизнесы акредитации)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (бизнесы акредитации)',
                                                              p_funcname => '/barsroot/cdnt/notary/getaccbusinesses\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (бранчи акредитации)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (бранчи акредитации)',
                                                              p_funcname => '/barsroot/cdnt/notary/getaccbranches\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (состояния акредитаций)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (состояния акредитаций)',
                                                              p_funcname => '/barsroot/cdnt/notary/accreditationstates\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідник нотаріусів ********** ');
          --  Створюємо функцію Довідник нотаріусів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідник нотаріусів',
                                                  p_funcname => '/barsroot/cdnt/notary/?mode=RU',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Довідник нотаріусів (оборты нотаріуса)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (оборты нотаріуса)',
                                                              p_funcname => '/barsroot/cdnt/notary/transactiondata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (бизнесы)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (бизнесы)',
                                                              p_funcname => '/barsroot/cdnt/notary/getlistofbusiness\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (головна довідника)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (головна довідника)',
                                                              p_funcname => '/barsroot/cdnt/notary/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (головна довідника)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (головна довідника)',
                                                              p_funcname => '/barsroot/cdnt/notary\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (джерело даних довідника)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (джерело даних довідника)',
                                                              p_funcname => '/barsroot/cdnt/notary/indexdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (бранчи)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (бранчи)',
                                                              p_funcname => '/barsroot/cdnt/notary/getbranches\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (акредитации нотаріуса)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (акредитации нотаріуса)',
                                                              p_funcname => '/barsroot/cdnt/notary/accreditationdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (типы акредитаций)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (типы акредитаций)',
                                                              p_funcname => '/barsroot/cdnt/notary/accreditationtypes\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Довідник нотаріусів (состояния акредитаций)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Довідник нотаріусів (состояния акредитаций)',
                                                              p_funcname => '/barsroot/cdnt/notary/accreditationstates\S*',
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_CDNT) - АРМ Нотаріуси  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_CDNT.sql =========**
PROMPT ===================================================================================== 
