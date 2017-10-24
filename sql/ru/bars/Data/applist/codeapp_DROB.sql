SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_DROB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  DROB ***
  declare
    l_application_code varchar2(10 char) := 'DROB';
    l_application_name varchar2(300 char) := 'Арм "Реєстр позичальникiв"';
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
     DBMS_OUTPUT.PUT_LINE(' DROB створюємо (або оновлюємо) АРМ Арм "Реєстр позичальникiв" ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 3.Запити/Вiдповiдi до ЦБД ********** ');
          --  Створюємо функцію 3.Запити/Вiдповiдi до ЦБД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '3.Запити/Вiдповiдi до ЦБД',
                                                  p_funcname => 'DRAcrProc (hWndMDI, "C" )',
                                                  p_rolename => 'DEB_REG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 4.Всi вiдповiдi з ЦБД ********** ');
          --  Створюємо функцію 4.Всi вiдповiдi з ЦБД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '4.Всi вiдповiдi з ЦБД',
                                                  p_funcname => 'DRAcrProc (hWndMDI, "D" )',
                                                  p_rolename => 'DEB_REG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.Зеркало Реєстру ********** ');
          --  Створюємо функцію 2.Зеркало Реєстру
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.Зеркало Реєстру',
                                                  p_funcname => 'DRAcrProc (hWndMDI, "DR_MIRROR" )',
                                                  p_rolename => 'DEB_REG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Монiторинг/Постака iнформацiї в ЦБД ********** ');
          --  Створюємо функцію 1.Монiторинг/Постака iнформацiї в ЦБД
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Монiторинг/Постака iнформацiї в ЦБД',
                                                  p_funcname => 'DRAcrProc (hWndMDI, "F" )  ',
                                                  p_rolename => 'DEB_REG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 6.Заблокованi клiєнти (по файлах PF) ********** ');
          --  Створюємо функцію 6.Заблокованi клiєнти (по файлах PF)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '6.Заблокованi клiєнти (по файлах PF)',
                                                  p_funcname => 'DRAcrProc (hWndMDI, "PF_BLK" )',
                                                  p_rolename => 'DEB_REG' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 5.Реєстр боржникiв (iнф.про файли) ********** ');
          --  Створюємо функцію 5.Реєстр боржникiв (iнф.про файли)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '5.Реєстр боржникiв (iнф.про файли)',
                                                  p_funcname => 'DRAcrProc(hWndMDI, "FILE_INFO")',
                                                  p_rolename => 'DEB_REG' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (DROB) - Арм "Реєстр позичальникiв"  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappDROB.sql =========*** En
PROMPT ===================================================================================== 
