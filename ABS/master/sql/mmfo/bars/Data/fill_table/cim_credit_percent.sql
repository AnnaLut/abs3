begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('0', 'Безпроцентна', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('2', 'Плаваюча (змінювана)', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('3', 'Фiксована', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('4', 'Проценти включені до основної суми', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('#', 'Розріз відсутній', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
