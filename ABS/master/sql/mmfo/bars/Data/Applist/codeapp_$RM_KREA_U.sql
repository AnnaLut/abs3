PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_KREA_U.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_KREA_U ***
  declare
    l_application_code varchar2(10 char) := '$RM_KREA_U';
    l_application_name varchar2(300 char) := 'АРМ Автоматизованих операцій КП ЮО';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_KREA_U створюємо (або оновлюємо) АРМ АРМ Автоматизованих операцій КП ЮО ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Start/ Авто-просрочка рахунків боргу SS - ЮО ********** ');
          --  Створюємо функцію Start/ Авто-просрочка рахунків боргу SS - ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start/ Авто-просрочка рахунків боргу SS - ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> CCK.CC_ASP ( -1,1)][QST=>Виконати Start/ Авто-просрочка рахунків боргу SS - ЮО?][MSG=>Виконано!]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S32: Авто-просрочка рахунків нарах.% SN ЮО ********** ');
          --  Створюємо функцію КП S32: Авто-просрочка рахунків нарах.% SN ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S32: Авто-просрочка рахунків нарах.% SN ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK.CC_ASPN(2,0,1)][QST=>Ви бажаєте виконати винесення на прострочку процентів клієнта?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО ********** ');
          --  Створюємо функцію Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ЮО ?][MSG=>Перенесення виканано !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ЮО ********** ');
          --  Створюємо функцію КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''5'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ЮО ?][MSG=>Перенесення виканано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка КП ЮО - виноси на прострочку(на старті) ********** ');
          --  Створюємо функцію Обробка КП ЮО - виноси на прострочку(на старті)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка КП ЮО - виноси на прострочку(на старті)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCT.StartI(0)][QST=>Ви бажаєте виконати винесення на прострочку(на старті)?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка КП ЮО - виноси на прострочку(на фініші) ********** ');
          --  Створюємо функцію Обробка КП ЮО - виноси на прострочку(на фініші)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка КП ЮО - виноси на прострочку(на фініші)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCT.StartI(0)][QST=>Ви бажаєте виконати винесення на прострочку(на фініші)?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F05_3: Авто разбір рах-ів ISG (3600) Кред-ої заборг-ті ЮО (SPN,SN) ********** ');
          --  Створюємо функцію КП F05_3: Авто разбір рах-ів ISG (3600) Кред-ої заборг-ті ЮО (SPN,SN)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F05_3: Авто разбір рах-ів ISG (3600) Кред-ої заборг-ті ЮО (SPN,SN)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_ISG(-1,''SPN|SN '')][QST=>Ви хочете зробити Авто разбір рахунків Кред-ої заборг-ті?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F05: Авто разбір рахунків ISG (3600) Кред-ої заборг-ті на (SPN,SN) ********** ');
          --  Створюємо функцію КП F05: Авто разбір рахунків ISG (3600) Кред-ої заборг-ті на (SPN,SN)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F05: Авто разбір рахунків ISG (3600) Кред-ої заборг-ті на (SPN,SN)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_ISG(0,''SPN|SN '')][QST=>Ви хочете зробити Авто разбір рахунків Кред-ої заборг-ті?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S7: Амортизація Дисконту/Премії ЮО з ЕПС ********** ');
          --  Створюємо функцію КП S7: Амортизація Дисконту/Премії ЮО з ЕПС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S7: Амортизація Дисконту/Премії ЮО з ЕПС',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY_PET(-1,gl.bd,3)][QST=>Ви хочете вик. Амортізацію Дисконту ЮО?][MSG=> Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S8: Авто закриття договорів ЮО ********** ');
          --  Створюємо функцію КП S8: Авто закриття договорів ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S8: Авто закриття договорів ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cc_close(2,bankdate)][QST=>Ви бажаєте виконати авто-закриття договорів ЮО?][MSG=>Закриття виканано !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вирівнювання залишків на 9129 по КП ЮО ********** ');
          --  Створюємо функцію Вирівнювання залишків на 9129 по КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вирівнювання залишків на 9129 по КП ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.CC_9129(bankdate,0,2) ][QST=>Виконати "Вирівнювання залишків на 9129 по КП ЮО"?][MSG=>Виконано !]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО ********** ');
          --  Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.cc_wdate(2,gl.bd,0)][QST=>Ви хочете винести на прострочку всі активи клієнта?][MSG=>Виконано !]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S9: Зміна парам ОБС.БОРГУ (ЮО) ********** ');
          --  Створюємо функцію КП S9: Зміна парам ОБС.БОРГУ (ЮО)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S9: Зміна парам ОБС.БОРГУ (ЮО)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.update_obs(gl.bd,-2)][QST=>Ви бажаєте виконати призупинення обслю боргу?][MSG=> Виконано!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S42: Нарахування %%  по поточних платіж. датах у КП ЮО ********** ');
          --  Створюємо функцію КП S42: Нарахування %%  по поточних платіж. датах у КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S42: Нарахування %%  по поточних платіж. датах у КП ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK&accessCode=1&sPar=[PROC=>p_interest_cck(null,1,:E)][PAR=>:E(SEM=Дата по,TYPE=D)][showDialogWindow=>false][DESCR=>КД: Нарах.%%][EXEC=>BEFORE][NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S55: Нарахування %%  по КД з залишками на рах. погашення ЮО ********** ');
          --  Створюємо функцію КП S55: Нарахування %%  по КД з залишками на рах. погашення ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S55: Нарахування %%  по КД з залишками на рах. погашення ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK&accessCode=1&sPar=[PROC=>p_interest_cck(null,4,:E)][PAR=>:E(SEM=Дата по,TYPE=D)][showDialogWindow=>false][DESCR=>КД: Нарах.%%][EXEC=>BEFORE][NSIFUNCTION]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_KREA_U) - АРМ Автоматизованих операцій КП ЮО  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_KREA_U.sql =========
PROMPT ===================================================================================== 
