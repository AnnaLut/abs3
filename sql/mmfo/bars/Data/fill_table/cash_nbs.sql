
begin
  begin insert into CASH_NBS values(3400, null); exception when dup_val_on_index then null; end;
end;
/
commit;