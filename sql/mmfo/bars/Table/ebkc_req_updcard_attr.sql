-- ======================================================================================
-- Module : CDM
-- Author : BAA
-- Date   : 21.11.2017
-- ======================================================================================
-- create table EBKC_REQ_UPDCARD_ATTR
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table EBKC_REQ_UPDCARD_ATTR
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'EBKC_REQ_UPDCARD_ATTR', 'WHOLE', null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'EBKC_REQ_UPDCARD_ATTR', 'FILIAL', 'M',  'M',  'M',  'M' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table EBKC_REQ_UPDCARD_ATTR 
( KF             VARCHAR2(6) constraint CC_EBKREQCARDATTR_KF_NN  NOT NULL
, RNK            NUMBER(38)  constraint CC_EBKREQCARDATTR_RNK_NN NOT NULL
, QUALITY        VARCHAR2(5)
, NAME           VARCHAR2(100)
, VALUE          VARCHAR2(4000)
, RECOMMENDVALUE VARCHAR2(4000)
, DESCR          VARCHAR2(4000)
, CUST_TYPE      VARCHAR2(1)
) tablespace BRSMDLD';

  dbms_output.put_line( 'Table "EBKC_REQ_UPDCARD_ATTR" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "EBKC_REQ_UPDCARD_ATTR" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alter table
prompt -- ======================================================

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table EBKC_REQ_UPDCARD_ATTR add constraint FK_EBKREQCARDATTR_EBKCUSTTYPES foreign key ( CUST_TYPE )
  references EBKC_CUST_TYPES ( CUST_TYPE )]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS then
    Null;
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
  execute immediate 'create index IDX_EBKREQCARDATTR on EBKC_REQ_UPDCARD_ATTR ( RNK, KF, CUST_TYPE ) tablespace BRSMDLI compress 3';
  dbms_output.put_line( 'Index "IDX_EBKREQCARDATTR" created.' );
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
  bpa.alter_policies( 'EBKC_REQ_UPDCARD_ATTR' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  EBKC_REQ_UPDCARD_ATTR                IS 'Таблицa приема рекомендаций по карточкам (детаил)';

COMMENT ON COLUMN EBKC_REQ_UPDCARD_ATTR.KF             IS '';
COMMENT ON COLUMN EBKC_REQ_UPDCARD_ATTR.RNK            IS '';
COMMENT ON COLUMN EBKC_REQ_UPDCARD_ATTR.QUALITY        IS '';
COMMENT ON COLUMN EBKC_REQ_UPDCARD_ATTR.NAME           IS '';
COMMENT ON COLUMN EBKC_REQ_UPDCARD_ATTR.VALUE          IS '';
COMMENT ON COLUMN EBKC_REQ_UPDCARD_ATTR.RECOMMENDVALUE IS '';
COMMENT ON COLUMN EBKC_REQ_UPDCARD_ATTR.DESCR          IS '';
COMMENT ON COLUMN EBKC_REQ_UPDCARD_ATTR.CUST_TYPE      IS '';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant DELETE,INSERT,SELECT,UPDATE on EBKC_REQ_UPDCARD_ATTR to BARS_ACCESS_DEFROLE;
grant SELECT                      on EBKC_REQ_UPDCARD_ATTR to BARS_DM;
