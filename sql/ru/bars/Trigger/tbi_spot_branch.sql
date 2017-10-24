

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SPOT_BRANCH.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SPOT_BRANCH ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SPOT_BRANCH 
BEFORE INSERT ON SPOT
FOR EACH ROW
BEGIN

  SELECT BRANCH INTO :NEW.BRANCH FROM ACCOUNTS WHERE acc = :NEW.acc;

END tbi_SPOT_branch;
/
ALTER TRIGGER BARS.TBI_SPOT_BRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SPOT_BRANCH.sql =========*** End
PROMPT ===================================================================================== 
