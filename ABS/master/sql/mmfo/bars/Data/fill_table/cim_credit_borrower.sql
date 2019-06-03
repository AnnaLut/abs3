begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('1', 'Банки - фінансови установи та корпорації, що залучають депозити', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('2', 'Підприємство з іноземними інвестиціями, але не дочірне', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('3', 'Інші позичальники', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('4', 'Підприємство, що контролюється іноземним інвестором (дочірне)', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('5', 'Фізична особа - суб''єкт підприємницької діяльності', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('6', 'Фізична особа, яка не зареєстрована як суб''єкт підприємницької діяльності', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('7', 'Орган місцевого самоврядування', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('8', 'Національний банк України (Центральний банк)', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('9', 'Кабінет міністрів України (уряд)', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('A', 'Фінансові установи, корпорації  інщі, що не залучають депозити (небанківські фінустанови)', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('B', 'Неприбуткові організації, що обслуговують домогосподарства', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('#', 'Розріз відсутній', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/


commit;
