

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_RODOVID.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_RODOVID ***

  CREATE OR REPLACE TRIGGER BARS.TI_RODOVID 
  BEFORE INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
SUBSTR(NEW.fn_a,2,1)='A' AND new.mfoa<>'300465' AND new.mfob=300465
      ) DECLARE
   ern  CONSTANT POSITIVE := 338; -- Trigger err code
   err  EXCEPTION;
   erm  VARCHAR2(80);
BEGIN
   IF ( :NEW.nlsb in ('29093066') and
        :NEW.kv   in ('756',
                      '978',
                      '826',
                      '985',
                      '643',
                      '980',
                      '840',
                      '959'     ) and
        :NEW.dk < 2
      )
   THEN
      erm := '0992 - Недопустимый счет клиента Б';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;
END;


/
ALTER TRIGGER BARS.TI_RODOVID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_RODOVID.sql =========*** End *** 
PROMPT ===================================================================================== 
