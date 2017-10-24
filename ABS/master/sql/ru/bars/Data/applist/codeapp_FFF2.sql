SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_FFF2.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  FFF2 ***
  declare
    l_application_code varchar2(10 char) := 'FFF2';
    l_application_name varchar2(300 char) := 'АРМ автоматизированных операций  КП (ЮО) ';
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
     DBMS_OUTPUT.PUT_LINE(' FFF2 створюємо (або оновлюємо) АРМ АРМ автоматизированных операций  КП (ЮО)  ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Проводки по стартовій ПЕНІ ********** ');
          --  Створюємо функцію Проводки по стартовій ПЕНІ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Проводки по стартовій ПЕНІ',
                                                  p_funcname => 'F1_Select ( 12, " PAY_SN8 ( 2 ) " )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію S. Авто-просрочка рахунків боргу SS -  ЮЛ ********** ');
          --  Створюємо функцію S. Авто-просрочка рахунків боргу SS -  ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'S. Авто-просрочка рахунків боргу SS -  ЮЛ',
                                                  p_funcname => 'F1_Select(12, " CCK.CC_ASP ( -1, 1 ) "  )',
                                                  p_rolename => 'TECH005' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F0_2: Авто-разб_р рахунк_в погашення SG ЮО ********** ');
          --  Створюємо функцію КП F0_2: Авто-разб_р рахунк_в погашення SG ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F0_2: Авто-разб_р рахунк_в погашення SG ЮО',
                                                  p_funcname => 'F1_Select(12, " CCK_ASG_SBER ( 2 , 1 )"  )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію OVR:  Невикористаний овердрафт 9129 ********** ');
          --  Створюємо функцію OVR:  Невикористаний овердрафт 9129
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'OVR:  Невикористаний овердрафт 9129',
                                                  p_funcname => 'F1_Select(12, ''OVR.P_OVR8z(91,0,0,0)'' ) ',
                                                  p_rolename => 'TECH005' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F05: Авто разбір рахунків ISG (3600) Кред-ої заборг-ті на (SPN,SN) ********** ');
          --  Створюємо функцію КП F05: Авто разбір рахунків ISG (3600) Кред-ої заборг-ті на (SPN,SN)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F05: Авто разбір рахунків ISG (3600) Кред-ої заборг-ті на (SPN,SN)',
                                                  p_funcname => 'F1_Select(13,"CC_ISG(0,''SPN|SN '');Ви хочете зробити Авто разбір рахунків Кред-ої заборг-ті ?; Виконано !" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S7_2: Амортизація Дисконту/Премії ЮО ********** ');
          --  Створюємо функцію КП S7_2: Амортизація Дисконту/Премії ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S7_2: Амортизація Дисконту/Премії ЮО',
                                                  p_funcname => 'F1_Select(13,"CC_RMANY_PET(-1,DAT,3);Ви хочете вик. Амортізацію Дисконту ЮО?; Виконано!" )',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО ********** ');
          --  Створюємо функцію КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F3: Перен-ня на простр. всіх боргів з минулою датою закінч. КД ЮО',
                                                  p_funcname => 'F1_Select(13,"cck.cc_wdate(2,DAT,0);Вы хотите вынести на просрочку все активы клиента ?; Выполнено !" )',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП R01: Звіти по автоматичним функціям КП ЮЛ ********** ');
          --  Створюємо функцію КП R01: Звіти по автоматичним функціям КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП R01: Звіти по автоматичним функціям КП ЮЛ',
                                                  p_funcname => 'FunNSIEditF("TMP_CCK_REP[NSIFUNCTION][PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=Вибір функції,TYPE=N,REF=V_CCK_REP_LIST_YL)][EXEC=>BEFORE][MSG=>Виконано!]", 6)',
                                                  p_rolename => 'RCC_DEAL' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S42: Нарахування %%  по поточним платіж. датам у КП ЮЛ ********** ');
          --  Створюємо функцію КП S42: Нарахування %%  по поточним платіж. датам у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S42: Нарахування %%  по поточним платіж. датам у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''20%'' and s.tip in (''SS '',''SP '') and i.acra is not null and i.acrb is not null and exists (select 1 from cc_lim where acc=s.accc and fdat=gl.bd  and sumo>0 and not_sn is null)",''SA'')',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ЮЛ ********** ');
          --  Створюємо функцію КП F40: Нарахування комісії на 9129 у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП F40: Нарахування комісії на 9129 у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0," and i.ID=0 and s.nbs like ''9129%'' and s.tip in (''CR9'') and i.acra is not null and i.acrb is not null and exists (select 1 from nd_acc n,cc_deal d where n.nd=d.nd and d.vidd in (1,2,3) and n.acc=s.acc)",''A'')',
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію КП S62: Нарахування Пенi  у КП ЮЛ ********** ');
          --  Створюємо функцію КП S62: Нарахування Пенi  у КП ЮЛ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'КП S62: Нарахування Пенi  у КП ЮЛ',
                                                  p_funcname => 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''20%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs2 where a=s.acc and j=i.acra and l=i.acrb)","A")',
                                                  p_rolename => 'RCC_DEAL' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (FFF2) - АРМ автоматизированных операций  КП (ЮО)   ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappFFF2.sql =========*** En
PROMPT ===================================================================================== 
