PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_KONO.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_KONO ***
  declare
    l_application_code varchar2(10 char) := '$RM_KONO';
    l_application_name varchar2(300 char) := 'АРМ Перекриття - розщіплення рахунків Операційного відділу';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_KONO створюємо (або оновлюємо) АРМ АРМ Перекриття - розщіплення рахунків Операційного відділу ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття залишків "Київ-Дніпровський" ********** ');
          --  Створюємо функцію Перекриття залишків "Київ-Дніпровський"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття залишків "Київ-Дніпровський"',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(1,6,'''','''')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів Нафтогаз (бюджет) ********** ');
          --  Створюємо функцію Перекриття платежів Нафтогаз (бюджет)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів Нафтогаз (бюджет)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(11,9,'''',''S'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття платежів з комісією зг.тарифу 46 ********** ');
          --  Створюємо функцію Перекриття платежів з комісією зг.тарифу 46
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття платежів з комісією зг.тарифу 46',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL015[NSIFUNCTION][PROC=>SPS.SEL015(3,:GR,'''',''A'')][PAR=>:GR(SEM=№ гр.перекриття,TYPE=S,REF=PEREKR_G)][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')][DESCR=>№ гр.перекриття]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перекриття по документу (Пр.пл. перв. док.) ********** ');
          --  Створюємо функцію Перекриття по документу (Пр.пл. перв. док.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перекриття по документу (Пр.пл. перв. док.)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TSEL023[NSIFUNCTION][PROC=>SPS.SEL023(7,77,''PER_INK_N'')][EXEC=>BEFORE][CONDITIONS=>US_ID=sys_context(''bars_global'',''user_id'')]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2603: Спец. схеми перекриття ********** ');
          --  Створюємо функцію 2603: Спец. схеми перекриття
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2603: Спец. схеми перекриття',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V2603[NSIFUNCTION][PROC=>PUL.Set_Mas_Ini(''IDG'', :G, STRING_Null)][PAR=>:G(SEM=№ гр.перекриття,TYPE=S,REF=PEREKR_G)][EXEC=>BEFORE][DESCR=>№ гр.перекриття]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію KP рах. 2603-Різні ********** ');
          --  Створюємо функцію KP рах. 2603-Різні
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'KP рах. 2603-Різні',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_DOKTIME[PROC=>PUL_DAT(to_char(:Par0,''dd.mm.yyyy''),to_char(:Par1,''dd.mm.yyyy''))][PAR=>:Par0(SEM=З dd.mm.yyyy>,TYPE=D),:Par1(SEM=По dd.mm.yyyy>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунки з Казнач.ЦА за КЗ ********** ');
          --  Створюємо функцію Розрахунки з Казнач.ЦА за КЗ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунки з Казнач.ЦА за КЗ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[NSIFUNCTION][PROC=> kaz_zobp(1)][QST=>Виконати розрахунки з Казнач.ЦА за КЗ?][EXEC=>BEFORE][MSG=>Виконано!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_KONO) - АРМ Перекриття - розщіплення рахунків Операційного відділу  ');
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
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_KONO.sql =========**
PROMPT ===================================================================================== 
