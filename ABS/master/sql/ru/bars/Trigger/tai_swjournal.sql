

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_SWJOURNAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_SWJOURNAL ***

  CREATE OR REPLACE TRIGGER BARS.TAI_SWJOURNAL 
after insert on sw_journal
for each row
begin

   if (:new.flags = 'L') then

       insert into sw_procque (swref)
       values (:new.swref);

   end if;

end;
/
ALTER TRIGGER BARS.TAI_SWJOURNAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_SWJOURNAL.sql =========*** End *
PROMPT ===================================================================================== 
