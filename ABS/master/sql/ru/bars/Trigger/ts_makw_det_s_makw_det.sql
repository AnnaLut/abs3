

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/ts_MAKW_DET_S_MAKW_DET.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger ts_MAKW_DET_S_MAKW_DET ***

  CREATE OR REPLACE TRIGGER BARS.ts_MAKW_DET_S_MAKW_DET BEFORE INSERT
ON "BARS"."MAKW_DET" FOR EACH ROW
BEGIN
	:new."ID" := "S_MAKW_DET".nextval;
END;
/
ALTER TRIGGER BARS.ts_MAKW_DET_S_MAKW_DET ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/ts_MAKW_DET_S_MAKW_DET.sql =========
PROMPT ===================================================================================== 
