

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDLEVSMLS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BSCHEDLEVSMLS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BSCHEDLEVSMLS 
before insert ON BARS.B_SCHEDULE_LEVSML_S
for each row
   WHEN (
new.idl is null
      ) begin
    SELECT nvl(max(idl),0)+1
    into   :new.idl
    FROM   b_schedule_levsml_s;
end;


/
ALTER TRIGGER BARS.TBI_BSCHEDLEVSMLS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDLEVSMLS.sql =========*** E
PROMPT ===================================================================================== 
