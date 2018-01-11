PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@IN .sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@IN  ***
  declare
    l_application_code varchar2(10 char) := '$RM_@IN ';
    l_application_name varchar2(300 char) := 'АРМ CIN Централiзована iнкасацiя';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@IN  створюємо (або оновлюємо) АРМ АРМ CIN Централiзована iнкасацiя ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Візування операцій свого та дочірніх відділень ********** ');
          --  Створюємо функцію Візування операцій свого та дочірніх відділень
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Візування операцій свого та дочірніх відділень',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=4',
                                                  p_rolename => 'WR_CHCKINNR_SUBTOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Візування операцій свого та дочірніх відділень
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Візування операцій свого та дочірніх відділень',
															  p_funcname => '/barsroot/checkinner/documents.aspx?type=4&grpid=\w+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Сервіс додатку BarsWeb.CheckInner
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Сервіс додатку BarsWeb.CheckInner',
															  p_funcname => '/barsroot/checkinner/service.asmx',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F3 Генерація проводок по НАРАХУВАННЮ комісії ********** ');
          --  Створюємо функцію F3 Генерація проводок по НАРАХУВАННЮ комісії
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F3 Генерація проводок по НАРАХУВАННЮ комісії',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CIN.KOM_GOU(3)][QST=>Виконати - НАРАХУВАННЯ ?][MSG=>Готово!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F4 Генерація проводок по СПЛАТІ комісії ********** ');
          --  Створюємо функцію F4 Генерація проводок по СПЛАТІ комісії
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F4 Генерація проводок по СПЛАТІ комісії',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CIN.KOM_GOU(37)][QST=>Виконати  - СПЛАТУ ?][MSG=>Готово!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Відбір ВПС-докментiв для розрахунку CIN ********** ');
          --  Створюємо функцію Відбір ВПС-докментiв для розрахунку CIN
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Відбір ВПС-докментiв для розрахунку CIN',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CIN.PREV_DOK(:D1,:D2)][PAR=>:D1(SEM=Дата ''З'',TYPE=D),:D2(SEM=Дата ''По'',TYPE=D)][MSG=>Виконано!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F1 Фінал-розрахунок + перегляд-коригування результів ********** ');
          --  Створюємо функцію F1 Фінал-розрахунок + перегляд-коригування результів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F1 Фінал-розрахунок + перегляд-коригування результів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=CIN_TKR[PROC=>CIN.KOM_ALL(1,:B,:E,:R)][PAR=>:B(SEM=Дата ''З'',TYPE=C),:E(SEM=Дата ''По'',TYPE=C),:R(SEM=РНК_кл,TYPE=N,REF=V_CUSTRNK)][EXEC=>BEFORE][CONDITIONS=> CIN.R in (0,CIN_TKR.RNK) and CIN_TKR.dat1>=CIN.B and CIN_TKR.dat2<=CIN.E][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Way4. Несквитовані документи (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. Несквитовані документи (web)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд довідника мережі точок клієнтів ********** ');
          --  Створюємо функцію Перегляд довідника мережі точок клієнтів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд довідника мережі точок клієнтів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_CUST&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд прогноз-протоколу (по Кл+TK+Док) ********** ');
          --  Створюємо функцію Перегляд прогноз-протоколу (по Кл+TK+Док)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд прогноз-протоколу (по Кл+TK+Док)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_KOM0&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд прогноз-протоколу (по Кл+TK) ********** ');
          --  Створюємо функцію Перегляд прогноз-протоколу (по Кл+TK)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд прогноз-протоколу (по Кл+TK)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_KOM1&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд прогноз-протоколу (по Кл) ********** ');
          --  Створюємо функцію Перегляд прогноз-протоколу (по Кл)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд прогноз-протоколу (по Кл)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_KOM2&accessCode=1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Прогноз-Розрахунок + Перегляд рез.(від Кл) ********** ');
          --  Створюємо функцію Прогноз-Розрахунок + Перегляд рез.(від Кл)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Прогноз-Розрахунок + Перегляд рез.(від Кл)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_KOM2&accessCode=1&sPar=[PROC=>CIN.KOM_ALL(0,:B,:E,:R)][PAR=>:B(SEM=Дата ''З'',TYPE=C),:E(SEM=Дата ''По'',TYPE=C),:R(SEM=РНК_кл,TYPE=N,REF=CIN_CUST)][EXEC=>BEFORE][CONDITIONS=> CIN.R in (0,CIN_KOM2.RNK) and CIN_KOM2.dat1>=CIN.B and CIN_KOM2.dat2<=CIN.E]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію F2.Перегляд/коригування фінального протоколу ********** ');
          --  Створюємо функцію F2.Перегляд/коригування фінального протоколу
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'F2.Перегляд/коригування фінального протоколу',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CIN_TKR&accessCode=2&sPar=[PROC=>CIN.KOM_ALL(3,:B,:E,:R)][PAR=>:B(SEM=Дата ''З'',TYPE=C),:E(SEM=Дата ''По'',TYPE=C),:R(SEM=РНК_кл,TYPE=N,REF=V_CUSTRNK)][EXEC=>BEFORE][CONDITIONS=> CIN.R in (0,CIN_TKR.RNK) and CIN_TKR.dat1>=CIN.B and CIN_TKR.dat2<=CIN.E]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Way4. Несквитовані документи (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. Несквитовані документи (web)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_@IN ) - АРМ CIN Централiзована iнкасацiя  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@IN .sql =========**
PROMPT ===================================================================================== 
