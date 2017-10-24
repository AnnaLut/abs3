SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_BUHG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  BUHG ***
  declare
    l_application_code varchar2(10 char) := 'BUHG';
    l_application_name varchar2(300 char) := 'АРМ Головний Бухгалтер';
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
     DBMS_OUTPUT.PUT_LINE(' BUHG створюємо (або оновлюємо) АРМ АРМ Головний Бухгалтер ');
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT ********** ');
          --  Створюємо функцію Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT',
                                                  p_funcname => 'F1_Select(13,"NLK_AUTO(''NL9'',''2909'',''56'');Вы хотите вып."Авто-разбор:Д.NL9/2909/56 -К/2620" ?; Выполнено !" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT ********** ');
          --  Створюємо функцію Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-разбор:NL9/2909/56 -> К.2620 по SWIFT',
                                                  p_funcname => 'F1_Select(13,"NLK_AUTO(''NL9'',''2909'',''56'');Вы хотите вып.<Авто-разбор:Д.NL9/2909/56 -К/2620> ?; Выполнено !" )',
                                                  p_rolename => 'PYOD001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій (весь банк) ********** ');
          --  Створюємо функцію Візування операцій (весь банк)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій (весь банк)',
                                                  p_funcname => 'FunCheckDocuments()',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій (свого відділення) ********** ');
          --  Створюємо функцію Візування операцій (свого відділення)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій (свого відділення)',
                                                  p_funcname => 'FunCheckDocumentsEx(hWndMDI, " a.TOBO = tobopack.GetTobo ")',
                                                  p_rolename => 'CHCK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдкриття рахункiв для роботи Бр-3 в MTI ********** ');
          --  Створюємо функцію Вiдкриття рахункiв для роботи Бр-3 в MTI
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдкриття рахункiв для роботи Бр-3 в MTI',
                                                  p_funcname => 'FunNSIEdit("[PROC=>MONEX_RU.OP_NLS_MTI(:B1,:B2,:B3,:B4,:B5)][PAR=>:B1(SEM=Б1,REF=BRANCH3),:B2(SEM=Б2,REF=BRANCH3),:B3(SEM=Б3,REF=BRANCH3),:B4(SEM=Б4,REF=BRANCH3),:B5(SEM=Б5,REF=BRANCH3)][MSG=>OK]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відкриття рахунків для казначейьких зобовязань. ********** ');
          --  Створюємо функцію Відкриття рахунків для казначейьких зобовязань.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відкриття рахунків для казначейьких зобовязань.',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BR_CP(:A,:B)][PAR=>:A(SEM=КАЗ.ЗОБ.,REF=V_CP_RETEIL),:B(SEM=Бранч,REF=BRANCH3)][MSG=>OK]")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-вiдкр.рах. по ВСIМ цiннос для 1-го бранчу 2,3 рiвня ********** ');
          --  Створюємо функцію Авто-вiдкр.рах. по ВСIМ цiннос для 1-го бранчу 2,3 рiвня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-вiдкр.рах. по ВСIМ цiннос для 1-го бранчу 2,3 рiвня',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BR_SX(:sPar1)][PAR=>:sPar1(SEM=Бранч,TYPE=S,REF=BRANCH)][MSG=>OK OP_BR_SX !]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-вiдкр.рах. по 1-й цiннос для бранчу 2,2+,3 рiвня ********** ');
          --  Створюємо функцію Авто-вiдкр.рах. по 1-й цiннос для бранчу 2,2+,3 рiвня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-вiдкр.рах. по 1-й цiннос для бранчу 2,2+,3 рiвня',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BR_SX1(:sPar1,:sPar2)][PAR=>:sPar1(SEM=Бранч,TYPE=S,REF=BRANCH_VAR),:sPar2(SEM=Цiннiсть,TYPE=S,REF=VALUABLES)][MSG=>OK OP_BR_SX1 !]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-вiдкр.рах. по БР+ОБ22 для всiх бранчiв 2 ********** ');
          --  Створюємо функцію Авто-вiдкр.рах. по БР+ОБ22 для всiх бранчiв 2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-вiдкр.рах. по БР+ОБ22 для всiх бранчiв 2',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BSOBV(0,:V,:A,'''','''','''','''')][PAR=>:V(SEM=Вал,TYPE=N),:A(SEM=ББББОО,REF=V_NBSOB22)][MSG=>OK]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-вiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня ********** ');
          --  Створюємо функцію Авто-вiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-вiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BSOBV(1,:V,:A,:B,'''','''',''''  )][PAR=>:V(SEM=Вал,TYPE=N),:A(SEM=ББББОО,REF=V_NBSOB22),:B(SEM=Бранч,REF=BRANCH_VAR)][MSG=>OK]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Авто-вiдкр.рах. по БР+ОБ22 для кiлькох бр(2,2+,3) ********** ');
          --  Створюємо функцію Авто-вiдкр.рах. по БР+ОБ22 для кiлькох бр(2,2+,3)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Авто-вiдкр.рах. по БР+ОБ22 для кiлькох бр(2,2+,3)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OP_BSOBV(2,:V,:A,:B,:C,:D,:E)][PAR=>:V(SEM=Вал,TYPE=N),:A(SEM=ББББОО,REF=V_NBSOB22),:B(SEM=Б-1,REF=BRANCH_VAR),:C(SEM=Б-2,REF=BRANCH_VAR),:D(SEM=Б-3,REF=BRANCH_VAR),:E(SEM=Б-4,REF=BRANCH_VAR)][MSG=>OK]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Привязать к 3800 соответствующие 6204 ********** ');
          --  Створюємо функцію Привязать к 3800 соответствующие 6204
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Привязать к 3800 соответствующие 6204',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_3800_6204(1)][MSG=>OK P_3800_6204 !]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СПОТ-курс = офф (если нет ничего) ********** ');
          --  Створюємо функцію СПОТ-курс = офф (если нет ничего)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СПОТ-курс = офф (если нет ничего)',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_3800_6204(2)][MSG=>OK P_3800_6204/2 !]")',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію HE_довiдкр.рах. по цiнностям(2.Вiдкр.+Перегляд) ********** ');
          --  Створюємо функцію HE_довiдкр.рах. по цiнностям(2.Вiдкр.+Перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'HE_довiдкр.рах. по цiнностям(2.Вiдкр.+Перегляд)',
                                                  p_funcname => 'FunNSIEditF(  "NOT_NLS98[PROC=>OP_BR_SXN(1)][EXEC=>BEFORE][MSG=>OK!]",2)',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію HE_довiдкр.рах. по цiнностям(1.Тiльки Перегляд) ********** ');
          --  Створюємо функцію HE_довiдкр.рах. по цiнностям(1.Тiльки Перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'HE_довiдкр.рах. по цiнностям(1.Тiльки Перегляд)',
                                                  p_funcname => 'FunNSIEditF( "NOT_NLS98" , 1 )',
                                                  p_rolename => 'CUST001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Позика <-> Забезпечення <-> Депозит ********** ');
          --  Створюємо функцію Позика <-> Забезпечення <-> Депозит
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Позика <-> Забезпечення <-> Депозит',
                                                  p_funcname => 'FunNSIEditF("CC_PAWN_DP",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iсторизацiя змiн ком.курсiв валют ********** ');
          --  Створюємо функцію Iсторизацiя змiн ком.курсiв валют
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iсторизацiя змiн ком.курсiв валют',
                                                  p_funcname => 'FunNSIEditF("CUR_RATE_KOM_UPD",1 | 0x0010)',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поточний стан рахунку 9760 ********** ');
          --  Створюємо функцію Поточний стан рахунку 9760
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поточний стан рахунку 9760',
                                                  p_funcname => 'FunNSIEditF("V9760",1)',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поточний стан: Кредитнi справи в сховищi ********** ');
          --  Створюємо функцію Поточний стан: Кредитнi справи в сховищi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поточний стан: Кредитнi справи в сховищi',
                                                  p_funcname => 'FunNSIEditF("V_ICCK[PROC=>ICCK(2)][EXEC=>BEFORE][MSG=>OK!]",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд проводок по Компенсації звіт №999990 ********** ');
          --  Створюємо функцію Перегляд проводок по Компенсації звіт №999990
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд проводок по Компенсації звіт №999990',
                                                  p_funcname => 'FunNSIEditF(''TMP_9760_2013'',2)',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перерозподiл комiсiї ГОУ за СЕП-платежi ********** ');
          --  Створюємо функцію Перерозподiл комiсiї ГОУ за СЕП-платежi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перерозподiл комiсiї ГОУ за СЕП-платежi',
                                                  p_funcname => 'Sel002(hWndMDI,18,1,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Створення розпорядження по вибору ********** ');
          --  Створюємо функцію Створення розпорядження по вибору
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Створення розпорядження по вибору',
                                                  p_funcname => 'Sel002(hWndMDI,19,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Динамiчний макет-2 ********** ');
          --  Створюємо функцію Динамiчний макет-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Динамiчний макет-2',
                                                  p_funcname => 'Sel002(hWndMDI,29,0,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Динамiчний макет-3 ********** ');
          --  Створюємо функцію Динамiчний макет-3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Динамiчний макет-3',
                                                  p_funcname => 'Sel002(hWndMDI,29,1,"","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Історія змін базових % ставок ********** ');
          --  Створюємо функцію Історія змін базових % ставок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Історія змін базових % ставок',
                                                  p_funcname => 'Sel010(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунки з Казнач.ЦА за КЗ ********** ');
          --  Створюємо функцію Розрахунки з Казнач.ЦА за КЗ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунки з Казнач.ЦА за КЗ',
                                                  p_funcname => 'Sel023(hWndMDI,391,NUMBER_Null,"KAZ_ZOBT,KAZ_ZOBP(0)","")',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Згортання рах 6-7 класу (ребранчинг) ********** ');
          --  Створюємо функцію Згортання рах 6-7 класу (ребранчинг)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Згортання рах 6-7 класу (ребранчинг)',
                                                  p_funcname => 'Sel023(hWndMDI,7,10,"PER_REBRANCH","")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Установка курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО ********** ');
          --  Створюємо функцію Установка курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Установка курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО',
                                                  p_funcname => 'Sel025( hWndMDI,96, 0, " ", "0" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО ********** ');
          --  Створюємо функцію Перегляд курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд курсів КУПІВЛІ-ПРОДАЖУ USD, EUR, RUB в ТОБО',
                                                  p_funcname => 'Sel025( hWndMDI,96, 1, " ", "0" )',
                                                  p_rolename => 'PYOD001' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Встановлення торгових курсів купівлі/продажу валют підрозділів банку ********** ');
          --  Створюємо функцію Встановлення торгових курсів купівлі/продажу валют підрозділів банку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Встановлення торгових курсів купівлі/продажу валют підрозділів банку',
                                                  p_funcname => 'Sel028(hWndMDI,1,1,'''','''')',
                                                  p_rolename => 'ABS_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналiз балансу за перiод ********** ');
          --  Створюємо функцію Аналiз балансу за перiод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналiз балансу за перiод',
                                                  p_funcname => 'Sel030(hWndMDI,22,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ОБ-БЮДЖЕТ в стуктурi показникiв (б/р 6-7 кл) ********** ');
          --  Створюємо функцію ОБ-БЮДЖЕТ в стуктурi показникiв (б/р 6-7 кл)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ОБ-БЮДЖЕТ в стуктурi показникiв (б/р 6-7 кл)',
                                                  p_funcname => 'Sel030(hWndMDI,4,0,"","")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Оновлення Рахунків ********** ');
          --  Створюємо функцію Оновлення Рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Оновлення Рахунків',
                                                  p_funcname => 'ShowAccList(0, AVIEW_USER, AVIEW_Linked | AVIEW_Limit | AVIEW_Financial | AVIEW_Interest | AVIEW_Access | AVIEW_Special, '''')',
                                                  p_rolename => 'CUST001' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ поточний BRANCH ********** ');
          --  Створюємо функцію БАЛАНС-РАХУНОК-ДОКУМЕНТ поточний BRANCH
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'БАЛАНС-РАХУНОК-ДОКУМЕНТ поточний BRANCH',
                                                  p_funcname => 'Show_Sal_GL(hWndMDI,91893)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (BUHG) - АРМ Головний Бухгалтер  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappBUHG.sql =========*** En
PROMPT ===================================================================================== 
