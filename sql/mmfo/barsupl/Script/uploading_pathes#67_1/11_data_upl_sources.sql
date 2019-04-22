-- ***************************************************************************
set verify off
--set define on

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_SOURCES');
end;
/

-- ======================================================================================
-- Изменение списка используемых в выгрузке таблиц
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- ======================================================================================

delete
  from barsupl.UPL_SOURCES
 where upper(OBJECT_NAME) in ('SMB_DEPOSIT',
                              'SMB_DEPOSIT_LOG',
                              'PROCESS',
                              'REGISTER_LOG',
                              'REGISTER_VALUE',
                              'ATTRIBUTE_HISTORY',
                              'ATTRIBUTE_KIND',
                              'ATTRIBUTE_SMALL_VALUE',
                              'ATTRIBUTE_VALUE_BY_DATE',
                              'ATTRIBUTE_VALUE',
                              'ATTRIBUTE_VALUES',
                              'DEAL_ACCOUNT',
                              'DEAL_PRODUCT',
                              'REGISTER_TYPE',
                              'OBJECT_STATE',
                              'OBJECT_TYPE',
                              'OBJECT',
                              'DEAL');

Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'SMB_DEPOSIT', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'SMB_DEPOSIT_LOG', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'PROCESS', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'REGISTER_LOG', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'REGISTER_VALUE', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'ATTRIBUTE_HISTORY', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'ATTRIBUTE_KIND', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'ATTRIBUTE_SMALL_VALUE', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'ATTRIBUTE_VALUE_BY_DATE', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'ATTRIBUTE_VALUE', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'ATTRIBUTE_VALUES', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'DEAL_ACCOUNT', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'DEAL_PRODUCT', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'REGISTER_TYPE', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OBJECT_STATE', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OBJECT_TYPE', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OBJECT', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'DEAL', 'TABLE', 'Y', 'Y');


