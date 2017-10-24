

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_REP_PROC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_REP_PROC ***

  CREATE OR REPLACE TRIGGER BARS.TBI_REP_PROC 
  BEFORE INSERT ON "BARS"."REP_PROC"
  REFERENCING FOR EACH ROW
  DECLARE bars NUMBER;
BEGIN
   IF ( :new.procc = 0 ) THEN
       SELECT s_rep_proc.NEXTVAL
       INTO   bars FROM DUAL;
       :new.procc := bars;
    END IF;
END;



/
ALTER TRIGGER BARS.TBI_REP_PROC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_REP_PROC.sql =========*** End **
PROMPT ===================================================================================== 
