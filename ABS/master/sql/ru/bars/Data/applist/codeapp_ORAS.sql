SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_ORAS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  ORAS ***
  declare
    l_application_code varchar2(10 char) := 'ORAS';
    l_application_name varchar2(300 char) := 'АРМ Адміністратора ORACLE STREAM';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_CENTURA;
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
     DBMS_OUTPUT.PUT_LINE(' ORAS створюємо (або оновлюємо) АРМ АРМ Адміністратора ORACLE STREAM ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: ORA STREAMS: Довiдники ********** ');
          --  Створюємо функцію ТВБВ: ORA STREAMS: Довiдники
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: ORA STREAMS: Довiдники',
                                                  p_funcname => 'Sel029(hWndMDI,3,1,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: ORA STREAMS: Пiдписчики ********** ');
          --  Створюємо функцію ТВБВ: ORA STREAMS: Пiдписчики
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: ORA STREAMS: Пiдписчики',
                                                  p_funcname => 'Sel029(hWndMDI,3,2,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: ORA STREAMS: Монiторинг ********** ');
          --  Створюємо функцію ТВБВ: ORA STREAMS: Монiторинг
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: ORA STREAMS: Монiторинг',
                                                  p_funcname => 'Sel029(hWndMDI,3,3,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ТВБВ: ORA STREAMS: Рахунки ********** ');
          --  Створюємо функцію ТВБВ: ORA STREAMS: Рахунки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ТВБВ: ORA STREAMS: Рахунки',
                                                  p_funcname => 'Sel029(hWndMDI,3,4,'''','''')',
                                                  p_rolename => 'AQ_ADMINISTRATOR_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (ORAS) - АРМ Адміністратора ORACLE STREAM  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappORAS.sql =========*** En
PROMPT ===================================================================================== 
