-- ======================================================================================
-- Module : UPL
-- ======================================================================================
--WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

prompt -- ========================================================
prompt -- Перевірка корректності встановлюваної версіїї оновлення 
       -- Перенесено з (02_data_upl_params.sql)
prompt -- ========================================================

--exec bars.bc.go('&&PKF');
--exec bars.tuda;

prompt -- ======================================================
prompt -- Архівація статистики вивантаження даних до DWH
prompt -- ======================================================
declare
  l_uplStats_cnt         INTEGER;
  l_uplStats_moved_cnt   INTEGER;
  l_kf                   bars.mv_kf.kf%type;
begin
  for l_kf in (select kf from bars.mv_kf)
  loop
    bars.bc.go(l_kf.kf);
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
       rollback;
       raise_application_error( -20667,'\ UPL: Кількість записів у таблиці UPL_STATS не відповідає кількості записів, перенесених до архіву!', TRUE );
    end if;
  end loop;
  execute immediate 'TRUNCATE TABLE BARSUPL.UPL_STATS';
  COMMIT;

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

begin
  execute immediate 'alter table BARSUPL.UPL_FILEGROUPS_RLN DISABLE constraint FK_SQLID';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_FILES DISABLE constraint FK_UPLFILES_SQLID';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/
-- alter table UPL_STATS          DISABLE constraint FK_UPLSTATSSQLID;

-- FILES
begin
  execute immediate 'alter table BARSUPL.UPL_COLUMNS DISABLE constraint FK_UPLCOLUMNS_FILEID';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_FILE_COUNTERS DISABLE constraint FK_UPLFILECOUNTS_FILEID';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_FILEGROUPS_RLN DISABLE constraint FK_FILESID';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_CONSTRAINTS DISABLE constraint FK_UPLCONSTRAINTS_FILEID';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_CONSTRAINTS DISABLE constraint FK_UPLCONSTRAINTS_FKFILEID';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/
-- alter table UPL_STATS          DISABLE constraint FK_UPLSTATSFILEID;

-- COLUMNS
begin
  execute immediate 'alter table UPL_CONS_COLUMNS   DISABLE constraint FK_UPLCONSCOLUMNS_FILEIDCOLN';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

-- AUTOJOBS
begin
  execute immediate 'alter table UPL_AUTOJOB_PARAM_VALUES DISABLE constraint FK_UPLAUTOJOBS_JOB';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

-- CONSTRAINTS
begin
  execute immediate 'alter table UPL_CONS_COLUMNS   DISABLE constraint FK_UPLCONSCOLUMNS_FILEID';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

-- FILEGROUPS_RLN
begin
  execute immediate 'alter table UPL_FILEGROUPS_RLN DISABLE constraint FK_GROUPID';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

-- TAG_LISTS
begin
  execute immediate 'alter table UPL_TAG_LISTS DISABLE constraint FK_UPLTAGLISTS_TAGTABLE';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table UPL_TAG_LISTS DISABLE constraint FK_UPLTAGLISTS_UPLTAGREF';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

-- DOMAINCODE
begin
  execute immediate 'alter table BARSUPL.UPL_FILES DISABLE constraint FK_DOMAINCODE';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/

-- SOURCES_TRIGGER
begin
  execute immediate 'alter table BARSUPL.UPL_SOURCES_TRIGGER DISABLE constraint FK_UPL_SOURCES_TRIGGER';
  exception when OTHERS then if sqlcode=-02431 or sqlcode=-00942 then null; else raise; end if;
end;
/


