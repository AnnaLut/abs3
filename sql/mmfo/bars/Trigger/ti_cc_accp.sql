

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_CC_ACCP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_CC_ACCP ***

  CREATE OR REPLACE TRIGGER BARS.TI_CC_ACCP 
  BEFORE INSERT ON "BARS"."CC_ACCP"
  REFERENCING FOR EACH ROW
BEGIN
  IF :NEW.IDZ IS NULL THEN
     :NEW.IDZ := USER_ID;
  END IF;
END TI_CC_ACCP;


/
ALTER TRIGGER BARS.TI_CC_ACCP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_CC_ACCP.sql =========*** End *** 
PROMPT ===================================================================================== 
