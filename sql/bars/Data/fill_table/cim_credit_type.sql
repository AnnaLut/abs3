begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(0, 'Кредит, залучений КМ Укра•ни або гарантований до повернення державою', to_date('01062009','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(1, 'Кредит, що рефiнансуїться за рахунок випуску боргових цiнних паперiв на мiжнар.та iноземн.фонд.ринках', to_date('01072006','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(1, 'Кредит, що рефiнансуїться за рахунок випуску боргових цiнних паперiв (їврооблўгацўй)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(2, 'Кредит, що залучаїться на умовах субординованого боргу', to_date('01072006','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(2, 'Кредит, залучений на умовах субординованого боргу (крўм субординованих їврооблўгацўй)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(3, 'Синдикований кредит', to_date('01072006','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(4, 'Будь-який iнший кредит, що не маї ознак кредитiв, позначених кодами 1-3', to_date('01072006','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(4, 'Будь-який iнший негарантований кредит', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/


commit;
