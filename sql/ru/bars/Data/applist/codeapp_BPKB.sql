SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_BPKB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  BPKB ***
  declare
    l_application_code varchar2(10 char) := 'BPKB';
    l_application_name varchar2(300 char) := 'АРМ БПК. Бухгалтер';
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
     DBMS_OUTPUT.PUT_LINE(' BPKB створюємо (або оновлюємо) АРМ АРМ БПК. Бухгалтер ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Документи, підготовлені для ПЦ ********** ');
          --  Створюємо функцію ПЦ. Документи, підготовлені для ПЦ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Документи, підготовлені для ПЦ',
                                                  p_funcname => 'DocViewListInt(hWndMDI,'' a.ref in (select ref from pkk_que where sos=0) and a.sos>=0'', ''Документи для ПЦ'' )',
                                                  p_rolename => 'RPBN001' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Прийом зарплатних файлів (txt, dbf) ********** ');
          --  Створюємо функцію ПЦ. Прийом зарплатних файлів (txt, dbf)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Прийом зарплатних файлів (txt, dbf)',
                                                  p_funcname => 'FOBPC_Select(14,'''')',
                                                  p_rolename => 'OBPC' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ПЦ. Поповнення карт. рахунків (по карт. рахунку) ********** ');
          --  Створюємо функцію ПЦ. Поповнення карт. рахунків (по карт. рахунку)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ПЦ. Поповнення карт. рахунків (по карт. рахунку)',
                                                  p_funcname => 'FOBPC_Select(17,'''')',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування "своїх" операцій ********** ');
          --  Створюємо функцію Візування "своїх" операцій
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування "своїх" операцій',
                                                  p_funcname => 'FunCheckDocumentsSel(1,''a.userid=''||Str(GetUserId()),'''',1,0)',
                                                  p_rolename => 'CHCK' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт   : Розбір документів ********** ');
          --  Створюємо функцію Iмпорт   : Розбір документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт   : Розбір документів',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 0, '''','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3.1: Зарплатнi файли (tt=PKS,sk=84) ********** ');
          --  Створюємо функцію Iмпорт 3.1: Зарплатнi файли (tt=PKS,sk=84)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3.1: Зарплатнi файли (tt=PKS,sk=84)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''3'',''imp_3_1'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт 3.2: Пенсiйнi файли (tt=PKX,sk=87) ********** ');
          --  Створюємо функцію Iмпорт 3.2: Пенсiйнi файли (tt=PKX,sk=87)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт 3.2: Пенсiйнi файли (tt=PKX,sk=87)',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 1, ''3'',''imp_3_2'')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iмпорт   : Розбір всіх відкладених документів ********** ');
          --  Створюємо функцію Iмпорт   : Розбір всіх відкладених документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iмпорт   : Розбір всіх відкладених документів',
                                                  p_funcname => 'GeneralImpExp(hWndMDI,2, 3, '''','''')',
                                                  p_rolename => 'OPER000' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування %% по рахунках заборг. 2207 ********** ');
          --  Створюємо функцію Нарахування %% по рахунках заборг. 2207
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування %% по рахунках заборг. 2207',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and s.ACC in (Select ACC_2207 from BPK_ACC)",''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування %% по рахунках заборг. 2202,2203 ********** ');
          --  Створюємо функцію Нарахування %% по рахунках заборг. 2202,2203
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування %% по рахунках заборг. 2202,2203',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and s.ACC in (Select ACC_OVR from BPK_ACC)",''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування %% по карт.рахунках 2625 ********** ');
          --  Створюємо функцію Нарахування %% по карт.рахунках 2625
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування %% по карт.рахунках 2625',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and s.ACC in (Select ACC_PK from BPK_ACC)",''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Введення документів ********** ');
          --  Створюємо функцію Введення документів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Введення документів',
                                                  p_funcname => 'Sel011(hWndMDI,2,1,'''','''')',
                                                  p_rolename => 'PYOD001' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (BPKB) - АРМ БПК. Бухгалтер  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappBPKB.sql =========*** En
PROMPT ===================================================================================== 
