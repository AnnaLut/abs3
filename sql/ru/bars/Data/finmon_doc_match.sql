prompt finmon_doc_match 7 -> 1
begin
  insert into finmon_doc_match(bars_code, finmon_code) values (7, 1);
exception
  when dup_val_on_index then null;
end;
/
commit;
/
