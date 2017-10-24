

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_TOP_CONTRACTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_TOP_CONTRACTS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_TOP_CONTRACTS 
BEFORE INSERT  ON TOP_CONTRACTS
FOR EACH ROW
DECLARE
  bars NUMBER;
BEGIN
   :NEW.dat:=gl.bdate;
   IF ( :NEW.pid = 0 OR :NEW.pid IS NULL) THEN
       SELECT s_top_contracts.NEXTVAL INTO  bars FROM DUAL;
       :NEW.pid := bars;
   END IF;
--   IF  :new.control_days IS NULL THEN
--       :new.control_days := 90;
--   END IF;
   IF  :NEW.id_oper IS NULL THEN
       :NEW.id_oper := 1;
   END IF;
END;
/
ALTER TRIGGER BARS.TBI_TOP_CONTRACTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_TOP_CONTRACTS.sql =========*** E
PROMPT ===================================================================================== 
