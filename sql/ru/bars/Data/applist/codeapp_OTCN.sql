SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_OTCN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  OTCN ***
  declare
    l_application_code varchar2(10 char) := 'OTCN';
    l_application_name varchar2(300 char) := 'АРМ Звітність НБУ';
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
     DBMS_OUTPUT.PUT_LINE(' OTCN створюємо (або оновлюємо) АРМ АРМ Звітність НБУ ');
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію <Бух.зведення док.дня> Формування Протоколу ********** ');
          --  Створюємо функцію <Бух.зведення док.дня> Формування Протоколу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<Бух.зведення док.дня> Формування Протоколу',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_ZVT_DOC(:D)][PAR=>:D(SEM=Звiтна_Дата DD.MM.YYYY>,TYPE=S)][MSG=>Сформовано]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд спецпараметрів рахунка (НБУ) ********** ');
          --  Створюємо функцію Перегляд спецпараметрів рахунка (НБУ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд спецпараметрів рахунка (НБУ)',
                                                  p_funcname => 'FunNSIEditF("SPEC1",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Ручна установка спецпараметрів ОБ  ********** ');
          --  Створюємо функцію Ручна установка спецпараметрів ОБ 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Ручна установка спецпараметрів ОБ ',
                                                  p_funcname => 'FunNSIEditF("SPEC1_INT",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  1.Ін-ція про суми коштів, зарезервованих на окремому рах. ********** ');
          --  Створюємо функцію  1.Ін-ція про суми коштів, зарезервованих на окремому рах.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' 1.Ін-ція про суми коштів, зарезервованих на окремому рах.',
                                                  p_funcname => 'FunNSIEditF("TMP_ISTVAL[PROC=>P_ISTVAL(:D)][PAR=>:D(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  4.Кред.оп.в ін.валюті,немає вал.виручки, видані після 28-12-2008 ********** ');
          --  Створюємо функцію  4.Кред.оп.в ін.валюті,немає вал.виручки, видані після 28-12-2008
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' 4.Кред.оп.в ін.валюті,немає вал.виручки, видані після 28-12-2008',
                                                  p_funcname => 'FunNSIEditF("V_111[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  3.Кред.оп.в ін.валюті, у яких немає вал.виручки ********** ');
          --  Створюємо функцію  3.Кред.оп.в ін.валюті, у яких немає вал.виручки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' 3.Кред.оп.в ін.валюті, у яких немає вал.виручки',
                                                  p_funcname => 'FunNSIEditF("V_11[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  2.Кредитні операції в ін.валюті, крім МБК ********** ');
          --  Створюємо функцію  2.Кредитні операції в ін.валюті, крім МБК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' 2.Кредитні операції в ін.валюті, крім МБК',
                                                  p_funcname => 'FunNSIEditF("V_1[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Коригування символу СК за останні 35 днів ********** ');
          --  Створюємо функцію Коригування символу СК за останні 35 днів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Коригування символу СК за останні 35 днів',
                                                  p_funcname => 'FunNSIEditF(''OPER_SK'',2 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення дод. реквізитів за всі дні для файлів 70,D3,C9,E2,2C,2D ********** ');
          --  Створюємо функцію Довведення дод. реквізитів за всі дні для файлів 70,D3,C9,E2,2C,2D
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення дод. реквізитів за всі дні для файлів 70,D3,C9,E2,2C,2D',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.REF in (select distinct REF from OTCN_TRACE_70) ","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення додаткових реквізитів за всі дні - документи всіх ********** ');
          --  Створюємо функцію Довведення додаткових реквізитів за всі дні - документи всіх
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення додаткових реквізитів за всі дні - документи всіх',
                                                  p_funcname => 'Sel000(hWndMDI,11,0,"oper.TT in (select TT from OP_RULES ) ","" )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд проводок ********** ');
          --  Створюємо функцію Перегляд проводок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд проводок',
                                                  p_funcname => 'Sel002(hWndMDI,14,0," "," ")',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звітність в НБУ ********** ');
          --  Створюємо функцію Звітність в НБУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звітність в НБУ',
                                                  p_funcname => 'ShowFilesNbu(hWndMDI) ',
                                                  p_rolename => 'RPBN002' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Заповнення позабалансових символів касплану ********** ');
          --  Створюємо функцію Заповнення позабалансових символів касплану
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Заповнення позабалансових символів касплану',
                                                  p_funcname => 'ShowRef(hWndMDI, 3,0,'''','''')',
                                                  p_rolename => 'RPBN002' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Технологічні рахунки ********** ');
          --  Створюємо функцію СЕП. Технологічні рахунки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Технологічні рахунки',
                                                  p_funcname => 'ShowTechAccountsEx(0)',
                                                  p_rolename => 'TECH001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Управління доступом до банківських днів ********** ');
          --  Створюємо функцію Управління доступом до банківських днів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Управління доступом до банківських днів',
                                                  p_funcname => 'StatBankDay()',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка запитів ********** ');
          --  Створюємо функцію Обробка запитів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка запитів',
                                                  p_funcname => 'ZAPROS(hWndMDI)',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (OTCN) - АРМ Звітність НБУ  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappOTCN.sql =========*** En
PROMPT ===================================================================================== 
