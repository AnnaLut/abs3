SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_XOZD.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_XOZD ***
  declare
    l_application_code varchar2(10 char) := '$RM_XOZD';
    l_application_name varchar2(300 char) := 'АРМ Деб.заборг. за госп. діяльністю банку';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_XOZD створюємо (або оновлюємо) АРМ АРМ Деб.заборг. за госп. діяльністю банку ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ДЗ-0) В ЦА:Моделi закриття ДЗ ********** ');
          --  Створюємо функцію ДЗ-0) В ЦА:Моделi закриття ДЗ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ДЗ-0) В ЦА:Моделi закриття ДЗ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=XOZ_OB22[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ДЗ-1) В РУ+ГОУ:Складні оп.перерахування з рахунків ДЗ ********** ');
          --  Створюємо функцію ДЗ-1) В РУ+ГОУ:Складні оп.перерахування з рахунків ДЗ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ДЗ-1) В РУ+ГОУ:Складні оп.перерахування з рахунків ДЗ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=OPER_XOZ[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ДЗ-2) В РУ+ГОУ:Портфель ДЗ за госп діяльністю ********** ');
          --  Створюємо функцію ДЗ-2) В РУ+ГОУ:Портфель ДЗ за госп діяльністю
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ДЗ-2) В РУ+ГОУ:Портфель ДЗ за госп діяльністю',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_XOZACC[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію --!!-- ДЗ-4) В КЗНЧ:Відшкодування в ЦА госп.ДЗ, що виникла в РУ ********** ');
          --  Створюємо функцію --!!-- ДЗ-4) В КЗНЧ:Відшкодування в ЦА госп.ДЗ, що виникла в РУ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '--!!-- ДЗ-4) В КЗНЧ:Відшкодування в ЦА госп.ДЗ, що виникла в РУ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_XOZ_RU_CA[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію -----Розрахунок резерву Деб.заборг за г/д ********** ');
          --  Створюємо функцію -----Розрахунок резерву Деб.заборг за г/д
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '-----Розрахунок резерву Деб.заборг за г/д',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_REZ[NSIFUNCTION][PROC=>XOZ.REZ(:A,1)][PAR=>:A(SEM=Зв_дата_01-мм-pppp)][EXEC=>BEFORE][CONDITIONS=>NBU23_REZ.FDAT=z23.B and id like ''XOZ%'' ]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ДЗ-3) В РУ+ГОУ:ДЗ за госп діяльністю. Архiв. ********** ');
          --  Створюємо функцію ДЗ-3) В РУ+ГОУ:ДЗ за госп діяльністю. Архiв.
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ДЗ-3) В РУ+ГОУ:ДЗ за госп діяльністю. Архiв.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_XOZREF2[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_XOZD) - АРМ Деб.заборг. за госп. діяльністю банку  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_XOZD.sql =========**
PROMPT ===================================================================================== 
