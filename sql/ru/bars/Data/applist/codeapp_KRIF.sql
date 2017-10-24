SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KRIF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KRIF ***
  declare
    l_application_code varchar2(10 char) := 'KRIF';
    l_application_name varchar2(300 char) := 'АРМ Кредити ФО - Iнвентаризацiя';
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
     DBMS_OUTPUT.PUT_LINE(' KRIF створюємо (або оновлюємо) АРМ АРМ Кредити ФО - Iнвентаризацiя ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнвентаризацiя ФО(щомiс)-Деталiзованi БПК ********** ');
          --  Створюємо функцію Iнвентаризацiя ФО(щомiс)-Деталiзованi БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнвентаризацiя ФО(щомiс)-Деталiзованi БПК',
                                                  p_funcname => 'FunNSIEditF("INV_BPK",1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнвентаризацiя ФО(щомiс)-Iншi ********** ');
          --  Створюємо функцію Iнвентаризацiя ФО(щомiс)-Iншi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнвентаризацiя ФО(щомiс)-Iншi',
                                                  p_funcname => 'FunNSIEditF("INV_INSHI",1)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 22**,9129 Баланс та Портфелi ********** ');
          --  Створюємо функцію 22**,9129 Баланс та Портфелi
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '22**,9129 Баланс та Портфелi',
                                                  p_funcname => 'FunNSIEditF("NOT_CCK_PK", 2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 22**,9129, що вiдсутнi в КП та в БПК ********** ');
          --  Створюємо функцію 22**,9129, що вiдсутнi в КП та в БПК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '22**,9129, що вiдсутнi в КП та в БПК',
                                                  p_funcname => 'FunNSIEditF("NOT_CCK_PK1", 2)',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iнвентаризацiя КП ФО(щомiсячна) ********** ');
          --  Створюємо функцію Iнвентаризацiя КП ФО(щомiсячна)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iнвентаризацiя КП ФО(щомiсячна)',
                                                  p_funcname => 'FunNSIEditFFiltered("INV_FL[PROC=>P_INV_CCK_FL(:Param0,:Param1,1)][PAR=>:Param0(SEM=Дата,TYPE=D,REF=REZ_PROTOCOL),:Param1(SEM=Переформувати?Так->1/Нi->0,TYPE=N)][EXEC=>BEFORE][MSG=>Ок]",2,"G00=TO_DATE(pul.get_mas_ini_val(''sFdat1''),''dd.mm.yyyy'')")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (KRIF) - АРМ Кредити ФО - Iнвентаризацiя  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKRIF.sql =========*** En
PROMPT ===================================================================================== 
