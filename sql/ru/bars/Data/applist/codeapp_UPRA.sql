SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_UPRA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  UPRA ***
  declare
    l_application_code varchar2(10 char) := 'UPRA';
    l_application_name varchar2(300 char) := 'АРМ Управління коррахунком';
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
     DBMS_OUTPUT.PUT_LINE(' UPRA створюємо (або оновлюємо) АРМ АРМ Управління коррахунком ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Архів документів ********** ');
          --  Створюємо функцію СЕП. Архів документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Архів документів',
                                                  p_funcname => 'DocViewListArc(hWndMDI,'''', '''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3900/980 Аналiз великих сум ********** ');
          --  Створюємо функцію 3900/980 Аналiз великих сум
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 Аналiз великих сум',
                                                  p_funcname => 'FunNSIEditF("N00_DON1[PROC=>PUL_DAT(:Par0,STRING_Null)][PAR=>:Par0(SEM=dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3902/04, 3903/04 Стан за перiод (стисло) ********** ');
          --  Створюємо функцію 3902/04, 3903/04 Стан за перiод (стисло)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3902/04, 3903/04 Стан за перiод (стисло)',
                                                  p_funcname => 'FunNSIEditF("N00_DON2[PROC=>PUL_DAT(:Par0,:Par1)][PAR=>:Par0(SEM=З dd.mm.yyyy>,TYPE=S),:Par1(SEM=По dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3901, 3902/04, 3903/04 Стан за перiод (по дням) ********** ');
          --  Створюємо функцію 3901, 3902/04, 3903/04 Стан за перiод (по дням)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3901, 3902/04, 3903/04 Стан за перiод (по дням)',
                                                  p_funcname => 'FunNSIEditF("N00_DON3[PROC=>PUL_DAT(:Par0,:Par1)][PAR=>:Par0(SEM=З dd.mm.yyyy>,TYPE=S),:Par1(SEM=По dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3900/980 Баланс оборотiв в розрiзi часу квитовки ********** ');
          --  Створюємо функцію 3900/980 Баланс оборотiв в розрiзi часу квитовки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 Баланс оборотiв в розрiзi часу квитовки',
                                                  p_funcname => 'FunNSIEditF("N00_HH[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=За dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3900/980 Баланс оборотiв в розрiзi часу+БР ********** ');
          --  Створюємо функцію 3900/980 Баланс оборотiв в розрiзi часу+БР
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 Баланс оборотiв в розрiзi часу+БР',
                                                  p_funcname => 'FunNSIEditF("N00_HH_NBS[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=За dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3900/980 Баланс оборотiв в розрiзi МФО ********** ');
          --  Створюємо функцію 3900/980 Баланс оборотiв в розрiзi МФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 Баланс оборотiв в розрiзi МФО',
                                                  p_funcname => 'FunNSIEditF("N00_MFO[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=За dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3900/980 Баланс оборотiв в розрiзi БР ********** ');
          --  Створюємо функцію 3900/980 Баланс оборотiв в розрiзi БР
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3900/980 Баланс оборотiв в розрiзi БР',
                                                  p_funcname => 'FunNSIEditF("N00_NBS[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=За dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Встановлення лімітів прямим учасникам ********** ');
          --  Створюємо функцію СЕП. Встановлення лімітів прямим учасникам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Встановлення лімітів прямим учасникам',
                                                  p_funcname => 'Sel014( hWndMDI, 9, 1, '''' ,'''')',
                                                  p_rolename => 'SETLIM01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи  (початковий Міжбанк) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи  (початковий Міжбанк)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи  (початковий Міжбанк)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11","arc_rrp.BLK =11")',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи  (ВСІ) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи  (ВСІ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи  (ВСІ)',
                                                  p_funcname => 'Sel014(hWndMDI,1,0,"11",'''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Інформація про файли (перегляд) ********** ');
          --  Створюємо функцію СЕП. Інформація про файли (перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Інформація про файли (перегляд)',
                                                  p_funcname => 'Sel014(hWndMDI,5,0,'''','''')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідники ********** ');
          --  Створюємо функцію Довідники
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідники',
                                                  p_funcname => 'ShowRefList(hWndMDI)',
                                                  p_rolename => 'REF0000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поточний стан залучень та резерву на грн-3900 ********** ');
          --  Створюємо функцію Поточний стан залучень та резерву на грн-3900
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поточний стан залучень та резерву на грн-3900',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI, 3 )',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ по доступу ********** ');
          --  Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ по доступу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БАЛАНС-РАХУНОК-ДОКУМЕНТ по доступу',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,189)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (UPRA) - АРМ Управління коррахунком  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappUPRA.sql =========*** En
PROMPT ===================================================================================== 
