

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_VP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_VP ***

  CREATE OR REPLACE TRIGGER BARS.TIU_VP 
  AFTER INSERT OR UPDATE ON "BARS"."VP_LIST"
  DECLARE
    n_ INT;
    ern          CONSTANT POSITIVE := 746;    -- Trigger err code
    err          EXCEPTION;
    erm          VARCHAR2(80);
BEGIN

 SELECT v.acc3801,COUNT(UNIQUE kv) INTO n_,n_
   FROM accounts a,vp_list v
  WHERE a.acc=v.acc3800 GROUP BY v.acc3801
 HAVING COUNT(UNIQUE kv)<>1;

   IF n_ > 1 THEN
      erm := '9417 - More then one currency VP equialent';
      RAISE err;

   END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN;
   WHEN err THEN
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
END tiu_vp;



/
ALTER TRIGGER BARS.TIU_VP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_VP.sql =========*** End *** ====
PROMPT ===================================================================================== 
