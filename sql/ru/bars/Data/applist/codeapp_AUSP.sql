SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_AUSP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  AUSP ***
  declare
    l_application_code varchar2(10 char) := 'AUSP';
    l_application_name varchar2(300 char) := 'АРМ "Аудит спецпараметрiв"';
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
     DBMS_OUTPUT.PUT_LINE(' AUSP створюємо (або оновлюємо) АРМ АРМ "Аудит спецпараметрiв" ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Деп.Портф.  (Формування ) ********** ');
          --  Створюємо функцію Аудит OB22 в Деп.Портф.  (Формування )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Деп.Портф.  (Формування )',
                                                  p_funcname => 'F1_Select( 12, " P_AUD_DPT ( 0, ''/'') " ) ',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Крд.Портф.  (Формування + Перегляд) ********** ');
          --  Створюємо функцію Аудит OB22 в Крд.Портф.  (Формування + Перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Крд.Портф.  (Формування + Перегляд)',
                                                  p_funcname => 'FunNSIEditF("AUD_CCK",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит парамету клієнта ЮО "Частка державної власності" (перегляд) ********** ');
          --  Створюємо функцію Аудит парамету клієнта ЮО "Частка державної власності" (перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит парамету клієнта ЮО "Частка державної власності" (перегляд)',
                                                  p_funcname => 'FunNSIEditF("AUD_CUSTW_UUDV",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Деп.портфелях ЮО ********** ');
          --  Створюємо функцію Аудит OB22 в Деп.портфелях ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Деп.портфелях ЮО',
                                                  p_funcname => 'FunNSIEditF("AUD_DPU",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 0.S180 Аудит спецпараметру ********** ');
          --  Створюємо функцію 0.S180 Аудит спецпараметру
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '0.S180 Аудит спецпараметру',
                                                  p_funcname => 'FunNSIEditF("A_S180[PROC=>AUDS.S180(0)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.S180 Замiна осн.рах на `R180 (вiд дат) ********** ');
          --  Створюємо функцію 1.S180 Замiна осн.рах на `R180 (вiд дат)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.S180 Замiна осн.рах на `R180 (вiд дат)',
                                                  p_funcname => 'FunNSIEditF("A_S180[PROC=>AUDS.S180(1)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.S180 Замiна на пов`язаних рах (вiд осн) ********** ');
          --  Створюємо функцію 2.S180 Замiна на пов`язаних рах (вiд осн)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.S180 Замiна на пов`язаних рах (вiд осн)',
                                                  p_funcname => 'FunNSIEditF("A_S180[PROC=>AUDS.S180(2)][EXEC=>BEFORE]", 2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3(1+2)S180 Замiна всiх рах `R180 (вiд дат) ********** ');
          --  Створюємо функцію 3(1+2)S180 Замiна всiх рах `R180 (вiд дат)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3(1+2)S180 Замiна всiх рах `R180 (вiд дат)',
                                                  p_funcname => 'FunNSIEditF("A_S180[PROC=>AUDS.S180(3)][EXEC=>BEFORE]", 4)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит OB22 в Деп.Портф. (Перегляд) ********** ');
          --  Створюємо функцію Аудит OB22 в Деп.Портф. (Перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит OB22 в Деп.Портф. (Перегляд)',
                                                  p_funcname => 'FunNSIEditF("TEST_AUD_DPT",1|0x0010)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит доп. параметов клиентов (редагування) ********** ');
          --  Створюємо функцію Аудит доп. параметов клиентов (редагування)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит доп. параметов клиентов (редагування)',
                                                  p_funcname => 'FunNSIEditF("V_AUD_CUST_PARAMS_ADD",2)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Помилкові входження рахунків до КД ********** ');
          --  Створюємо функцію Помилкові входження рахунків до КД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Помилкові входження рахунків до КД',
                                                  p_funcname => 'FunNSIEditF("V_CCK_ERR_REL_ACC[NSIFUNCTION]",6)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Некоректні види та рахунки забезпечення ********** ');
          --  Створюємо функцію Некоректні види та рахунки забезпечення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Некоректні види та рахунки забезпечення',
                                                  p_funcname => 'FunNSIEditF("V_CC_PAWN_ERROR",1)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Дозаповнення поля стать контрагента (ПВБКІ) ********** ');
          --  Створюємо функцію Дозаповнення поля стать контрагента (ПВБКІ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Дозаповнення поля стать контрагента (ПВБКІ)',
                                                  p_funcname => 'FunNSIEditF("V_CUSTOMER_CIG_SEX",2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит параметру R013 в КП ЮО ********** ');
          --  Створюємо функцію Аудит параметру R013 в КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит параметру R013 в КП ЮО',
                                                  p_funcname => 'FunNSIEditFFiltered("V_CCK_R013", 2, " VIDD in (1,2,3) " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит параметру R013 в КП ФО ********** ');
          --  Створюємо функцію Аудит параметру R013 в КП ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит параметру R013 в КП ФО',
                                                  p_funcname => 'FunNSIEditFFiltered("V_CCK_R013", 2, " VIDD in (11,12,13) " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Аудит параметру R013 поза КП ЮО+ФО ********** ');
          --  Створюємо функцію Аудит параметру R013 поза КП ЮО+ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Аудит параметру R013 поза КП ЮО+ФО',
                                                  p_funcname => 'FunNSIEditFFiltered("V_CCN_R013", 2, " 1=1 " )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (AUSP) - АРМ "Аудит спецпараметрiв"  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappAUSP.sql =========*** En
PROMPT ===================================================================================== 
