

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_SWJOURNAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_SWJOURNAL ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_SWJOURNAL 
  BEFORE INSERT ON "BARS"."SW_JOURNAL"
  REFERENCING FOR EACH ROW
  begin

   if (:new.flags = 'L') then

       if (:new.date_out is null) then
           :new.date_out := to_date('01014000', 'ddmmyyyy');
       end if;

   end if;

end;



/
ALTER TRIGGER BARS.TBIU_SWJOURNAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_SWJOURNAL.sql =========*** End 
PROMPT ===================================================================================== 
