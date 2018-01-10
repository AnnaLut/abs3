begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(0, 'Без реорганізації', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(1, 'Реорганіз-но шляхом збільшення частки крудитора в статутному капіталі', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(2, 'Реорганізовано шляхом прощення боргу', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(3, 'Реорганізовано шляхом взаїмозаліку', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(4, 'Реорганізовано шляхом зміни графіка погашення', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(5, 'Реорганізовано шляхом рефінансування боргу', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(6, 'Реорг-но шляхом визнання гарантом обовязків з погаше-я боргового зобов', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(7, 'Реорганізовано шляхом конверсії боргу', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/



commit;

