prompt -- ======================================================
prompt -- create sequence
prompt -- ======================================================

declare
  l_seq_nm               varchar2(30);
  e_seq_exists           exception;
  pragma exception_init( e_seq_exists, -00955 );
begin
  l_seq_nm := 'S_PRVN_FIN_DEB_ARCH';
  execute immediate 'create sequence '||l_seq_nm||' start with 1 increment by 1 nocycle cache 10 order';
  dbms_output.put_line( 'Sequence "'||l_seq_nm||'" created.' );
exception
  when e_seq_exists then
    dbms_output.put_line( 'Sequence "'||l_seq_nm||'" already exists.' );
end;
/
