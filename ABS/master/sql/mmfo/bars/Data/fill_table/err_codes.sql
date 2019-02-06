begin
  insert into err_codes(errmod_code, err_code, err_excpnum, err_name)
  values('CIM', 105, -20000, '105');  
  exception 
    when dup_val_on_index then null;
end;
/

commit;