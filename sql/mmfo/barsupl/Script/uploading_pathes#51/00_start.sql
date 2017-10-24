-- ======================================================================================
-- Module : UPL
-- ======================================================================================

prompt -- ========================================================
prompt -- Перевірка корректності встановлюваної версіїї оновлення 
       -- Перенесено з (02_data_upl_params.sql)
prompt -- ========================================================

exec bars.bc.go('&&PKF');
--exec bars.tuda;

declare
  l_vers      varchar2(100) := '51.0 20/04/2017';
  l_job_name  varchar(130);
begin
  dbms_output.put_line( 'REGION_CODE=' || BARSUPL.BARS_UPLOAD.get_param('REGION_PRFX') );

  l_job_name := BARSUPL.BARS_UPLOAD_UTL.GET_RUNNING_JOB_NAME();

  if ( l_job_name Is Not Null )
  then
    raise_application_error( -20666,'\ UPL: Заборонена інсталяція оновлень за наявності активних завдань вивантаження (' || l_job_name || ')!', TRUE );
  end if;
  
  begin
    Insert into BARSUPL.UPL_PARAMS
      (PARAM, VALUE, DESCRIPT, GROUP_ID)
    Values
      ('RELEASE',  l_vers, 'Текущий номер релиза', 4);
    COMMIT;
  exception
    when DUP_VAL_ON_INDEX then
      update BARSUPL.UPL_PARAMS
         set VALUE = l_vers 
       where PARAM = 'RELEASE';
    when OTHERS then
      ROLLBACK;
      RAISE;
  end;

exception
  when OTHERS then
    ROLLBACK;
    RAISE;
end;
/

prompt -- ======================================================
prompt -- Архівація статистики вивантаження даних до DWH
prompt -- ======================================================
declare
  l_uplStats_cnt         INTEGER;
  l_uplStats_moved_cnt   INTEGER;
begin
  select count(*) into l_uplStats_cnt from BARSUPL.UPL_STATS;

  insert
    into BARSUPL.UPL_STATS_ARCHIVE
       ( ID, UPL_BANKDATE, GROUP_ID, FILE_ID, FILE_CODE, SQL_ID, START_TIME, STOP_TIME, 
         STATUS_ID, PARAMS, UPL_ERRORS, ROWS_UPLOADED,
         START_ARC_TIME, STOP_ARC_TIME, ARC_LOGMESS, 
         START_FTP_TIME, STOP_FTP_TIME, FTP_LOGMESS, PARENT_ID, FILE_NAME, JOB_ID, REC_TYPE )
  select
         ID, UPL_BANKDATE, GROUP_ID, FILE_ID, FILE_CODE, SQL_ID, START_TIME, STOP_TIME, 
         STATUS_ID, PARAMS, UPL_ERRORS, ROWS_UPLOADED,
         START_ARC_TIME, STOP_ARC_TIME, ARC_LOGMESS, 
         START_FTP_TIME, STOP_FTP_TIME, FTP_LOGMESS, PARENT_ID, FILE_NAME, JOB_ID, REC_TYPE
    from BARSUPL.UPL_STATS;

  l_uplStats_moved_cnt := SQL%ROWCOUNT;

  DBMS_OUTPUT.PUT_LINE('UPL_STATS record = ' || l_uplStats_cnt );
  DBMS_OUTPUT.PUT_LINE('moved into ARCHIVE = ' || l_uplStats_moved_cnt || ' record' );

  if l_uplStats_cnt != l_uplStats_moved_cnt then
     raise_application_error( -20667,'\ UPL: Кількість записів у таблиці UPL_STATS не відповідає кількості записів, перенесених до архіву!', TRUE );
  end if;

  COMMIT;

  execute immediate 'TRUNCATE TABLE BARSUPL.UPL_STATS';

  exception
    when OTHERS then
    ROLLBACK;
    RAISE;
end;
/


prompt -- ======================================================
prompt -- DISABLE ALL CONSTRAINTS ON TABLE
prompt -- ======================================================

-- SQL
alter table UPL_FILEGROUPS_RLN DISABLE constraint FK_SQLID;
alter table UPL_FILES          DISABLE constraint FK_UPLFILES_SQLID;
-- alter table UPL_STATS          DISABLE constraint FK_UPLSTATSSQLID;

-- FILES
alter table UPL_COLUMNS        DISABLE constraint FK_UPLCOLUMNS_FILEID;
alter table UPL_FILE_COUNTERS  DISABLE constraint FK_UPLFILECOUNTS_FILEID;
alter table UPL_FILEGROUPS_RLN DISABLE constraint FK_FILESID; 
alter table UPL_CONSTRAINTS    DISABLE constraint FK_UPLCONSTRAINTS_FILEID;
alter table UPL_CONSTRAINTS    DISABLE constraint FK_UPLCONSTRAINTS_FKFILEID;

-- alter table UPL_STATS          DISABLE constraint FK_UPLSTATSFILEID;

-- COLUMNS
alter table UPL_CONS_COLUMNS   DISABLE constraint FK_UPLCONSCOLUMNS_FILEIDCOLN;

-- AUTOJOBS
alter table UPL_AUTOJOB_PARAM_VALUES DISABLE constraint FK_UPLAUTOJOBS_JOB;

-- CONSTRAINTS
alter table UPL_CONS_COLUMNS   DISABLE constraint FK_UPLCONSCOLUMNS_FILEID;

-- FILEGROUPS_RLN
alter table UPL_FILEGROUPS_RLN DISABLE constraint FK_GROUPID;

-- TAG_LISTS
alter table UPL_TAG_LISTS DISABLE constraint FK_UPLTAGLISTS_TAGTABLE;

-- DOMAINCODE
alter table UPL_FILES DISABLE constraint FK_DOMAINCODE;
