

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_TIER.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_TIER ***

  CREATE OR REPLACE TRIGGER BARS.TIU_TIER 
  AFTER INSERT OR UPDATE ON "BARS"."BR_TIER_EDIT"
  DECLARE
    n_ INT;
    ern          CONSTANT POSITIVE := 746;    -- Trigger err code
    err          EXCEPTION;
    erm          VARCHAR2(80);
BEGIN

SELECT t.br_id,COUNT(UNIQUE t.kv) INTO n_,n_
  FROM br_tier t, brates b
 WHERE b.br_type IN (5,6) AND b.br_id=t.br_id
 GROUP BY t.br_id
HAVING COUNT(UNIQUE t.kv)>1;

   IF n_ > 1 THEN
      erm := '9420 - No more then one currency for the scale alowed';
      RAISE err;

   END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN;
   WHEN err THEN
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
END tiu_tier;



/
ALTER TRIGGER BARS.TIU_TIER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_TIER.sql =========*** End *** ==
PROMPT ===================================================================================== 
