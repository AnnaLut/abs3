begin
  begin insert into f049(f049, txt, d_open) values('1', 'без змін', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/

begin
  begin insert into f049(f049, txt, d_open) values('2', 'зміна строковості (довгостроковий чи навпаки)', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/

begin
  begin insert into f049(f049, txt, d_open) values('3', 'зміна типу кредитора', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('4', 'зміна виду позичальника або переведення боргу з первісного на нового боржника', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('5', 'перехід кліїнта з іншого обслуговуючого банку', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('6', 'анулювання реїстраційного свідоцтва', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('7', 'інше', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('8', 'зміна економічних умов надання кредиту', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('9', 'зміна суми заборгованості. Зміна обсягу заборгованості до погашення за додатковою угодою', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('A', 'продовження терміну дії договору', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('B', 'зміна резидентної належності позичальника (кредитора)', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('C', 'новація', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('#', 'Розріз відсутній', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/



commit;