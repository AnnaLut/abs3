update cim_credit_f503_purpose set name = 'інші цілі' where id = 10;
/
begin
  begin insert into cim_credit_f503_purpose(id, name) values(11, 'експортний кредит'); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name) values(12, 'націоналізація'); exception when dup_val_on_index then null; end;
end;
/
commit;

