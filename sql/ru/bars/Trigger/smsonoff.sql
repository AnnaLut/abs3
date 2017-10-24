

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/SMSONOFF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger SMSONOFF ***

  CREATE OR REPLACE TRIGGER BARS.SMSONOFF 
   INSTEAD OF UPDATE
   ON V_SMS_CONFIRM_ADM
   REFERENCING NEW AS New OLD AS Old
   FOR EACH ROW
 CALL kl_sms_on_off (:new.VALUE)
/
ALTER TRIGGER BARS.SMSONOFF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/SMSONOFF.sql =========*** End *** ==
PROMPT ===================================================================================== 
