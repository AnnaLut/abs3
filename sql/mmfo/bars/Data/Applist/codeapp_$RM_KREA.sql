SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_KREA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_KREA ***
  declare
    l_application_code varchar2(10 char) := '$RM_KREA';
    l_application_name varchar2(300 char) := 'АРМ Автоматизованих операцiй КП';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_KREA створюємо (або оновлюємо) АРМ АРМ Автоматизованих операцiй КП ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію  Модулі в АБС, що пов`язані з Фін.Деб ********** ');
          --  Створюємо функцію  Модулі в АБС, що пов`язані з Фін.Деб
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' Модулі в АБС, що пов`язані з Фін.Деб',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=FIN_DEBM',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Start/ Авто-просрочка рахунків боргу SS - ЮО ********** ');
          --  Створюємо функцію Start/ Авто-просрочка рахунків боргу SS - ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start/ Авто-просрочка рахунків боргу SS - ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> CCK.CC_ASP ( -1,1)][QST=>Виконати Start/ Авто-просрочка рахунків боргу SS - ЮО?][MSG=>Виконано!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F0: Авторозбір рахунків погашення SG ********** ');
          --  Створюємо функцію КП F0: Авторозбір рахунків погашення SG
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F0: Авторозбір рахунків погашення SG',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK.CC_ASG (0)][QST=>Виконати "КП F0: Авторозбір рахунків погашення SG"?][MSG=>Виконано !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО ********** ');
          --  Створюємо функцію Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ЮО ?][MSG=>Перенесення виканано !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш. ФО ********** ');
          --  Створюємо функцію #2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш. ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш. ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''3'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C,REF=BRANCH)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ФО ?][MSG=>Перенесення виканано !]',
                                                  p_rolename => 'bars_access_defrole' ,    
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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Амортизація Дисконту/Премії ФО ********** ');
          --  Створюємо функцію Амортизація Дисконту/Премії ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Амортизація Дисконту/Премії ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(-11,bankdate,3)][QST=>Виконати амортизацію дисконту ФО?][MSG=>Готово!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Амортизація Дисконту/Премії ********** ');
          --  Створюємо функцію Амортизація Дисконту/Премії
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Амортизація Дисконту/Премії',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(0,bankdate,3)][QST=>Виконати амортизацію дисконту?][MSG=>Готово!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S7: Амортизація Дисконту/Премії ЮО ********** ');
          --  Створюємо функцію КП S7: Амортизація Дисконту/Премії ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S7: Амортизація Дисконту/Премії ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY_PET(-1,gl.bd,3)][QST=>Ви хочете вик. Амортізацію Дисконту ЮО?][MSG=> Виконано !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S7: Амортизація Диск/Прем ********** ');
          --  Створюємо функцію КП S7: Амортизація Диск/Прем
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S7: Амортизація Диск/Прем',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY_PET(0,gl.bd,3)][QST=>Ви хочете вик. Амортізацію Дисконту?][MSG=> Виконано!]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S69: Функція по автоматичному згортанню пені ********** ');
          --  Створюємо функцію КП S69: Функція по автоматичному згортанню пені
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S69: Функція по автоматичному згортанню пені',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>PENY_PAY(gl.bd,0)][QST=>Зробити згортання пені?][MSG=>Згортання завершене!]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію CCK: Встановити розрахунковий спецпараметр S080 для ЮО ********** ');
          --  Створюємо функцію CCK: Встановити розрахунковий спецпараметр S080 для ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'CCK: Встановити розрахунковий спецпараметр S080 для ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>P_SET_S080(2,:Param0)][PAR=>:Param0(SEM=БРАНЧ для встановл з підл. ТВБВ додавати  *,TYPE=C)][QST=> Встановити розрахунковий параметр S080 для ЮО ?][MSG=>Встановлення виканано !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію CCK: Встановити розрахунковий спецпараметр S080 для ФО ********** ');
          --  Створюємо функцію CCK: Встановити розрахунковий спецпараметр S080 для ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'CCK: Встановити розрахунковий спецпараметр S080 для ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>P_SET_S080(3,:Param0)][PAR=>:Param0(SEM=БРАНЧ для встановл з підл. ТВБВ додавати  *,TYPE=C)][QST=> Встановити розрахунковий параметр S080 для ФО ?][MSG=>Встановлення виканано !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S8: Авто закриття договорів ФО ********** ');
          --  Створюємо функцію КП S8: Авто закриття договорів ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S8: Авто закриття договорів ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cc_close(3,bankdate)][QST=>Ви бажаєте виконати авто-закриття договорів ФО?][MSG=>Закриття виканано !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вирівнювання залишків на 9129 по КП ЮО ********** ');
          --  Створюємо функцію Вирівнювання залишків на 9129 по КП ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вирівнювання залишків на 9129 по КП ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.CC_9129(bankdate,0,2) ][QST=>Виконати "Вирівнювання залишків на 9129 по КП ЮО"?][MSG=>Виконано !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вирівнювання залишків на 9129 по КП ФО ********** ');
          --  Створюємо функцію Вирівнювання залишків на 9129 по КП ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вирівнювання залишків на 9129 по КП ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.CC_9129(bankdate,0,3)][QST=>Виконати "Вирівнювання залишків на 9129 по КП ФО?][MSG=>Виконано !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО ********** ');
          --  Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ФО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.cc_wdate(3,gl.bd,0)][QST=>Ви хочете винести на прострочку всі активи клієнта?][MSG=>Виконано !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F6: Збереження актуальних ГПК на звітну дату ********** ');
          --  Створюємо функцію КП F6: Збереження актуальних ГПК на звітну дату
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F6: Збереження актуальних ГПК на звітну дату',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck_arc_cc_lim(gl.bd, -1)][QST=>Ви бажаєте виконати збереження актуальних ГПК?][MSG=>Виконано !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Нарахування %% Кредити ЮО ********** ');
          --  Створюємо функцію Нарахування %% Кредити ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Нарахування %% Кредити ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=INT_GL&sPar=[PROC=>PUL_DAT(to_char(:P,''dd/mm/yyyy''),null)][PAR=>:P(SEM=Дата,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][CONDITIONS=>NBS like ''20%'' AND ID = 0]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Продукт: "ФІНАНСОВА ДЕБІТОРКА" в ОБ ********** ');
          --  Створюємо функцію Продукт: "ФІНАНСОВА ДЕБІТОРКА" в ОБ
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Продукт: "ФІНАНСОВА ДЕБІТОРКА" в ОБ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FIN_DEBT&accessCode=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Таблиця КД та їх потоків ********** ');
          --  Створюємо функцію Таблиця КД та їх потоків
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Таблиця КД та їх потоків',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=PRVN_FLOW_DEALS&accessCode=2&sPar=[NSIFUNCTION][PROC=>PUL_DAT(:A,null)][PAR=>:A(SEM=Звiтна дата dd_mm_yyyy)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звіти по автоматичним функціям КП ЮО ********** ');
          --  Створюємо функцію Звіти по автоматичним функціям КП ЮО
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звіти по автоматичним функціям КП ЮО',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_REP&accessCode=1&sPar=[PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=Вибір функції,TYPE=N,REF=V_CCK_REP_LIST_YL)][NSIFUNCTION][EXEC=>BEFORE][MSG=>Виконано!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП: Нарахування щомiсячної комiсiї по КП ********** ');
          --  Створюємо функцію КП: Нарахування щомiсячної комiсiї по КП
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП: Нарахування щомiсячної комiсiї по КП',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK&accessCode=1&sPar=[PROC=>p_interest_cck(null,5,:E)][PAR=>:E(SEM=Дата по,TYPE=D)][showDialogWindow=>false][DESCR=>КД: Нарах.%%][EXEC=>BEFORE][NSIFUNCTION]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_KREA) - АРМ Автоматизованих операцiй КП  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_KREA.sql =========**
PROMPT ===================================================================================== 
