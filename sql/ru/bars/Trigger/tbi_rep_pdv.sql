

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_REP_PDV.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_REP_PDV ***

  CREATE OR REPLACE TRIGGER BARS.TBI_REP_PDV 
BEFORE INSERT  ON rep_pdv
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( :new.id = 0 or :new.id is null) THEN
       SELECT S_rep_pdv.NEXTVAL
       INTO   bars FROM DUAL;
       :new.id := bars;
    END IF;
END;
/
ALTER TRIGGER BARS.TBI_REP_PDV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_REP_PDV.sql =========*** End ***
PROMPT ===================================================================================== 
