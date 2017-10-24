

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_OPERW_SSP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_OPERW_SSP ***

  CREATE OR REPLACE TRIGGER BARS.TI_OPERW_SSP 
  AFTER INSERT ON "BARS"."OPERW"
  REFERENCING FOR EACH ROW
      WHEN (
NEW.TAG='SSP  ' and substr(NEW.VALUE,1,1)='1'
      ) DECLARE
BEGIN
   UPDATE oper
   SET    prty=1
   WHERE  ref=:NEW.REF;
END;


/
ALTER TRIGGER BARS.TI_OPERW_SSP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_OPERW_SSP.sql =========*** End **
PROMPT ===================================================================================== 
