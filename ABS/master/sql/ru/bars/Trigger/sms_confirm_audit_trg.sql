

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/SMS_CONFIRM_AUDIT_TRG.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger SMS_CONFIRM_AUDIT_TRG ***

  CREATE OR REPLACE TRIGGER BARS.SMS_CONFIRM_AUDIT_TRG 
   BEFORE INSERT
   ON SMS_CONFIRM_AUDIT
   REFERENCING NEW AS New OLD AS Old
   FOR EACH ROW
BEGIN
   :new.ID := SMS_CONFIRM_AUDIT_SEQ.NEXTVAL;
END SMS_CONFIRM_AUDIT_TRG;
/
ALTER TRIGGER BARS.SMS_CONFIRM_AUDIT_TRG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/SMS_CONFIRM_AUDIT_TRG.sql =========*
PROMPT ===================================================================================== 
