-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 13.03.2018
-- ======================================================================================
-- create table NBUR_TMP_E9_CLOB
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
prompt -- create table NBUR_TMP_E9_CLOB
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_CLOB', 'WHOLE' , NULL, NULL, NULL, 'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_CLOB', 'FILIAL',  'M',  'M',  'M', 'M' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_CLOB', 'CENTER', NULL,  'E',  'E', 'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_TMP_E9_CLOB
( REPORT_DATE     DATE         CONSTRAINT CC_NBURTMPE9CLOB_REPORTDT_NN   NOT NULL
, KF              CHAR(6)      CONSTRAINT CC_NBURTMPE9CLOB_KF_NN         NOT NULL
, XML_FILE        CLOB
, CONSTRAINT UK_NBURTMPE9CLOB UNIQUE ( REPORT_DATE, KF ) USING INDEX TABLESPACE BRSMDLI
) TABLESPACE BRSMDLD
LOB (XML_FILE ) STORE AS SECUREFILE ( TABLESPACE BRSLOBD
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

dbms_output.put_line('table "NBUR_TMP_E9_CLOB" created.');

exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "NBUR_TMP_E9_CLOB" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  l_stmt   varchar2(2048);
begin
  l_stmt := q'[CLOB LOB ( XML_FILE ) STORE AS SECUREFILE ( TABLESPACE BRSLOBD DISABLE STORAGE IN ROW COMPRESS HIGH NOCACHE NOLOGGING )]';
  NBUR_UTIL.SET_COL('NBUR_TMP_E9_CLOB','XML_FILE', l_stmt );
exception 
	when others then
		if sqlcode in (-22859, -01430) then null;
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
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate q'[create unique index UK_NBURTMPE9CLOB_FILESTATUS on NBUR_TMP_E9_CLOB ( REPORT_DATE, KF )
  TABLESPACE BRSMDLI ]';
  dbms_output.put_line( 'Index created.' );
exception
  when E_IDX_EXISTS
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when E_COL_ALREADY_IDX
  then dbms_output.put_line( 'Such column list already indexed.' );
  when E_DUP_KEYS_FOUND
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_TMP_E9_CLOB' );
end;
/

commit;

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

comment on  table BARS.NBUR_TMP_E9_CLOB              is 'Отримані XML файли по ШК для Е9 файлу';

comment on column BARS.NBUR_TMP_E9_CLOB.REPORT_DATE  is 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_CLOB.KF           IS 'Код фiлiалу (МФО)';
comment on column BARS.NBUR_TMP_E9_CLOB.XML_FILE     is 'XML файл';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_TMP_E9_CLOB TO BARSUPL;
GRANT SELECT ON BARS.NBUR_TMP_E9_CLOB TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================


--drop table NBUR_TMP_E9_CLOB cascade constraints