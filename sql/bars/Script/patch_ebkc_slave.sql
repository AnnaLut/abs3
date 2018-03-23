-- ================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 14.02.2017
-- ================================== <Comments> ==================================
-- modify table EBKC_SLAVE
-- move data from EBK_SLAVE_CLIENT to EBKC_SLAVE
-- drop table EBK_SLAVE_CLIENT
-- add policies to EBKC_SLAVE
-- ================================================================================

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table EBKC_SLAVE add constraint FK_EBKCSLAVE_EBKCUSTTYPES foreign key ( CUST_TYPE ) references EBKC_CUST_TYPES ( CUST_TYPE )]';
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
  execute immediate q'[insert 
    into EBKC_SLAVE
       ( SLAVE_KF, SLAVE_RNK, CUST_TYPE, GCIF )
  select SLAVE_KF, SLAVE_RNK, 'I',       GCIF
    from EBK_SLAVE_CLIENT]';
  dbms_output.put_line( to_char(sql%rowcount)||' rows created.' );
  commit;
  execute immediate 'drop table EBK_SLAVE_CLIENT';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists then
    dbms_output.put_line( 'Table "EBK_SLAVE_CLIENT" does not exist.' );
end;  
/

begin
  BPA.ALTER_POLICY_INFO( 'EBKC_SLAVE', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'EBKC_SLAVE', 'FILIAL', NULL, NULL, NULL, NULL );
end;
/

commit;

begin
  BPA.ALTER_POLICIES( 'EBKC_SLAVE' );
end;
/

commit;
