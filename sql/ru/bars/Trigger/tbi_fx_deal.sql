

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_FX_DEAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_FX_DEAL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_FX_DEAL 
BEFORE INSERT  ON fx_deal
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( :new.deal_tag = 0 ) THEN  SELECT s_fx_deal.NEXTVAL
       INTO   bars FROM DUAL; :new.deal_tag := bars; END IF;
END;
/
ALTER TRIGGER BARS.TBI_FX_DEAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_FX_DEAL.sql =========*** End ***
PROMPT ===================================================================================== 
