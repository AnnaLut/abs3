

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CP_RYN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CP_RYN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CP_RYN 
  BEFORE INSERT ON "BARS"."CP_RYN"
  REFERENCING FOR EACH ROW
   WHEN (nvl(NEW.RYN,0)=0) DECLARE
  VSEQ NUMBER;
BEGIN
     SELECT  bars_sqnc.get_nextval('S_CP_RYN') INTO VSEQ  FROM DUAL;
     :NEW.RYN := VSEQ;
END;
/
ALTER TRIGGER BARS.TBI_CP_RYN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CP_RYN.sql =========*** End *** 
PROMPT ===================================================================================== 
