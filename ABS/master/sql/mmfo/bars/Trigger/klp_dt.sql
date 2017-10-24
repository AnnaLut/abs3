

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/KLP_DT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger KLP_DT ***

  CREATE OR REPLACE TRIGGER BARS.KLP_DT 
   BEFORE INSERT ON klp
   FOR EACH ROW
BEGIN
   IF (:new.datedokkb is null) THEN
       :new.datedokkb := SYSDATE;
   END IF;
END klp_dt;




/
ALTER TRIGGER BARS.KLP_DT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/KLP_DT.sql =========*** End *** ====
PROMPT ===================================================================================== 
