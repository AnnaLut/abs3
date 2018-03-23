-- ================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 14.02.2017
-- ================================== <Comments> ==================================
-- modify table EBKC_GCIF
-- move data from EBK_GCIF to EBKC_GCIF
-- drop table EBK_GCIF
-- add policies to EBKC_GCIF
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
