SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_@INP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  @INP ***
  declare
    l_application_code varchar2(10 char) := '@INP';
    l_application_name varchar2(300 char) := 'АРМ Цінні папери';
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
     DBMS_OUTPUT.PUT_LINE(' @INP створюємо (або оновлюємо) АРМ АРМ Цінні папери ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Форма по ієрархіям Y/H/Q/M/D ********** ');
          --  Створюємо функцію ЦП: Форма по ієрархіям Y/H/Q/M/D
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Форма по ієрархіям Y/H/Q/M/D',
                                                  p_funcname => 'FunNSIEditF("CP_HIERARCHY_REPORT[PROC=>p_cp_hierarchy_report(0,:B,:E,:Z,:P)][PAR=>:B(SEM=з,TYPE=D),:E(SEM=по,TYPE=D),:Z(SEM=Формувати так/ні =1/0,TYPE=N),:P(SEM=Y/H/Q/M/D,TYPE=C)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Форма для погашення простроченої заборгованості ********** ');
          --  Створюємо функцію ЦП: Форма для погашення простроченої заборгованості
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Форма для погашення простроченої заборгованості',
                                                  p_funcname => 'FunNSIEditF("V_CPDEAL_EXPPAY", 2)',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Переформування Форми KALENDAR ********** ');
          --  Створюємо функцію ЦП: Переформування Форми KALENDAR
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Переформування Форми KALENDAR',
                                                  p_funcname => 'FunNSIEditF("V_CP_KALENDAR[PROC=>CP_KALENDAR(0,:B,:E,:Z,:F,:P)][PAR=>:B(SEM=дата з <dd.mm.yyyy>,TYPE=D),:E(SEM=дата по <dd.mm.yyyy>,TYPE=D),:Z(SEM=Форм так/н_ 1/0,TYPE=N),:F(SEM=Форма=KLB/KLS,TYPE=C),:P(SEM=пер_од=Y/H/Q/M/D,TYPE=C)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Форма KALENDAR по ЦП (придбання) ********** ');
          --  Створюємо функцію ЦП: Форма KALENDAR по ЦП (придбання)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Форма KALENDAR по ЦП (придбання)',
                                                  p_funcname => 'FunNSIEditFFiltered("V_CP_KALENDAR_BUY",0,"frm=''KLB'' " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП: Форма KALENDAR по ЦП (продаж/погашення) ********** ');
          --  Створюємо функцію ЦП: Форма KALENDAR по ЦП (продаж/погашення)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП: Форма KALENDAR по ЦП (продаж/погашення)',
                                                  p_funcname => 'FunNSIEditFFiltered("V_CP_KALENDAR_SALE",0,"frm=''KLS'' " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію РЕПО: Портфель угод ********** ');
          --  Створюємо функцію РЕПО: Портфель угод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'РЕПО: Портфель угод',
                                                  p_funcname => 'Sel008( hWndMDI, 0, 1 ,"", "vidd in (1622, 1522)" ) ',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель Загальний ********** ');
          --  Створюємо функцію ЦП- Портфель Загальний
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель Загальний',
                                                  p_funcname => 'Sel008( hWndMDI, 20, 22, " 37392555, 35413555, 36412555, ", " " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель Загальний ********** ');
          --  Створюємо функцію ЦП- Портфель Загальний
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель Загальний',
                                                  p_funcname => 'Sel008( hWndMDI, 20, 8, " 354190701, 3541603001, 364120703, ", " " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію РЕПО: Введення угод + Платежi ********** ');
          --  Створюємо функцію РЕПО: Введення угод + Платежi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'РЕПО: Введення угод + Платежi',
                                                  p_funcname => 'Sel008( hWndMDI, 2001, 0 ,"#vidd in (1622, 1522)", "100" )',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію РЕПО: Введення угод + Платежi ********** ');
          --  Створюємо функцію РЕПО: Введення угод + Платежi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'РЕПО: Введення угод + Платежi',
                                                  p_funcname => 'Sel008( hWndMDI, 2001, 0 ,"#vidd in (1622, 1522)", "100" )',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію РЕПО: Введення угод + Платежi ********** ');
          --  Створюємо функцію РЕПО: Введення угод + Платежi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'РЕПО: Введення угод + Платежi',
                                                  p_funcname => 'Sel008( hWndMDI, 2001, 0 ,"#vidd in (1622, 1522)", "100" )',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Архiв угод ВАЛ ********** ');
          --  Створюємо функцію ЦП- Архiв угод ВАЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Архiв угод ВАЛ',
                                                  p_funcname => 'Sel008( hWndMDI, 21, 0, " ", " and KV!=980 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Архiв угод ГРН ********** ');
          --  Створюємо функцію ЦП- Архiв угод ГРН
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Архiв угод ГРН',
                                                  p_funcname => 'Sel008( hWndMDI, 21, 0, " ", " and KV=980 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель / Перегляд ********** ');
          --  Створюємо функцію ЦП- Портфель / Перегляд
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель / Перегляд',
                                                  p_funcname => 'Sel008( hWndMDI, 22, 0 ,"", "" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Візування угод в підрозділі ********** ');
          --  Створюємо функцію ЦП- Візування угод в підрозділі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Візування угод в підрозділі',
                                                  p_funcname => 'Sel008( hWndMDI, 24, 12 ,"", "" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Візування угод в підрозділі ********** ');
          --  Створюємо функцію ЦП- Візування угод в підрозділі
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Візування угод в підрозділі',
                                                  p_funcname => 'Sel008( hWndMDI, 24, 16 ,"", "" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель інших емітентів ВАЛ ********** ');
          --  Створюємо функцію ЦП- Портфель інших емітентів ВАЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель інших емітентів ВАЛ',
                                                  p_funcname => 'Sel008( hWndMDI, 25, 22, " 37392555, 35413555, 36412555, ", " and KV<>980 and TIP=1" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП*- Портфель інших емітентів ГРН (2 спец_ал_ст +бух) ********** ');
          --  Створюємо функцію ЦП*- Портфель інших емітентів ГРН (2 спец_ал_ст +бух)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП*- Портфель інших емітентів ГРН (2 спец_ал_ст +бух)',
                                                  p_funcname => 'Sel008( hWndMDI, 25, 22, " 37392555, 35413555, 36412555, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель інших емітентів ВАЛ ********** ');
          --  Створюємо функцію ЦП- Портфель інших емітентів ВАЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель інших емітентів ВАЛ',
                                                  p_funcname => 'Sel008( hWndMDI, 25, 8, " 354190701, 3541603001, 364120703, ", " and KV<>980 and TIP=1" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП*- Портфель інших емітентів ГРН (2 спец_ал_ст +бух) ********** ');
          --  Створюємо функцію ЦП*- Портфель інших емітентів ГРН (2 спец_ал_ст +бух)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП*- Портфель інших емітентів ГРН (2 спец_ал_ст +бух)',
                                                  p_funcname => 'Sel008( hWndMDI, 25, 8, " 354190701, 3541603001, 364120703, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель Власна емісія  ВАЛ ********** ');
          --  Створюємо функцію ЦП- Портфель Власна емісія  ВАЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель Власна емісія  ВАЛ',
                                                  p_funcname => 'Sel008( hWndMDI, 26, 22, " 37392555, 35413555, 36412555, ", " and KV<>980 and TIP=2" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель Власна емісія ГРН  ********** ');
          --  Створюємо функцію ЦП- Портфель Власна емісія ГРН 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель Власна емісія ГРН ',
                                                  p_funcname => 'Sel008( hWndMDI, 26, 22, " 37392555, 35413555, 36412555, ", " and KV=980 and TIP=2" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель Власна емісія  ВАЛ ********** ');
          --  Створюємо функцію ЦП- Портфель Власна емісія  ВАЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель Власна емісія  ВАЛ',
                                                  p_funcname => 'Sel008( hWndMDI, 26, 8, " 354190701, 3541603001, 364120703, ", " and KV<>980 and TIP=2" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель Власна емісія ГРН  ********** ');
          --  Створюємо функцію ЦП- Портфель Власна емісія ГРН 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель Власна емісія ГРН ',
                                                  p_funcname => 'Sel008( hWndMDI, 26, 8, " 354190701, 3541603001, 364120703, ", " and KV=980 and TIP=2" )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Проспекти емісії (Розміщення коштів) ********** ');
          --  Створюємо функцію ЦП- Проспекти емісії (Розміщення коштів)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Проспекти емісії (Розміщення коштів)',
                                                  p_funcname => 'Sel008( hWndMDI, 28, 1 ,"", "  " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Проспекти емісії (Залучення коштів) ********** ');
          --  Створюємо функцію ЦП- Проспекти емісії (Залучення коштів)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Проспекти емісії (Залучення коштів)',
                                                  p_funcname => 'Sel008( hWndMDI, 28, 2 ,"", "  " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель інших емітентів ГРН (3 спец_ал_ст) ********** ');
          --  Створюємо функцію ЦП- Портфель інших емітентів ГРН (3 спец_ал_ст)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель інших емітентів ГРН (3 спец_ал_ст)',
                                                  p_funcname => 'Sel008( hWndMDI,35, 22, " 37392555, 35413555, 36412555, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель інших емітентів ГРН (3 спец_ал_ст) ********** ');
          --  Створюємо функцію ЦП- Портфель інших емітентів ГРН (3 спец_ал_ст)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель інших емітентів ГРН (3 спец_ал_ст)',
                                                  p_funcname => 'Sel008( hWndMDI,35, 8, " 354190701, 3541603001, 364120703, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель інших емітентів ГРН (4 бухгалтер) ********** ');
          --  Створюємо функцію ЦП- Портфель інших емітентів ГРН (4 бухгалтер)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель інших емітентів ГРН (4 бухгалтер)',
                                                  p_funcname => 'Sel008( hWndMDI,45, 22, " 37392555, 35413555, 36412555, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ЦП- Портфель інших емітентів ГРН (4 бухгалтер) ********** ');
          --  Створюємо функцію ЦП- Портфель інших емітентів ГРН (4 бухгалтер)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ЦП- Портфель інших емітентів ГРН (4 бухгалтер)',
                                                  p_funcname => 'Sel008( hWndMDI,45, 8, " 354190701, 3541603001, 364120703, ", " and KV=980 and TIP=1 " )',
                                                  p_rolename => 'START1' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (@INP) - АРМ Цінні папери  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp@INP.sql =========*** En
PROMPT ===================================================================================== 
