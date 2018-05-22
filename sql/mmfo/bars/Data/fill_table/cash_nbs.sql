begin
  delete CASH_NBS where nbs = 3400;
end;
/

begin
  begin insert into CASH_NBS values(3400, '08'); exception when dup_val_on_index then null; end;
end;
/

begin
  begin insert into CASH_NBS values(3400, '19'); exception when dup_val_on_index then null; end;
end;
/
commit;