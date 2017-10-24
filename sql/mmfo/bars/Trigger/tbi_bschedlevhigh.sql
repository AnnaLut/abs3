

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDLEVHIGH.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BSCHEDLEVHIGH ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BSCHEDLEVHIGH 
before insert on b_schedule_levhigh
for each row    WHEN (new.idl is null) begin
    SELECT nvl(max(idl),0)+1
    into   :new.idl
    FROM   b_schedule_levhigh;
end;


/
ALTER TRIGGER BARS.TBI_BSCHEDLEVHIGH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BSCHEDLEVHIGH.sql =========*** E
PROMPT ===================================================================================== 
