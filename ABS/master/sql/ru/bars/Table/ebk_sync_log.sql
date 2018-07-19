-- ======================================================================================
-- Module : CDM
-- Author : BAA
-- Date   : 20.06.2018
-- ======================================================================================
-- create table EBK_SYNC_LOG
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
prompt -- create table EBK_SYNC_LOG
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'EBK_SYNC_LOG', 'WHOLE', NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'EBK_SYNC_LOG', 'FILIAL', 'M',  'M',  'M',  'M' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table EBK_SYNC_LOG
( ID         number(38)  constraint CC_EBKSYNCLOG_ID_NN     Not Null
, KF         varchar2(6) default sys_context(''bars_context'',''user_mfo'')
                         constraint CC_EBKSYNCLOG_KF_NN     Not Null
, CUST_ID    number(38)  constraint CC_EBKSYNCLOG_CUSTID_NN Not Null
, CUST_TP    varchar2(1) constraint CC_EBKSYNCLOG_CUSTTP_NN Not Null
, SYNC_ST    number(1)   constraint CC_EBKSYNCLOG_SYNCST_NN Not Null
, STRT_TM    timestamp(3) with time zone
, FNSH_TM    timestamp(3) with time zone
, ERR_MSG    varchar2(2000)
, constraint PK_EBKSYNCLOG primary key ( ID ) using index tablespace BRSDYNI
) tablespace BRSDYND';

  dbms_output.put_line( 'Table created.' );

exception
  when e_tab_exists
  then null;
end;
/

prompt -- ======================================================
prompt -- Alter table
prompt -- ======================================================

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_EBKSYNCLOG_CUSTID on EBK_SYNC_LOG ( CUST_ID ) tablespace BRSDYNI';
  dbms_output.put_line( 'Index "IDX_EBKSYNCLOG_CUSTID" created.' );
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
  bpa.alter_policies( 'EBK_SYNC_LOG' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  EBK_SYNC_LOG         IS 'Протокол синхронізації з ЄБК';

COMMENT ON COLUMN EBK_SYNC_LOG.KF      IS 'Код філіалу (МФО)';
COMMENT ON COLUMN EBK_SYNC_LOG.CUST_ID IS 'Iдентифiкатор клієнта (РНК)';
COMMENT ON COLUMN EBK_SYNC_LOG.CUST_TP IS 'Тип клієнта (I/P/L)';
COMMENT ON COLUMN EBK_SYNC_LOG.SYNC_ST IS 'Статус синхронізації';
COMMENT ON COLUMN EBK_SYNC_LOG.STRT_TM IS 'Час початку синхронізації';
COMMENT ON COLUMN EBK_SYNC_LOG.FNSH_TM IS 'Час звершення синхронізації';
COMMENT ON COLUMN EBK_SYNC_LOG.ERR_MSG IS 'Повідомленя про помилку при синхронізації';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on EBK_SYNC_LOG to BARS_ACCESS_DEFROLE;
