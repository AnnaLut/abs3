-- ======================================================================================
-- Module : CDM
-- Author : BAA
-- Date   : 18.10.2017
-- ======================================================================================
-- create table EBKC_GCIF
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table EBKC_GCIF
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'EBKC_GCIF', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'EBKC_GCIF', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table EBKC_GCIF 
( KF              VARCHAR2(6)     NOT NULL
, RNK             NUMBER(38)      NOT NULL
, GCIF            VARCHAR2(30)    NOT NULL
, CUST_TYPE       VARCHAR2(1)     NOT NULL
, INSERT_DATE     DATE
, MOD_TMS         TIMESTAMP(3) WITH TIME ZONE
) tablespace BRSMDLD';

  dbms_output.put_line( 'Table "EBKC_GCIF" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "EBKC_GCIF" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alter table
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table EBKC_GCIF add ( MOD_TMS timestamp(3) WITH TIME ZONE )';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "MOD_TMS" already exists in table.' );
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
  execute immediate 'create unique index UK_EBKCGCIF_GCIF on EBKC_GCIF ( KF, GCIF ) tablespace BRSMDLI compress 1';
  dbms_output.put_line( 'Index "UK_EBKCGCIF_GCIF" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate 'create unique index UK_EBKCGCIF_RNK on EBKC_GCIF ( RNK ) tablespace BRSMDLI';
  dbms_output.put_line( 'Index "UK_EBKCGCIF_RNK" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/


SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'EBKC_GCIF' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  EBKC_GCIF             IS 'Таблица идентификатора мастер-карточки для ЮО, ФОП на уровне банка';

COMMENT ON COLUMN EBKC_GCIF.KF          IS 'Код філіалу (МФО)';
COMMENT ON COLUMN EBKC_GCIF.RNK         IS 'Iдентифiкатор клієнта (РНК)';
COMMENT ON COLUMN EBKC_GCIF.GCIF        IS 'Унікально непостійний ідентифiкатор клієнта в ЄБК';
COMMENT ON COLUMN EBKC_GCIF.CUST_TYPE   IS 'Тип клієнта (I/P/L)';
COMMENT ON COLUMN EBKC_GCIF.MOD_TMS     IS 'Дата модифікації в ЄБК';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant DELETE,INSERT,SELECT,UPDATE on EBKC_GCIF to BARS_ACCESS_DEFROLE;
grant SELECT                      on EBKC_GCIF to BARS_DM;
