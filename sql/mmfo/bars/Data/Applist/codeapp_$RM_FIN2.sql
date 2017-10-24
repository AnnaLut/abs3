SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_FIN2.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_FIN2 ***
  declare
    l_application_code varchar2(10 char) := '$RM_FIN2';
    l_application_name varchar2(300 char) := 'АРМ Фiнансовий стан позичальника';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_FIN2 створюємо (або оновлюємо) АРМ АРМ Фiнансовий стан позичальника ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунок фінстану ЮО ********** ');
          --  Створюємо функцію Розрахунок фінстану ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунок фінстану ЮО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_cust',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Карточка форми
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Карточка форми',
                                                              p_funcname => '/barsroot/credit/fin_nbu/fin_form_kpb.aspx?okpo=\S*frm=\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан розрахунок постанова 351
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Фінстан розрахунок постанова 351',
                                                              p_funcname => '/barsroot/credit/fin_nbu/credit_defolt_kons.aspx?\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан ЮО print
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Фінстан ЮО print',
                                                              p_funcname => '/barsroot/credit/fin_nbu/fin_list_conclusions.aspx?rnk=\S*nd=\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка клієнта фінстан ЮО
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Карточка клієнта фінстан ЮО',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан друк постанова 351
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Фінстан друк постанова 351',
                                                              p_funcname => '/barsroot/credit/fin_nbu/print_fin.aspx?\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан розрахунок постанова 351
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Фінстан розрахунок постанова 351',
                                                              p_funcname => '/barsroot/credit/fin_nbu/credit_defolt.aspx?\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Карточка форми',
                                                              p_funcname => '/barsroot/credit/fin_nbu/fin_form_obu.aspx?okpo=\S*frm=\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми2
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Карточка форми2',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_p\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Контроль форми
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Контроль форми',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_k\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан розрахунок постанова 351 History
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Фінстан розрахунок постанова 351 History',
                                                              p_funcname => '/barsroot/credit/fin_nbu/fin_list_dat.aspx?\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан ЮО застава
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Фінстан ЮО застава',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_obu_pawn\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка форми
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Карточка форми',
                                                              p_funcname => '/barsroot/credit/fin_nbu/fin_form.aspx?okpo=\S*frm=\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Фінстан визначення КВЕД
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Фінстан визначення КВЕД',
                                                              p_funcname => '/barsroot/credit/fin_nbu/fin_kved.aspx?okpo=\S*rnk=\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Карточка контролера фінстан ЮО
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Карточка контролера фінстан ЮО',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kontr\S*',
                                                              p_rolename => 'START1' ,    
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_FIN2) - АРМ Фiнансовий стан позичальника  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_FIN2.sql =========**
PROMPT ===================================================================================== 
