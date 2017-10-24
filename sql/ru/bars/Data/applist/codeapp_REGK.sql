SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_REGK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  REGK ***
  declare
    l_application_code varchar2(10 char) := 'REGK';
    l_application_name varchar2(300 char) := 'АРМ Реєстрація Клієнтів та Рахунків';
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
     DBMS_OUTPUT.PUT_LINE(' REGK створюємо (або оновлюємо) АРМ АРМ Реєстрація Клієнтів та Рахунків ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звіт про кільк. рах. ЮО та держ. органів ********** ');
          --  Створюємо функцію Звіт про кільк. рах. ЮО та держ. органів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звіт про кільк. рах. ЮО та держ. органів',
                                                  p_funcname => 'ExportCatQuery(5314,"=(select ''ZvitAccounts''||substr(ncks,2,3)||substr(bars_report.frmt_date(nvl(:sFdat1,to_char(gl.bd,''dd/mm/yyyy'')), ''DMY''),1,3)||''.TXT''  from rcukru where mfo=gl.kf)",7,"",TRUE)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Слияние и закрытие клиентов ********** ');
          --  Створюємо функцію Слияние и закрытие клиентов
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Слияние и закрытие клиентов',
                                                  p_funcname => 'FunNSIEdit("[PROC=>rnk2rnk(:r1,:r2)][PAR=>:r1(SEM=r1 закрываемый РНК,TYPE=S,REF=customer),:r2(SEM=r2 действующий РНК,TYPE=S,REF=customer)][MSG=>OK (Клиент r1 --> Клиент r2)]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Клієнти з недіючими рахунками ********** ');
          --  Створюємо функцію Клієнти з недіючими рахунками
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Клієнти з недіючими рахунками',
                                                  p_funcname => 'FunNSIEditF("NRU_NLS[NSIFUNCTION][PROC=>PUL.PUT(''DAT'',:D) ][PAR=>:D(SEM=Звітна_Дата,TYPE=S)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зм_на РНК установи банку на РНК кл_єнта ********** ');
          --  Створюємо функцію Зм_на РНК установи банку на РНК кл_єнта
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зм_на РНК установи банку на РНК кл_єнта',
                                                  p_funcname => 'FunNSIEditF("REPLACEMENT_RNK_INK",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Доповнення параметрами РКО рахунків в АБС ********** ');
          --  Створюємо функцію Доповнення параметрами РКО рахунків в АБС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Доповнення параметрами РКО рахунків в АБС',
                                                  p_funcname => 'FunNSIEditF(''V_RKO_ACCOUNTS'', 1|0x0010)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Контроль ПОМИЛКОВИХ спец.парам. OB22 ********** ');
          --  Створюємо функцію Контроль ПОМИЛКОВИХ спец.парам. OB22
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Контроль ПОМИЛКОВИХ спец.парам. OB22',
                                                  p_funcname => 'Sel040( hWndMDI, 22, 0 , "" ,"" )',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Підтвердження змін КК ********** ');
          --  Створюємо функцію Підтвердження змін КК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Підтвердження змін КК',
                                                  p_funcname => 'ShowCustomers(101, 1)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків  (загальна) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків  (загальна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків  (загальна)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,0,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків  (ФО-СПД) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків  (ФО-СПД)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків  (ФО-СПД)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,10,"")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків (ЮО) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків (ЮО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків (ЮО)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,2,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Реєстрація Клієнтів і Рахунків (ФО) ********** ');
          --  Створюємо функцію Реєстрація Клієнтів і Рахунків (ФО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Реєстрація Клієнтів і Рахунків (ФО)',
                                                  p_funcname => 'ShowCustomersByType(CVIEW_Closed,3,3,"##2012220#")',
                                                  p_rolename => 'CUST001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів у відкладеному режимі ********** ');
          --  Створюємо функцію Друк звітів у відкладеному режимі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів у відкладеному режимі',
                                                  p_funcname => 'ShowOutForms(hWndMDI, -2)',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Счета. Редактирование шаблонов договоров ********** ');
          --  Створюємо функцію Счета. Редактирование шаблонов договоров
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Счета. Редактирование шаблонов договоров',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''ACC%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Клієнти. Редагування шаблонів анкет фін.моніторингу ********** ');
          --  Створюємо функцію Клієнти. Редагування шаблонів анкет фін.моніторингу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Клієнти. Редагування шаблонів анкет фін.моніторингу',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''CUST%'' ")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (REGK) - АРМ Реєстрація Клієнтів та Рахунків  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappREGK.sql =========*** En
PROMPT ===================================================================================== 
