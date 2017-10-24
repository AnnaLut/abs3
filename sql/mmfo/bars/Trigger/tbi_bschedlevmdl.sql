

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDLEVMDL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BSCHEDLEVMDL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BSCHEDLEVMDL 
before insert on b_schedule_levmdl
for each row    WHEN (new.idl is null) begin
    SELECT nvl(max(idl),0)+1
    into   :new.idl
    FROM   b_schedule_levmdl;
end;


/
ALTER TRIGGER BARS.TBI_BSCHEDLEVMDL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDLEVMDL.sql =========*** En
PROMPT ===================================================================================== 
