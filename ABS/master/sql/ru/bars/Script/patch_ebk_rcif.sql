-- ======================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 20.08.2016
-- ======================================================================================
-- create table EBK_RCIF
-- ======================================================


prompt -- ======================================================
prompt -- recreate table EBK_RCIF
prompt -- ======================================================

declare
  e_cnstrn_nm_exsts  exception;
  pragma exception_init( e_cnstrn_nm_exsts, -02264 );
begin
  
  -- create new table 
  execute immediate q'[CREATE TABLE BARS.TEST_EBK_RCIF
( KF     default sys_context('bars_context','user_mfo') NOT NULL
, RCIF                                                  NOT NULL
, SEND                                                  NOT NULL
, CONSTRAINT PK_EBKRCIF PRIMARY KEY ( KF, RCIF, SEND )
) ORGANIZATION INDEX 
COMPRESS 1
TABLESPACE BRSMDLD
as
select c.KF, r.RCIF, r.SEND
  from BARS.EBK_RCIF r
  join BARS.CUSTOMER c 
    on ( c.RNK = r.RCIF )]';
  
  dbms_output.put_line( 'Table "TEST_EBK_RCIF" created.' );
  
  -- rename old table
  execute immediate q'[rename EBK_RCIF to EBK_RCIF_OLD]';
  dbms_output.put_line( 'Rename complete.' );
  
  -- rename new table
  execute immediate q'[rename TEST_EBK_RCIF to EBK_RCIF]';
  dbms_output.put_line( 'Rename complete.' );
  
exception
  when e_cnstrn_nm_exsts then
    dbms_output.put_line( 'Table "EBK_RCIF" has already recreated.' );
end;
/

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE BARS.EBK_RCIF IS 'Ідентифікатори майстер-картки на рівні РУ (рівні РНК)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.EBK_RCIF TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
