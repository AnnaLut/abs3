-- ======================================================================================
-- Module : CDM
-- Author : BAA
-- Date   : 18.10.2017
-- ======================================================================================
-- create table EBKC_REQ_UPDATECARD
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET DEFINE       OFF
SET LINES        300
SET PAGES        500
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table EBKC_REQ_UPDATECARD
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'EBKC_REQ_UPDATECARD', 'WHOLE',  null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'EBKC_REQ_UPDATECARD', 'FILIAL',  'M',  'M',  'M',  'M' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table EBKC_REQ_UPDATECARD
( BATCHID             VARCHAR2(50)
, KF                  VARCHAR2(6) constraint CC_EBKREQUPDCARD_KF_NN  NOT NULL
, RNK                 NUMBER(38)  constraint CC_EBKREQUPDCARD_RNK_NN NOT NULL
, QUALITY             NUMBER(6,2)
, DEFAULTGROUPQUALITY NUMBER(6,2)
, GROUP_ID            NUMBER(1)
, CUST_TYPE           VARCHAR2(1)
, MOD_TMS             TIMESTAMP(3) WITH TIME ZONE
) tablespace BRSMDLD';

  dbms_output.put_line( 'Table "EBKC_REQ_UPDATECARD" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "EBKC_REQ_UPDATECARD" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alter table
prompt -- ======================================================

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table EBKC_REQ_UPDATECARD add constraint FK_EBKREQUPDCARD_EBKCUSTTYPES foreign key ( CUST_TYPE ) references EBKC_CUST_TYPES ( CUST_TYPE )]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS then
    Null;
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table EBKC_REQ_UPDATECARD add ( MOD_TMS timestamp(3) WITH TIME ZONE )';
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
begin
  execute immediate 'create unique index UK_EBKREQUPDCARD on EBKC_REQ_UPDATECARD ( KF, RNK ) tablespace BRSMDLI compress 1';
  dbms_output.put_line( 'Index "UK_EBKREQUPDCARD" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'EBKC_REQ_UPDATECARD' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  EBKC_REQ_UPDATECARD                     IS 'Таблицa приема рекомендаций по карточкам (мастер)';

COMMENT ON COLUMN EBKC_REQ_UPDATECARD.BATCHID             IS '';
COMMENT ON COLUMN EBKC_REQ_UPDATECARD.KF                  IS 'Код філіалу (МФО)';
COMMENT ON COLUMN EBKC_REQ_UPDATECARD.RNK                 IS 'Iдентифiкатор клієнта (РНК)';
COMMENT ON COLUMN EBKC_REQ_UPDATECARD.QUALITY             IS '';
COMMENT ON COLUMN EBKC_REQ_UPDATECARD.DEFAULTGROUPQUALITY IS '';
COMMENT ON COLUMN EBKC_REQ_UPDATECARD.GROUP_ID            IS '';
COMMENT ON COLUMN EBKC_REQ_UPDATECARD.CUST_TYPE           IS 'Тип клієнта (I/P/L)';
COMMENT ON COLUMN EBKC_REQ_UPDATECARD.MOD_TMS             IS 'Дата модифікації в ЄБК';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant DELETE,INSERT,SELECT,UPDATE on EBKC_REQ_UPDATECARD to BARS_ACCESS_DEFROLE;
grant SELECT                      on EBKC_REQ_UPDATECARD to BARS_DM;
