-- ***************************************************************************
set verify off
--set define on

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_SOURCES');
end;
/

-- ======================================================================================
-- Изменение списка используемых в выгрузке таблиц
-- ======================================================================================

delete
  from barsupl.UPL_SOURCES 
 where upper(OBJECT_NAME) in ('VIP_FLAGS_UPDATE',
                              'VIP_FLAGS_ARC',
                              'VIP_FLAGS',
                              'CP_ACCOUNTS',
                              'CP_ACCOUNTS_UPDATE',
                              'OW_OIC_ATRANSFERS_HIST',
                              'BR_TYPES');

Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'VIP_FLAGS', 'TABLE', 'N', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'VIP_FLAGS_ARC', 'TABLE', 'Y', 'Y');

Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CP_ACCOUNTS', 'TABLE', 'N', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CP_ACCOUNTS_UPDATE', 'TABLE', 'Y', 'Y');

Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OW_OIC_ATRANSFERS_HIST', 'TABLE', 'Y', 'Y');
Insert into UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'BR_TYPES', 'TABLE', 'Y', 'Y');

