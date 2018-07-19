-- ================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 21.06.2018
-- ================================== <Comments> ==================================
-- move data from EBK_QUEUE_UPDATECARD to EBKC_QUEUE_UPDATECARD
-- drop table EBK_QUEUE_UPDATECARD
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON

declare
  E_CNSTRN_NOT_EXISTS    exception;
  pragma exception_init( E_CNSTRN_NOT_EXISTS, -02443 );
begin
  execute immediate q'[alter table EBKC_QUEUE_UPDATECARD drop constraint CHK_EBK_QUPDCARD_LP]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CNSTRN_NOT_EXISTS
  then null;
end;
/

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin
  execute immediate q'[alter table EBKC_QUEUE_UPDATECARD add constraint FK_EBKCQUPDCARD_EBKCUSTTYPES foreign key ( CUST_TYPE ) references EBKC_CUST_TYPES ( CUST_TYPE )]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS
  then null;
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate q'[insert /*+ IGNORE_ROW_ON_DUPKEY_INDEX( EBKC_QUEUE_UPDATECARD( RNK ) ) */
    into EBKC_QUEUE_UPDATECARD
       ( RNK, STATUS, INSERT_DATE, BRANCH, CUST_TYPE, KF )
  select RNK, STATUS, INSERT_DATE, BRANCH,       'I', KF
    from EBK_QUEUE_UPDATECARD]';
  dbms_output.put_line( to_char(sql%rowcount)||' rows created.' );
  commit;
  execute immediate 'drop table EBK_QUEUE_UPDATECARD';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists
  then dbms_output.put_line( 'Table "EBK_QUEUE_UPDATECARD" does not exist.' );
end;
/
