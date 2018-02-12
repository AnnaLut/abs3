
begin
  insert into mway_errors(err_code, err_name, err_message )
  values (730, 'ERROR_TERM_REPL', 'The term of replenishment has expired. Term of replenishment was %s');
  exception
      when dup_val_on_index then null;
      when others then raise;
  commit;
end;
/
begin
  insert into mway_errors(err_code, err_name, err_message )
  values (731, 'ERROR_LIMIT_EXCEED', 'Replenishment limit exceeded %s');
  exception
      when dup_val_on_index then null;
      when others then raise;
  commit;
end;
/
