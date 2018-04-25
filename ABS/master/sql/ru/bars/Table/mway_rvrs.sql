SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table ACCOUNTS_RSRV
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'MWAY_RVRS', 'WHOLE',  NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'MWAY_RVRS', 'FILIAL', NULL, NULL, NULL, NULL );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table MWAY_RVRS
( RRN_TR     VARCHAR2(100) constraint CC_MWAYRVRS_RRNTR_NN Not Null
, constraint PK_MWAYRVRS primary key ( RRN_TR )
) tablespace BRSSMLD]';
  
  dbms_output.put_line( 'Table "MWAY_RVRS" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "MWAY_RVRS" already exists.' );
end;
/