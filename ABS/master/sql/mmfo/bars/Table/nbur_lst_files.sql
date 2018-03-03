-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 17.05.2017
-- ======================================================================================
-- create table NBUR_LST_FILES
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_LST_FILES
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LST_FILES', 'WHOLE' , NULL, NULL, NULL, 'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LST_FILES', 'FILIAL',  'M',  'M',  'M', 'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LST_FILES', 'CENTER', NULL,  'E',  'E', 'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_LST_FILES
( REPORT_DATE     DATE         CONSTRAINT CC_NBURLSTFILES_REPORTDT_NN   NOT NULL
, KF              CHAR(6)      CONSTRAINT CC_NBURLSTFILES_KF_NN         NOT NULL
, VERSION_ID      NUMBER(3)    CONSTRAINT CC_NBURLSTFILES_VERSIONID_NN  NOT NULL
, FILE_ID         NUMBER(5)    CONSTRAINT CC_NBURLSTFILES_FILEID_NN     NOT NULL
, FILE_NAME       CHAR(12)     CONSTRAINT CC_NBURLSTFILES_FILENAME_NN   NOT NULL
, FILE_BODY       CLOB
, FILE_HASH       RAW(20)      CONSTRAINT CC_NBURLSTFILES_FILEHASH_NN   NOT NULL DEFERRABLE
, FILE_STATUS     VARCHAR2(20) CONSTRAINT CC_NBURLSTFILES_FILESTATUS_NN NOT NULL
, START_TIME      TIMESTAMP    CONSTRAINT CC_NBURLSTFILES_STARTTM_NN    NOT NULL
, FINISH_TIME     TIMESTAMP
, USER_ID         NUMBER(12)   CONSTRAINT CC_NBURLSTFILES_USERID_NN     NOT NULL
, CHK_LOG         CLOB
, CONSTRAINT UK_NBURLSTFILES UNIQUE ( REPORT_DATE, KF, VERSION_ID, FILE_ID ) USING INDEX TABLESPACE BRSMDLI
, CONSTRAINT CC_NBURLSTFILES_FINISHTM CHECK ( FINISH_TIME > START_TIME )
, CONSTRAINT FK_NBURLSTFILES_LSTFILES FOREIGN KEY ( REPORT_DATE, KF, VERSION_ID ) REFERENCES NBUR_LST_VERSIONS ( REPORT_DATE, KF, VERSION_ID )
, CONSTRAINT FK_NBURLSTFILES_REFFILES FOREIGN KEY ( FILE_ID ) REFERENCES NBUR_REF_FILES ( ID )
, CONSTRAINT FK_NBURLSTFILES_REFSTATUS FOREIGN KEY ( FILE_STATUS ) REFERENCES NBUR_REF_STATUS (STATUS_TYPE)
) TABLESPACE BRSMDLD
LOB ( FILE_BODY, CHK_LOG ) STORE AS SECUREFILE ( TABLESPACE BRSLOBD
                                                DISABLE STORAGE IN ROW
                                                COMPRESS HIGH
                                                NOCACHE
                                                NOLOGGING )
PARTITION BY LIST ( KF )
( PARTITION P_300465 VALUES ('300465')
, PARTITION P_302076 VALUES ('302076')
, PARTITION P_303398 VALUES ('303398')
, PARTITION P_304665 VALUES ('304665')
, PARTITION P_305482 VALUES ('305482')
, PARTITION P_311647 VALUES ('311647')
, PARTITION P_312356 VALUES ('312356')
, PARTITION P_313957 VALUES ('313957')
, PARTITION P_315784 VALUES ('315784')
, PARTITION P_322669 VALUES ('322669')
, PARTITION P_323475 VALUES ('323475')
, PARTITION P_324805 VALUES ('324805')
, PARTITION P_325796 VALUES ('325796')
, PARTITION P_326461 VALUES ('326461')
, PARTITION P_328845 VALUES ('328845')
, PARTITION P_331467 VALUES ('331467')
, PARTITION P_333368 VALUES ('333368')
, PARTITION P_335106 VALUES ('335106')
, PARTITION P_336503 VALUES ('336503')
, PARTITION P_337568 VALUES ('337568')
, PARTITION P_338545 VALUES ('338545')
, PARTITION P_351823 VALUES ('351823')
, PARTITION P_352457 VALUES ('352457')
, PARTITION P_353553 VALUES ('353553')
, PARTITION P_354507 VALUES ('354507')
, PARTITION P_356334 VALUES ('356334') ) ]';

  dbms_output.put_line('table "NBUR_LST_FILES" created.');

exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "NBUR_LST_FILES" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  l_stmt   varchar2(2048);
begin
  l_stmt := q'[CLOB LOB ( CHK_LOG ) STORE AS SECUREFILE ( TABLESPACE BRSLOBD DISABLE STORAGE IN ROW COMPRESS HIGH NOCACHE NOLOGGING )]';
  NBUR_UTIL.SET_COL('NBUR_LST_FILES','CHK_LOG', l_stmt );
end;
/

begin
  execute immediate q'[alter table BARS.NBUR_LST_FILES add constraint FK_NBURLSTFILES_STAFF foreign key ( USER_ID ) references STAFF$BASE ( ID )]';
  dbms_output.put_line( 'Table altered.' );
exception
  when OTHERS then
    if ( sqlcode = -02275 )
    then dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
    else raise;
    end if;  
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate q'[create unique index UK_NBURLSTFILES_FILESTATUS on BARS.NBUR_LST_FILES ( REPORT_DATE, KF, FILE_ID, decode( FILE_STATUS, 'FINISHED', 0, 'BLOCKED', 0, VERSION_ID ) )
  TABLESPACE BRSMDLI
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LST_FILES' );
end;
/

commit;

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

comment on  table BARS.NBUR_LST_FILES              is 'Список сформованих звітних файлiв';

comment on column BARS.NBUR_LST_FILES.REPORT_DATE  is 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.KF           IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.VERSION_ID   IS 'Ід. версії (для кожного фiлiалу своя)';
comment on column BARS.NBUR_LST_FILES.FILE_ID      is 'Iдентифiкатор файлу';
comment on column BARS.NBUR_LST_FILES.FILE_NAME    is 'Ім`я сформованого файлу';
comment on column BARS.NBUR_LST_FILES.FILE_STATUS  is 'Статус файлу';
comment on column BARS.NBUR_LST_FILES.START_TIME   is 'Дата початку формування';
comment on column BARS.NBUR_LST_FILES.FINISH_TIME  is 'Дата закiнчення формування';
comment on column BARS.NBUR_LST_FILES.USER_ID      is 'Iдентифiкатор користувача';
comment on column BARS.NBUR_LST_FILES.CHK_LOG      is 'Протокол перевірки файлу';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_LST_FILES TO BARSUPL;
GRANT SELECT ON BARS.NBUR_LST_FILES TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
