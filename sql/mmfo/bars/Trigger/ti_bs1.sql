

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_BS1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_BS1 ***

  CREATE OR REPLACE TRIGGER BARS.TI_BS1 
  BEFORE INSERT ON "BARS"."BS1"
  REFERENCING FOR EACH ROW
  DECLARE bars NUMBER;
BEGIN
   SELECT S_bs1.NEXTVAL
   INTO   bars FROM DUAL;
   :new.id := bars;
END;



/
ALTER TRIGGER BARS.TI_BS1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_BS1.sql =========*** End *** ====
PROMPT ===================================================================================== 
