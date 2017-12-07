-- ================================================================================
-- Module   : DPU
-- Author   : BAA
-- Date     : 28.11.2017
-- ================================== <Comments> ==================================
-- ОБ22 не міститиме ознаки строковості
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET FEEDBACK     OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON
set VERIFY       OFF

declare
  e_col_not_exists exception;
  pragma exception_init(e_col_not_exists,-00904);
begin
  execute immediate 'alter table DPU_VIDD drop column IRREVOCABLE';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_not_exists then
    dbms_output.put_line( 'Column "IRREVOCABLE" does not exist in table.' );
end;
/

declare
  e_col_not_exists       exception;
  pragma exception_init( e_col_not_exists,-00904 );
  e_dup_col_nm           exception;
  pragma exception_init( e_dup_col_nm, -00957 );
begin
  execute immediate 'alter table DPU_VIDD rename column DPU_TYPE to IRVK';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_not_exists
  then null;
  when e_dup_col_nm
  then dbms_output.put_line('Duplicate column name.');
end;
/

declare
  E_CNSTRN_NOT_EXISTS     exception;
  pragma exception_init( E_CNSTRN_NOT_EXISTS, -02443 );
begin
  execute immediate 'alter table DPU_VIDD drop constraint CC_DPUVIDD_SROK_NN';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CNSTRN_NOT_EXISTS
  then null;
end;
/

declare
  E_CHK_CNSTRN_EXISTS exception;
  pragma exception_init( E_CHK_CNSTRN_EXISTS, -02264 );
begin
  execute immediate 'alter table DPU_VIDD add constraint CC_DPUVIDD_COMPROC_FREQ check ( COMPROC = decode(FREQ_V,5,COMPROC,0) )';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CHK_CNSTRN_EXISTS
  then null;
end;
/

SET FEEDBACK ON

comment on column DPU_VIDD.COMPROC is 'Allowed compound interest';
comment on column DPU_VIDD.FREQ_V  is 'Frequency of interest payment';
comment on column DPU_VIDD.IRVK    is '1 - Irrevocable (terminable) / 0 - Revocable (on demand)';

update DPU_VIDD
   set TT  = 'DU%'
 where lnnvl( TT = 'DU%' );

commit;
