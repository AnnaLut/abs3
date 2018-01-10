begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(1, 'Банк', to_date('01042003','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(1, 'Банк-фўн.установи та корпорацў•,що залучають депозити', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(2, 'Пiдприїмство з iноземними iнвестицiями,але не дочiрнї', to_date('01042003','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(3, 'Iншi позичальники', to_date('01042003','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(4, 'Пiдприїмство,що контрол-ся iноземн.iнвестором(дочiрнї)', to_date('01042003','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(5, 'Фiзична особа - суб''їкт пiдприїмницько• дiяльностi', to_date('01042003','DDMMYYYY'), to_date('01102005','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(6, 'Фiз.особа,яка не зареїстр-на як суб''їкт пiдпр.дўяль-тi', to_date('01102005','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(7, 'Орган мiсцевого самоврядування', to_date('01032006','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(8, 'Нацўональний банк Укра•ни (центральний банк)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(9, 'Кабўнет мўнўстрўв Укра•ни (уряд)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(10, 'Фўн.уст.,корп-цў• ўн.,що не залучають депозити(НФУ)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(11, 'Неприбутковў орг-цў•,що обслуговують домогоспод-ва', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/


commit;
