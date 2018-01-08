-- ======================================================================================
-- Module   : SOC - Вклады пенсионеров и безработных
-- Author   : INNA
-- Modifier : BAA
-- Date     : 26.05.2015
-- ======================================================================================
-- create table DPT_FILE_ROW_UPD
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table DPT_FILE_ROW_UPD
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_ROW_UPD', 'WHOLE',  Null, Null, Null, Null );
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_ROW_UPD', 'FILIAL',  'M',  'M',  'M',  'M' );
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_ROW_UPD', 'CENTER' , Null, 'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table DPT_FILE_ROW_UPD 
( REC_ID     NUMBER(38)    constraint CC_DPTFILEROWUPD_RECID_NN   NOT NULL
, ROW_ID     NUMBER(38)    constraint CC_DPTFILEROWUPD_ROWID_NN   NOT NULL
, BRANCH     VARCHAR2(30)  constraint CC_DPTFILEROWUPD_BRANCH_NN  NOT NULL
, USER_ID    NUMBER(38)    constraint CC_DPTFILEROWUPD_USERID_NN  NOT NULL
, SYSDAT     DATE          constraint CC_DPTFILEROWUPD_SYSDAT_NN  NOT NULL
, BNKDAT     DATE          constraint CC_DPTFILEROWUPD_BNKDAT_NN  NOT NULL
, COLUMNAME  VARCHAR2(30)  constraint CC_DPTFILEROWUPD_COLNAME_NN NOT NULL
, OLD_VALUE  VARCHAR2(100) 
, NEW_VALUE  VARCHAR2(100) 
, constraint PK_DPTFILEROWUPD            primary key ( REC_ID ) using index tablespace BRSMDLI
, constraint CC_DPTFILEROWUPD_VALUES     CHECK ( nvl(old_value,'_') <> nvl(new_value,'_') )
, constraint FK_DPTFILEROWUPD_BRANCH     foreign key ( BRANCH  ) references BRANCH (BRANCH) deferrable initially immediate
, constraint FK_DPTFILEROWUPD_DPTFILEROW foreign key ( ROW_ID  ) references DPT_FILE_ROW (INFO_ID)
, constraint FK_DPTFILEROWUPD_STAFF$BASE foreign key ( USER_ID ) references STAFF$BASE (ID) 
) tablespace BRSMDLD ]';
  
  dbms_output.put_line( 'Table "DPT_FILE_ROW_UPD" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "DPT_FILE_ROW_UPD" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create index IDX_DPTFILEROWUPD_KF_ROWID on DPT_FILE_ROW_UPD ( KF, ROW_ID ) tablespace BRSBIGI]';
  dbms_output.put_line( 'Index "IDX_DPTFILEROWUPD_KF_ROWID" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_DPTFILEROWUPD_KF_ROWID" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column(s) "KF", "HEADER_ID" already indexed.' );
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'DPT_FILE_ROW_UPD' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  DPT_FILE_ROW_UPD           IS 'Изменения данных файлов зачислений от ОСЗ';

comment on column DPT_FILE_ROW_UPD.KF        is 'Код фiлiалу (МФО)';
comment on column DPT_FILE_ROW_UPD.REC_ID    IS 'Идентификатор записи';
comment on column DPT_FILE_ROW_UPD.ROW_ID    IS 'Идентификатор строки файла';
comment on column DPT_FILE_ROW_UPD.BRANCH    IS 'Код подразделения';
comment on column DPT_FILE_ROW_UPD.USER_ID   IS 'Код пользователя';
comment on column DPT_FILE_ROW_UPD.SYSDAT    IS 'Календарная дата изменения';
comment on column DPT_FILE_ROW_UPD.BNKDAT    IS 'Банковская дата изменения';
comment on column DPT_FILE_ROW_UPD.COLUMNAME IS 'Название редактируемого реквизита';
comment on column DPT_FILE_ROW_UPD.OLD_VALUE IS 'Старое значение реквизита';
comment on column DPT_FILE_ROW_UPD.NEW_VALUE IS 'Новое значение реквизита';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on DPT_FILE_ROW_UPD to BARS_ACCESS_DEFROLE;
grant SELECT on DPT_FILE_ROW_UPD to BARS_DM;
grant SELECT on DPT_FILE_ROW_UPD to DPT_ROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
