PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@PPZ.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@PPZ ***
  declare
    l_application_code      varchar2(10 char)  := '$RM_@PPZ';
    l_application_name      varchar2(300 char) := 'АРМ Технологічні договірні списання';
    l_application_type_id   integer            := user_menu_utl.APPLICATION_TYPE_WEB;
    l_function_ids          number_list        := number_list();
    l_function_codeoper     OPERLIST.CODEOPER%type;
    l_function_deps         OPERLIST.CODEOPER%type;
    l_application_id        integer;
    l_role_resource_type_id integer := resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE);
    l_arm_resource_type_id  integer := resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_application_type_id));
    l_func_resource_type_id integer := resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_application_type_id));
    l integer := 0;
    d integer := 0;
begin
    bc.go('/');
    DBMS_OUTPUT.PUT_LINE(' $RM_@PPZ створюємо (або оновлюємо) АРМ Технологічні договірні списання ');
    user_menu_utl.cor_arm(P_ARM_CODE            => l_application_code,
                          P_ARM_NAME            => l_application_name,
                          P_APPLICATION_TYPE_ID => l_application_type_id);
    
    -- отримуємо ідентифікатор створеного АРМу
    l_application_id := user_menu_utl.get_arm_id(l_application_code);

    DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||' ********** Створюємо функцію Перекриття по групам схем ********** ');
    -- Cтворюємо функцію Перекриття по групам схем
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l) := abs_utils.add_func(
                           p_name     => 'Перекриття по групам схем',
                           p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>SPS.PAY_SOME_PEREKR(:Param0)][PAR=>:Param0(SEM=ID групування,TYPE=N,REF=V_SPS_UNION)][EXEC=>BEFORE][MSG=>OK]',
                           p_rolename => 'BARS_ACCESS_DEFROLE',
                           p_frontend => l_application_type_id);
    

    DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||' ********** Створюємо функцію Технологічні перекриття в розрізі РУ ********** ');
    -- Створюємо функцію Технологічні перекриття в розрізі РУ
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l) := abs_utils.add_func(
                           p_name     => 'Технологічні перекриття в розрізі РУ',
                           p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>SPS.PAY_SOME_PEREKR(1)][QST=>Ви дійсно бажаєте виконати техн. списання?]',
                           p_rolename => 'BARS_ACCESS_DEFROLE',
                           p_frontend => l_application_type_id);
    

    DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||' ********** Створюємо функцію Технологічні перекриття в кінці операційного дня ********** ');
    -- створюємо функцію Технологічні перекриття в кінці операційного дня
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l) := abs_utils.add_func(
                           p_name     => 'Технологічні перекриття в кінці операційного дня',
                           p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>SPS.PAY_SOME_PEREKR(2)][QST=>Ви дійсно бажаєте виконати техн. списання?]',
                           p_rolename => 'BARS_ACCESS_DEFROLE',
                           p_frontend => l_application_type_id);
    

    DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||' ********** Створюємо функцію Довідники NEW ********** ');
    -- створюємо функцію Довідники NEW
    l := l +1;
    l_function_ids.extend(l);
    l_function_ids(l) := abs_utils.add_func(
                           p_name     => 'Довідники NEW',
                           p_funcname => '/barsroot/referencebook/referencelist/',
                           p_rolename => 'BARS_ACCESS_DEFROLE',
                           p_frontend => l_application_type_id);
    

    DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||' Прикріпляємо ресурси функцій до даного АРМу ($RM_@PPZ) - АРМ Технологічні договірні списання ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l) is not null) loop
      resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
      l := l_function_ids.next(l);
    end loop;
    
    
    DBMS_OUTPUT.PUT_LINE(' Bидані функції можливо потребують підтвердження - автоматично підтверджуємо їх ');
    for i in (select a.id
                from adm_resource_activity a
               where a.grantee_type_id = l_arm_resource_type_id
                 and a.resource_type_id = l_func_resource_type_id
                 and a.grantee_id = l_application_id
                 and a.resource_id in (select column_value from table(l_function_ids))
                 and a.access_mode_id = 1
                 and a.resolution_time is null)
    loop
      resource_utl.approve_resource_access(i.id, 'Автоматичне підтвердження прав на функції для АРМу');
    end loop;
    DBMS_OUTPUT.PUT_LINE(' Commit; ');
    commit;
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@PPZ.sql =========**
PROMPT ===================================================================================== 
