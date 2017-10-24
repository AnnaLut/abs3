SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_NACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  NACC ***
  declare
    l_application_code varchar2(10 char) := 'NACC';
    l_application_name varchar2(300 char) := 'АРМ Нарахування %%';
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
     DBMS_OUTPUT.PUT_LINE(' NACC створюємо (або оновлюємо) АРМ АРМ Нарахування %% ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Стягнення податку з %% на залишки (СПД) 2560-2600-2650 ********** ');
          --  Створюємо функцію  Стягнення податку з %% на залишки (СПД) 2560-2600-2650
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Стягнення податку з %% на залишки (СПД) 2560-2600-2650',
                                                  p_funcname => 'F1_Select(13, "BARS.INT15_N(DAT);Виконати <Стягнення податку з %% на залишки (СПД) 2560-2600-2650>?;Виконано!")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 2.Виплата % за залишки на 2560-2600-2650 ********** ');
          --  Створюємо функцію 2.Виплата % за залишки на 2560-2600-2650
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '2.Виплата % за залишки на 2560-2600-2650',
                                                  p_funcname => 'FunNSIEdit("[PROC=>P_INTCAP(:Param0)][PAR=>:Param0(SEM=Банкiвська дата нарахування %,TYPE=D)][QST=>Ви не забули після нарахування % виконати < Стягнення податку з %% СПД > ?      ВИКОНАТИ  ВИПЛАТУ %%  ?][MSG=>Виконано !]")',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Iсторiя змiн базових %% ставок (перегляд) ********** ');
          --  Створюємо функцію Iсторiя змiн базових %% ставок (перегляд)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Iсторiя змiн базових %% ставок (перегляд)',
                                                  p_funcname => 'FunNSIEditF("BR_NORMAL_VIEW",1 | 0x0010)',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування % по Портфелю Овердрафтiв (2600,2067,3600) ********** ');
          --  Створюємо функцію Нарахування % по Портфелю Овердрафтiв (2600,2067,3600)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування % по Портфелю Овердрафтiв (2600,2067,3600)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0, " and (s.ACC in (Select ACCO from ACC_OVER) or s.ACC in (Select ACC_3600 from ACC_OVER) or s.ACC in (Select ACC_9129 from ACC_OVER)) and not (s.NBS=''2600'' and i.ID=1)", ''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 1.Нарахування % за залишки  2560-2600-2650 ********** ');
          --  Створюємо функцію 1.Нарахування % за залишки  2560-2600-2650
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '1.Нарахування % за залишки  2560-2600-2650',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," AND (s.NBS in (''2560'',''2565'',''2600'',''2603'',''2604'',''2650'') or s.NBS=''2620'' and s.ACC in (select ACC from Specparam_INT where OB22=''07'') ) AND s.ACC not in (Select ACC from DPU_DEAL) AND i.ID=1",''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування % (загальне) ********** ');
          --  Створюємо функцію Нарахування % (загальне)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування % (загальне)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,'''',''SA'')',
                                                  p_rolename => 'DPT_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Історія змін базових % ставок ********** ');
          --  Створюємо функцію Історія змін базових % ставок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Історія змін базових % ставок',
                                                  p_funcname => 'Sel010(hWndMDI,2,0,'''','''')',
                                                  p_rolename => 'DPT_ADMIN' ,
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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (NACC) - АРМ Нарахування %%  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappNACC.sql =========*** En
PROMPT ===================================================================================== 
