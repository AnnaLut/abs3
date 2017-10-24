

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_SW_BANKS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_SW_BANKS ***

  CREATE OR REPLACE TRIGGER BARS.TI_SW_BANKS 
  AFTER INSERT ON "BARS"."SW_BANKS"
  REFERENCING FOR EACH ROW
  declare
  id_upd int;

BEGIN
  SELECT S_SW_BANKS_UPD.NEXTVAL into id_upd FROM DUAL;

  INSERT
  INTO SW_BANKS_UPD
    (IDUPD,BIC,NAME,OFFICE,CITY,COUNTRY,CHRSET,TRANSBACK,ACTION,DATUPD)
  VALUES (id_upd,:NEW.BIC,:NEW.NAME,:NEW.OFFICE,:NEW.CITY,:NEW.COUNTRY,
          :NEW.CHRSET,:NEW.TRANSBACK,'I',sysdate);
END;



/
ALTER TRIGGER BARS.TI_SW_BANKS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_SW_BANKS.sql =========*** End ***
PROMPT ===================================================================================== 
