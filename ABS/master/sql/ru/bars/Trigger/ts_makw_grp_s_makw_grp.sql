

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/ts_MAKW_GRP_S_MAKW_GRP.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger ts_MAKW_GRP_S_MAKW_GRP ***

  CREATE OR REPLACE TRIGGER BARS.ts_MAKW_GRP_S_MAKW_GRP BEFORE INSERT
ON "BARS"."MAKW_GRP" FOR EACH ROW
BEGIN
	:new."GRP" := "S_MAKW_GRP".nextval;
END;
/
ALTER TRIGGER BARS.ts_MAKW_GRP_S_MAKW_GRP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/ts_MAKW_GRP_S_MAKW_GRP.sql =========
PROMPT ===================================================================================== 
