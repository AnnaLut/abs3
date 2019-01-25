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
                                      COMMENT => '�������� ���� ��� ����'
                                    );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN(
                                      PLAN => 'OLTP', 
                                      COMMENT => '���� ��� Web �� ����������� Job'
                                    );
                                    
   DBMS_RESOURCE_MANAGER.CREATE_PLAN(
                                      PLAN => 'ETL', 
                                      COMMENT => '���� ��� ����� ������������ �����'
                                    );
   DBMS_RESOURCE_MANAGER.CREATE_CONSUMER_GROUP(
                                                 CONSUMER_GROUP => 'OLTP_WEB', 
                                                 COMMENT => '������ ������������ WEB'
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_CONSUMER_GROUP(
                                                 CONSUMER_GROUP => 'OLTP_JOB', 
                                                 COMMENT => '������ ����������� �������'
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_CONSUMER_GROUP(
                                                 CONSUMER_GROUP => 'ETL_DWH', 
                                                 COMMENT => '������ ������� ������������ ����� � DWH'
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_CONSUMER_GROUP(
                                                 CONSUMER_GROUP => 'ETL_OTHERS', 
                                                 COMMENT => '����� ������� �������'
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'BARS_PLAN', 
                                                 GROUP_OR_SUBPLAN => 'OLTP', 
                                                 COMMENT=> '������� ����� OLTP �� ��� 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 70
                                              );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'OLTP', 
                                                 GROUP_OR_SUBPLAN => 'OLTP_WEB', 
                                                 COMMENT=> '������� ����� OLTP_WEB �� ��� 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 75
                                              );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'OLTP', 
                                                 GROUP_OR_SUBPLAN => 'OLTP_JOB', 
                                                 COMMENT=> '������� ����� OLTP_JOB �� ��� 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 25
                                              );

   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'BARS_PLAN', 
                                                 GROUP_OR_SUBPLAN => 'ETL', 
                                                 COMMENT=> '������� ����� ETL �� ��� 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 30
                                              );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'ETL', 
                                                 GROUP_OR_SUBPLAN => 'ETL_DWH', 
                                                 COMMENT=> '������� ����� ETL_DWH �� ��� 2', 
                                                 MGMT_P1 => 0,
                                                 MGMT_P2 => 20
                                              );
   DBMS_RESOURCE_MANAGER.CREATE_PLAN_DIRECTIVE(
                                                 PLAN => 'ETL', 
                                                 GROUP_OR_SUBPLAN => 'ETL_OTHERS', 
                                                 COMMENT=> '������� ����� ETL_OTHERS �� ��� 2', 
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