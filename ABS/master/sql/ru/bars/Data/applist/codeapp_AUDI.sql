SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_AUDI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  AUDI ***
  declare
    l_application_code varchar2(10 char) := 'AUDI';
    l_application_name varchar2(300 char) := 'Делойт-Аудит РУ ОБ';
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
     DBMS_OUTPUT.PUT_LINE(' AUDI створюємо (або оновлюємо) АРМ Делойт-Аудит РУ ОБ ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Export-4. Оборотно-сальдова вiдомiсть ********** ');
          --  Створюємо функцію Export-4. Оборотно-сальдова вiдомiсть
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-4. Оборотно-сальдова вiдомiсть',
                                                  p_funcname => 'ExportCatQuery(4586,"",7,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Export-1. Всi трансакцiї ********** ');
          --  Створюємо функцію Export-1. Всi трансакцiї
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-1. Всi трансакцiї',
                                                  p_funcname => 'ExportCatQuery(4587,"",7,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Export-3. Довiдник користувачiв ********** ');
          --  Створюємо функцію Export-3. Довiдник користувачiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-3. Довiдник користувачiв',
                                                  p_funcname => 'ExportCatQuery(4588,"",7,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Export-2. План рахункiв ********** ');
          --  Створюємо функцію Export-2. План рахункiв
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-2. План рахункiв',
                                                  p_funcname => 'ExportCatQuery(4589,"",7,"",TRUE)',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Export-6. Форма F_22. ********** ');
          --  Створюємо функцію Export-6. Форма F_22.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Export-6. Форма F_22.',
                                                  p_funcname => 'ExportCatQuery(4746,"",7,"",TRUE)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Таблиця проводок Test_Del1 ********** ');
          --  Створюємо функцію 1.Таблиця проводок Test_Del1
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Таблиця проводок Test_Del1',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(1,:Par1,:Par2)][PAR=>:Par1(SEM= Поч.дата dd.mm.yyyy>,TYPE=S),:Par2(SEM= Кiн.дата dd.mm.yyyy>,TYPE=S)]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.План рахункiв Test_Del2 ********** ');
          --  Створюємо функцію 2.План рахункiв Test_Del2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.План рахункiв Test_Del2',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(2,:Par1,:Par2)][PAR=>:Par1(SEM= Поч.дата dd.mm.yyyy>,TYPE=S),:Par2(SEM= Кiн.дата dd.mm.yyyy>,TYPE=S)]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3.Довiдник користувачiв Test_Del3 ********** ');
          --  Створюємо функцію 3.Довiдник користувачiв Test_Del3
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.Довiдник користувачiв Test_Del3',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(3,'''','''')]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4.Таблиця Об-сальд вiдомiсть Test_Del4 ********** ');
          --  Створюємо функцію 4.Таблиця Об-сальд вiдомiсть Test_Del4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.Таблиця Об-сальд вiдомiсть Test_Del4',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(4,:Par1,:Par2)][PAR=>:Par1(SEM= Поч.дата dd.mm.yyyy>,TYPE=S),:Par2(SEM= Кiн.дата dd.mm.yyyy>,TYPE=S)]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 5.Формування рiзницi оборотiв в ном.Test_Del4 ********** ');
          --  Створюємо функцію 5.Формування рiзницi оборотiв в ном.Test_Del4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5.Формування рiзницi оборотiв в ном.Test_Del4',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(5,'''','''')]")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6.Форма F_22. Test_Del6 ********** ');
          --  Створюємо функцію 6.Форма F_22. Test_Del6
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.Форма F_22. Test_Del6',
                                                  p_funcname => 'FunNSIEdit("[PROC=>deloit(6,:Par1,:Par1)][PAR=>:Par1(SEM= Звiтна дата dd.mm.yyyy>,TYPE=S)]")',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію View + Export-6. Форма F_22. ********** ');
          --  Створюємо функцію View + Export-6. Форма F_22.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'View + Export-6. Форма F_22.',
                                                  p_funcname => 'FunNSIEditF("TEST_DEL6",1)',
                                                  p_rolename => 'DPT_ADMIN' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 5х.Перегляд рiзницi оборотiв в ном.Test_Del4 ********** ');
          --  Створюємо функцію 5х.Перегляд рiзницi оборотiв в ном.Test_Del4
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5х.Перегляд рiзницi оборотiв в ном.Test_Del4',
                                                  p_funcname => 'FunNSIEditFFiltered("TEST_DEL4",1,"(DEL_KN<>0 or DEL_DN<>0)")',
                                                  p_rolename => 'SALGL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (AUDI) - Делойт-Аудит РУ ОБ  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappAUDI.sql =========*** En
PROMPT ===================================================================================== 
