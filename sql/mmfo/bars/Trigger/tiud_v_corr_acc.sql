

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_CORR_ACC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_V_CORR_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_V_CORR_ACC 
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
ALTER TRIGGER BARS.TIUD_V_CORR_ACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_CORR_ACC.sql =========*** End
PROMPT ===================================================================================== 
