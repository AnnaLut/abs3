-- ================================================================================
-- Module   : DPU
-- Author   : BAA
-- Date     : 15.12.2017
-- ================================== <Comments> ==================================
-- 
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
  e_col_not_exists       exception;
  pragma exception_init( e_col_not_exists,-00904 );
  e_dup_col_nm           exception;
  pragma exception_init( e_dup_col_nm, -00957 );
begin
  execute immediate 'alter table DPU_VIDD rename column IRREVOCABLE to IRVK';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_not_exists
  then
    begin
      execute immediate 'alter table DPU_VIDD add ( IRVK number(1) )';
      dbms_output.put_line('Table altered.');
    end;
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

update DPU_VIDD
   set TERM_TYPE = 2
 where TERM_TYPE is Null;

commit;

SET FEEDBACK OFF

begin
  execute immediate 'alter table DPU_VIDD modify TERM_TYPE constraint CC_DPUVIDD_TERMTYPE_NN NOT NULL';
  dbms_output.put_line( 'Table altered.' );
exception
  when others then 
    if (sqlcode = -01442)
    then dbms_output.put_line( 'Column "TERM_TYPE" is already NOT NULL.' );
    else raise;
    end if;
end;
/

declare
  E_CHK_CNSTRN_EXISTS exception;
  pragma exception_init( E_CHK_CNSTRN_EXISTS, -02264 );
begin
  execute immediate 'alter table DPU_VIDD add constraint CC_DPUVIDD_TERMTYPE check ( TERM_TYPE in ( 1, 2 ) ) NOVALIDATE';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CHK_CNSTRN_EXISTS
  then null;
end;
/

begin
  execute immediate 'alter table DPU_VIDD modify TERM_MIN constraint CC_DPUVIDD_TERMMIN_NN NOT NULL NOVALIDATE';
  dbms_output.put_line('Table altered.');
exception
  when others then 
    if (sqlcode = -01442)
    then dbms_output.put_line( 'Column "TERM_MIN" is already NOT NULL.' );
    else raise;
    end if;
end;
/

declare
  E_CHK_CNSTRN_EXISTS exception;
  pragma exception_init( E_CHK_CNSTRN_EXISTS, -02264 );
begin
  execute immediate 'alter table DPU_VIDD add constraint CC_DPUVIDD_TERMMIN check ( TERM_MIN > 0 )';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CHK_CNSTRN_EXISTS
  then null;
end;
/

declare
  E_CHK_CNSTRN_EXISTS exception;
  pragma exception_init( E_CHK_CNSTRN_EXISTS, -02264 );
begin
  execute immediate 'alter table DPU_VIDD add constraint CC_DPUVIDD_SHABLON_EXISTS check ( FLAG = nvl2(SHABLON,FLAG,0) ) NOVALIDATE';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CHK_CNSTRN_EXISTS
  then null;
end;
/
