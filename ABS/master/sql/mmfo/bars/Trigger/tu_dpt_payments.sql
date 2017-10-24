

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_DPT_PAYMENTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_DPT_PAYMENTS ***

  CREATE OR REPLACE TRIGGER BARS.TU_DPT_PAYMENTS 
   BEFORE UPDATE OF ostb, ostc, ostf
   ON accounts
   FOR EACH ROW
     WHEN (    (old.tip = 'DEP')
         AND (   new.ostb != old.ostb
              OR new.ostc != old.ostc
              OR new.ostf != old.ostf)) DECLARE
   l_dptid   dpt_payments.dpt_id%TYPE;
   l_ref     dpt_payments.REF%TYPE;
   l_kf      dpt_payments.kf%TYPE := gl.kf;
BEGIN
   IF (gl.aref IS NULL)
   THEN
      RETURN;
   END IF;

   SELECT deposit_id
     INTO l_dptid
     FROM dpt_deposit
    WHERE acc = :new.acc;

   BEGIN
      INSERT INTO dpt_payments (dpt_id, REF, kf)
           VALUES (l_dptid, gl.aref, l_kf);
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         NULL;
   END;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
END tu_dpt_payments;



/
ALTER TRIGGER BARS.TU_DPT_PAYMENTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_DPT_PAYMENTS.sql =========*** End
PROMPT ===================================================================================== 
