prompt -- ======================================================
prompt -- create sequence S_NBUR_REF_FILE_CHECKS
prompt -- ======================================================

declare
  e_seq_exists           exception;
  pragma exception_init( e_seq_exists, -00955 );
begin
  execute immediate 'create sequence S_NBUR_REF_FILE_CHECKS start with 1 increment by 1 nocycle nocache order';
  dbms_output.put_line(  'Sequence "S_NBUR_REF_FILE_CHECKS" created.' );
exception
  when e_seq_exists then
    dbms_output.put_line( 'Sequence "S_NBUR_REF_FILE_CHECKS" already exists.' );
end;  
/
