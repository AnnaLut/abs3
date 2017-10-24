

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_TIPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_TIPS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_TIPS 
  BEFORE INSERT OR UPDATE ON "BARS"."TIPS"
  REFERENCING FOR EACH ROW
     WHEN ( SUBSTR(NEW.TIP,1,2)='PK') DECLARE
  ern          CONSTANT POSITIVE := 302;    -- Trigger err code
  err          EXCEPTION;
  erm          VARCHAR2(80);
BEGIN
  --Õ≈À‹«ﬂ ¬—“¿¬Àﬂ“‹ “»œ€ Õ¿◊»Õ¿ﬁŸ»≈—ﬂ Õ¿ PK
  --“»œ€ PK* «¿¡»“€ œŒƒ œÀ¿—“» Œ¬€≈  ¿–“Œ◊ »
  erm := '8302 - Type PK* reserved for cards only';
  raise_application_error(-(20000+ern),'\'||erm,TRUE);
END tiu_tips;



/
ALTER TRIGGER BARS.TIU_TIPS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_TIPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
