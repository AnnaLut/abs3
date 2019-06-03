begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('1', 'фінансування будівництва, реконструкції, капітального ремонту, придбання об’єктів нерухомості', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('2', 'фінансування інвестицій у нематеріальні активи', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('3', 'надання споживчих кредитів', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('4', 'надання кредитів на підприємницьку, господарську діяльність, у тому числі факторинг, лізинг', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('5', 'рефінансування кредитної заборгованості', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('6', 'підтримання ліквідності', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('7', 'придбання цінних паперів', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('8', 'фінансування формування запасів', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('9', 'фінансування інших виробничих витрат, оплата послуг', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('10', 'інше', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/


begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('11', 'експортний кредит', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('12', 'націоналізація', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('#', 'Розріз відсутній', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
commit;

