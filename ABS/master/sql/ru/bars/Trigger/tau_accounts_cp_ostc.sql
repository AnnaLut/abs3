

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_CP_OSTC.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_CP_OSTC ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_CP_OSTC 
AFTER UPDATE OF ostc ON accounts FOR EACH ROW
 WHEN (new.nbs is null and old.ostc=0 and old.ostc<>new.ostc) declare
fl int;

BEGIN
 select count(*) into fl  from cp_deal where acc=:new.acc;

 if fl<>0 then

    update CP_DEAL set active=1 where acc=:new.acc and nvl(active,0)=0;

 end if;

END TAU_ACCOUNTS_CP_OSTC;
/
ALTER TRIGGER BARS.TAU_ACCOUNTS_CP_OSTC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_CP_OSTC.sql =========**
PROMPT ===================================================================================== 
