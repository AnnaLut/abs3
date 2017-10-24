

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPER ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPER 
  BEFORE INSERT ON "BARS"."OPER"
  REFERENCING FOR EACH ROW
BEGIN
   IF :NEW.tobo IS NULL THEN
      :NEW.tobo := tobopack.gettobo;
   END IF;
END;


/
ALTER TRIGGER BARS.TBI_OPER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER.sql =========*** End *** ==
PROMPT ===================================================================================== 
