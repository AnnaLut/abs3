SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_TKLB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  TKLB ***
  declare
    l_application_code varchar2(10 char) := 'TKLB';
    l_application_name varchar2(300 char) := 'АРМ Технолога Клієнт-Банк';
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
     DBMS_OUTPUT.PUT_LINE(' TKLB створюємо (або оновлюємо) АРМ АРМ Технолога Клієнт-Банк ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Наличие документов Клиент-Банк ********** ');
          --  Створюємо функцію Наличие документов Клиент-Банк
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Наличие документов Клиент-Банк',
                                                  p_funcname => 'FunNSIEditF(''KLPEOM'',1)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відбір підсумкових (проміжних) виписок (E) поточного дня (SBB) ********** ');
          --  Створюємо функцію Відбір підсумкових (проміжних) виписок (E) поточного дня (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відбір підсумкових (проміжних) виписок (E) поточного дня (SBB)',
                                                  p_funcname => 'KliTex(1,hWndMDI,"")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F/Відбір виписок "електронним" клієнтам ********** ');
          --  Створюємо функцію F/Відбір виписок "електронним" клієнтам
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F/Відбір виписок "електронним" клієнтам',
                                                  p_funcname => 'KliTex(2, hWndMDI, "")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відбір закл. виписок поточного дня (SBB) ********** ');
          --  Створюємо функцію Відбір закл. виписок поточного дня (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відбір закл. виписок поточного дня (SBB)',
                                                  p_funcname => 'KliTex(4,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відбір закл. виписок поточного дня + курси (SBB) ********** ');
          --  Створюємо функцію Відбір закл. виписок поточного дня + курси (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відбір закл. виписок поточного дня + курси (SBB)',
                                                  p_funcname => 'KliTex(5,hWndMDI,"")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Передача и возврат полномочий пользователей по КЛИЕНТ-БАНК ********** ');
          --  Створюємо функцію Передача и возврат полномочий пользователей по КЛИЕНТ-БАНК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Передача и возврат полномочий пользователей по КЛИЕНТ-БАНК',
                                                  p_funcname => 'Sel000(hWndMDI,10,0,"","")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Управление счетами "электронных" клиентов ********** ');
          --  Створюємо функцію Управление счетами "электронных" клиентов
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Управление счетами "электронных" клиентов',
                                                  p_funcname => 'Sel000(hWndMDI,33,0,"","")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Необработанные документы от КБ ********** ');
          --  Створюємо функцію Необработанные документы от КБ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Необработанные документы от КБ',
                                                  p_funcname => 'Sel000(hWndMDI,37,0,"","")',
                                                  p_rolename => 'TECH_MOM1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Картки (параметри) абонентів КЛІЄНТ-БАНК ********** ');
          --  Створюємо функцію Картки (параметри) абонентів КЛІЄНТ-БАНК
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Картки (параметри) абонентів КЛІЄНТ-БАНК',
                                                  p_funcname => 'Sel000(hWndMDI,7,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S/Очистка CUSTCOUNT для КЛІЄНТ-БАНК (SBB) ********** ');
          --  Створюємо функцію S/Очистка CUSTCOUNT для КЛІЄНТ-БАНК (SBB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S/Очистка CUSTCOUNT для КЛІЄНТ-БАНК (SBB)',
                                                  p_funcname => 'Sel000(hWndMDI,8,0,"","")',
                                                  p_rolename => 'OPERKKK' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (TKLB) - АРМ Технолога Клієнт-Банк  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappTKLB.sql =========*** En
PROMPT ===================================================================================== 
