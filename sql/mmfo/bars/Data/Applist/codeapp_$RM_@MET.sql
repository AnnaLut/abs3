SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@MET.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@MET ***
  declare
    l_application_code varchar2(10 char) := '$RM_@MET';
    l_application_name varchar2(300 char) := 'АРМ Банківські метали';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@MET створюємо (або оновлюємо) АРМ АРМ Банківські метали ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БМ-КБ. Оптовий продаж виробів з БМ ********** ');
          --  Створюємо функцію БМ-КБ. Оптовий продаж виробів з БМ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БМ-КБ. Оптовий продаж виробів з БМ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_BM_WARE_RU_WEB&accessCode=2&sPar=[PAR=>:D(SEM=Дорога,TYPE=C),:G(SEM=Cумок,TYPE=C),:F(SEM=ПIБ,TYPE=C),:I(SEM=Пiдства,TYPE=C),:P(SEM=Документ,TYPE=C),:N(SEM=Серія Номер,TYPE=C),:A(SEM=Виданий,TYPE=C)][PROC=>BM_300465.SET_NLS(''36404111111547'',:D,:G,:F,:I,:P,:N,:A)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БМ-ФО. Роздрібний продаж виробів з БМ ********** ');
          --  Створюємо функцію БМ-ФО. Роздрібний продаж виробів з БМ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БМ-ФО. Роздрібний продаж виробів з БМ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_BM_WARE_RU_WEB&accessCode=2&sPar=[PAR=>:F(SEM=ПIБ,TYPE=C),:P(SEM=Документ,TYPE=C),:N(SEM=Серія Номер,TYPE=C),:A(SEM=Виданий,TYPE=C)][PROC=>BM_300465.SET_NLS(''10012'','''','''',:F,'''',:P,:N,:A)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БМ-РУ. Внутрішня передача виробів з БМ ********** ');
          --  Створюємо функцію БМ-РУ. Внутрішня передача виробів з БМ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БМ-РУ. Внутрішня передача виробів з БМ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_BM_WARE_RU_WEB&accessCode=2&sPar=[PAR=>:T(SEM=3903,REF=BM_3903),:D(SEM=Дорога,TYPE=C),:G(SEM=Cумок,TYPE=C),:F(SEM=ПIБ,TYPE=C),:I(SEM=Пiдстава,TYPE=C),:P(SEM=Документ,TYPE=C),:N(SEM=Серія Номер,TYPE=C),:A(SEM=Виданий,TYPE=C)][PROC=>BM_300465.SET_NLS(:T,:D,:G,:F,:I,:P,:N,:A)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_@MET) - АРМ Банківські метали  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@MET.sql =========**
PROMPT ===================================================================================== 
