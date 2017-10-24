SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KONO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KONO ***
  declare
    l_application_code varchar2(10 char) := 'KONO';
    l_application_name varchar2(300 char) := 'АРМ Перекриття - розщіплення рахунків Операційного відділу';
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
     DBMS_OUTPUT.PUT_LINE(' KONO створюємо (або оновлюємо) АРМ АРМ Перекриття - розщіплення рахунків Операційного відділу ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2603:Спец.схеми перекриття ********** ');
          --  Створюємо функцію 2603:Спец.схеми перекриття
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2603:Спец.схеми перекриття',
                                                  p_funcname => 'FunNSIEditF("V2603[NSIFUNCTION][PROC=>PUL.Set_Mas_Ini( ''IDG'', Str(:G), STRING_Null)][PAR=>:G(SEM=№ гр.перекриття,TYPE=N,REF=PEREKR_G)][EXEC=>BEFORE]",2) ',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КР рах.2603-Рiзнi ********** ');
          --  Створюємо функцію КР рах.2603-Рiзнi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КР рах.2603-Рiзнi',
                                                  p_funcname => 'FunNSIEditF("V_DOKTIME[PROC=>PUL_DAT(:Par0,:Par1)][PAR=>:Par0(SEM=З dd.mm.yyyy>,TYPE=S),:Par1(SEM=По dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів  РОД ВАТ НАСК "Оранта" ********** ');
          --  Створюємо функцію Перекриття платежів  РОД ВАТ НАСК "Оранта"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів  РОД ВАТ НАСК "Оранта"',
                                                  p_funcname => 'Sel015(hWndMDI,11,5028,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів  "Велта" ********** ');
          --  Створюємо функцію Перекриття платежів  "Велта"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів  "Велта"',
                                                  p_funcname => 'Sel015(hWndMDI,11,6,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів РФ АТ "Укр.пожежно-страхова компанія" ********** ');
          --  Створюємо функцію Перекриття платежів РФ АТ "Укр.пожежно-страхова компанія"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів РФ АТ "Укр.пожежно-страхова компанія"',
                                                  p_funcname => 'Sel015(hWndMDI,11,7,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів РФ ДП "Документ" ********** ');
          --  Створюємо функцію Перекриття платежів РФ ДП "Документ"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів РФ ДП "Документ"',
                                                  p_funcname => 'Sel015(hWndMDI,11,8488,''S'','''')',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів з комісією зг.тарифу 46 ********** ');
          --  Створюємо функцію Перекриття платежів з комісією зг.тарифу 46
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів з комісією зг.тарифу 46',
                                                  p_funcname => 'Sel015(hWndMDI,3,0,"","")',
                                                  p_rolename => 'BARS015' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (KONO) - АРМ Перекриття - розщіплення рахунків Операційного відділу  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKONO.sql =========*** En
PROMPT ===================================================================================== 
