create or replace trigger tiud_v_corr_acc
  instead of insert or update or delete on bars.v_corr_acc
  for each row
begin
  if inserting then
    insert into bic_acc
      (bic, acc, transit, their_acc)
    values
      (:new.bic, :new.acc, :new.transit_acc, :new.their_acc);
  elsif updating then
    update bic_acc t
       set t.bic       = :new.bic,
           t.acc       = :new.acc,
           t.transit   = :new.transit_acc,
           t.their_acc = :new.their_acc
     where t.bic = :old.bic and t.acc = :old.acc;
  
  elsif deleting then
    delete from bic_acc where acc = :old.acc and bic = :old.bic;
  end if;
end;
/

