SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_VALB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  VALB ***
  declare
    l_application_code varchar2(10 char) := 'VALB';
    l_application_name varchar2(300 char) := 'АРМ Валютний Бухгалтер ';
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
     DBMS_OUTPUT.PUT_LINE(' VALB створюємо (або оновлюємо) АРМ АРМ Валютний Бухгалтер  ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Стан платежів ********** ');
          --  Створюємо функцію СЕП. Стан платежів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Стан платежів',
                                                  p_funcname => 'DOC_PROC(TRUE)',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прием курсов НБУ(#99) + ЦА(KURSK___.val) ********** ');
          --  Створюємо функцію Прием курсов НБУ(#99) + ЦА(KURSK___.val)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прием курсов НБУ(#99) + ЦА(KURSK___.val)',
                                                  p_funcname => 'F1_Select ( 99, "")',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F/Розрахунок SPOT-курсу за результатами дня ********** ');
          --  Створюємо функцію F/Розрахунок SPOT-курсу за результатами дня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/Розрахунок SPOT-курсу за результатами дня',
                                                  p_funcname => 'F1_Select(12," SPOT_P ( 0, DAT) " ) ',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Start+Finish: Переоцiнка вал.зал.(техн) ********** ');
          --  Створюємо функцію Start+Finish: Переоцiнка вал.зал.(техн)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start+Finish: Переоцiнка вал.зал.(техн)',
                                                  p_funcname => 'F1_Select(5,'''')',
                                                  p_rolename => 'TECH005' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію KLP: Платiжнi доручення в iноз.валютi ********** ');
          --  Створюємо функцію KLP: Платiжнi доручення в iноз.валютi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'KLP: Платiжнi доручення в iноз.валютi',
                                                  p_funcname => 'FunNSIEditF("KLP_SWIFT",6 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію KLP: Заява на конверсiю валюти ********** ');
          --  Створюємо функцію KLP: Заява на конверсiю валюти
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'KLP: Заява на конверсiю валюти',
                                                  p_funcname => 'FunNSIEditF("KLP_ZCONV",6 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію KLP: Заява на купiвлю валюти ********** ');
          --  Створюємо функцію KLP: Заява на купiвлю валюти
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'KLP: Заява на купiвлю валюти',
                                                  p_funcname => 'FunNSIEditF("KLP_ZKUPP",6 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію KLP: Заява на продаж валюти ********** ');
          --  Створюємо функцію KLP: Заява на продаж валюти
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'KLP: Заява на продаж валюти',
                                                  p_funcname => 'FunNSIEditF("KLP_ZPROD",6 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію KLP: Вiдмова вiд заявки ********** ');
          --  Створюємо функцію KLP: Вiдмова вiд заявки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'KLP: Вiдмова вiд заявки',
                                                  p_funcname => 'FunNSIEditF("KLP_ZVIDM",6 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звiт про куп/прод. вал та результат ********** ');
          --  Створюємо функцію Звiт про куп/прод. вал та результат
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звiт про куп/прод. вал та результат',
                                                  p_funcname => 'FunNSIEditF("R6204[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=Дата_З,TYPE=S),:E(SEM=Дата_ПО,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стан рах.резерву та 3800/16 ********** ');
          --  Створюємо функцію Стан рах.резерву та 3800/16
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Стан рах.резерву та 3800/16',
                                                  p_funcname => 'FunNSIEditF("REZ_3800[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=За dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поточний стан 3800+3801. ********** ');
          --  Створюємо функцію Поточний стан 3800+3801.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поточний стан 3800+3801.',
                                                  p_funcname => 'FunNSIEditF("V3800T",0)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стан 3800<->3801 ********** ');
          --  Створюємо функцію Стан 3800<->3801
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Стан 3800<->3801',
                                                  p_funcname => 'FunNSIEditF("V3800_3801[PROC=>BS_2620(380 + :M,:D)][PAR=>:M(SEM=0=пот/1=день/2=мiс,TYPE=N),:D(SEM=Дата,TYPE=D)][EXEC=>BEFORE]",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стан рахункiв каси (1001,1002,1101,1102) ********** ');
          --  Створюємо функцію Стан рахункiв каси (1001,1002,1101,1102)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Стан рахункiв каси (1001,1002,1101,1102)',
                                                  p_funcname => 'FunNSIEditF("V_1001S[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=За dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стан рахунку 6204 ********** ');
          --  Створюємо функцію Стан рахунку 6204
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Стан рахунку 6204',
                                                  p_funcname => 'FunNSIEditF("V_6204S[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=За dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Стан вибраного Бал.рахунку ********** ');
          --  Створюємо функцію Стан вибраного Бал.рахунку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Стан вибраного Бал.рахунку',
                                                  p_funcname => 'FunNSIEditF("V_BBBBS[PROC=>PUL_DAT(:Par0,:NBS)][PAR=>:Par0(SEM=За dd.mm.yyyy>,TYPE=S),:NBS(SEM=Маска БР %%%%>,TYPE=S)][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Курси банківських металів ********** ');
          --  Створюємо функцію Курси банківських металів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Курси банківських металів',
                                                  p_funcname => 'FunNSIEditF("V_CENTR_KUBM_2013",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Таблиця - Матриця рахунків ВП-ЕВП-НКР-РКР ********** ');
          --  Створюємо функцію Таблиця - Матриця рахунків ВП-ЕВП-НКР-РКР
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Таблиця - Матриця рахунків ВП-ЕВП-НКР-РКР',
                                                  p_funcname => 'FunNSIEditF("V_VPLIST",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Start+Finish: Переоцiнка вал.поз.(бухг) ********** ');
          --  Створюємо функцію Start+Finish: Переоцiнка вал.поз.(бухг)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start+Finish: Переоцiнка вал.поз.(бухг)',
                                                  p_funcname => 'Pereocenka_VP()',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Пiдкрiплення Валютної Позицiї ********** ');
          --  Створюємо функцію Пiдкрiплення Валютної Позицiї
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Пiдкрiплення Валютної Позицiї',
                                                  p_funcname => 'Sel002(hWndMDI,11,0,"","")',
                                                  p_rolename => 'PYOD001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Гуртова передача вал.позицiї ********** ');
          --  Створюємо функцію Гуртова передача вал.позицiї
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Гуртова передача вал.позицiї',
                                                  p_funcname => 'Sel002(hWndMDI,30,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Розбір 3720  (ВАЛ) ********** ');
          --  Створюємо функцію СЕП. Розбір 3720  (ВАЛ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Розбір 3720  (ВАЛ)',
                                                  p_funcname => 'Sel014(hWndMDI,2,0,'''',''a.kv<>980'')',
                                                  p_rolename => 'BARS014' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Зарахування на рах iноз.iнвесторiв ********** ');
          --  Створюємо функцію Зарахування на рах iноз.iнвесторiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Зарахування на рах iноз.iнвесторiв',
                                                  p_funcname => 'Sel022(hWndMDI,11,0,"NLN","024")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-6.Var-аналiз ********** ');
          --  Створюємо функцію ANI-6.Var-аналiз
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-6.Var-аналiз',
                                                  p_funcname => 'Sel030(hWndMDI,6,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Касовi док., що завізовано з затримкою більше 15 хв. ********** ');
          --  Створюємо функцію Касовi док., що завізовано з затримкою більше 15 хв.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Касовi док., що завізовано з затримкою більше 15 хв.',
                                                  p_funcname => 'ShowAllDocs(hWndMDI,1,0," (a.nlsa like ''100%'' or a.nlsb like ''100%'') and exists (select 1 from oper_visa where ref=a.ref and status=2 and (dat-a.pdat)>1/96)", "Касовi док., що завізовано з затримкою більше 15 хв.")',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Таблиця рахунків ВП, ЕВП, НКР ********** ');
          --  Створюємо функцію Таблиця рахунків ВП, ЕВП, НКР
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Таблиця рахунків ВП, ЕВП, НКР',
                                                  p_funcname => 'ShowRefCur(''RW'')',
                                                  p_rolename => 'ABS_ADMIN' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (VALB) - АРМ Валютний Бухгалтер   ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappVALB.sql =========*** En
PROMPT ===================================================================================== 
