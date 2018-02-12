prompt -- ======================================================
prompt -- create sequence S_ACCOUNTS_RSRV
prompt -- ======================================================

declare
  e_seq_exists           exception;
  pragma exception_init( e_seq_exists, -00955 );
begin
  execute immediate 'create sequence S_ACCOUNTS_RSRV start with 1 increment by 1 nocycle nocache ordeR';
  dbms_output.put_line( 'Sequence created.' );
exception
  when e_seq_exists then
    null;
end;
/
