begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(1, 'Розрахунки за кредитом остаточно завершенi вiдповiдно до графiка погашення заборгованостi', to_date('04012008','DDMMYYYY'), to_date('31102016','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(1, 'Розрахунки за кредитом завершено', to_date('01112016','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(2, 'Розрахунки за кредитом не завершено', to_date('04012008','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(3, 'Кредит не отримано, строк дiї реїстрацiї договору не закiнчився', to_date('04012008','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(4, 'Розрахунки за кредитом остаточно та достроково завершенi', to_date('01062009','DDMMYYYY'), to_date('31102016','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(4, 'Розрахунки за кредитом завершено достроково', to_date('01112016','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(5, 'Кредит неотриманий,строк дії реїстрації договору закінчився', to_date('01082012','DDMMYYYY'), to_date('31012013','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(5, 'Cтрок дії реїстрації договору закінчився', to_date('01022013','DDMMYYYY'), to_date('30092013','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(5, 'Cтрок дў• реїстрацў• договору закўнчився, у тому числў анулювання реїстрацўйного свўдоцтва', to_date('01102013','DDMMYYYY'), to_date('31102016','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(5, 'Cтрок дў• договору закўнчився, у тому числў анулювання реїстрацўйного свўдоцтва', to_date('01112016','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/


commit;

