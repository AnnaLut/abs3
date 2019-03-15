-- ***************************************************************************
set verify off
--set define on

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_SOURCES');
end;
/

-- ======================================================================================
-- Изменение списка используемых в выгрузке таблиц
-- TSK-0001285  UPL - отключить выгрузку из АБС файлов субдоговоров кредитных линий и файлов предварительного расчета FNV
-- ======================================================================================

delete
  from barsupl.UPL_SOURCES 
 where upper(OBJECT_NAME) in ('PRVN_FLOW_DEALS_VAR',
                              'PRVN_FLOW_DEALS_CONST',
                              'TMP_REZ_OBESP23',
                              'TMP_REZ_ZALOG23',
                              'FIN_FM_UPDATE',
                              'FIN_FM',
                              'FIN_FORMA1',
                              'FIN_FORMA1M',
                              'FIN_FORMA2',
                              'FIN_FORMA2M',
                              'FIN_ND_UPDATE',
                              'FM_YESNO');

--Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OW_INST_TOTALS_HIST', 'TABLE', 'Y', 'Y');
