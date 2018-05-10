-- ================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 20.09.2017
-- ================================== <Comments> ==================================
-- modify table EBKC_REQ_UPDCARD_ATTR
-- move data from TMP_EBK_REQ_UPDCARD_ATTR to EBKC_REQ_UPDCARD_ATTR
-- drop table TMP_EBK_REQ_UPDCARD_ATTR
-- create index IDX_EBKREQCARDATTR
-- add policies to EBKC_REQ_UPDCARD_ATTR
-- move table to correct tablespace
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET DEFINE       OFF
SET LINES        300
SET PAGES        500
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON

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

-- after move data from EBK_CARD_ATTRIBUTES -> EBKC_CARD_ATTRIBUTES
-- declare
--   E_REF_CNSTRN_EXISTS exception;
--   pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
-- begin
--   execute immediate q'[alter table EBKC_REQ_UPDCARD_ATTR add constraint FK_EBKREQCARDATTR_EBKCARDATTRS foreign key ( NAME, CUST_TYPE )
--   references EBKC_CARD_ATTRIBUTES ( NAME, CUST_TYPE )]';
--   dbms_output.put_line( 'Table altered.' );
-- exception
--   when E_REF_CNSTRN_EXISTS then
--     Null;
-- end;
-- /

prompt --
prompt -- create index IDX_EBKREQCARDATTR
prompt --

declare
  e_idx_not_exists       exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index I1_EBKC_REQ_UPDCARD_ATTR';
  dbms_output.put_line( 'Index dropped.' );
exception
  when e_idx_not_exists then
    null;
end;
/

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

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate q'[insert
    into EBKC_REQ_UPDCARD_ATTR
       ( KF, RNK, QUALITY, NAME, VALUE, RECOMMENDVALUE, DESCR, CUST_TYPE )
       
  select KF, RNK, QUALITY, NAME, VALUE, RECOMMENDVALUE, DESCR, 'I'
    from TMP_EBK_REQ_UPDCARD_ATTR]';
  dbms_output.put_line( to_char(sql%rowcount)||' rows created.' );
  commit;
  execute immediate 'drop table TMP_EBK_REQ_UPDCARD_ATTR';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists then
    null;
end;
/

begin
  BPA.ALTER_POLICY_INFO( 'EBKC_REQ_UPDCARD_ATTR', 'WHOLE', NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'EBKC_REQ_UPDCARD_ATTR', 'FILIAL', 'M',  'M',  'M',  'M' );
end;
/

commit;

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'EBKC_REQ_UPDCARD_ATTR' );
end;
/

commit;

prompt --
prompt -- move table to correct tablespace
prompt --

declare
  l_tbl_nm     varchar2(30);
  l_tblsp_nm   varchar2(30);
begin

  l_tbl_nm := 'EBKC_REQ_UPDCARD_ATTR';

  begin
    
    select TABLESPACE_NAME
      into l_tblsp_nm
      from USER_TABLES
     where TABLE_NAME = l_tbl_nm;
    
    if ( l_tblsp_nm = 'BRSDYND' )
    then
      execute immediate 'alter table '||l_tbl_nm||' move tablespace BRSMDLD';
      dbms_output.put_line( 'Table altered.' );
    end if;
    
  exception
    when no_data_found then
      null;
  end;
  
end;
/
