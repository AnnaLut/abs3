declare
  e_obj_exists exception;
  pragma exception_init( e_obj_exists, -00955 );
begin
  execute immediate 'create type T_DICTIONARY as table of T_DICTIONARY_ITEM';
exception
  when e_obj_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
end;
/

grant execute on T_DICTIONARY      to BARS_ACCESS_DEFROLE;
