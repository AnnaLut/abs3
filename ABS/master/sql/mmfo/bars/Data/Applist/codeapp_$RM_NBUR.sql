PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_NBUR.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_NBUR ***
  declare
    l_application_code varchar2(10 char) := '$RM_NBUR';
    l_application_name varchar2(300 char) := 'АРМ Звітність (новий)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_NBUR створюємо (або оновлюємо) АРМ АРМ Звітність (новий) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення дод. реквізитів за всі дні для файлів 70,D3,C9,E2,2C,2D ********** ');
          --  Створюємо функцію Довведення дод. реквізитів за всі дні для файлів 70,D3,C9,E2,2C,2D
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення дод. реквізитів за всі дні для файлів 70,D3,C9,E2,2C,2D',
                                                  p_funcname => '/barsroot/Doc/AdditionalReqv/Index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд документів відділення ********** ');
          --  Створюємо функцію Перегляд документів відділення
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд документів відділення',
                                                  p_funcname => '/barsroot/DocView/Docs/DocumentDateFilter?type=0',
                                                  p_rolename => 'WR_DOCLIST_TOBO' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Перелік усіх документів за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів відділення за період
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів відділення за період',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів відділення за період
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів відділення за період',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік усіх документів за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік усіх документів за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=11',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перегляд картки документу
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перегляд картки документу',
															  p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів відділення за дату
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів відділення за дату',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&date=\d{2}\.\d{2}\.\d{4}',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Перелік отриманих документів відділення за сьогодні
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Перелік отриманих документів відділення за сьогодні',
															  p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=12',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Завантаження XSD схем файлів звітності НБУ ********** ');
          --  Створюємо функцію Завантаження XSD схем файлів звітності НБУ
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Завантаження XSD схем файлів звітності НБУ',
                                                  p_funcname => '/barsroot/DownloadXsdScheme/DownloadXsdScheme/index',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Установка спецпараметрів НБУ для БС ********** ');
          --  Створюємо функцію Установка спецпараметрів НБУ для БС
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Установка спецпараметрів НБУ для БС',
                                                  p_funcname => '/barsroot/admin/assignmentspecparams/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Коригування СК за 35 днів ********** ');
          --  Створюємо функцію Коригування СК за 35 днів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Коригування СК за 35 днів',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=OPER_SK&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів ********** ');
          --  Створюємо функцію Друк звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів',
                                                  p_funcname => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Друк звітів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк звітів',
															  p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Друк звітів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк звітів',
															  p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довведення дод. реквізитів - всі документи відділення(WEB) ********** ');
          --  Створюємо функцію Довведення дод. реквізитів - всі документи відділення(WEB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довведення дод. реквізитів - всі документи відділення(WEB)',
                                                  p_funcname => '/barsroot/docinput/editprops.aspx?mode=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Довведення дод. реквізитів по реф.(WEB)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Довведення дод. реквізитів по реф.(WEB)',
															  p_funcname => '/barsroot/docinput/editprops.aspx?ref=\d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Вивантаження А7 ********** ');
          --  Створюємо функцію Вивантаження А7
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Вивантаження А7',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=[PROC=>BARSUPL.BARS_UPLOAD_USR.DELETE_JOBINFO(p_bankdate => :date_to, p_groupid => 18); BARSUPL.BARS_UPLOAD_USR.create_interface_job(p_group_id => 18, p_enabled =>1,p_sheduled => 0, p_bankdate=> :date_to)][PAR=>:date_to(SEM=За дату,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false][CONDITIONS=>KF=sys_context(''bars_context'',''user_mfo'')]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 503(6А).Звіт про залучення та обслуговування кредиту ********** ');
          --  Створюємо функцію 503(6А).Звіт про залучення та обслуговування кредиту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '503(6А).Звіт про залучення та обслуговування кредиту',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&tableName=CIM_F503&sPar=[PROC=>cim_reports.prepare_f503_change(:date_to)][PAR=>:date_to(SEM=За дату,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][showDialogWindow=>false][CONDITIONS=> KF = sys_context(''bars_context'',''user_mfo'')]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію 504(35).Прогноз операцій з одержання та обслуговування кредиту ********** ');
          --  Створюємо функцію 504(35).Прогноз операцій з одержання та обслуговування кредиту
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '504(35).Прогноз операцій з одержання та обслуговування кредиту',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&tableName=CIM_F504&sPar=[PROC=>cim_reports.prepare_f504_change(:date_to)][PAR=>:date_to(SEM=За дату,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][showDialogWindow=>false][CONDITIONS=> KF = sys_context(''bars_context'',''user_mfo'')]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд проводок ********** ');
          --  Створюємо функцію Перегляд проводок
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд проводок',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=PAR_PROVODKI[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Заповнення позабалансових символів касплану (режим з вилученням) ********** ');
          --  Створюємо функцію Заповнення позабалансових символів касплану (режим з вилученням)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Заповнення позабалансових символів касплану (режим з вилученням)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=OTCN_F13_ZBSK&accessCode=0&sPar=[NSIFUNCTION][PROC=>P_POP_F13ZB(:Param1,:Param2,0)][PAR=>:Param1(SEM=Дата ''з'',TYPE=D),:Param2(SEM=Дата ''по'',TYPE=D)][EXEC=>BEFORE][MSG=>OK!][CONDITIONS=>fdat>=:Param1 and fdat<=:Param2][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Заповнення позабалансових символів касплану (режим донаповнення) ********** ');
          --  Створюємо функцію Заповнення позабалансових символів касплану (режим донаповнення)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Заповнення позабалансових символів касплану (режим донаповнення)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=OTCN_F13_ZBSK&accessCode=0&sPar=[NSIFUNCTION][PROC=>P_POP_F13ZB(:Param1,:Param2,1)][PAR=>:Param1(SEM=Дата ''з'',TYPE=D),:Param2(SEM=Дата ''по'',TYPE=D)][EXEC=>BEFORE][MSG=>OK!][CONDITIONS=>fdat>=:Param1 and fdat<=:Param2][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Заповнення позабалансових символів касплану (перегляд та редагування)  ********** ');
          --  Створюємо функцію Заповнення позабалансових символів касплану (перегляд та редагування) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Заповнення позабалансових символів касплану (перегляд та редагування) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=OTCN_F13_ZBSK&accessCode=0&sPar=[NSIFUNCTION][PROC=>P_POP_F13ZB(:Param1,:Param2,2)][PAR=>:Param1(SEM=Дата ''з'',TYPE=D),:Param2(SEM=Дата ''по'',TYPE=D)][EXEC=>BEFORE][MSG=>OK!][CONDITIONS=>fdat>=:Param1 and fdat<=:Param2][EDIT_MODE=>MULTI_EDIT]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Налаштування періодів формування файлів звітності ********** ');
          --  Створюємо функцію Налаштування періодів формування файлів звітності
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Налаштування періодів формування файлів звітності',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_FILE_SCHEDULE&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд списку сформованих файлів ********** ');
          --  Створюємо функцію Перегляд списку сформованих файлів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд списку сформованих файлів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_FORM_FINISHED_USER&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд списку файлів, що не сформувались через помилку ********** ');
          --  Створюємо функцію Перегляд списку файлів, що не сформувались через помилку
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд списку файлів, що не сформувались через помилку',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_LIST_FORM_ERROR&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Перегляд черги формування файлів ********** ');
          --  Створюємо функцію Перегляд черги формування файлів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Перегляд черги формування файлів',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_QUEUE_FORM_ALL&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Календар формування файлів звітності ********** ');
          --  Створюємо функцію Календар формування файлів звітності
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Календар формування файлів звітності',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_NBUR_REF_CALENDAR&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Звітність (до НБУ та внутрішня) ********** ');
          --  Створюємо функцію Звітність (до НБУ та внутрішня)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Звітність (до НБУ та внутрішня)',
                                                  p_funcname => '/barsroot/reporting/nbu/index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка запитів ********** ');
          --  Створюємо функцію Обробка запитів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка запитів',
                                                  p_funcname => '/barsroot/requestsProcessing/requestsProcessing',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_NBUR) - АРМ Звітність (новий)  ');
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
umu.add_report2arm(88,'$RM_NBUR');
umu.add_report2arm(95,'$RM_NBUR');
umu.add_report2arm(128,'$RM_NBUR');
umu.add_report2arm(155,'$RM_NBUR');
umu.add_report2arm(156,'$RM_NBUR');
umu.add_report2arm(167,'$RM_NBUR');
umu.add_report2arm(172,'$RM_NBUR');
umu.add_report2arm(173,'$RM_NBUR');
umu.add_report2arm(179,'$RM_NBUR');
umu.add_report2arm(180,'$RM_NBUR');
umu.add_report2arm(182,'$RM_NBUR');
umu.add_report2arm(188,'$RM_NBUR');
umu.add_report2arm(189,'$RM_NBUR');
umu.add_report2arm(190,'$RM_NBUR');
umu.add_report2arm(191,'$RM_NBUR');
umu.add_report2arm(192,'$RM_NBUR');
umu.add_report2arm(193,'$RM_NBUR');
umu.add_report2arm(194,'$RM_NBUR');
umu.add_report2arm(196,'$RM_NBUR');
umu.add_report2arm(197,'$RM_NBUR');
umu.add_report2arm(217,'$RM_NBUR');
umu.add_report2arm(218,'$RM_NBUR');
umu.add_report2arm(220,'$RM_NBUR');
umu.add_report2arm(221,'$RM_NBUR');
umu.add_report2arm(589,'$RM_NBUR');
umu.add_report2arm(593,'$RM_NBUR');
umu.add_report2arm(594,'$RM_NBUR');
umu.add_report2arm(595,'$RM_NBUR');
umu.add_report2arm(596,'$RM_NBUR');
umu.add_report2arm(597,'$RM_NBUR');
umu.add_report2arm(598,'$RM_NBUR');
umu.add_report2arm(599,'$RM_NBUR');
umu.add_report2arm(600,'$RM_NBUR');
umu.add_report2arm(601,'$RM_NBUR');
umu.add_report2arm(602,'$RM_NBUR');
umu.add_report2arm(1008,'$RM_NBUR');
umu.add_report2arm(5502,'$RM_NBUR');
umu.add_report2arm(100233,'$RM_NBUR');
umu.add_report2arm(100676,'$RM_NBUR');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_NBUR.sql =========**
PROMPT ===================================================================================== 
