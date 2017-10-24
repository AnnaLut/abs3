

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_SWOPERW_TAG57.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_SWOPERW_TAG57 ***

  CREATE OR REPLACE TRIGGER BARS.TI_SWOPERW_TAG57 
  AFTER INSERT ON "BARS"."SW_OPERW"
  REFERENCING FOR EACH ROW
  DECLARE
    SWREF_ NUMBER;
BEGIN
    IF :NEW.TAG = '57' THEN
	SWREF_ := :NEW.SWREF;
	UPDATE SW_JOURNAL SET TRANSIT=:NEW.VALUE WHERE SWREF=SWREF_;
    END IF;
END;



/
ALTER TRIGGER BARS.TI_SWOPERW_TAG57 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_SWOPERW_TAG57.sql =========*** En
PROMPT ===================================================================================== 
