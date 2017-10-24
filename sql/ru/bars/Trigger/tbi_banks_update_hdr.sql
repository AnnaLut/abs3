

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BANKS_UPDATE_HDR.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BANKS_UPDATE_HDR ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BANKS_UPDATE_HDR 
BEFORE INSERT  ON banks_update_hdr
FOR EACH ROW
   







DECLARE bars NUMBER;
BEGIN
   IF ( :new.id = 0 ) THEN
       SELECT s_banks_update_hdr.NEXTVAL
       INTO   bars FROM DUAL;
       :new.id := bars;
    END IF;
END;
/
ALTER TRIGGER BARS.TBI_BANKS_UPDATE_HDR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BANKS_UPDATE_HDR.sql =========**
PROMPT ===================================================================================== 
