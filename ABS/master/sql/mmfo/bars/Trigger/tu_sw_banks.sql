

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_SW_BANKS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_SW_BANKS ***

  CREATE OR REPLACE TRIGGER BARS.TU_SW_BANKS 
  AFTER UPDATE ON "BARS"."SW_BANKS"
  REFERENCING FOR EACH ROW
     WHEN (NEW.NAME<>OLD.NAME or NEW.CITY<>OLD.CITY or NEW.COUNTRY<>OLD.COUNTRY) declare
  id_upd int;

BEGIN
  SELECT S_SW_BANKS_UPD.NEXTVAL into id_upd FROM DUAL;

  INSERT
  INTO SW_BANKS_UPD
    (IDUPD,BIC,NAME,OFFICE,CITY,COUNTRY,CHRSET,TRANSBACK,ACTION,DATUPD)
  VALUES (id_upd,:NEW.BIC,:NEW.NAME,:NEW.OFFICE,:NEW.CITY,:NEW.COUNTRY,
          :NEW.CHRSET,:NEW.TRANSBACK,'U',sysdate);
END;



/
ALTER TRIGGER BARS.TU_SW_BANKS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_SW_BANKS.sql =========*** End ***
PROMPT ===================================================================================== 
