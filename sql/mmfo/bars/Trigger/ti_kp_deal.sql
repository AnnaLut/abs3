

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_KP_DEAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_KP_DEAL ***

  CREATE OR REPLACE TRIGGER BARS.TI_KP_DEAL 
BEFORE INSERT  ON KP_DEAL
 FOR EACH ROW
BEGIN
 If Nvl(:NEW.ND,0) =0 then
    SELECT bars_sqnc.get_nextval('S_CC_DEAL') into :NEW.ND FROM dual ;
 end if;
END ti_KP_deal;




/
ALTER TRIGGER BARS.TI_KP_DEAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_KP_DEAL.sql =========*** End *** 
PROMPT ===================================================================================== 
