PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_SEPN.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_SEPN ***
  declare
    l_application_code varchar2(10 char) := '$RM_SEPN';
    l_application_name varchar2(300 char) := 'АРМ Заблоковані док-ти СЕП';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_SEPN створюємо (або оновлюємо) АРМ АРМ Заблоковані док-ти СЕП ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Документи з майбутньою датою валютування, що НЕ настала ********** ');
          --  Створюємо функцію СЕП. Документи з майбутньою датою валютування, що НЕ настала
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Документи з майбутньою датою валютування, що НЕ настала',
                                                  p_funcname => '/barsroot/sep/sepfuturedocs/',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Документи з майбутньою датою валютування, що Не настала (Видал.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Документи з майбутньою датою валютування, що Не настала (Видал.)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/removesepfuturedoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Документи з майбутньою датою валютування, що Не настала (Рахунок)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Документи з майбутньою датою валютування, що Не настала (Рахунок)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/getsepfuturedocaccount\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Документи з майбутньою датою валютування, що Не настала (Встанов.)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Документи з майбутньою датою валютування, що Не настала (Встанов.)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/setsepfuturedoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Документи з майбутньою датою валютування, що Не настала (Документи)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Документи з майбутньою датою валютування, що Не настала (Документи)',
															  p_funcname => '/barsroot/sep/sepfuturedocs/getsepfuturedoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані документи СЕП  ( Всі ) ********** ');
          --  Створюємо функцію СЕП. Заблоковані документи СЕП  ( Всі )
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані документи СЕП  ( Всі )',
                                                  p_funcname => '/barsroot/sep/seplockdocs/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Заблоковані документи СЕП (Без контролю ВПС) (Документи)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Заблоковані документи СЕП (Без контролю ВПС) (Документи)',
															  p_funcname => '/barsroot/sep/seplockdocs/getseplockdoc\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Заблоковані документи СЕП (Без контролю ВПС)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Заблоковані документи СЕП (Без контролю ВПС)',
															  p_funcname => '/barsroot/sep/seplockdocs/index\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Заблоковані документи СЕП (Без контролю ВПС)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Заблоковані документи СЕП (Без контролю ВПС)',
															  p_funcname => '/barsroot/sep/seplockdocs/index?DefinedCode=1',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію СЕП. Заблоковані надходження (ЕнергоРинок) ********** ');
          --  Створюємо функцію СЕП. Заблоковані надходження (ЕнергоРинок)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'СЕП. Заблоковані надходження (ЕнергоРинок)',
                                                  p_funcname => '/barsroot/sep/seplockdocs?fixedblk=(25,27)',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Звітність Ощадного Банку
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Звітність Ощадного Банку',
															  p_funcname => 'ShowFilesInt(hWndMDI)',
															  p_rolename => 'RPBN002' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_SEPN) - АРМ Заблоковані док-ти СЕП  ');
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
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_SEPN.sql =========**
PROMPT ===================================================================================== 
