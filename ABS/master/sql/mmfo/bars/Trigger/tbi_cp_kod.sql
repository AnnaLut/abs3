

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CP_KOD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CP_KOD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CP_KOD 
  BEFORE INSERT ON "BARS"."CP_KOD"
  REFERENCING FOR EACH ROW
   WHEN (nvl(NEW.ID,0)=0) DECLARE
  VSEQ NUMBER;
BEGIN
     SELECT  bars_sqnc.get_nextval('S_CP_KOD') INTO VSEQ  FROM DUAL;
     :NEW.ID := VSEQ;
END;
/
ALTER TRIGGER BARS.TBI_CP_KOD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CP_KOD.sql =========*** End *** 
PROMPT ===================================================================================== 
