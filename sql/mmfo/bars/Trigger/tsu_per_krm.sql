

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TSU_PER_KRM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TSU_PER_KRM ***

  CREATE OR REPLACE TRIGGER BARS.TSU_PER_KRM 
INSTEAD OF UPDATE OR DELETE ON per_krm
FOR EACH ROW
DECLARE
  sos_ NUMBER;
BEGIN
   UPDATE nlk_ref SET ref2=:NEW.ref WHERE ref1=:OLD.ref;
   --IF SQL%ROWCOUNT=0 THEN
   --   INSERT INTO per_que (ref,refx) VALUES (:OLD.ref,:NEW.ref);
   --END IF;
END;


/
ALTER TRIGGER BARS.TSU_PER_KRM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TSU_PER_KRM.sql =========*** End ***
PROMPT ===================================================================================== 
