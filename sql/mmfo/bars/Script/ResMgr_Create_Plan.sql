BEGIN
   DBMS_RESOURCE_MANAGER.CLEAR_PENDING_AREA();
   DBMS_RESOURCE_MANAGER.CREATE_PENDING_AREA();

   begin
      DBMS_RESOURCE_MANAGER.delete_plan_cascade(PLAN => 'BARS_PLAN');
   exception   
      when others then 
		  if sqlcode = -29358 then null; end if;
   end;

   DBMS_RESOURCE_MANAGER.CREATE_PLAN(
                                      PLAN => 'BARS_PLAN', 
                                      COMMENT => 'Основний план АБС ММФО'
                                    );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN(
                                      PLAN => 'OLTP', 
                                      COMMENT => 'План для Web та оперативних Job'
                                    );
                                    
   DBMS_RESOURCE_MANAGER.CREATE_PLAN(
                                      PLAN => 'ETL', 
                                      COMMENT => 'План для задач вивантаження даних'
                                    );
   DBMS_RESOURCE_MANAGER.CREATE_CONSUMER_GROUP(
                                                 CONSUMER_GROUP => 'OLTP_WEB', 
                                                 COMMENT => 'Группа користувачів WEB'
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_CONSUMER_GROUP(
                                                 CONSUMER_GROUP => 'OLTP_JOB', 
                                                 COMMENT => 'Группа оперативних завдань'
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_CONSUMER_GROUP(
                                                 CONSUMER_GROUP => 'ETL_DWH', 
                                                 COMMENT => 'Группа завдань вивантаження даних в DWH'
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_CONSUMER_GROUP(
                                                 CONSUMER_GROUP => 'ETL_OTHERS', 
                                                 COMMENT => 'Група фонових завдань'
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'BARS_PLAN', 
                                                 GROUP_OR_SUBPLAN => 'OLTP', 
                                                 COMMENT=> 'Ресурси плану OLTP на рівні 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 70
                                              );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'OLTP', 
                                                 GROUP_OR_SUBPLAN => 'OLTP_WEB', 
                                                 COMMENT=> 'Ресурси групи OLTP_WEB на рівні 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 75
                                              );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'OLTP', 
                                                 GROUP_OR_SUBPLAN => 'OLTP_JOB', 
                                                 COMMENT=> 'Ресурси групи OLTP_JOB на рівні 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 25
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'BARS_PLAN', 
                                                 GROUP_OR_SUBPLAN => 'ETL', 
                                                 COMMENT=> 'Ресурси плану ETL на рівні 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 30
                                              );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'ETL', 
                                                 GROUP_OR_SUBPLAN => 'ETL_DWH', 
                                                 COMMENT=> 'Ресурси групи ETL_DWH на рівні 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 20
                                              );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'ETL', 
                                                 GROUP_OR_SUBPLAN => 'ETL_OTHERS', 
                                                 COMMENT=> 'Ресурси групи ETL_OTHERS на рівні 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 80
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'BARS_PLAN',
                                                 GROUP_OR_SUBPLAN => 'SYS_GROUP', 
                                                 COMMENT => 'all system session at level 1', 
                                                 MGMT_P1 => 75
                                              );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'BARS_PLAN',
                                                 GROUP_OR_SUBPLAN => 'OTHER_GROUPS', 
                                                 COMMENT => 'all other users sessions at level 3', 
                                                 MGMT_P1 => 0, 
                                                 MGMT_P2 => 0,
                                                 MGMT_P3 => 100
                                              );

   DBMS_RESOURCE_MANAGER.VALIDATE_PENDING_AREA();
   DBMS_RESOURCE_MANAGER.SUBMIT_PENDING_AREA();

   DBMS_RESOURCE_MANAGER_PRIVS.GRANT_SWITCH_CONSUMER_GROUP (
                                                              GRANTEE_NAME   => 'public',
                                                              CONSUMER_GROUP => 'OLTP_WEB',
                                                              GRANT_OPTION   =>  FALSE
                                                           );
                                              
   DBMS_RESOURCE_MANAGER_PRIVS.GRANT_SWITCH_CONSUMER_GROUP (
                                                              GRANTEE_NAME   => 'public',
                                                              CONSUMER_GROUP => 'OLTP_JOB',
                                                              GRANT_OPTION   =>  FALSE
                                                           );
                                              
   DBMS_RESOURCE_MANAGER_PRIVS.GRANT_SWITCH_CONSUMER_GROUP (
                                                              GRANTEE_NAME   => 'public',
                                                              CONSUMER_GROUP => 'ETL_DWH',
                                                              GRANT_OPTION   =>  FALSE
                                                           );
                                              
   DBMS_RESOURCE_MANAGER_PRIVS.GRANT_SWITCH_CONSUMER_GROUP (
                                                              GRANTEE_NAME   => 'public',
                                                              CONSUMER_GROUP => 'ETL_OTHERS',
                                                              GRANT_OPTION   =>  FALSE
                                                           );

END;
/