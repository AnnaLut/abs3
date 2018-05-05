-- ================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 20.09.2017
-- ================================== <Comments> ==================================
-- modify table EBKC_REQ_UPDATECARD
-- move data from TMP_EBK_REQ_UPDATECARD to EBKC_REQ_UPDATECARD
-- drop table TMP_EBK_REQ_UPDATECARD
-- add column MOD_TMS
-- create unique index UK_EBKREQUPDCARD
-- add policies to EBKC_REQ_UPDATECARD
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
  execute immediate q'[alter table EBKC_REQ_UPDATECARD add constraint FK_EBKREQUPDCARD_EBKCUSTTYPES foreign key ( CUST_TYPE ) references EBKC_CUST_TYPES ( CUST_TYPE )]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS then
    Null;
end;
/

declare
  E_COL_EXISTS           exception;
  pragma exception_init( E_COL_EXISTS, -01430 );
begin
  execute immediate 'alter table EBKC_REQ_UPDATECARD add ( MOD_TMS timestamp(3) WITH TIME ZONE )';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_COL_EXISTS then
    dbms_output.put_line( 'Column "MOD_TMS" already exists in table.' );
end;
/

SET FEEDBACK ON

COMMENT ON COLUMN EBKC_REQ_UPDATECARD.MOD_TMS IS 'Дата модифікації в ЄБК';

delete EBKC_REQ_UPDATECARD t1
 where ROWID > ( select min(ROWID)
                   from EBKC_REQ_UPDATECARD t2
                  where t2.KF  = t1.KF 
                    and t2.RNK = t1.RNK );

commit;

SET FEEDBACK OFF

prompt --
prompt -- create unique index UK_EBKREQUPDCARD
prompt --

declare
  e_idx_not_exists       exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index I1_EBKC_REQ_UPDCARD';
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
  execute immediate 'create unique index UK_EBKREQUPDCARD on EBKC_REQ_UPDATECARD ( KF, RNK ) tablespace BRSMDLI compress 1';
  dbms_output.put_line( 'Index "UK_EBKREQUPDCARD" created.' );
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
  execute immediate q'[insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX( EBKC_REQ_UPDATECARD( KF, RNK ) ) */
    into EBKC_REQ_UPDATECARD
       ( BATCHID, KF, RNK, QUALITY, DEFAULTGROUPQUALITY, GROUP_ID, CUST_TYPE )
  select BATCHID, KF, RNK, QUALITY, DEFAULTGROUPQUALITY, GROUP_ID, 'I'
    from TMP_EBK_REQ_UPDATECARD]';
  dbms_output.put_line( to_char(sql%rowcount)||' rows created.' );
  commit;
  execute immediate 'drop table TMP_EBK_REQ_UPDATECARD';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists then
    null;
end;
/

begin
  BPA.ALTER_POLICY_INFO( 'EBKC_REQ_UPDATECARD', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'EBKC_REQ_UPDATECARD', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/

commit;

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'EBKC_REQ_UPDATECARD' );
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

  l_tbl_nm := 'EBK_REQ_UPDATECARD';

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
