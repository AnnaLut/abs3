begin
  update op_field f set f.default_value = '' where f.tag like 'ADRES';
exception
  when others then
    null;
end;
/
commit;
/
