SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_MANY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_MANY ***
  declare
    l_application_code varchar2(10 char) := '$RM_MANY';
    l_application_name varchar2(300 char) := 'АРМ Формування резервного фонду';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
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
     DBMS_OUTPUT.PUT_LINE(' $RM_MANY створюємо (або оновлюємо) АРМ АРМ Формування резервного фонду ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Автоматичні операції портфеля ДФО ********** ');
          --  Створюємо функцію Автоматичні операції портфеля ДФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Автоматичні операції портфеля ДФО',
                                                  p_funcname => '/barsroot/DptAdm/DptAdm/DPTAutoOperations',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Портфель договорів забезпечення ФО ********** ');
          --  Створюємо функцію Портфель договорів забезпечення ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Портфель договорів забезпечення ФО',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_portfolio&mode=3',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  Створюємо дочірню функцію Ипотека
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Ипотека',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Депозиты
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Депозиты',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_deposits&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд графіку подій
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Перегляд графіку подій',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dog_events&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Ипотека - земля
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Ипотека - земля',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_mortgage_land&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Движимое имущество
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Движимое имущество',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_vehicles&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Пустая карта договора
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Пустая карта договора',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_dual&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Ценности
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Ценности',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_valuables&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Товары
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'Товары',
                                                              p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_grt_products&deal_id=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ! Протокол розрахунку резерву по НБУ-23 ********** ');
          --  Створюємо функцію ! Протокол розрахунку резерву по НБУ-23
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '! Протокол розрахунку резерву по НБУ-23',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=NBU23_REZ',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію !!Формування+Перег+Кор ЗАГАЛЬНОГО протоколу по НБУ-23 ********** ');
          --  Створюємо функцію !!Формування+Перег+Кор ЗАГАЛЬНОГО протоколу по НБУ-23
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '!!Формування+Перег+Кор ЗАГАЛЬНОГО протоколу по НБУ-23',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=NBU23_REZ[PROC=>REZ_23_BLOCK(:A,1)][PAR=>:A(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3.1. Протокол відхилення резерву ********** ');
          --  Створюємо функцію 3.1. Протокол відхилення резерву
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.1. Протокол відхилення резерву',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=REZ_NBU23_DELTA[PROC=>z23.P_DELTA(:A,:B)][PAR=>:A(SEM=Зв_дата_З_01-ММ-ГГГГ,TYPE=D),:B(SEM=Зв_дата_По_01-ДД-ГГГГ,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 04. Протокол резерву по КРЕДИТАХ ********** ');
          --  Створюємо функцію 04. Протокол резерву по КРЕДИТАХ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '04. Протокол резерву по КРЕДИТАХ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TEST_MANY_CCK[PROC=>Z23.TK_MANY(:A,:D,1,0,1)][PAR=>:A(SEM=Реф_КД,TYPE=N),:D(SEM=Зв_дата_01,TYPE=D))][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 98_1. Перевірка формування проводок (резерв<->план.залиш.рах.резерву) ********** ');
          --  Створюємо функцію 98_1. Перевірка формування проводок (резерв<->план.залиш.рах.резерву)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98_1. Перевірка формування проводок (резерв<->план.залиш.рах.резерву)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=VER_DOC_MAKET[PROC=>P_DOC_MAKET(:A)][PAR=>:A(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 05. Протокол резерву по ЦП ********** ');
          --  Створюємо функцію 05. Протокол резерву по ЦП
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '05. Протокол резерву по ЦП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_MANY[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=Звiтна_дата 01.mm.yyyy>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6.1. Резерв по фін.деб.заборгованності (зведена) ********** ');
          --  Створюємо функцію 6.1. Резерв по фін.деб.заборгованності (зведена)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.1. Резерв по фін.деб.заборгованності (зведена)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=DEB_FIN[PROC=>P_DEB_FIN(:A)][PAR=>:A(SEM=Зв_дата_ДД-ММ-ГГГГ,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6.2. Резерв по госп.деб.заборгованності (зведена) ********** ');
          --  Створюємо функцію 6.2. Резерв по госп.деб.заборгованності (зведена)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.2. Резерв по госп.деб.заборгованності (зведена)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=DEB_HOZ[PROC=>P_DEB_HOZ(:A)][PAR=>:A(SEM=Зв_дата_ДД-ММ-ГГГГ,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4.3. Перегляд/заповнення параметрiв угод КП Банки (ручні) ********** ');
          --  Створюємо функцію 4.3. Перегляд/заповнення параметрiв угод КП Банки (ручні)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.3. Перегляд/заповнення параметрiв угод КП Банки (ручні)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CCK_BN_KOR[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=Звiтна_дата 01.ММ.ГГГГ>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію НБУ-23/R.Перегляд/заповнення параметрiв угод КП ФО ********** ');
          --  Створюємо функцію НБУ-23/R.Перегляд/заповнення параметрiв угод КП ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'НБУ-23/R.Перегляд/заповнення параметрiв угод КП ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CCK_FL[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=Зв_дата_01-MM-ГГГГ,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4.1. Перегляд/заповнення параметрiв угод КП ЮО ********** ');
          --  Створюємо функцію 4.1. Перегляд/заповнення параметрiв угод КП ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.1. Перегляд/заповнення параметрiв угод КП ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CCK_UL[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію НБУ-23/R.Перегляд/заповнення параметрiв ЦП ********** ');
          --  Створюємо функцію НБУ-23/R.Перегляд/заповнення параметрiв ЦП
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'НБУ-23/R.Перегляд/заповнення параметрiв ЦП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=NBU23_CP[PROC=>PUL_DAT(:Par0,null)][PAR=>:Par0(SEM=Звiтна_дата 01.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 98_ Розпорядження на проводки ********** ');
          --  Створюємо функцію 98_ Розпорядження на проводки
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98_ Розпорядження на проводки',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=ORDER_REZ[PROC=>P_ORDER_REZ(:A)][PAR=>:A(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію FV=>АБС: Обробка Екв-Вітрини "Резерв-МСФЗ" ********** ');
          --  Створюємо функцію FV=>АБС: Обробка Екв-Вітрини "Резерв-МСФЗ"
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'FV=>АБС: Обробка Екв-Вітрини "Резерв-МСФЗ"',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=PRVN_OSAQ[NSIFUNCTION][PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=Зв_дата 01/ММ/РРРР,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3.2. Протокол виконання функцій розрахунку резерву ********** ');
          --  Створюємо функцію 3.2. Протокол виконання функцій розрахунку резерву
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.2. Протокол виконання функцій розрахунку резерву',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=REZ_LOG',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 07. Протокол BV по фин.дебитор.задолж. ********** ');
          --  Створюємо функцію 07. Протокол BV по фин.дебитор.задолж.
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '07. Протокол BV по фин.дебитор.задолж.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=TEST_MANY_CCK_DF[PROC=>Z23.REZ_DEB_F(:D,0,0,1)][PAR=>:D(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 08. Протокол BV по хоз.дебитор.задолж. ********** ');
          --  Створюємо функцію 08. Протокол BV по хоз.дебитор.задолж.
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '08. Протокол BV по хоз.дебитор.задолж.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=TEST_MANY_CCK_DH[PROC=>Z23.REZ_DEB_F(:D,1,0,1)][PAR=>:D(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->00.Розподіл фін.актівів на суттєві та несуттєві ********** ');
          --  Створюємо функцію ->00.Розподіл фін.актівів на суттєві та несуттєві
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->00.Розподіл фін.актівів на суттєві та несуттєві',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,2)][PAR=>:A(SEM=Зв_дата_01-ММ-ГГГГ,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->01. Перенесення поточних ГПК в архiв ********** ');
          --  Створюємо функцію ->01. Перенесення поточних ГПК в архiв
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->01. Перенесення поточних ГПК в архiв',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,3)][PAR=>:A(SEM=Зв_дата_01-ММ-ГГГГ,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->02.Розрахунок ОБС.БОРГУ по КП  ********** ');
          --  Створюємо функцію ->02.Розрахунок ОБС.БОРГУ по КП 
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->02.Розрахунок ОБС.БОРГУ по КП ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,4)][PAR=>:A(SEM=Зв_дата_01-ММ-ГГГГ,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->03.Розрахунок ОБС.БОРГУ по МБК ********** ');
          --  Створюємо функцію ->03.Розрахунок ОБС.БОРГУ по МБК
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->03.Розрахунок ОБС.БОРГУ по МБК',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,5)][PAR=>:A(SEM=Зв_дата_01-ММ-ГГГГ,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->04.Розрахунок ОБС.БОРГУ по БПK ********** ');
          --  Створюємо функцію ->04.Розрахунок ОБС.БОРГУ по БПK
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->04.Розрахунок ОБС.БОРГУ по БПK',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,6)][PAR=>:A(SEM=Зв_дата_01-ММ-ГГГГ,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->04_0.Розрахунок ОБС.БОРГУ по ОВЕРДРАФТАМ ********** ');
          --  Створюємо функцію ->04_0.Розрахунок ОБС.БОРГУ по ОВЕРДРАФТАМ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->04_0.Розрахунок ОБС.БОРГУ по ОВЕРДРАФТАМ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,7)][PAR=>:A(SEM=Зв_дата_01-ММ-ГГГГ,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->05. Розрахунок ЗАБЕЗПЕЧЕННЯ ********** ');
          --  Створюємо функцію ->05. Розрахунок ЗАБЕЗПЕЧЕННЯ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->05. Розрахунок ЗАБЕЗПЕЧЕННЯ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>REZ_23_BLOCK(:A,8)][PAR=>:A(SEM=Зв_дата_01-ММ-ГГГГ,TYPE=D)][MSG=>OK]',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Порівняльна таблиця рахунків нар.% прострочених <30 та >30 днів ********** ');
          --  Створюємо функцію Порівняльна таблиця рахунків нар.% прострочених <30 та >30 днів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Порівняльна таблиця рахунків нар.% прострочених <30 та >30 днів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=ACC_30&accessCode=1&sPar=[PROC=>p_acc_d30(:A)][PAR=>:A(SEM=Звітна дата,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідники NEW ********** ');
          --  Створюємо функцію Довідники NEW
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідники NEW',
                                                  p_funcname => '/barsroot/referencebook/referencelist/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка запитів ********** ');
          --  Створюємо функцію Обробка запитів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка запитів',
                                                  p_funcname => '/barsroot/requestsProcessing/requestsProcessing',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_MANY) - АРМ Формування резервного фонду  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_MANY.sql =========**
PROMPT ===================================================================================== 
