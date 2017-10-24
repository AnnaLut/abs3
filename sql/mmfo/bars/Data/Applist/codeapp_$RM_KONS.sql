SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_KONS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_KONS ***
  declare
    l_application_code varchar2(10 char) := '$RM_KONS';
    l_application_name varchar2(300 char) := 'АРМ Конструювання схем перекриття - розщіплення';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_KONS створюємо (або оновлюємо) АРМ АРМ Конструювання схем перекриття - розщіплення ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування "своїх" операцій ********** ');
          --  Створюємо функцію Візування "своїх" операцій
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування "своїх" операцій',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Візування "своїх" операцій
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Візування "своїх" операцій',
                                                              p_funcname => '/barsroot/checkinner/documents.aspx?type=0&grpid=\w+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.CheckInner
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Сервіс додатку BarsWeb.CheckInner',
                                                              p_funcname => '/barsroot/checkinner/service.asmx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Динамічний макет - 2 ********** ');
          --  Створюємо функцію Динамічний макет - 2
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Динамічний макет - 2',
                                                  p_funcname => '/barsroot/dynamicLayout/dynamic_layout.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Динамічний макет - 3 ********** ');
          --  Створюємо функцію Динамічний макет - 3
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Динамічний макет - 3',
                                                  p_funcname => '/barsroot/dynamicLayout/dynamic_layout.aspx?type=3',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Створення розпорядження по вибору ********** ');
          --  Створюємо функцію Створення розпорядження по вибору
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Створення розпорядження по вибору',
                                                  p_funcname => '/barsroot/dynamicLayout/static_layout.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Way4. Несквитовані документи (web)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Way4. Несквитовані документи (web)',
                                                              p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Конструювання схем перекриття/розщеплення ********** ');
          --  Створюємо функцію Конструювання схем перекриття/розщеплення
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Конструювання схем перекриття/розщеплення',
                                                  p_funcname => '/barsroot/gl/schemebuilder',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття в БЮДЖЕТ ********** ');
          --  Створюємо функцію Перекриття в БЮДЖЕТ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття в БЮДЖЕТ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,1,'''',''A'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обнуление залишку ТОВ "ДІЄСА" на 17:00 ********** ');
          --  Створюємо функцію Обнуление залишку ТОВ "ДІЄСА" на 17:00
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обнуление залишку ТОВ "ДІЄСА" на 17:00',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,19,'''',''S'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекрития 2902-2600 ********** ');
          --  Створюємо функцію Перекрития 2902-2600
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекрития 2902-2600',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,2,'''',''S'',1)][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів РФ АТ "Укр.пожежно-страхова компанія" ********** ');
          --  Створюємо функцію Перекриття платежів РФ АТ "Укр.пожежно-страхова компанія"
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів РФ АТ "Укр.пожежно-страхова компанія"',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,7,'''',''S'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів (поточний залишок) sps = 1 ********** ');
          --  Створюємо функцію Перекриття платежів (поточний залишок) sps = 1
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів (поточний залишок) sps = 1',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,:GR,01,''S'')][PAR=>:GR(SEM=№ гр.перекриття,TYPE=N,REF=PEREKR_G)][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')][DESCR=>№ гр.перекриття]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів (поточний залишок-н.ліміт) sps =139 ********** ');
          --  Створюємо функцію Перекриття платежів (поточний залишок-н.ліміт) sps =139
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів (поточний залишок-н.ліміт) sps =139',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,:GR,139,''S'')][PAR=>:GR(SEM=№ гр.перекриття,TYPE=N,REF=PEREKR_G)][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')][DESCR=>№ гр.перекриття]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів (залишок на ранок) sps= 29 ********** ');
          --  Створюємо функцію Перекриття платежів (залишок на ранок) sps= 29
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів (залишок на ранок) sps= 29',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,:GR,29,''S'')][PAR=>:GR(SEM=№ гр.перекриття,TYPE=N,REF=PEREKR_G)][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')][DESCR=>№ гр.перекриття]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів (поточний залишок-блок.сума) sps = 39 ********** ');
          --  Створюємо функцію Перекриття платежів (поточний залишок-блок.сума) sps = 39
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів (поточний залишок-блок.сума) sps = 39',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,:GR,39,''S'')][PAR=>:GR(SEM=№ гр.перекриття,TYPE=N,REF=PEREKR_G)][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')][DESCR=>№ гр.перекриття]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів з комісією зг.тарифу 46 ********** ');
          --  Створюємо функцію Перекриття платежів з комісією зг.тарифу 46
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів з комісією зг.тарифу 46',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(3,:GR,'''',''A'')][PAR=>:GR(SEM=№ гр.перекриття,TYPE=N,REF=PEREKR_G)][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')][DESCR=>№ гр.перекриття]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Макети юридичних осіб ********** ');
	          --  Створюємо функцію Макети юридичних осіб
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Макети юридичних осіб',
                                                  p_funcname => '/barsroot/DynamicLayoutLegalEntities/DynamicLayoutLegalEntities/index?filter=true',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2603: Спец. схеми перекриття ********** ');
          --  Створюємо функцію 2603: Спец. схеми перекриття
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2603: Спец. схеми перекриття',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V2603[NSIFUNCTION][PROC=>PUL.Set_Mas_Ini(''IDG'', :G, STRING_Null)][PAR=>:G(SEM=№ гр.перекриття,TYPE=N,REF=PEREKR_G)][EXEC=>BEFORE][DESCR=>№ гр.перекриття]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Спецпараметри РАХУНКА для ручної установки ********** ');
          --  Створюємо функцію Спецпараметри РАХУНКА для ручної установки
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Спецпараметри РАХУНКА для ручної установки',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=SPEC1&accessCode=2',
                                                  p_rolename => 'bars_access_defrole' ,    
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
     
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Для КРИМА ********** ');
          --  Створюємо функцію Довідники NEW
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Рах 2600 (Крим) для  перенесення на 2903 та закриття',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||'sPar=V_NLS_KRM[NSIFUNCTION][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     
   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_KONS) - АРМ Конструювання схем перекриття - розщіплення  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_KONS.sql =========**
PROMPT ===================================================================================== 
