

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/tsu_MAKW_DET_S_MAKW_DET.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger tsu_MAKW_DET_S_MAKW_DET ***

  CREATE OR REPLACE TRIGGER BARS.tsu_MAKW_DET_S_MAKW_DET AFTER UPDATE OF "ID"
ON "BARS"."MAKW_DET" FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR(-20010,'Cannot update column "ID" in table "BARS"."MAKW_DET" as it uses sequence.');
END;


/
ALTER TRIGGER BARS.tsu_MAKW_DET_S_MAKW_DET ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/tsu_MAKW_DET_S_MAKW_DET.sql ========
PROMPT ===================================================================================== 
