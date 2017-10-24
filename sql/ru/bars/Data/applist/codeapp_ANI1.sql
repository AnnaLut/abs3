SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_ANI1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  ANI1 ***
  declare
    l_application_code varchar2(10 char) := 'ANI1';
    l_application_name varchar2(300 char) := 'АРМ Аналітичні функції';
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
     DBMS_OUTPUT.PUT_LINE(' ANI1 створюємо (або оновлюємо) АРМ АРМ Аналітичні функції ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Матриця БР=2620,2625,2630,2635; Вал=980,840,978 ********** ');
          --  Створюємо функцію Матриця БР=2620,2625,2630,2635; Вал=980,840,978
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Матриця БР=2620,2625,2630,2635; Вал=980,840,978',
                                                  p_funcname => 'ExportCatQuery(4356,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Матриця Бал.Рах. 6*, 7* по Бранч-2 ********** ');
          --  Створюємо функцію Матриця Бал.Рах. 6*, 7* по Бранч-2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Матриця Бал.Рах. 6*, 7* по Бранч-2',
                                                  p_funcname => 'ExportCatQuery(4357,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Матриця Бал.Рах. 6*, 7* по Бранч-2 (з корр) ********** ');
          --  Створюємо функцію Матриця Бал.Рах. 6*, 7* по Бранч-2 (з корр)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Матриця Бал.Рах. 6*, 7* по Бранч-2 (з корр)',
                                                  p_funcname => 'ExportCatQuery(4648,"",8,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Уточнення Бранч-3 для фiн.рез ********** ');
          --  Створюємо функцію Уточнення Бранч-3 для фiн.рез
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Уточнення Бранч-3 для фiн.рез',
                                                  p_funcname => 'FunNSIEdit("V_FINREZ[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З dd.mm.yyyy),:E(SEM=По dd.mm.yyyy)][EXEC=>BEFORE],2")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поперед.мiс Баланс (по доступу) ББББ+Бранч ********** ');
          --  Створюємо функцію Поперед.мiс Баланс (по доступу) ББББ+Бранч
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поперед.мiс Баланс (по доступу) ББББ+Бранч',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_PMZ",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Попереднiй Баланс (по доступу) ББББ+ОО+ВВВ+Бранч ********** ');
          --  Створюємо функцію Попереднiй Баланс (по доступу) ББББ+ОО+ВВВ+Бранч
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Попереднiй Баланс (по доступу) ББББ+ОО+ВВВ+Бранч',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_PRO",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Попереднiй Баланс (по доступу) ББББ+Бранч ********** ');
          --  Створюємо функцію Попереднiй Баланс (по доступу) ББББ+Бранч
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Попереднiй Баланс (по доступу) ББББ+Бранч',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_PRZ",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поточний Баланс (по доступу) ББББ+ОО+ВВВ+Бранч ********** ');
          --  Створюємо функцію Поточний Баланс (по доступу) ББББ+ОО+ВВВ+Бранч
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поточний Баланс (по доступу) ББББ+ОО+ВВВ+Бранч',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_TEK",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Поточний Баланс (по доступу) ББББ+Бранч ********** ');
          --  Створюємо функцію Поточний Баланс (по доступу) ББББ+Бранч
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Поточний Баланс (по доступу) ББББ+Бранч',
                                                  p_funcname => 'FunNSIEditF("BAL_BRANCH_TEZ",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Розрахунковi вiдсотки по рах. ********** ');
          --  Створюємо функцію Розрахунковi вiдсотки по рах.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Розрахунковi вiдсотки по рах.',
                                                  p_funcname => 'FunNSIEditF("CCK_SUM_POG[PROC=>PLAY_INTA(:D1,:D2,:BR,:NB,:KV,:AP)][PAR=>:D1(SEM=Дат_1,TYPE=D),:D2(SEM=Дат_2,TYPE=D),:BR(SEM=Бранч,TYPE=S),:NB(SEM=Бал/р,TYPE=S),:KV(SEM=Вал,TYPE=N),:AP(SEM=0_А/1_П,TYPE=N)][EXEC=>BEFORE][MSG=>OK!]",2)',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiн.рез. (ББББ+ОО+ВВВ+Бранч) ********** ');
          --  Створюємо функцію Фiн.рез. (ББББ+ОО+ВВВ+Бранч)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiн.рез. (ББББ+ОО+ВВВ+Бранч)',
                                                  p_funcname => 'FunNSIEditF("TMP_FIN_REZ[PROC=>P_FIN_REZ_ALL(:U,:L,:V,:O,:B,:E)][PAR=>:U(SEM=Брaнч>1 2 3),:L(SEM=Бал>1=Y 0=N),:V(SEM=Вал>1-Y 0-N),:O(SEM=Об22=1-Y 0-N),:B(SEM=Поч.дата dd.mm.yyyy),:E(SEM=Кiн.дата dd.mm.yyyy)][MSG=>ОК][EXEC=>BEFORE]",2|0x0010)',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Протокол наявностi iнф."Про кiлькiсть оп." по бр.3 ********** ');
          --  Створюємо функцію Протокол наявностi iнф."Про кiлькiсть оп." по бр.3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Протокол наявностi iнф."Про кiлькiсть оп." по бр.3',
                                                  p_funcname => 'FunNSIEditF("V_ACC0000[PROC=>PUL_DAT(:Par1,:Par2)][PAR=>:Par1(SEM= з дати,TYPE=S),:Par2(SEM= по дату,TYPE=S)][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiнансовi результати по Бранчам ********** ');
          --  Створюємо функцію Фiнансовi результати по Бранчам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiнансовi результати по Бранчам',
                                                  p_funcname => 'FunNSIEditF("V_FIN_REZ_BRANCH[PROC=>P_FIN_REZ_BRANCH (10,:Par1,:Par2)][PAR=>:Par1(SEM= Поч.дата dd.mm.yyyy>,TYPE=S),:Par2(SEM= Кiн.дата dd.mm.yyyy>,TYPE=S)][MSG=>OK p_FIN_REZ_branch !][EXEC=>BEFORE]", 2|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiнансовi результати по КП ЮО ********** ');
          --  Створюємо функцію Фiнансовi результати по КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiнансовi результати по КП ЮО',
                                                  p_funcname => 'FunNSIEditF("V_FIN_REZ_CCK[PROC=>P_FIN_REZ_CCK(2,0,:B,:E)][PAR=>:B(SEM=Дата_З,TYPE=D),:E(SEM=Дата_ПО,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Фiнансовi результати по Контрагентам ********** ');
          --  Створюємо функцію Фiнансовi результати по Контрагентам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Фiнансовi результати по Контрагентам',
                                                  p_funcname => 'FunNSIEditF("V_FIN_REZ_RNK[PROC=>P_FIN_REZ_RNK(0,:B,:E,0)][PAR=>:B(SEM=Дата_З,TYPE=D),:E(SEM=Дата_ПО,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довiдник Бранчiв та їх  типiв ********** ');
          --  Створюємо функцію Довiдник Бранчiв та їх  типiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довiдник Бранчiв та їх  типiв',
                                                  p_funcname => 'FunNSIEditF(''V_BRANCH_TIP'', 2 | 0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-1s.Пiдсумковi та усередненi GAP ********** ');
          --  Створюємо функцію ANI-1s.Пiдсумковi та усередненi GAP
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-1s.Пiдсумковi та усередненi GAP',
                                                  p_funcname => 'Sel030(hWndMDI,0,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-1. Аналіз вiдповiдностi АКТ-ПАС ********** ');
          --  Створюємо функцію ANI-1. Аналіз вiдповiдностi АКТ-ПАС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-1. Аналіз вiдповiдностi АКТ-ПАС',
                                                  p_funcname => 'Sel030(hWndMDI,1,700,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-10. Аналіз вiдповiдностi Проц.АКТ-ПАС ********** ');
          --  Створюємо функцію ANI-10. Аналіз вiдповiдностi Проц.АКТ-ПАС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-10. Аналіз вiдповiдностi Проц.АКТ-ПАС',
                                                  p_funcname => 'Sel030(hWndMDI,1,800,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ОБ-БАЛАНС в стуктурi показникiв ********** ');
          --  Створюємо функцію ОБ-БАЛАНС в стуктурi показникiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ОБ-БАЛАНС в стуктурi показникiв',
                                                  p_funcname => 'Sel030(hWndMDI,11,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Квартальнi Плани по бюджету. ********** ');
          --  Створюємо функцію Квартальнi Плани по бюджету.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Квартальнi Плани по бюджету.',
                                                  p_funcname => 'Sel030(hWndMDI,14,0,"","")',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-32. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi ********** ');
          --  Створюємо функцію ANI-32. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi',
                                                  p_funcname => 'Sel030(hWndMDI,32,0,"","")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-32n. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi ********** ');
          --  Створюємо функцію ANI-32n. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-32n. Ефективнiсть проц.АКТ-ПАС по ном. та трансф. цiнi',
                                                  p_funcname => 'Sel030(hWndMDI,32,1,"","")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ANI-5. Концентрацiя ресурсiв (SNAP) ********** ');
          --  Створюємо функцію ANI-5. Концентрацiя ресурсiв (SNAP)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ANI-5. Концентрацiя ресурсiв (SNAP)',
                                                  p_funcname => 'Sel030(hWndMDI,5,7,"","")',
                                                  p_rolename => 'SALGL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз структури балансів  (розріз - Валюта) ********** ');
          --  Створюємо функцію Аналіз структури балансів  (розріз - Валюта)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз структури балансів  (розріз - Валюта)',
                                                  p_funcname => 'ShowBal(hWndMDI, 1)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аналіз балансів банку в динаміці ********** ');
          --  Створюємо функцію Аналіз балансів банку в динаміці
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аналіз балансів банку в динаміці',
                                                  p_funcname => 'ShowDin(hWndMDI)',
                                                  p_rolename => '' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (ANI1) - АРМ Аналітичні функції  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappANI1.sql =========*** En
PROMPT ===================================================================================== 
