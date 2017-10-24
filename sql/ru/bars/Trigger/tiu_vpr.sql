

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_VPR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_VPR ***

  CREATE OR REPLACE TRIGGER BARS.TIU_VPR 
AFTER INSERT OR UPDATE ON vp_list
  FOR EACH ROW
-- VER @(#) tiu_vpr.sql 5.2  14/05/2003

DECLARE
    n_ INT;
    ern          CONSTANT POSITIVE := 746;    -- Trigger err code
    err          EXCEPTION;
    erm          VARCHAR2(80);
BEGIN

   SELECT kv INTO n_ FROM accounts WHERE acc = :NEW.acc3800;

   IF n_ = gl.BaseVal THEN
      erm := '9415 - Not foreign currency VP account';
      RAISE err;
   END IF;

   SELECT kv INTO n_ FROM accounts WHERE acc = :NEW.acc3801;

   IF n_ <> gl.BaseVal THEN
      erm := '9416 - Not base currency EQV VP account';
      RAISE err;
   END IF;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
      erm := '9414 - No VP or EqvVP account found';
      RAISE err;
   WHEN err THEN
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
END tiu_vpr;
/
ALTER TRIGGER BARS.TIU_VPR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_VPR.sql =========*** End *** ===
PROMPT ===================================================================================== 
