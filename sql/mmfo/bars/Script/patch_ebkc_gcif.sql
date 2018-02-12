-- ================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 20.09.2017
-- ================================== <Comments> ==================================
-- modify table EBKC_GCIF
-- move data from EBK_GCIF to EBKC_GCIF
-- drop table EBK_GCIF
-- add policies to EBKC_GCIF
-- create unique index UK_EBKCGCIF_GCIF
-- create unique index UK_EBKCGCIF_RNK
-- move table to correct tablespace
-- ================================================================================


declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table EBKC_GCIF add constraint FK_EBKGCIF_EBKCUSTTYPES foreign key ( CUST_TYPE ) references EBKC_CUST_TYPES ( CUST_TYPE )]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS then
    Null;
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate q'[insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX( EBKC_GCIF( GCIF ) ) */
    into EBKC_GCIF
       ( KF, RNK, GCIF, CUST_TYPE, INSERT_DATE )
  select KF, RNK, GCIF, 'I',       INSERT_DATE
    from EBK_GCIF]';
  dbms_output.put_line( to_char(sql%rowcount)||' rows created.' );
  commit;
  execute immediate 'drop table EBK_GCIF';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists then
    dbms_output.put_line( 'Table "EBK_GCIF" does not exist.' );
end;  
/

begin
  BPA.ALTER_POLICY_INFO( 'EBKC_GCIF', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'EBKC_GCIF', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/

commit;

begin
  BPA.ALTER_POLICIES( 'EBKC_GCIF' );
end;
/

commit;

declare
  e_idx_not_exists       exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index IU1_EBKC_GCIF';
  dbms_output.put_line( 'Index dropped.' );
exception
  when e_idx_not_exists then
    null;
end;
/

-- to avoid ORA-01502: index 'BARS.UK_EBKCGCIF_GCIF' or partition of such index is in unusable state
declare
  e_idx_not_exists       exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index UK_EBKCGCIF_GCIF';
  dbms_output.put_line( 'Index dropped.' );
exception
  when e_idx_not_exists then
    null;
end;
/

SET FEEDBACK ON

delete BARS.EBKC_GCIF t1
 where ROWID > ( select min(ROWID)
                   from BARS.EBKC_GCIF t2
                  where t2.KF   = t1.KF 
                    and t2.GCIF = t1.GCIF );

commit;

delete BARS.EBKC_GCIF t1
 where ROWID > ( select min(ROWID)
                   from BARS.EBKC_GCIF t2
                  where t2.RNK = t1.RNK );
commit;

SET FEEDBACK OFF

prompt --
prompt -- create unique index UK_EBKCGCIF_GCIF
prompt --

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create unique index UK_EBKCGCIF_GCIF on EBKC_GCIF ( KF, GCIF ) tablespace BRSMDLI compress 1';
  dbms_output.put_line( 'Index "UK_EBKCGCIF_GCIF" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

prompt --
prompt -- create unique index UK_EBKCGCIF_RNK
prompt --

declare
  e_idx_not_exists       exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index IU2_EBKC_GCIF';
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
  execute immediate 'create unique index UK_EBKCGCIF_RNK on EBKC_GCIF ( RNK ) tablespace BRSMDLI';
  dbms_output.put_line( 'Index "UK_EBKCGCIF_RNK" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
  -- ORA-01452: cannot CREATE UNIQUE INDEX; duplicate keys found
  -- select rnk, max(rowid) 
  --   from EBKC_GCIF
  --  group by rnk having count(rnk) > 1;
end;
/

prompt --
prompt -- move table to correct tablespace
prompt --

declare
  l_tblsp_nm   varchar2(30);
begin
  
  begin
    
    select TABLESPACE_NAME
      into l_tblsp_nm
      from user_TABLES
     where TABLE_NAME ='EBKC_GCIF';
    
    if ( l_tblsp_nm = 'BRSDYND' )
    then
      execute immediate 'alter table EBKC_GCIF move tablespace BRSMDLD';
      dbms_output.put_line( 'Table altered.' );
    end if;
    
  exception
    when no_data_found then
      null;
  end;
  
end;
/
