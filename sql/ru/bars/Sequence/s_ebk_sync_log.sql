prompt -- ======================================================
prompt -- create sequence S_EBK_SYNC_LOG
prompt -- ======================================================

declare
  l_seq_nm               varchar2(30);
  e_seq_exists           exception;
  pragma exception_init( e_seq_exists, -00955 );
begin
  l_seq_nm := 'S_EBK_SYNC_LOG';
  execute immediate 'CREATE SEQUENCE BARS.'||l_seq_nm||' START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE ORDER';
  dbms_output.put_line( 'Sequence "'||l_seq_nm||'" created.' );
exception
  when e_seq_exists then
    dbms_output.put_line( 'Sequence "'||l_seq_nm||'" already exists.' );
end;
/