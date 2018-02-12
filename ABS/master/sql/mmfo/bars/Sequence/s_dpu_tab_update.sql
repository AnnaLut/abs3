prompt -- ======================================================
prompt -- create sequence S_DPU_TAB_UPDATE
prompt -- ======================================================

declare
  e_seq_exists           exception;
  pragma exception_init( e_seq_exists, -00955 );
begin
  execute immediate 'create sequence S_DPU_TAB_UPDATE START WITH 1 INCREMENT BY 1 NOCACHE';
  dbms_output.put_line( 'Sequence "S_DPU_TAB_UPDATE" created.' );
exception
  when e_seq_exists then
    dbms_output.put_line( 'Sequence "S_DPU_TAB_UPDATE" already exists.' );
end;
/
