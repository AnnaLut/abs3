

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDLEVSMLD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BSCHEDLEVSMLD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BSCHEDLEVSMLD 
before insert ON BARS.B_SCHEDULE_LEVSML_D
for each row
   WHEN (
new.idl is null
      ) begin
    SELECT nvl(max(idl),0)+1
    into   :new.idl
    FROM   b_schedule_levsml_d;
end;


/
ALTER TRIGGER BARS.TBI_BSCHEDLEVSMLD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDLEVSMLD.sql =========*** E
PROMPT ===================================================================================== 
