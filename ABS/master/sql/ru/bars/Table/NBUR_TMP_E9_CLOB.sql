-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 13.03.2018
-- ======================================================================================
-- create table NBUR_TMP_E9_CLOB
-- ======================================================================================


prompt -- ======================================================
prompt -- create table NBUR_TMP_E9_CLOB
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_CLOB', 'WHOLE' , NULL, NULL, NULL, 'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_CLOB', 'FILIAL',  'M',  'M',  'M', 'M' );
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
                                      NOLOGGING ) ]';

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
  e_col_exsts            exception;
  pragma exception_init( e_col_exsts, -01430 );
begin
  execute immediate 'alter table BARS.NBUR_TMP_E9_CLOB add XML_FILE CLOB LOB ( XML_FILE ) STORE AS SECUREFILE ( TABLESPACE BRSLOBD DISABLE STORAGE IN ROW COMPRESS HIGH NOCACHE NOLOGGING )';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_COL_EXSTS
  then null;
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