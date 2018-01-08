PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_AVVV.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_AVVV ***
  declare
    l_application_code varchar2(10 char) := '$RM_AVVV';
    l_application_name varchar2(300 char) := 'АРМ Відкриття внутрішніх рахунків';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_AVVV створюємо (або оновлюємо) АРМ АРМ Відкриття внутрішніх рахунків ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Оновлення рахунків(по доступу) ********** ');
          --  Створюємо функцію Оновлення рахунків(по доступу)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Оновлення рахунків(по доступу)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=2&t=1',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Автовiдкр.рах.по ВИБРАНИМ цiнностям для бранчу 2,2+,3 рiвня ********** ');
          --  Створюємо функцію Автовiдкр.рах.по ВИБРАНИМ цiнностям для бранчу 2,2+,3 рiвня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Автовiдкр.рах.по ВИБРАНИМ цiнностям для бранчу 2,2+,3 рiвня',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=VALUABLES[NSIFUNCTION][PROC=>PUL.PUT(''BRA'',:BRA)][PAR=>:BRA(SEM=Бранч,TYPE=S,REF=BRANCH_VAR)][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Автовiдкр.рах.по ВСIМ цiннос для 1-го бранчу 2,3 рiвня ********** ');
          --  Створюємо функцію Автовiдкр.рах.по ВСIМ цiннос для 1-го бранчу 2,3 рiвня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Автовiдкр.рах.по ВСIМ цiннос для 1-го бранчу 2,3 рiвня',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BR_SX(:P)][PAR=>:P(SEM=Бранч,TYPE=S,REF=BRANCH_OP_BR)][MSG=>OK!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Автовiдкр.рах.по 1-й цiннос для бранчу 2,2+,3 рiвня ********** ');
          --  Створюємо функцію Автовiдкр.рах.по 1-й цiннос для бранчу 2,2+,3 рiвня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Автовiдкр.рах.по 1-й цiннос для бранчу 2,2+,3 рiвня',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BR_SX1(:P1,:P2)][PAR=>:P1(SEM=Бранч,TYPE=S,REF=BRANCH_VAR),:P2(SEM=Цiннiсть,TYPE=S,REF=VALUABLES)][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Автовідкриття рахунків по 1-й цінності для бранчу 2,2+3 рівня (кущ)  ********** ');
          --  Створюємо функцію Автовідкриття рахунків по 1-й цінності для бранчу 2,2+3 рівня (кущ) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Автовідкриття рахунків по 1-й цінності для бранчу 2,2+3 рівня (кущ) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BR_SXO(:P1,:P2)][PAR=>:P1(SEM=Бранч,TYPE=S,REF=V_SXO),:P2(SEM=Цiннiсть,TYPE=S,REF=VALUABLES)][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Автовiдкр.рах.по БР+ОБ22 для всiх бранчiв 2 ********** ');
          --  Створюємо функцію Автовiдкр.рах.по БР+ОБ22 для всiх бранчiв 2
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Автовiдкр.рах.по БР+ОБ22 для всiх бранчiв 2',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BSOBV(0,:V,:A,null,null,null,null)][PAR=>:V(SEM=Вал,TYPE=N),:A(SEM=ББББОО,REF=V_NBSOB22)][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Автовiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня ********** ');
          --  Створюємо функцію Автовiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Автовiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>OP_BSOBV(1,:V,:A,:B,null,null,null)][PAR=>:V(SEM=Вал,TYPE=N),:A(SEM=ББББОО,REF=V_NBSOB22),:B(SEM=Бранч,REF=BRANCH_VAR)][MSG=>OK]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію "Оптове" закриття внутрішніх рахунків ********** ');
          --  Створюємо функцію "Оптове" закриття внутрішніх рахунків
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"Оптове" закриття внутрішніх рахунків',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=ACCOUNTS0[NSIFUNCTION][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вiдкриття рахункiв для роботи Бр-3 в MTI ********** ');
          --  Створюємо функцію Вiдкриття рахункiв для роботи Бр-3 в MTI
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вiдкриття рахункiв для роботи Бр-3 в MTI',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>MONEX_RU.OP_NLS_MTI(:A,:B,:C,:D,:E)][PAR=>:A(SEM=Б1,REF=BRANCH3_OB),:B(SEM=Б2,REF=BRANCH3_OB),:C(SEM=Б3,REF=BRANCH3_OB),:D(SEM=Б4,REF=BRANCH3_OB),:E(SEM=Б5,REF=BRANCH3_OB)][MSG=>OK]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Автовiдкр.рах. по БР+ОБ22 для кiлькох бр(2,2+,3) ********** ');
          --  Створюємо функцію Автовiдкр.рах. по БР+ОБ22 для кiлькох бр(2,2+,3)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Автовiдкр.рах. по БР+ОБ22 для кiлькох бр(2,2+,3)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>OP_BSOBV(2,:V,:A,:B,:C,:D,:E)][PAR=>:V(SEM=Вал,TYPE=N),:A(SEM=ББББОО,REF=V_NBSOB22),:B(SEM=Б-1,REF=BRANCH_VAR),:C(SEM=Б-2,REF=BRANCH_VAR),:D(SEM=Б-3,REF=BRANCH_VAR),:E(SEM=Б-4,REF=BRANCH_VAR)][MSG=>OK]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_AVVV) - АРМ Відкриття внутрішніх рахунків  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_AVVV.sql =========**
PROMPT ===================================================================================== 
