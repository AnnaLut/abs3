SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_BPKI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  BPKI ***
  declare
    l_application_code varchar2(10 char) := 'BPKI';
    l_application_name varchar2(300 char) := 'АРМ БПК-ПЦ. Імпорт файлів з ПЦ';
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
     DBMS_OUTPUT.PUT_LINE(' BPKI створюємо (або оновлюємо) АРМ АРМ БПК-ПЦ. Імпорт файлів з ПЦ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ-4. Комплексне виконання овердрафту ********** ');
          --  Створюємо функцію ПЦ-4. Комплексне виконання овердрафту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ-4. Комплексне виконання овердрафту',
                                                  p_funcname => 'FListRun(4, FALSE)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель БПК ********** ');
          --  Створюємо функцію Портфель БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель БПК',
                                                  p_funcname => 'FOBPC_Select(11, '''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Видалення необроблених транзакцій TRAN ********** ');
          --  Створюємо функцію ПЦ. Видалення необроблених транзакцій TRAN
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Видалення необроблених транзакцій TRAN',
                                                  p_funcname => 'FOBPC_Select(20,'''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд внутр. не заквитованих  документів ********** ');
          --  Створюємо функцію ПЦ. Перегляд внутр. не заквитованих  документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд внутр. не заквитованих  документів',
                                                  p_funcname => 'FOBPC_Select(3,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд зовніш. не заквитованих  документів ********** ');
          --  Створюємо функцію ПЦ. Перегляд зовніш. не заквитованих  документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд зовніш. не заквитованих  документів',
                                                  p_funcname => 'FOBPC_Select(5,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Архівація файлів прийнятих від ПЦ ********** ');
          --  Створюємо функцію ПЦ. Архівація файлів прийнятих від ПЦ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Архівація файлів прийнятих від ПЦ',
                                                  p_funcname => 'FOBPC_Select(9,"")',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ-3. Протокол розбіжностей лімітів ПЦ і Банку ********** ');
          --  Створюємо функцію ПЦ-3. Протокол розбіжностей лімітів ПЦ і Банку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ-3. Протокол розбіжностей лімітів ПЦ і Банку',
                                                  p_funcname => 'FunNSIEditF(''OBPC_ACC_LIMIT'',2)',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд невідповідностей рахунків ПЦ і банка ********** ');
          --  Створюємо функцію ПЦ. Перегляд невідповідностей рахунків ПЦ і банка
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд невідповідностей рахунків ПЦ і банка',
                                                  p_funcname => 'FunNSIEditF(''OBPC_BAD_ACC'', 2 | 0x0010)',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Перегляд невідповідностей залишків ПЦ і банка ********** ');
          --  Створюємо функцію ПЦ. Перегляд невідповідностей залишків ПЦ і банка
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Перегляд невідповідностей залишків ПЦ і банка',
                                                  p_funcname => 'FunNSIEditF(''OBPC_BAD_OST'', 2 | 0x0010)',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи по карткових рахунках ********** ');
          --  Створюємо функцію Документи по карткових рахунках
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи по карткових рахунках',
                                                  p_funcname => 'ShowAllDocs(hWndMDI,1,0,''(exists (select 1 from v_bpk_accounts where nls=a.nlsa) or exists (select 1 from v_bpk_accounts where nls=a.nlsb))'',''Документи по карткових рахунках'')',
                                                  p_rolename => 'RPBN001' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (BPKI) - АРМ БПК-ПЦ. Імпорт файлів з ПЦ  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappBPKI.sql =========*** En
PROMPT ===================================================================================== 
