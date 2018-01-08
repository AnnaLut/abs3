SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WINS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WINS ***
  declare
    l_application_code varchar2(10 char) := '$RM_WINS';
    l_application_name varchar2(300 char) := 'АРМ Портфель страхових договорів';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WINS створюємо (або оновлюємо) АРМ АРМ Портфель страхових договорів ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Акредитовані СК ********** ');
          --  Створюємо функцію Акредитовані СК
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Акредитовані СК',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_akrsk',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перевищення лімітів СК ********** ');
          --  Створюємо функцію Перевищення лімітів СК
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перевищення лімітів СК',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_brokenlims',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель договорів страхування ЮО ********** ');
          --  Створюємо функцію Портфель договорів страхування ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель договорів страхування ЮО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_portfolio&mode=2',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Картка страхового договору - договір застави
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка страхового договору - договір застави',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_card_grt&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка страхового договору - контрагент
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка страхового договору - контрагент',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_card_rnk&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка страхового договору
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка страхового договору',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_card_view&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Графік платежів за договором
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Графік платежів за договором',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_pay_sched&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель договорів страхування ФО ********** ');
          --  Створюємо функцію Портфель договорів страхування ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель договорів страхування ФО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_portfolio&mode=3',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Картка страхового договору
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка страхового договору',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_card_view&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Найближчі події ЮО ********** ');
          --  Створюємо функцію Найближчі події ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Найближчі події ЮО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_tasks&mode=2',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Картка страхового договору - договір застави
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка страхового договору - договір застави',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_card_grt&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка страхового договору - контрагент
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка страхового договору - контрагент',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_card_rnk&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Графік платежів за договором
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Графік платежів за договором',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_pay_sched&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Найближчі події ФО ********** ');
          --  Створюємо функцію Найближчі події ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Найближчі події ФО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_tasks&mode=3',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Картка страхового договору - договір застави
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка страхового договору - договір застави',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_card_grt&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Картка страхового договору - контрагент
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Картка страхового договору - контрагент',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_card_rnk&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Графік платежів за договором
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Графік платежів за договором',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ins_pay_sched&deal_id=\d+',
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
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_WINS) - АРМ Портфель страхових договорів  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WINS.sql =========**
PROMPT ===================================================================================== 
