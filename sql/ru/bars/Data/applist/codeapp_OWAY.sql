SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_OWAY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  OWAY ***
  declare
    l_application_code varchar2(10 char) := 'OWAY';
    l_application_name varchar2(300 char) := 'АРМ Інтерфейс з OpenWay';
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
     DBMS_OUTPUT.PUT_LINE(' OWAY створюємо (або оновлюємо) АРМ АРМ Інтерфейс з OpenWay ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Синхронізація З/П проектів CardMake ********** ');
          --  Створюємо функцію Way4. Синхронізація З/П проектів CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Синхронізація З/П проектів CardMake',
                                                  p_funcname => 'F1_Select(13,''bars_ow.cm_salary_sync(0)'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Протокол обробки файлів від ПЦ ********** ');
          --  Створюємо функцію Way4. Протокол обробки файлів від ПЦ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Протокол обробки файлів від ПЦ',
                                                  p_funcname => 'FOBPC_Select(101, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт та обробка файлів OIC*.xml ********** ');
          --  Створюємо функцію Way4. Імпорт та обробка файлів OIC*.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт та обробка файлів OIC*.xml',
                                                  p_funcname => 'FOBPC_Select(101, ''OIC'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт та обробка файлів комісій OIC_FTransfers*.xml ********** ');
          --  Створюємо функцію Way4. Імпорт та обробка файлів комісій OIC_FTransfers*.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт та обробка файлів комісій OIC_FTransfers*.xml',
                                                  p_funcname => 'FOBPC_Select(101, ''OIC_FTRANSFERS'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт файлу балансу CNG*.xml ********** ');
          --  Створюємо функцію Way4. Імпорт файлу балансу CNG*.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт файлу балансу CNG*.xml',
                                                  p_funcname => 'FOBPC_Select(102, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Обробка квитанцій R_IIC з Way4 ********** ');
          --  Створюємо функцію Way4. Обробка квитанцій R_IIC з Way4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Обробка квитанцій R_IIC з Way4',
                                                  p_funcname => 'FOBPC_Select(105, ''R_IIC'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Обробка квитанцій R_OIC з Way4 ********** ');
          --  Створюємо функцію Way4. Обробка квитанцій R_OIC з Way4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Обробка квитанцій R_OIC з Way4',
                                                  p_funcname => 'FOBPC_Select(105, ''R_OIC'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Формування файла поповнень/списань IIC_Documents*.xml для Way4 ********** ');
          --  Створюємо функцію Way4. Формування файла поповнень/списань IIC_Documents*.xml для Way4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Формування файла поповнень/списань IIC_Documents*.xml для Way4',
                                                  p_funcname => 'FOBPC_Select(106, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Формування файла IIC_Documents*.xml по док. погашення КД з 2625 ********** ');
          --  Створюємо функцію Way4. Формування файла IIC_Documents*.xml по док. погашення КД з 2625
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Формування файла IIC_Documents*.xml по док. погашення КД з 2625',
                                                  p_funcname => 'FOBPC_Select(106, ''1'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Формування файла IIC_Documents*.xml по док. регул.плат. ********** ');
          --  Створюємо функцію Way4. Формування файла IIC_Documents*.xml по док. регул.плат.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Формування файла IIC_Documents*.xml по док. регул.плат.',
                                                  p_funcname => 'FOBPC_Select(106, ''2'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Формування файла повернення платежів OIC*LOCPAY*.xml ********** ');
          --  Створюємо функцію Way4. Формування файла повернення платежів OIC*LOCPAY*.xml
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Формування файла повернення платежів OIC*LOCPAY*.xml',
                                                  p_funcname => 'FOBPC_Select(106, ''3'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Архів файлів IIC ********** ');
          --  Створюємо функцію Way4. Архів файлів IIC
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Архів файлів IIC',
                                                  p_funcname => 'FOBPC_Select(108, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Документи до відправки ********** ');
          --  Створюємо функцію Way4. Документи до відправки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Документи до відправки',
                                                  p_funcname => 'FOBPC_Select(109, ''0'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Несквитовані документи ********** ');
          --  Створюємо функцію Way4. Несквитовані документи
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Несквитовані документи',
                                                  p_funcname => 'FOBPC_Select(109, ''1'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Портфель БПК(ЮО) ********** ');
          --  Створюємо функцію Way4. Портфель БПК(ЮО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Портфель БПК(ЮО)',
                                                  p_funcname => 'FOBPC_Select(111, "substr(acc_nls,1,4) in (''2605'',''2655'',''2552'',''2554'')")',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Портфель БПК(ФО) ********** ');
          --  Створюємо функцію Way4. Портфель БПК(ФО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Портфель БПК(ФО)',
                                                  p_funcname => 'FOBPC_Select(111, "substr(acc_nls,1,4) not in (''2605'',''2655'',''2552'',''2554'')")',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт зарплатних проектів ********** ');
          --  Створюємо функцію Way4. Імпорт зарплатних проектів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт зарплатних проектів',
                                                  p_funcname => 'FOBPC_Select(115, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Архів файлів зарплатних проектів ********** ');
          --  Створюємо функцію Way4. Архів файлів зарплатних проектів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Архів файлів зарплатних проектів',
                                                  p_funcname => 'FOBPC_Select(116, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запити до CardMake ********** ');
          --  Створюємо функцію Way4. Запити до CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запити до CardMake',
                                                  p_funcname => 'FOBPC_Select(119, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запити до CardMake - перегляд ********** ');
          --  Створюємо функцію Way4. Запити до CardMake - перегляд
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запити до CardMake - перегляд',
                                                  p_funcname => 'FOBPC_Select(120, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт файлів на поновлення реквізитів клієнтів ********** ');
          --  Створюємо функцію Way4. Імпорт файлів на поновлення реквізитів клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт файлів на поновлення реквізитів клієнтів',
                                                  p_funcname => 'FOBPC_Select(122, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запит на миттєві картки ********** ');
          --  Створюємо функцію Way4. Запит на миттєві картки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запит на миттєві картки',
                                                  p_funcname => 'FOBPC_Select(123, '''')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт проектів PENSION ********** ');
          --  Створюємо функцію Way4. Імпорт проектів PENSION
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт проектів PENSION',
                                                  p_funcname => 'FOBPC_Select(127, ''PENSION'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт проектів SOCIAL ********** ');
          --  Створюємо функцію Way4. Імпорт проектів SOCIAL
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт проектів SOCIAL',
                                                  p_funcname => 'FOBPC_Select(127, ''SOCIAL'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перерахування комісійних доходів(віл. рекв.) ********** ');
          --  Створюємо функцію Перерахування комісійних доходів(віл. рекв.)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перерахування комісійних доходів(віл. рекв.)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>p_locpay_fee(:Param0)][PAR=>:Param0(SEM=Звiтна дата 01/mm/yyyy,TYPE=D)][MSG=>Віднесено комісію на доходи Банку]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Групове візування операцій OW6 ********** ');
          --  Створюємо функцію Групове візування операцій OW6
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Групове візування операцій OW6',
                                                  p_funcname => 'FunNSIEdit("[PROC=>visa_batch_ow6(97,100)][MSG=>Виконано успішно!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Зміна відділення за З/П проектом ********** ');
          --  Створюємо функцію Way4. Зміна відділення за З/П проектом
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Зміна відділення за З/П проектом',
                                                  p_funcname => 'FunNSIEdit(''[PROC=>p_w4_change_branch(:proect,:branch)][PAR=>:proect(SEM=З/П проект,REF=v_w4_proect_sal),:branch(SEM=Відділення,REF=branch)][MSG=>Бранч змінено]'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Виплати з рахункiв 2625/22(Комп.2012) ********** ');
          --  Створюємо функцію Виплати з рахункiв 2625/22(Комп.2012)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Виплати з рахункiв 2625/22(Комп.2012)',
                                                  p_funcname => 'FunNSIEditF("VDEB_2625_22[PROC=>PUL_DAT(:Par0,:Par1)][PAR=>:Par0(SEM=З dd.mm.yyyy>,TYPE=S),:Par1(SEM=По dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування документів для файла реверсала ********** ');
          --  Створюємо функцію Формування документів для файла реверсала
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування документів для файла реверсала',
                                                  p_funcname => 'FunNSIEditF("V_OW_FORM_REVERS",4 | 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Помилки при обробці файлу СМ на зміну номеру тел. ********** ');
          --  Створюємо функцію Way4. Помилки при обробці файлу СМ на зміну номеру тел.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Помилки при обробці файлу СМ на зміну номеру тел.',
                                                  p_funcname => 'FunNSIEditF(''OW_CL_INFO_DATA_ERROR'', 1 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель договорів кредитів під БПК ********** ');
          --  Створюємо функцію Портфель договорів кредитів під БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель договорів кредитів під БПК',
                                                  p_funcname => 'FunNSIEditF(''V_BPK_CREDIT_DEAL[NSIFUNCTION]'', 1 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Запити від CardMake ********** ');
          --  Створюємо функцію Way4. Запити від CardMake
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Запити від CardMake',
                                                  p_funcname => 'FunNSIEditF(''V_CM_ACC_REQUEST[PROC=>bars_ow.cm_process_request(0)][EXEC=>ONCE][QST=>Обробити запити?][MSG=>Запити оброблено]'', 4 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Арештовані рахунки - історія ********** ');
          --  Створюємо функцію Way4. Арештовані рахунки - історія
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Арештовані рахунки - історія',
                                                  p_funcname => 'FunNSIEditF(''V_OW_ACCHISTORY'',1)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Документи, що надійшли по системі «Клієнт банк» ********** ');
          --  Створюємо функцію Way4. Документи, що надійшли по системі «Клієнт банк»
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Документи, що надійшли по системі «Клієнт банк»',
                                                  p_funcname => 'FunNSIEditF(''V_OW_KLBAD'', 2)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Звірка балансів ********** ');
          --  Створюємо функцію Way4. Звірка балансів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Звірка балансів',
                                                  p_funcname => 'FunNSIEditF(''V_W4_BALANCE'', 1 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Звірка балансів(new) ********** ');
          --  Створюємо функцію Way4. Звірка балансів(new)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Звірка балансів(new)',
                                                  p_funcname => 'FunNSIEditF(''V_W4_BALANCE_TXT'', 1 | 0x0010)',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Арештовані рахунки до відправки ********** ');
          --  Створюємо функцію Way4. Арештовані рахунки до відправки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Арештовані рахунки до відправки',
                                                  p_funcname => 'FunNSIEditFFiltered(''V_OW_ACCQUE'',1,''sos=0'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Арештовані рахунки, що чекають квитовки ********** ');
          --  Створюємо функцію Way4. Арештовані рахунки, що чекають квитовки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Арештовані рахунки, що чекають квитовки',
                                                  p_funcname => 'FunNSIEditFFiltered(''V_OW_ACCQUE'',1,''sos=1'')',
                                                  p_rolename => 'OW' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Way4. Імпорт файлу з CM на зміну мобільного телефону ********** ');
          --  Створюємо функцію Way4. Імпорт файлу з CM на зміну мобільного телефону
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Way4. Імпорт файлу з CM на зміну мобільного телефону',
                                                  p_funcname => 'GeneralImpExp(hWndMDI, 3, 1, ''bars_ow.import_files(1, sFileName)'', '''')',
                                                  p_rolename => 'OW' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (OWAY) - АРМ Інтерфейс з OpenWay  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappOWAY.sql =========*** En
PROMPT ===================================================================================== 
