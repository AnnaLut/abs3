SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_NALY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  NALY ***
  declare
    l_application_code varchar2(10 char) := 'NALY';
    l_application_name varchar2(300 char) := 'АРМ Податковий облік ОБ (закриття - відкриття року)';
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
     DBMS_OUTPUT.PUT_LINE(' NALY створюємо (або оновлюємо) АРМ АРМ Податковий облік ОБ (закриття - відкриття року) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Згортання рахункiв станом на 01.04.2011р  ********** ');
          --  Створюємо функцію  Згортання рахункiв станом на 01.04.2011р 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Згортання рахункiв станом на 01.04.2011р ',
                                                  p_funcname => 'F1_Select(13, "NAL8_0_2011(DAT);Виконати згортання датою 01-04-2011?;Списання сум  завершено!"  ) ',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Списання сум тимчасових рiзниць поточного року  ********** ');
          --  Створюємо функцію Списання сум тимчасових рiзниць поточного року 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Списання сум тимчасових рiзниць поточного року ',
                                                  p_funcname => 'F1_Select(13, "NAL8_0_88_12(DAT);Виконати списання сум?;Списання сум  завершено!"  ) ',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Згортання рахунків ПОД. обліку на ПОЧАТОК РОКУ ********** ');
          --  Створюємо функцію  Згортання рахунків ПОД. обліку на ПОЧАТОК РОКУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Згортання рахунків ПОД. обліку на ПОЧАТОК РОКУ',
                                                  p_funcname => 'F1_Select(13, "NAL8_0_OB22(DAT);Виконати згортання рахунк_в ПО на початок року?;Згортання завершено!"  ) ',
                                                  p_rolename => 'NALOG' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (NALY) - АРМ Податковий облік ОБ (закриття - відкриття року)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappNALY.sql =========*** En
PROMPT ===================================================================================== 
