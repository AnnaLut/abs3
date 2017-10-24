

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAPRET810.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ZAPRET810 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ZAPRET810 
   BEFORE INSERT OR UPDATE OF KV
   ON ACCOUNTS
   REFERENCING FOR EACH ROW
DECLARE

    ern          CONSTANT POSITIVE := 746;    -- Trigger err code
    err          EXCEPTION;
    erm          VARCHAR2(80);

BEGIN

   IF ( :new.kv=810 ) THEN
      erm := '9205 - Unsuccessful open account with currency 810';
      RAISE err;
   END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN;
   WHEN err THEN
     raise_application_error(-(20000+ern),'\'||erm,TRUE);

END tiu_zapret810;



/
ALTER TRIGGER BARS.TIU_ZAPRET810 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAPRET810.sql =========*** End *
PROMPT ===================================================================================== 
