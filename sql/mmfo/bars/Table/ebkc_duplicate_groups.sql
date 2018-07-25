-- ======================================================================================
-- Module : CDM
-- Author : BAA
-- Date   : 08.06.2018
-- ======================================================================================
-- create table EBKC_DUPLICATE_GROUPS
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
prompt -- create table EBKC_DUPLICATE_GROUPS
prompt -- ======================================================

begin
  bpa.alter_policy_info('EBKC_DUPLICATE_GROUPS', 'CENTER', null, null, null, null);
  bpa.alter_policy_info('EBKC_DUPLICATE_GROUPS', 'FILIAL', null, null, null, null);
  bpa.alter_policy_info('EBKC_DUPLICATE_GROUPS', 'WHOLE' , null, null, null, null);
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table EBKC_DUPLICATE_GROUPS 
( KF         varchar2(6) default SYS_CONTEXT(''BARS_CONTEXT'',''USER_MFO'')
                         constraint CC_EBKCDUPLICATEGROUPS_KF_NN NOT NULL
, CUST_TYPE  varchar2(1)
, M_RNK      number(38)
, D_RNK      number(38)
) tablespace BRSMDLD';

  dbms_output.put_line( 'Table "EBKC_DUPLICATE_GROUPS" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "EBKC_DUPLICATE_GROUPS" already exists.' );
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
  execute immediate 'create index IDX_EBKCDUPLICATEGROUPS on EBKC_DUPLICATE_GROUPS ( KF, CUST_TYPE, M_RNK ) tablespace BRSMDLI compress 2';
  dbms_output.put_line( 'Index "IDX_EBKREQCARDATTR" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
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
--execute immediate 'create unique index UK_EBKCDUPLICATEGROUPS on EBKC_DUPLICATE_GROUPS ( KF, D_RNK ) tablespace BRSMDLI compress 1';
  execute immediate 'create index UK_EBKCDUPLICATEGROUPS on EBKC_DUPLICATE_GROUPS ( KF, M_RNK, D_RNK ) tablespace BRSMDLI compress 1';
  dbms_output.put_line( 'Index "UK_EBKCDUPLICATEGROUPS" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Index "UK_EBKCDUPLICATEGROUPS" already exists.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies('EBKC_DUPLICATE_GROUPS');
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  EBKC_DUPLICATE_GROUPS           IS 'Таблица основной карточки с дочерними для дедубликации';

COMMENT ON COLUMN EBKC_DUPLICATE_GROUPS.KF        IS 'Код філіалу (МФО)';
COMMENT ON COLUMN EBKC_DUPLICATE_GROUPS.M_RNK     IS 'Iдентифiкатор клієнта (основний)';
COMMENT ON COLUMN EBKC_DUPLICATE_GROUPS.D_RNK     IS 'Iдентифiкатор клієнта (дублікат)';
COMMENT ON COLUMN EBKC_DUPLICATE_GROUPS.CUST_TYPE IS 'Тип клієнта (I/P/L)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on EBKC_DUPLICATE_GROUPS to BARSREADER_ROLE;
grant SELECT on EBKC_DUPLICATE_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT on EBKC_DUPLICATE_GROUPS to BARS_DM;
grant SELECT on EBKC_DUPLICATE_GROUPS to UPLD;
