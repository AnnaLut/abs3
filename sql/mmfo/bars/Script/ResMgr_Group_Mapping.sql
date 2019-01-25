BEGIN
   DBMS_RESOURCE_MANAGER.CLEAR_PENDING_AREA();
   DBMS_RESOURCE_MANAGER.CREATE_PENDING_AREA();

   -- Mapping session to group OLTP_WEB
   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME, 
                                                      'w3wp.exe', 
                                                      'OLTP_WEB'
                                                   ); -- ������ ���
   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME, 
                                                      '%TOSS%', 
                                                      'OLTP_WEB'
                                                   ); -- ������ ��������
   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME, 
                                                      'CSV', 
                                                      'OLTP_WEB'
                                                   ); -- ����� CSV. ����� ������ �������� ������ �� �������

   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME, 
                                                      'O%.EXE', 
                                                      'OLTP_WEB'
                                                   );

   -- Mapping session to group OLTP_JOB
   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME, 
                                                      'DBMS_SCHEDULER', 
                                                      'OLTP_JOB'
                                                   ); -- ������ JOB-��
   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME, 
                                                      'PRC_DOG_GENERAL%', 
                                                      'OLTP_JOB'
                                                   ); -- ������ �������������� � ����� (��������� ����)

   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME, 
                                                      'DPT', 
                                                      'OLTP_JOB'
                                                   ); -- �������� ������������ �������

   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME, 
                                                      'DPU', 
                                                      'OLTP_JOB'
                                                   ); -- ������ � ���������� ����������� ���
   -- Mapping session to group ETL_DWH
   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME_ACTION, 
                                                      'DBMS_SCHEDULER.%UPLOAD%', 
                                                      'ETL_DWH'
                                                   ); -- �������� BARSUPL

   -- Mapping session to group ETL_OTHERS
   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME_ACTION, 
                                                      'DBMS_SCHEDULER.%NBUR%', 
                                                      'ETL_OTHERS'
                                                   ); -- ���� ������� ������������ ���������� ���

   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME_ACTION, 
                                                      'DBMS_SCHEDULER.SAVE_VERSION', 
                                                      'ETL_OTHERS'
                                                   ); -- ���� ������� ������������ ���������� ���

   DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(
                                                      DBMS_RESOURCE_MANAGER.MODULE_NAME_ACTION, 
                                                      'REPORT.EXECUTE', 
                                                      'ETL_OTHERS'
                                                   ); -- ������������ ������� ����� RS.EXEC_REPORT_QUERY

   DBMS_RESOURCE_MANAGER.VALIDATE_PENDING_AREA();
   DBMS_RESOURCE_MANAGER.SUBMIT_PENDING_AREA();
END;
/