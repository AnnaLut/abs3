

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDSUBDIV.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BSCHEDSUBDIV ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BSCHEDSUBDIV 
before insert ON BARS.B_SCHEDULE_SUBDIVISION
for each row
   WHEN (
new.idd is null
      ) begin
    SELECT nvl(max(idd),0)+1
    into   :new.idd
    FROM   b_schedule_subdivision;
end;


/
ALTER TRIGGER BARS.TBI_BSCHEDSUBDIV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDSUBDIV.sql =========*** En
PROMPT ===================================================================================== 
