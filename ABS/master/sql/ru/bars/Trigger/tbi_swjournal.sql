

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SWJOURNAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SWJOURNAL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SWJOURNAL 
before insert on sw_journal
for each row
begin

   if (:new.flags = 'L') then

       if (:new.date_out is null) then
           :new.date_out := to_date('01014000', 'ddmmyyyy');
       end if;

   end if;

end;
/
ALTER TRIGGER BARS.TBI_SWJOURNAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SWJOURNAL.sql =========*** End *
PROMPT ===================================================================================== 
