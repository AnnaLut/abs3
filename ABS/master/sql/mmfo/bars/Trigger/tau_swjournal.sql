

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_SWJOURNAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_SWJOURNAL ***

  CREATE OR REPLACE TRIGGER BARS.TAU_SWJOURNAL 
  AFTER UPDATE OF DATE_PAY ON "BARS"."SW_JOURNAL"
  REFERENCING FOR EACH ROW
  begin

   if (:new.mt=102 and :new.date_pay is not null and :old.date_pay is null) then
       insert into tmp_sw102_ref(swref) values (:new.swref);
   end if;

end;



/
ALTER TRIGGER BARS.TAU_SWJOURNAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_SWJOURNAL.sql =========*** End *
PROMPT ===================================================================================== 
