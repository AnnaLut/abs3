SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KREB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KREB ***
  declare
    l_application_code varchar2(10 char) := 'KREB';
    l_application_name varchar2(300 char) := 'КП бухгалтера';
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
     DBMS_OUTPUT.PUT_LINE(' KREB створюємо (або оновлюємо) АРМ КП бухгалтера ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП : Разное ********** ');
          --  Створюємо функцію КП : Разное
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП : Разное',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 0, 701, 0 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ЮЛ: Бухгалтер ********** ');
          --  Створюємо функцію КП ЮЛ: Бухгалтер
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ЮЛ: Бухгалтер',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 22, 0, 3 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Бухгалтер ********** ');
          --  Створюємо функцію КП ФЛ: Бухгалтер
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Бухгалтер',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 23, 0, 5)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Аналіз ********** ');
          --  Створюємо функцію КП ФЛ: Аналіз
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Аналіз',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 93, 0, 5 )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Аналіз ГП% ********** ');
          --  Створюємо функцію КП ФЛ: Аналіз ГП%
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Аналіз ГП%',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 97, 03, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Аналіз ГПК ********** ');
          --  Створюємо функцію КП ФЛ: Аналіз ГПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Аналіз ГПК',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 98, 03, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП ФЛ: Аналіз (Петроком) ********** ');
          --  Створюємо функцію КП ФЛ: Аналіз (Петроком)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП ФЛ: Аналіз (Петроком)',
                                                  p_funcname => 'CC_INKRE(hWndMDI, 99, 00, 0)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Проводки по стартовій ПЕНІ ********** ');
          --  Створюємо функцію Проводки по стартовій ПЕНІ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Проводки по стартовій ПЕНІ',
                                                  p_funcname => 'F1_Select ( 12, " PAY_SN8 ( 2 ) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F0: Авто-разбір рахунків погашення SG ********** ');
          --  Створюємо функцію КП F0: Авто-разбір рахунків погашення SG
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F0: Авто-разбір рахунків погашення SG',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASG ( 0, 1)"  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S. Авто-просрочка рахунків боргу SS -  ФЛ ********** ');
          --  Створюємо функцію S. Авто-просрочка рахунків боргу SS -  ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S. Авто-просрочка рахунків боргу SS -  ФЛ',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( -11, 1 ) "  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #1) КП S2: Авто-просрочка рахунків боргу SS ********** ');
          --  Створюємо функцію #1) КП S2: Авто-просрочка рахунків боргу SS
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#1) КП S2: Авто-просрочка рахунків боргу SS',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( 0, 1 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F1: Вирівнювання залишків на 9129 по КП ********** ');
          --  Створюємо функцію КП F1: Вирівнювання залишків на 9129 по КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F1: Вирівнювання залишків на 9129 по КП',
                                                  p_funcname => 'F1_Select(12, " cck.CC_9129( DAT, 0, 0 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка КЛ ЮО - выносы на просрочку(на старте) ********** ');
          --  Створюємо функцію Обробка КЛ ЮО - выносы на просрочку(на старте)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка КЛ ЮО - выносы на просрочку(на старте)',
                                                  p_funcname => 'F1_Select(12,"CCT.StartI (0)")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка КЛ ЮО - отметки о погашениях(на финише) ********** ');
          --  Створюємо функцію Обробка КЛ ЮО - отметки о погашениях(на финише)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка КЛ ЮО - отметки о погашениях(на финише)',
                                                  p_funcname => 'F1_Select(12,"CCT.StartIO (0)")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S32: Авто-просрочка рахунків нарах.% SN ЮЛ ********** ');
          --  Створюємо функцію КП S32: Авто-просрочка рахунків нарах.% SN ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S32: Авто-просрочка рахунків нарах.% SN ЮЛ',
                                                  p_funcname => 'F1_Select(13,"CCK.CC_ASPN (2, 0, 1 );Вы хотите вынести на просрочку % клиента ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S33: Авто-просрочка рахунків нарах.% SN ФЛ ********** ');
          --  Створюємо функцію КП S33: Авто-просрочка рахунків нарах.% SN ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S33: Авто-просрочка рахунків нарах.% SN ФЛ',
                                                  p_funcname => 'F1_Select(13,"CCK.CC_ASPN (3, 0, 1 );Вы хотите вынести на просрочку % клиента ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F4: Виконати актуалізацію потоків ********** ');
          --  Створюємо функцію КП F4: Виконати актуалізацію потоків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F4: Виконати актуалізацію потоків',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY(0,DAT,0);Вы хотите вып.Актуализацию потоков ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S7: Амортизація Диск/Прем ********** ');
          --  Створюємо функцію КП S7: Амортизація Диск/Прем
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S7: Амортизація Диск/Прем',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY_PET(0,DAT,3);Ви хочете вик. Амортізацію Дисконту?; Виконано!" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S8: Авто закриття договорів ЮО ********** ');
          --  Створюємо функцію КП S8: Авто закриття договорів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S8: Авто закриття договорів ЮО',
                                                  p_funcname => 'F1_Select(13,"cc_close(2,DAT);Вы хотите вып. авто закрытие дог. ЮЛ ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S8: Авто закриття договорів ФО ********** ');
          --  Створюємо функцію КП S8: Авто закриття договорів ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S8: Авто закриття договорів ФО',
                                                  p_funcname => 'F1_Select(13,"cc_close(3,DAT);Вы хотите вып. авто закрытие дог. ФЛ ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО ********** ');
          --  Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(2,DAT,0);Вы хотите вынести на просрочку все активы клиента ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО ********** ');
          --  Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(3,DAT,0);Вы хотите вынести на просрочку все активы клиента ?; Выполнено !" )',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію АРЖК:Розмежув.0(тiльки проток) дох за КД АРЖК ********** ');
          --  Створюємо функцію АРЖК:Розмежув.0(тiльки проток) дох за КД АРЖК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'АРЖК:Розмежув.0(тiльки проток) дох за КД АРЖК',
                                                  p_funcname => 'FunNSIEditF("A_CCK_DU[PROC=>P_CCK_DU(:B,:E,0)][PAR=>:B(SEM=Дата_З,TYPE=D),:E(SEM=Дата_ПО,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію АРЖК:Розмежув.1(провод+проток) дох за КД АРЖК ********** ');
          --  Створюємо функцію АРЖК:Розмежув.1(провод+проток) дох за КД АРЖК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'АРЖК:Розмежув.1(провод+проток) дох за КД АРЖК',
                                                  p_funcname => 'FunNSIEditF("A_CCK_DU[PROC=>P_CCK_DU(:B,:E,1)][PAR=>:B(SEM=Дата_З,TYPE=D),:E(SEM=Дата_ПО,TYPE=D)][EXEC=>BEFORE][QST=>Виконати Розмежування?][MSG=>OK!]",1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Графiк погашення Циклiчних Кредитних Лiнiй ********** ');
          --  Створюємо функцію Графiк погашення Циклiчних Кредитних Лiнiй
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Графiк погашення Циклiчних Кредитних Лiнiй',
                                                  p_funcname => 'FunNSIEditF("TMP_CCK_CKL[PROC=>CCK_CKL(:NLS,:KV)][PAR=>:NLS(SEM=Рахунок,TYPE=S),:KV(SEM=Вал,TYPE=N)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП R02: Звіти по автоматичним функціям КП ФЛ ********** ');
          --  Створюємо функцію КП R02: Звіти по автоматичним функціям КП ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП R02: Звіти по автоматичним функціям КП ФЛ',
                                                  p_funcname => 'FunNSIEditF("TMP_CCK_REP[NSIFUNCTION][PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=Вибір функції,TYPE=N,REF=V_CCK_REP_LIST_FL)][EXEC=>BEFORE][MSG=>Виконано!]", 6)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП R01: Звіти по автоматичним функціям КП ЮЛ ********** ');
          --  Створюємо функцію КП R01: Звіти по автоматичним функціям КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП R01: Звіти по автоматичним функціям КП ЮЛ',
                                                  p_funcname => 'FunNSIEditF("TMP_CCK_REP[NSIFUNCTION][PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=Вибір функції,TYPE=N,REF=V_CCK_REP_LIST_YL)][EXEC=>BEFORE][MSG=>Виконано!]", 6)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ESCR:Картотека відшкодувань по енергокредитам   ********** ');
          --  Створюємо функцію ESCR:Картотека відшкодувань по енергокредитам  
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'ESCR:Картотека відшкодувань по енергокредитам  ',
                                                  p_funcname => 'FunNSIEditF("VZ_ESCR[NSIFUNCTION]",6)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Просморт КД с дисконтом в потоках ********** ');
          --  Створюємо функцію Просморт КД с дисконтом в потоках
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Просморт КД с дисконтом в потоках',
                                                  p_funcname => 'FunNSIEditF("V_CC_SDI" ,1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F12: Щомiсячне Нарахування %% по всім дог. у КП ЮО ********** ');
          --  Створюємо функцію КП F12: Щомiсячне Нарахування %% по всім дог. у КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F12: Щомiсячне Нарахування %% по всім дог. у КП ЮО',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (1,2,3))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО ********** ');
          --  Створюємо функцію #5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (11,12,13))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S52: Нарахування %%  по простроченим дог. у КП ЮЛ ********** ');
          --  Створюємо функцію КП S52: Нарахування %%  по простроченим дог. у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S52: Нарахування %%  по простроченим дог. у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SP '') and i.acra is not null and i.acrb is not null",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S42: Нарахування %%  по поточним платіж. датам у КП ЮЛ ********** ');
          --  Створюємо функцію КП S42: Нарахування %%  по поточним платіж. датам у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S42: Нарахування %%  по поточним платіж. датам у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SS '',''SP '') and i.acra is not null and i.acrb is not null and exists (select 1 from cc_lim where acc=s.accc and fdat=gl.bd  and sumo>0 and not_sn is null)",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S53: Нарахування %%  по простроченим дог. у КП ФЛ ********** ');
          --  Створюємо функцію КП S53: Нарахування %%  по простроченим дог. у КП ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S53: Нарахування %%  по простроченим дог. у КП ФЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''22%'' and s.tip in (''SP '') and i.acra is not null and i.acrb is not null",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ЮЛ ********** ');
          --  Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F40: Нарахування комісії на 9129 у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''9129%'' and s.tip in (''CR9'') and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc n,cc_deal d where n.nd=d.nd and d.vidd in (1,2,3) and n.acc=s.acc)",''A'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ФЛ ********** ');
          --  Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F40: Нарахування комісії на 9129 у КП ФЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''9129%'' and s.tip in (''CR9'') and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc n,cc_deal d where n.nd=d.nd and d.vidd in (11,12,13) and n.acc=s.acc)",''A'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #3) КП S43: Нарахування %% по пл. датам у КП ФЛ (АНУЇТЕТ) ********** ');
          --  Створюємо функцію #3) КП S43: Нарахування %% по пл. датам у КП ФЛ (АНУЇТЕТ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#3) КП S43: Нарахування %% по пл. датам у КП ФЛ (АНУЇТЕТ)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.tip in(''SS '',''SP '')  and s.acc in (select N.acc from nd_acc n, cc_v d  where d.GPK=4 and n.nd=d.nd and d.vidd=11  and cck.PAY_GPK(gl.bd,D.ND,null)=1)","SAN")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S62: Нарахування Пенi  у КП ЮЛ ********** ');
          --  Створюємо функцію КП S62: Нарахування Пенi  у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S62: Нарахування Пенi  у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''20%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs2 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S63: Нарахування Пенi  у КП ФЛ ********** ');
          --  Створюємо функцію КП S63: Нарахування Пенi  у КП ФЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S63: Нарахування Пенi  у КП ФЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''22%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs1 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП: Нарахування щомiсячнiй комiсiї по КП ********** ');
          --  Створюємо функцію КП: Нарахування щомiсячнiй комiсiї по КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП: Нарахування щомiсячнiй комiсiї по КП',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,''and i.metr>90'',''S'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП: Нарахування щомiсячнiй комiсiї по КП ********** ');
          --  Створюємо функцію КП: Нарахування щомiсячнiй комiсiї по КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП: Нарахування щомiсячнiй комiсiї по КП',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,''and i.metr>90'',''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Кредити. Редагування шаблонів договорів ********** ');
          --  Створюємо функцію Кредити. Редагування шаблонів договорів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Кредити. Редагування шаблонів договорів',
                                                  p_funcname => 'cdoc_EditDocTemplatesFilt(hWndMDI, " id like ''KD%''  or id like ''CCK%''")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (KREB) - КП бухгалтера  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKREB.sql =========*** En
PROMPT ===================================================================================== 
