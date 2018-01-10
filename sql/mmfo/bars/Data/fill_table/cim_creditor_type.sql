begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(1, 'Iнший банк або фiнансова   установа', to_date('01042002','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(1, 'Iнший банк', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(2, 'Iноземна материнська       компанiя', to_date('01042002','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(3, 'Офiцiйний кредитор', to_date('01042002','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(3, 'Ўноземний уряд або державна установа', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(4, 'Iнший приватний кредитор', to_date('01042002','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(5, 'Iнший прямий iнвестор', to_date('01042002','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(6, 'Материнський банк', to_date('01062009','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(7, 'Iнша, небанкўвська, фўнансова установа', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(8, 'Мўжнародна фўнансова органўзацўя', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/


commit;
