

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/tsu_MAKW_GRP_S_MAKW_GRP.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger tsu_MAKW_GRP_S_MAKW_GRP ***

  CREATE OR REPLACE TRIGGER BARS.tsu_MAKW_GRP_S_MAKW_GRP AFTER UPDATE OF "GRP"
ON "BARS"."MAKW_GRP" FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR(-20010,'Cannot update column "GRP" in table "BARS"."MAKW_GRP" as it uses sequence.');
END;


/
ALTER TRIGGER BARS.tsu_MAKW_GRP_S_MAKW_GRP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/tsu_MAKW_GRP_S_MAKW_GRP.sql ========
PROMPT ===================================================================================== 
