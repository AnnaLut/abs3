

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_KV_MFO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_KV_MFO ***

  CREATE OR REPLACE TRIGGER BARS.TI_KV_MFO 
  BEFORE INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
NEW.kv<>980
      ) DECLARE
   ern  CONSTANT POSITIVE := 338; -- Trigger err code
   err  EXCEPTION;
   erm  VARCHAR2(80);
   kod_ NUMBER;
BEGIN

   SELECT  kodn INTO kod_ FROM banks
    WHERE  kodn IN (2,6) AND mfop = gl.aMFO AND
         ( mfo = :NEW.mfob OR
           mfo = (SELECT mfop FROM banks WHERE mfop <> gl.aMFO AND mfo=:NEW.mfob));

EXCEPTION
WHEN NO_DATA_FOUND THEN
   erm := '0919 - Банк Б не работает с указанной валютой';
   raise_application_error(-(20000+ern),'\'||erm,TRUE);
END;


/
ALTER TRIGGER BARS.TI_KV_MFO DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_KV_MFO.sql =========*** End *** =
PROMPT ===================================================================================== 
