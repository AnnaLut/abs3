

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCSMSCLEARANSE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ACCSMSCLEARANSE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ACCSMSCLEARANSE 
after insert or update on acc_sms_phones for each row
begin
  if (:new.payforsms = 'Y' and  nvl(:old.payforsms,'N')<>'Y' )  then
  BARS.BARS_SMS_CLEARANCE.set_clearance_acc(:new.acc);
 end if;
end taiu_accsmsclearanse;
/
ALTER TRIGGER BARS.TAIU_ACCSMSCLEARANSE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCSMSCLEARANSE.sql =========**
PROMPT ===================================================================================== 
