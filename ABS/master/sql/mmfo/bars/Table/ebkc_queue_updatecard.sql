PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_QUEUE_UPDATECARD.sql =========***
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to EBKC_QUEUE_UPDATECARD ***

begin
  bpa.alter_policy_info( 'EBKC_QUEUE_UPDATECARD', 'CENTER', null,  'E',  'E',  'E' );
  bpa.alter_policy_info( 'EBKC_QUEUE_UPDATECARD', 'FILIAL', null, null, null, null );
  bpa.alter_policy_info( 'EBKC_QUEUE_UPDATECARD', 'WHOLE' , null, null, null, null );
end;
/

PROMPT *** Create  table EBKC_QUEUE_UPDATECARD ***

begin
  execute immediate 'CREATE TABLE EBKC_QUEUE_UPDATECARD 
( RNK         NUMBER(38)   constraint CC_EBKCQUPDATECARD_RNK_NN NOT NULL
, STATUS      NUMBER(1)    DEFAULT 0
, INSERT_DATE DATE         DEFAULT trunc(sysdate)
, BRANCH      VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
, CUST_TYPE   VARCHAR2(1)  constraint CC_EBKCQUPDATECARD_CUSTTYPE_NN NOT NULL
, KF          VARCHAR2(6)  DEFAULT sys_context(''bars_context'',''user_mfo'') constraint CC_EBKCQUPDATECARD_KF_NN NOT NULL
) tablespace BRSDYND ';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** ALTER_POLICIES to EBKC_QUEUE_UPDATECARD ***

exec bpa.alter_policies('EBKC_QUEUE_UPDATECARD');

COMMENT ON TABLE  EBKC_QUEUE_UPDATECARD IS 'Черга клієнтів (ЮО, ФОП) для формування пакету оновлень';

COMMENT ON COLUMN EBKC_QUEUE_UPDATECARD.CUST_TYPE IS 'Тип клієнта: L - юрособа, P - ФОП';
COMMENT ON COLUMN EBKC_QUEUE_UPDATECARD.KF        IS 'Код філіалу (МФО)';

PROMPT *** Create  constraint CHK_EBK_QUPDCARD_LP ***

begin
 execute immediate 'ALTER TABLE EBKC_QUEUE_UPDATECARD ADD CONSTRAINT CHK_EBK_QUPDCARD_LP check (CUST_TYPE in (''L'',''P'',''I'')) ENABLE NOVALIDATE';
exception
  when others then
    if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

declare
  E_IDX_NOT_EXISTS       exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index U1_EBKC_QUPDCARD';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS 
  then null;
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
  execute immediate 'create unique index UK_EBKCQUPDATECARD_RNK ON EBKC_QUEUE_UPDATECARD ( RNK ) tablespace BRSMDLI';
  dbms_output.put_line( 'Index "UK_EBKCQUPDATECARD_RNK" created.' );
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
  E_IDX_NOT_EXISTS       exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index UK_EBKCQUEUEUPDATECARD';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS 
  then null;
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_EBKCQUPDATECARD_CUSTTP_KF on EBKC_QUEUE_UPDATECARD ( CUST_TYPE, KF, STATUS, RNK )
  tablespace BRSMDLI
  COMPRESS 3';
  dbms_output.put_line( 'Index "IDX_EBKCQUPDATECARD_CUSTTP_KF" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

PROMPT *** Create  grants  EBKC_QUEUE_UPDATECARD ***

grant SELECT                      on EBKC_QUEUE_UPDATECARD to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE on EBKC_QUEUE_UPDATECARD to BARS_ACCESS_DEFROLE;
grant SELECT                      on EBKC_QUEUE_UPDATECARD to BARS_DM;
grant SELECT                      on EBKC_QUEUE_UPDATECARD to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_QUEUE_UPDATECARD.sql =========***
PROMPT ===================================================================================== 
