

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_STAFFDISABLE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_STAFFDISABLE ***

  CREATE OR REPLACE TRIGGER BARS.TU_STAFFDISABLE 
after update of disable on staff$base
for each row
begin
      update web_usermap set BLOCKED = :new.disable where DBUSER = :new.logname;
end TU_STAFFDISABLE;
/
ALTER TRIGGER BARS.TU_STAFFDISABLE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_STAFFDISABLE.sql =========*** End
PROMPT ===================================================================================== 
