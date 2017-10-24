

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_CALDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_CALDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_CALDATE 
after update of sos ON BARS.OPER
for each row
    WHEN (
old.sos != 5 and new.sos=5
      ) begin
    if (trunc(sysdate) < gl.bdate) then
        begin
          insert into oper_ext(ref, kf, pay_bankdate, pay_caldate)
          values (:new.ref, :new.kf, gl.bdate, sysdate);
        exception
          when dup_val_on_index then null; -- спецоплата в налоговом учете
        end;
    end if;
end tau_oper_caldate;


/
ALTER TRIGGER BARS.TAU_OPER_CALDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_CALDATE.sql =========*** En
PROMPT ===================================================================================== 
