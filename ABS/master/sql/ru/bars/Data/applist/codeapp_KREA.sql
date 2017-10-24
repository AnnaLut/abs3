SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_KREA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  KREA ***
  declare
    l_application_code varchar2(10 char) := 'KREA';
    l_application_name varchar2(300 char) := 'АРМ автоматизованих операцiй КП';
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
     DBMS_OUTPUT.PUT_LINE(' KREA створюємо (або оновлюємо) АРМ АРМ автоматизованих операцiй КП ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F1_2: Вир_внювання залишк_в на 9129 по КП ЮО ********** ');
          --  Створюємо функцію КП F1_2: Вир_внювання залишк_в на 9129 по КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F1_2: Вир_внювання залишк_в на 9129 по КП ЮО',
                                                  p_funcname => 'F1_Select(12, " cck.CC_9129( DAT, 0, 2 ) "  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F6: збереження актуальних ГПК на звітну дату ********** ');
          --  Створюємо функцію КП F6: збереження актуальних ГПК на звітну дату
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F6: збереження актуальних ГПК на звітну дату',
                                                  p_funcname => 'F1_Select(12, "cck_arc_cc_lim ( DAT , -1) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Додаткова щоденна бізнес-логіка продуктів КП ********** ');
          --  Створюємо функцію Додаткова щоденна бізнес-логіка продуктів КП
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Додаткова щоденна бізнес-логіка продуктів КП',
                                                  p_funcname => 'F1_Select(12,"CCK_SCAN (''%'') ") ',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка КЛ ЮО - выносы на просрочку(на старте) ********** ');
          --  Створюємо функцію Обробка КЛ ЮО - выносы на просрочку(на старте)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка КЛ ЮО - выносы на просрочку(на старте)',
                                                  p_funcname => 'F1_Select(12,"CCT.StartI (0)")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка КЛ ЮО - отметки о погашениях(на финише) ********** ');
          --  Створюємо функцію Обробка КЛ ЮО - отметки о погашениях(на финише)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка КЛ ЮО - отметки о погашениях(на финише)',
                                                  p_funcname => 'F1_Select(12,"CCT.StartIO (0)")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S69: Функція по автоматичному згортанню пені. ********** ');
          --  Створюємо функцію КП S69: Функція по автоматичному згортанню пені.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S69: Функція по автоматичному згортанню пені.',
                                                  p_funcname => 'F1_Select(13,  "PENY_PAY(DAT,0);Зробити згортання пені?; Згортання завершене!"  ) ',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F05_2: Авто разбір рах-ів ISG (3600) Кред-ої заборг-ті ЮО (SPN,SN) ********** ');
          --  Створюємо функцію КП F05_2: Авто разбір рах-ів ISG (3600) Кред-ої заборг-ті ЮО (SPN,SN)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F05_2: Авто разбір рах-ів ISG (3600) Кред-ої заборг-ті ЮО (SPN,SN)',
                                                  p_funcname => 'F1_Select(13,"CC_ISG(-1,''SPN|SN '');Ви хочете зробити Авто разбір рахунків Кред-ої заборг-ті ЮО?; Виконано !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S36: Перенесення на прострочку відсотків згідно ДНЯ погаш ЮО ********** ');
          --  Створюємо функцію КП S36: Перенесення на прострочку відсотків згідно ДНЯ погаш ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S36: Перенесення на прострочку відсотків згідно ДНЯ погаш ЮО',
                                                  p_funcname => 'FunNSIEdit("[PROC=>CCK_SBER(''2'',''2'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C)][QST=>Зробити перенос % згідно ДНЯ погаш ЮО ?][MSG=>Перенесення виканано !]")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ЮО ********** ');
          --  Створюємо функцію КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ЮО',
                                                  p_funcname => 'FunNSIEdit("[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ЮО ?][MSG=>Перенесення виканано !]")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ФО ********** ');
          --  Створюємо функцію #2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ФО',
                                                  p_funcname => 'FunNSIEdit("[PROC=>CCK_SBER(''3'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ФО ?][MSG=>Перенесення виканано !]")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ФО ********** ');
          --  Створюємо функцію #2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ФО',
                                                  p_funcname => 'FunNSIEdit("[PROC=>CCK_SBER(''3'',''4'',:Param0)][PAR=>:Param0(SEM=БРАНЧ,TYPE=C)][QST=>Зробити перенос % згідно ДНЯ і ТИПУ погаш ФО ?][MSG=>Перенесення виканано !]")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Договори прокукту "ОСВВ" ********** ');
          --  Створюємо функцію Договори прокукту "ОСВВ"
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Договори прокукту "ОСВВ"',
                                                  p_funcname => 'FunNSIEditF("V_CCK_OSBB[PROC=>cck_OSBB_ex(0)][EXEC=>BEFORE]", 2 )',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F12: Щомiсячне Нарахування %% по всім дог. у КП ЮО ********** ');
          --  Створюємо функцію КП F12: Щомiсячне Нарахування %% по всім дог. у КП ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F12: Щомiсячне Нарахування %% по всім дог. у КП ЮО',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (1,2,3))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО ********** ');
          --  Створюємо функцію #5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID in (0,1) and (s.dazs is null or s.dazs>gl.bd) and s.tip in (''SS '',''SP '',''SDI'',''S36'')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=s.acc and n.nd=d.nd and d.vidd in (11,12,13))",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S55: Нарахування %%  по КД з залишками на рах. погашення ЮО ********** ');
          --  Створюємо функцію КП S55: Нарахування %%  по КД з залишками на рах. погашення ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S55: Нарахування %%  по КД з залишками на рах. погашення ЮО',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SS '',''SP '' , ''SL '') and exists (select n.acc from nd_acc n, nd_acc n2,accounts a2  where n.acc=s.acc and  n.nd=n2.nd and n2.acc=a2.acc and a2.tip=''SG '' and a2.ostc>0)",''SA''),''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S54: Нарахування %%  по КД з залишками на рах. погашення ФО ********** ');
          --  Створюємо функцію КП S54: Нарахування %%  по КД з залишками на рах. погашення ФО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S54: Нарахування %%  по КД з залишками на рах. погашення ФО',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''22%'' and s.tip in (''SS '',''SP '' , ''SL '') and exists (select n.acc from nd_acc n, nd_acc n2,accounts a2  where n.acc=s.acc and  n.nd=n2.nd and n2.acc=a2.acc and a2.tip=''SG '' and a2.ostc>0)",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #3) КП S42: Нарахування %% по пл. датам у КП ЮО (АНУЇТЕТ) ********** ');
          --  Створюємо функцію #3) КП S42: Нарахування %% по пл. датам у КП ЮО (АНУЇТЕТ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#3) КП S42: Нарахування %% по пл. датам у КП ЮО (АНУЇТЕТ)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.tip in(''SS '',''SP '')  and s.acc in (select N.acc from nd_acc n, cc_v d  where d.GPK=4 and n.nd=d.nd and d.vidd=1  and cck.PAY_GPK(gl.bd,D.ND,null)=1)","SAN")',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію #3) КП S43: Нарахування %% по пл. датам у КП ФЛ (АНУЇТЕТ) ********** ');
          --  Створюємо функцію #3) КП S43: Нарахування %% по пл. датам у КП ФЛ (АНУЇТЕТ)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#3) КП S43: Нарахування %% по пл. датам у КП ФЛ (АНУЇТЕТ)',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.tip in(''SS '',''SP '')  and s.acc in (select N.acc from nd_acc n, cc_v d  where d.GPK=4 and n.nd=d.nd and d.vidd=11  and cck.PAY_GPK(gl.bd,D.ND,null)=1)","SAN")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F22: Щомiсячне Нарахування комісії по ЮЛ. ********** ');
          --  Створюємо функцію КП F22: Щомiсячне Нарахування комісії по ЮЛ.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F22: Щомiсячне Нарахування комісії по ЮЛ.',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=2 and i.metr in (95,96,97,98) and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc nn,cc_deal dd where nn.nd=dd.nd and dd.vidd in (1,2,3) and nn.acc=s.acc) ",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (KREA) - АРМ автоматизованих операцiй КП  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappKREA.sql =========*** En
PROMPT ===================================================================================== 
