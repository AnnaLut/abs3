-- ======================================================================================
-- Module : UPL
-- ======================================================================================
--WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

prompt -- ========================================================
prompt -- �������� ����������� ������������� ���񳿿 ��������� 
       -- ���������� � (02_data_upl_params.sql)
prompt -- ========================================================

--exec bars.bc.go('&&PKF');
--exec bars.tuda;

declare
  l_vers           varchar2(100) := '65.0 11/09/2018';
  l_prev_vers      varchar2(100) := '64.0;64.1;64.2'; -- ������ ������ (����� ';'), �� ������� ����� ������� ��� ����������
  l_curr_vers      varchar2(100);
  l_prev_rel_num   varchar2(4);
  l_job_name       varchar(130);
begin
  dbms_output.put_line( 'INSTALL VERSION ' || l_vers );
  for l_kf in (select kf from bars.mv_kf)
  loop
      bars.bc.go(l_kf.kf);
      barsupl.bars_upload.init_params(p_force => 1);

      dbms_output.put_line( 'REGION_CODE=' || BARSUPL.BARS_UPLOAD.get_param('REGION_PRFX') );

      l_job_name := BARSUPL.BARS_UPLOAD_UTL.GET_RUNNING_JOB_NAME();

      if ( l_job_name Is Not Null )
      then
        raise_application_error( -20998,'\ UPL: ���������� ���������� �������� �� �������� �������� ������� ������������ (' || l_job_name || ')!', TRUE );
      end if;

      --�������� ����������� ������ ������
      select value
       into l_curr_vers
       from BARSUPL.UPL_PARAMS
      where upper(param) = 'RELEASE';
      l_prev_rel_num := SubStr(l_curr_vers,1,4);

      if ( instr(l_prev_vers, l_prev_rel_num, 1, 1) <= 0 and l_prev_rel_num != SubStr(l_vers,1,4) )
      then
        raise_application_error( -20998,'\ UPL: ���������� ���������� �������� ' || SubStr(l_vers,1,4) || ' �� ����� ' || l_prev_rel_num || '. �� ���� ����� ' || l_prev_vers, TRUE );
      end if;

      begin
        Insert into BARSUPL.UPL_PARAMS
          (PARAM, VALUE, DESCRIPT, GROUP_ID)
        Values
          ('RELEASE',  l_vers, '������� ����� ������', 4);

      exception
        when DUP_VAL_ON_INDEX then
          update BARSUPL.UPL_PARAMS
             set VALUE = l_vers 
           where PARAM = 'RELEASE';

        when OTHERS then
          ROLLBACK;
          RAISE;
      end;
  end loop;
exception
  when OTHERS then
    ROLLBACK;
    RAISE;
end;
/

prompt -- ======================================================
prompt -- ��������� ���������� ������������ ����� �� DWH
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
       raise_application_error( -20667,'\ UPL: ʳ������ ������ � ������� UPL_STATS �� ������� ������� ������, ����������� �� ������!', TRUE );
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
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_FILES DISABLE constraint FK_UPLFILES_SQLID';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/
-- alter table UPL_STATS          DISABLE constraint FK_UPLSTATSSQLID;

-- FILES
begin
  execute immediate 'alter table BARSUPL.UPL_COLUMNS DISABLE constraint FK_UPLCOLUMNS_FILEID';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_FILE_COUNTERS DISABLE constraint FK_UPLFILECOUNTS_FILEID';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_FILEGROUPS_RLN DISABLE constraint FK_FILESID';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_CONSTRAINTS DISABLE constraint FK_UPLCONSTRAINTS_FILEID';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table BARSUPL.UPL_CONSTRAINTS DISABLE constraint FK_UPLCONSTRAINTS_FKFILEID';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/
-- alter table UPL_STATS          DISABLE constraint FK_UPLSTATSFILEID;

-- COLUMNS
begin
  execute immediate 'alter table UPL_CONS_COLUMNS   DISABLE constraint FK_UPLCONSCOLUMNS_FILEIDCOLN';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

-- AUTOJOBS
begin
  execute immediate 'alter table UPL_AUTOJOB_PARAM_VALUES DISABLE constraint FK_UPLAUTOJOBS_JOB';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

-- CONSTRAINTS
begin
  execute immediate 'alter table UPL_CONS_COLUMNS   DISABLE constraint FK_UPLCONSCOLUMNS_FILEID';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

-- FILEGROUPS_RLN
begin
  execute immediate 'alter table UPL_FILEGROUPS_RLN DISABLE constraint FK_GROUPID';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

-- TAG_LISTS
begin
  execute immediate 'alter table UPL_TAG_LISTS DISABLE constraint FK_UPLTAGLISTS_TAGTABLE';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

begin
  execute immediate 'alter table UPL_TAG_LISTS DISABLE constraint FK_UPLTAGLISTS_UPLTAGREF';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

-- DOMAINCODE
begin
  execute immediate 'alter table BARSUPL.UPL_FILES DISABLE constraint FK_DOMAINCODE';
  exception when OTHERS then if  sqlcode=-02431 then null; else raise; end if;
end;
/

