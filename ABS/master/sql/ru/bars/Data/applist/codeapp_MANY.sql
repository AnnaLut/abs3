SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_MANY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  MANY ***
  declare
    l_application_code varchar2(10 char) := 'MANY';
    l_application_name varchar2(300 char) := 'АРМ Формування резервного фонду';
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
     DBMS_OUTPUT.PUT_LINE(' MANY створюємо (або оновлюємо) АРМ АРМ Формування резервного фонду ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->04.Розрахунок ОБС.БОРГУ по БПK ********** ');
          --  Створюємо функцію ->04.Розрахунок ОБС.БОРГУ по БПK
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->04.Розрахунок ОБС.БОРГУ по БПK',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OBS_23_BPK_BLOCK(:A)][PAR=>:A(SEM=Зв_дата_дд-мм-гггг,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->02.Розрахунок ОБС.БОРГУ по КП  ********** ');
          --  Створюємо функцію ->02.Розрахунок ОБС.БОРГУ по КП 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->02.Розрахунок ОБС.БОРГУ по КП ',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OBS_23_KP_block(:A)][PAR=>:A(SEM=Зв_дата_дд-мм-гггг,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->03.Розрахунок ОБС.БОРГУ по МБК ********** ');
          --  Створюємо функцію ->03.Розрахунок ОБС.БОРГУ по МБК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->03.Розрахунок ОБС.БОРГУ по МБК',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OBS_23_MBK_block(:A)][PAR=>:A(SEM=Зв_дата_дд-мм-гггг,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->04_0.Розрахунок ОБС.БОРГУ по ОВЕРДРАФТАМ ********** ');
          --  Створюємо функцію ->04_0.Розрахунок ОБС.БОРГУ по ОВЕРДРАФТАМ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->04_0.Розрахунок ОБС.БОРГУ по ОВЕРДРАФТАМ',
                                                  p_funcname => 'FunNSIEdit("[PROC=>OBS_23_OVER_BLOCK(:A)][PAR=>:A(SEM=Зв_дата_дд-мм-гггг,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->00.Розподіл фін.актівів на суттєві та несуттєві ********** ');
          --  Створюємо функцію ->00.Розподіл фін.актівів на суттєві та несуттєві
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->00.Розподіл фін.актівів на суттєві та несуттєві',
                                                  p_funcname => 'FunNSIEdit("[PROC=>REZ_351_BLOCK(:A,2)][PAR=>:A(SEM=Зв_дата_дд-мм-гггг,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->01.Розрахунок ЗАБЕЗПЕЧЕННЯ ********** ');
          --  Створюємо функцію ->01.Розрахунок ЗАБЕЗПЕЧЕННЯ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->01.Розрахунок ЗАБЕЗПЕЧЕННЯ',
                                                  p_funcname => 'FunNSIEdit("[PROC=>REZ_351_BLOCK(:A,3)][PAR=>:A(SEM=Зв_дата_дд-мм-гггг,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ->01.Перенесення поточних ГПК в архiв ********** ');
          --  Створюємо функцію ->01.Перенесення поточних ГПК в архiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '->01.Перенесення поточних ГПК в архiв',
                                                  p_funcname => 'FunNSIEdit("[PROC=>START_REZ_block(:A)][PAR=>:A(SEM=Зв_дата_дд-мм-pppp,TYPE=D)][MSG=>OK]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію А!Розблокування, для повторного розрахунку резерву та проводок ********** ');
          --  Створюємо функцію А!Розблокування, для повторного розрахунку резерву та проводок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'А!Розблокування, для повторного розрахунку резерву та проводок',
                                                  p_funcname => 'FunNSIEdit("[PROC=>p_rez_dat(0)][QST=>УВАГА! Виконується розблокування проводок! Розблокувати?][MSG=>OK! Проводки розблоковані!]")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6.1. Резерв по фін.деб.заборгованності (зведена) ********** ');
          --  Створюємо функцію 6.1. Резерв по фін.деб.заборгованності (зведена)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.1. Резерв по фін.деб.заборгованності (зведена)',
                                                  p_funcname => 'FunNSIEditF("DEB_FIN[PROC=>P_DEB_FIN(:A)][PAR=>:A(SEM=Зв_дата_дд-мм-гггг,TYPE=D)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6.2. Резерв по госп.деб.заборгованності (зведена) ********** ');
          --  Створюємо функцію 6.2. Резерв по госп.деб.заборгованності (зведена)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.2. Резерв по госп.деб.заборгованності (зведена)',
                                                  p_funcname => 'FunNSIEditF("DEB_HOZ[PROC=>P_DEB_HOZ(:A)][PAR=>:A(SEM=Зв_дата_дд-мм-гггг,TYPE=D)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ! БАЛАНС + Протокол розрахунку резерву по НБУ-23 ********** ');
          --  Створюємо функцію ! БАЛАНС + Протокол розрахунку резерву по НБУ-23
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '! БАЛАНС + Протокол розрахунку резерву по НБУ-23',
                                                  p_funcname => 'FunNSIEditF("GL_NBU23_REZ[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ! БАЛАНС + Протокол (розбiжностi по рах) ********** ');
          --  Створюємо функцію ! БАЛАНС + Протокол (розбiжностi по рах)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '! БАЛАНС + Протокол (розбiжностi по рах)',
                                                  p_funcname => 'FunNSIEditF("GL_NBU23_REZ_ACC[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4.3. Перегляд/заповнення параметрiв угод КП Банки (ручні) ********** ');
          --  Створюємо функцію 4.3. Перегляд/заповнення параметрiв угод КП Банки (ручні)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.3. Перегляд/заповнення параметрiв угод КП Банки (ручні)',
                                                  p_funcname => 'FunNSIEditF("NBU23_CCK_BN_KOR[PROC=>PUL_DAT(:Par0,'''')][PAR=>:Par0(SEM=Звiтна_дата 01.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4.2. Перегляд/заповнення параметрiв угод КП ФО ********** ');
          --  Створюємо функцію 4.2. Перегляд/заповнення параметрiв угод КП ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.2. Перегляд/заповнення параметрiв угод КП ФО',
                                                  p_funcname => 'FunNSIEditF("NBU23_CCK_FL[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4.1. Перегляд/заповнення параметрiв угод КП ЮО ********** ');
          --  Створюємо функцію 4.1. Перегляд/заповнення параметрiв угод КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.1. Перегляд/заповнення параметрiв угод КП ЮО',
                                                  p_funcname => 'FunNSIEditF("NBU23_CCK_UL[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ! !Формування+Перег+Корр ЗАГАЛЬНОГО протоколу по НБУ-23 ********** ');
          --  Створюємо функцію ! !Формування+Перег+Корр ЗАГАЛЬНОГО протоколу по НБУ-23
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '! !Формування+Перег+Корр ЗАГАЛЬНОГО протоколу по НБУ-23',
                                                  p_funcname => 'FunNSIEditF("NBU23_REZ[PROC=>REZ_23_BLOCK(:A)][PAR=>:A(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]",0| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.0. Протокол розрахунку резерву по НБУ-351+FINEVARE ********** ');
          --  Створюємо функцію 2.0. Протокол розрахунку резерву по НБУ-351+FINEVARE
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.0. Протокол розрахунку резерву по НБУ-351+FINEVARE',
                                                  p_funcname => 'FunNSIEditF("NBU23_REZ_P[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",0| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 98_ Розпорядження на проводки ********** ');
          --  Створюємо функцію 98_ Розпорядження на проводки
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98_ Розпорядження на проводки',
                                                  p_funcname => 'FunNSIEditF("ORDER_REZ[PROC=>P_ORDER_REZ(:A)][PAR=>:A(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]",0| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію АРЖК:Суми погашень по КП пулу АРЖК за перiод ********** ');
          --  Створюємо функцію АРЖК:Суми погашень по КП пулу АРЖК за перiод
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'АРЖК:Суми погашень по КП пулу АРЖК за перiод',
                                                  p_funcname => 'FunNSIEditF("POG_ARJK[PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=З dd.mm.yyyy>,TYPE=S),:E(SEM=По dd.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]",1|0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3.2. Протокол виконання функцій розрахунку резерву ********** ');
          --  Створюємо функцію 3.2. Протокол виконання функцій розрахунку резерву
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.2. Протокол виконання функцій розрахунку резерву',
                                                  p_funcname => 'FunNSIEditF("REZ_LOG",0)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3.1. Протокол відхилення резерву ********** ');
          --  Створюємо функцію 3.1. Протокол відхилення резерву
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.1. Протокол відхилення резерву',
                                                  p_funcname => 'FunNSIEditF("REZ_NBU23_DELTA[PROC=>z23.P_DELTA(:A,:B)][PAR=>:A(SEM=Зв_дата_З_дд-мм-гггг,TYPE=D),:B(SEM=Зв_дата_По_дд-мм-гггг,TYPE=D)][EXEC=>BEFORE]",1| 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 5.1. Обсяг формування резерву ********** ');
          --  Створюємо функцію 5.1. Обсяг формування резерву
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5.1. Обсяг формування резерву',
                                                  p_funcname => 'FunNSIEditF("TEST_FINREZ[PROC=>FINREZ_SB(:B)][PAR=>:B(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 04.Протокол PV,BV,Irr КП з потоками ********** ');
          --  Створюємо функцію 04.Протокол PV,BV,Irr КП з потоками
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '04.Протокол PV,BV,Irr КП з потоками',
                                                  p_funcname => 'FunNSIEditF("TEST_MANY_CCK[PROC=>Z23.TK_MANY(:A,:D,:R,:Z,1)][PAR=>:A(SEM=Реф_КД,TYPE=N),:D(SEM=Зв_дата_01,TYPE=D),:R(SEM=Перег=1/0,TYPE=N),:Z(SEM=Включ.в 1B=1/0,TYPE=N)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 07.Протокол BV по фин.дебитор.задолж. ********** ');
          --  Створюємо функцію 07.Протокол BV по фин.дебитор.задолж.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '07.Протокол BV по фин.дебитор.задолж.',
                                                  p_funcname => 'FunNSIEditF("TEST_MANY_CCK_DF[PROC=>Z23.REZ_DEB_F(:D,0,0,1)][PAR=>:D(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 08.Протокол BV по хоз.дебитор.задолж. ********** ');
          --  Створюємо функцію 08.Протокол BV по хоз.дебитор.задолж.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '08.Протокол BV по хоз.дебитор.задолж.',
                                                  p_funcname => 'FunNSIEditF("TEST_MANY_CCK_DH[PROC=>Z23.REZ_DEB_F(:D,1,:Z,1)][PAR=>:D(SEM=Зв_дата_01,TYPE=D),:Z(SEM=Включ.в 1B=1/0,TYPE=N))][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 98_1. Перевірка формування проводок (резерв<->план.залиш.рах.резерву) ********** ');
          --  Створюємо функцію 98_1. Перевірка формування проводок (резерв<->план.залиш.рах.резерву)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98_1. Перевірка формування проводок (резерв<->план.залиш.рах.резерву)',
                                                  p_funcname => 'FunNSIEditF("VER_DOC_MAKET[PROC=>P_DOC_MAKET(:A)][PAR=>:A(SEM=Зв_дата_01-MM-ГГГГ,TYPE=D)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 18.Протокол поточних PV,BV,Irr, Резерву по ЦП ********** ');
          --  Створюємо функцію 18.Протокол поточних PV,BV,Irr, Резерву по ЦП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '18.Протокол поточних PV,BV,Irr, Резерву по ЦП',
                                                  p_funcname => 'FunNSIEditF("V_CP_MANY[PROC=>Z23.PUL_DAT_CP(:B,:Z,1)][PAR=>:B(SEM=Звiтна_дата 01.mm.yyyy>,TYPE=D),:Z(SEM=Включ.в 1B=1/0,TYPE=N)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 13.Протокол розрахунку резерву по 9100 ********** ');
          --  Створюємо функцію 13.Протокол розрахунку резерву по 9100
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '13.Протокол розрахунку резерву по 9100',
                                                  p_funcname => 'FunNSIEditF("V_REZ_9100[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 17.Протокол розрахунку резерву по НЕОПОЗНАННЫМ ********** ');
          --  Створюємо функцію 17.Протокол розрахунку резерву по НЕОПОЗНАННЫМ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '17.Протокол розрахунку резерву по НЕОПОЗНАННЫМ',
                                                  p_funcname => 'FunNSIEditF("V_REZ_NLO[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 09.Протокол резерву:9000,9001,9002,9003,9020,9023,9129` ********** ');
          --  Створюємо функцію 09.Протокол резерву:9000,9001,9002,9003,9020,9023,9129`
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '09.Протокол резерву:9000,9001,9002,9003,9020,9023,9129`',
                                                  p_funcname => 'FunNSIEditFFiltered("NBU23_REZ[PROC=>Z23.PUL_DAT_9(:A,1,1)][PAR=>:A(SEM=Зв_дата_дд-мм-pppp)][EXEC=>BEFORE]",2,"FDAT=z23.B and id like ''9%'' ")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 99. Формування проводок по МСФЗ ********** ');
          --  Створюємо функцію 99. Формування проводок по МСФЗ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '99. Формування проводок по МСФЗ',
                                                  p_funcname => 'FunNSIEditFFiltered("REZ_DOC_MAKET[PROC=>PAY_23(:A,0,NUMBER_Null,0)][PAR=>:A(SEM=Зв_дата_01,TYPE=D)][QST=> Проводки виконуються по ФАКТУ. Виконати?][EXEC=>BEFORE]",1,"DK>=0")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 98. Макет проводок по 23 постановi (без формування) ********** ');
          --  Створюємо функцію 98. Макет проводок по 23 постановi (без формування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '98. Макет проводок по 23 постановi (без формування)',
                                                  p_funcname => 'FunNSIEditFFiltered("REZ_DOC_MAKET[PROC=>PAY_23(:A,1,NUMBER_Null,0)][PAR=>:A(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]",1,"DK>=0")',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію ---- ********** ');
          --  Створюємо функцію ----
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '----',
                                                  p_funcname => 'SqlPrepareAndExecute(hSql(),"begin delete from acc_nlo; commit; end;")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (MANY) - АРМ Формування резервного фонду  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappMANY.sql =========*** En
PROMPT ===================================================================================== 
