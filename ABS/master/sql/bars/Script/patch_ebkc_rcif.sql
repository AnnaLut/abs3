-- ======================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 20.08.2016
-- ======================================================================================
-- create table EBKC_RCIF
-- ======================================================


prompt -- ======================================================
prompt -- recreate table EBKC_RCIF
prompt -- ======================================================

declare
  e_cnstrn_nm_exsts  exception;
  pragma exception_init( e_cnstrn_nm_exsts, -02264 );
begin
  
  -- create new table 
  execute immediate q'[CREATE TABLE BARS.TEST_EBKC_RCIF
( KF     default sys_context('bars_context','user_mfo') NOT NULL
, RCIF                                                  NOT NULL
, SEND                                                  NOT NULL
, CUST_TYPE
, CONSTRAINT PK_EBKCRCIF PRIMARY KEY ( KF, RCIF, SEND )
) ORGANIZATION INDEX 
COMPRESS 1
INCLUDING CUST_TYPE
TABLESPACE BRSMDLD
OVERFLOW TABLESPACE BRSMDLD
as
select c.KF, r.RCIF, r.SEND, r.CUST_TYPE
  from BARS.EBKC_RCIF r
  join BARS.CUSTOMER c 
    on ( c.RNK = r.RCIF )]';
  
  dbms_output.put_line( 'Table "TEST_EBKC_RCIF" created.' );
  
  -- rename old table
  execute immediate q'[rename EBKC_RCIF to EBKC_RCIF_OLD]';
  dbms_output.put_line( 'Rename complete.' );
  
  -- rename new table
  execute immediate q'[rename TEST_EBKC_RCIF to EBKC_RCIF]';
  dbms_output.put_line( 'Rename complete.' );
  
exception
  when e_cnstrn_nm_exsts then
    dbms_output.put_line( 'Table "EBKC_RCIF" has already recreated.' );
end;
/

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE BARS.EBKC_RCIF IS 'Ідентифікатори майстер-картки на рівні РУ (рівні РНК)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.EBKC_RCIF TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
