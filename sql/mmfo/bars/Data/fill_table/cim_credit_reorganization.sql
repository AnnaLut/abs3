begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('0', 'Без реорганізації', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('1', 'Реорганіз-но шляхом збільшення частки крудитора в статутному капіталі', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('2', 'Реорганізовано шляхом прощення боргу', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('3', 'Реорганізовано шляхом взаїмозаліку', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('4', 'Реорганізовано шляхом зміни графіка погашення', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('5', 'Реорганізовано шляхом рефінансування боргу', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('6', 'Реорг-но шляхом визнання гарантом обовязків з погаше-я боргового зобов', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('7', 'Реорганізовано шляхом конверсії боргу', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('#', 'Розріз відсутній', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/



commit;

