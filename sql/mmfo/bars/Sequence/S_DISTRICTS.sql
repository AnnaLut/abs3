prompt -- ======================================================
prompt -- create sequence
prompt -- ======================================================

begin
  execute immediate 'CREATE SEQUENCE BARS.S_DISTRICTS START WITH 28 INCREMENT BY 1 NOCACHE NOCYCLE ORDER';
  dbms_output.put_line( 'Sequence S_DISTRICTS created.' );
exception 
  when others then 
    if (sqlcode = -00955) 
    then dbms_output.put_line( 'Sequence S_DISTRICTS already exists.' );
    else raise; 
    end if;
end;  
/