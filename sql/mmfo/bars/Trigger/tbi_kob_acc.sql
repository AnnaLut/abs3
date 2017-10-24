

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_KOB_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_KOB_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TBI_KOB_ACC 
  BEFORE INSERT ON "BARS"."KOB_ACC"
  REFERENCING FOR EACH ROW
  BEGIN
   update accounts set tip='KOB' where acc=:NEW.ACC26;
END tbi_KOB_ACC;



/
ALTER TRIGGER BARS.TBI_KOB_ACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_KOB_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
