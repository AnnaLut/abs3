SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_FMON.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  FMON ***
  declare
    l_application_code varchar2(10 char) := 'FMON';
    l_application_name varchar2(300 char) := 'АРМ Уповноваженої особи Фінансового Моніторингу';
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
     DBMS_OUTPUT.PUT_LINE(' FMON створюємо (або оновлюємо) АРМ АРМ Уповноваженої особи Фінансового Моніторингу ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію XLS - Оборотно-сальдова вiдомiсть фiлiї (данi ф.#02) - аудит НБУ ********** ');
          --  Створюємо функцію XLS - Оборотно-сальдова вiдомiсть фiлiї (данi ф.#02) - аудит НБУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'XLS - Оборотно-сальдова вiдомiсть фiлiї (данi ф.#02) - аудит НБУ',
                                                  p_funcname => 'ExportCatQuery(4789,"", 8,"",TRUE)',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Перевірка клієнтів ********** ');
          --  Створюємо функцію ФМ. Перевірка клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Перевірка клієнтів',
                                                  p_funcname => 'F1_Select(13, ''klient_is_reft(DAT);Виконати перевірку всіх клієнтів банку?;Перевірку завершено. Перевірте довідник підозрілих клієнтів!'')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Документи ВСІХ користувачів ********** ');
          --  Створюємо функцію Документи ВСІХ користувачів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Документи ВСІХ користувачів',
                                                  p_funcname => 'F_Ctrl_D(TRUE)',
                                                  p_rolename => 'CHCK002' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Публічні діячі - перевірка належності клієнтів до публічних діячів ********** ');
          --  Створюємо функцію ФМ. Публічні діячі - перевірка належності клієнтів до публічних діячів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Публічні діячі - перевірка належності клієнтів до публічних діячів',
                                                  p_funcname => 'FunNSIEdit("[PROC=>finmon_check_public(0)][QST=>Виконати перевірку всіх клієнтів банку?][MSG=>Виконано!]")',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Підтвердження рівня ризику клієнтів ********** ');
          --  Створюємо функцію Підтвердження рівня ризику клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Підтвердження рівня ризику клієнтів',
                                                  p_funcname => 'FunNSIEditF("V_CUSTOMER_RIZIK[NSIFUNCTION]",1)',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Корегування рівня ризику клієнтів ********** ');
          --  Створюємо функцію Корегування рівня ризику клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Корегування рівня ризику клієнтів',
                                                  p_funcname => 'FunNSIEditF("V_CUST_R",1)',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Клієнти – публічні особи ********** ');
          --  Створюємо функцію ФМ. Клієнти – публічні особи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Клієнти – публічні особи',
                                                  p_funcname => 'FunNSIEditF(''FINMON_PUBLIC_CUSTOMERS'', 1)',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Підозрілі клієнти ********** ');
          --  Створюємо функцію ФМ. Підозрілі клієнти
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Підозрілі клієнти',
                                                  p_funcname => 'FunNSIEditF(''V_FM_KLIENT'', 1)',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк анкет ФМ по операціях без відкриття рахунків ********** ');
          --  Створюємо функцію Друк анкет ФМ по операціях без відкриття рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк анкет ФМ по операціях без відкриття рахунків',
                                                  p_funcname => 'FunNSIEditFFiltered("V_OPER_FM",1|0x0010,"PDAT >= SYSDATE-30")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Імпорт файлу публічних діячів ********** ');
          --  Створюємо функцію ФМ. Імпорт файлу публічних діячів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Імпорт файлу публічних діячів',
                                                  p_funcname => 'GeneralImpExp(hWndMDI, 3, 1, ''finmon_import_files(1, sFileName)'', '''')',
                                                  p_rolename => 'IMPEXP' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Вiдбiр документiв для Фiн. Монiторiнгу [ВСI ДОКУМЕНТИ] ********** ');
          --  Створюємо функцію ФМ. Вiдбiр документiв для Фiн. Монiторiнгу [ВСI ДОКУМЕНТИ]
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Вiдбiр документiв для Фiн. Монiторiнгу [ВСI ДОКУМЕНТИ]',
                                                  p_funcname => 'Sel005(hWndMDI,0,1,''NIBS7UT'','''')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ФМ. Імпорт файлу терористів ********** ');
          --  Створюємо функцію ФМ. Імпорт файлу терористів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ФМ. Імпорт файлу терористів',
                                                  p_funcname => 'Sel005(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'FINMON01' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів ********** ');
          --  Створюємо функцію Друк звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -1)',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (FMON) - АРМ Уповноваженої особи Фінансового Моніторингу  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappFMON.sql =========*** En
PROMPT ===================================================================================== 
