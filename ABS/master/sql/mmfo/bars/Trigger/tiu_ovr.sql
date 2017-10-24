

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_OVR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_OVR ***

  CREATE OR REPLACE TRIGGER BARS.TIU_OVR 
AFTER INSERT OR UPDATE ON acc_over
-- VER @(#) tiu_ovr.sql 5.2  14/05/2003
DECLARE
  n_ INT;
    ern          CONSTANT POSITIVE := 746;    -- Trigger err code
    err          EXCEPTION;
    erm          VARCHAR2(80);
BEGIN

 SELECT COUNT(*) INTO n_
   FROM accounts a,accounts b,acc_over o
  WHERE a.acc=o.acc AND b.acc=o.acco AND a.kv<>b.kv;

   IF n_ > 0 THEN
      erm := '9418 - Not the same currency';
      RAISE err;

   END IF;


EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN;
   WHEN err THEN
        raise_application_error(-(20000+ern),'\'||erm,TRUE);


END tiu_ovr;




/
ALTER TRIGGER BARS.TIU_OVR DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_OVR.sql =========*** End *** ===
PROMPT ===================================================================================== 
