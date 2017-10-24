SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_RISK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  RISK ***
  declare
    l_application_code varchar2(10 char) := 'RISK';
    l_application_name varchar2(300 char) := 'АРМ Розрахунок кредитного ризику (351)';
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
     DBMS_OUTPUT.PUT_LINE(' RISK створюємо (або оновлюємо) АРМ АРМ Розрахунок кредитного ризику (351) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.2. Звіт про визнання банками України розміру кредитного ризику(351) ********** ');
          --  Створюємо функцію 1.2. Звіт про визнання банками України розміру кредитного ризику(351)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.2. Звіт про визнання банками України розміру кредитного ризику(351)',
                                                  p_funcname => 'ExportCatQuery(6694,"",18,"",TRUE)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.3. Звіт про концентрацію ризиків за операціями банку з боржниками ********** ');
          --  Створюємо функцію 1.3. Звіт про концентрацію ризиків за операціями банку з боржниками
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.3. Звіт про концентрацію ризиків за операціями банку з боржниками',
                                                  p_funcname => 'ExportCatQuery(6734,"",18,"",TRUE)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звіт про концентрацію ризиків за операціями банку (351) катзап.  ********** ');
          --  Створюємо функцію Звіт про концентрацію ризиків за операціями банку (351) катзап. 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звіт про концентрацію ризиків за операціями банку (351) катзап. ',
                                                  p_funcname => 'ExportCatQuery(6874,"",8,"",TRUE)',
                                                  p_rolename => '' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 9.0 ! Протокол розрахунку резерву по НБУ-23 (АРХІВ) ********** ');
          --  Створюємо функцію 9.0 ! Протокол розрахунку резерву по НБУ-23 (АРХІВ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '9.0 ! Протокол розрахунку резерву по НБУ-23 (АРХІВ)',
                                                  p_funcname => 'FunNSIEditF("NBU23_REZ_ARC[PROC=>p_NBU23_ARC(:A)][PAR=>:A(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]",0| 0x0010)',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.2. Перегляд(без розр.) кредитного ризику по постанові 351(ЗАГАЛЬНА) ********** ');
          --  Створюємо функцію 2.2. Перегляд(без розр.) кредитного ризику по постанові 351(ЗАГАЛЬНА)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.2. Перегляд(без розр.) кредитного ризику по постанові 351(ЗАГАЛЬНА)',
                                                  p_funcname => 'FunNSIEditF("V_351_FDAT[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.1. Розрахунок кредитного ризику по постанові 351 (ЗАГАЛЬНА) ********** ');
          --  Створюємо функцію 1.1. Розрахунок кредитного ризику по постанові 351 (ЗАГАЛЬНА)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.1. Розрахунок кредитного ризику по постанові 351 (ЗАГАЛЬНА)',
                                                  p_funcname => 'FunNSIEditF("V_351_FDAT[PROC=>REZ_351_BLOCK(:A,1)][PAR=>:A(SEM=Зв_дата_дд-мм-гггг,TYPE=D)][EXEC=>BEFORE]",2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.3. Перегляд кредитного ризику (Кредити Юр.осіб + Фіз.осіб) ********** ');
          --  Створюємо функцію 2.3. Перегляд кредитного ризику (Кредити Юр.осіб + Фіз.осіб)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.3. Перегляд кредитного ризику (Кредити Юр.осіб + Фіз.осіб)',
                                                  p_funcname => 'FunNSIEditF("V_CCK_351[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.6. Перегляд кредитного ризику (Цінні папери) ********** ');
          --  Створюємо функцію 2.6. Перегляд кредитного ризику (Цінні папери)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.6. Перегляд кредитного ризику (Цінні папери)',
                                                  p_funcname => 'FunNSIEditF("V_CP_351[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.5. Перегляд кредитного ризику (Дебіторська заборгованість) ********** ');
          --  Створюємо функцію 2.5. Перегляд кредитного ризику (Дебіторська заборгованість)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.5. Перегляд кредитного ризику (Дебіторська заборгованість)',
                                                  p_funcname => 'FunNSIEditF("V_DEB_351[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.4. Перегляд кредитного ризику (Банки + Коррахунки) ********** ');
          --  Створюємо функцію 2.4. Перегляд кредитного ризику (Банки + Коррахунки)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.4. Перегляд кредитного ризику (Банки + Коррахунки)',
                                                  p_funcname => 'FunNSIEditF("V_MBDK_351[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.1. Протокол Постанова23+Постанова351 ********** ');
          --  Створюємо функцію 2.1. Протокол Постанова23+Постанова351
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.1. Протокол Постанова23+Постанова351',
                                                  p_funcname => 'FunNSIEditF("V_NBU23_351[PROC=>PUL_DAT(:A,'''')][PAR=>:A(SEM=Зв_дата_01,TYPE=S)][EXEC=>BEFORE]",0| 0x0010)',
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (RISK) - АРМ Розрахунок кредитного ризику (351)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappRISK.sql =========*** En
PROMPT ===================================================================================== 
