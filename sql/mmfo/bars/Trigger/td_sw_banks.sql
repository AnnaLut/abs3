

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_SW_BANKS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_SW_BANKS ***

  CREATE OR REPLACE TRIGGER BARS.TD_SW_BANKS 
  AFTER DELETE ON "BARS"."SW_BANKS"
  REFERENCING FOR EACH ROW
  declare
  id_upd int;

BEGIN
  SELECT S_SW_BANKS_UPD.NEXTVAL into id_upd FROM DUAL;

  INSERT
  INTO SW_BANKS_UPD
    (IDUPD,BIC,NAME,OFFICE,CITY,COUNTRY,CHRSET,TRANSBACK,ACTION,DATUPD)
  VALUES (id_upd,:OLD.BIC,:OLD.NAME,:OLD.OFFICE,:OLD.CITY,:OLD.COUNTRY,
          :OLD.CHRSET,:OLD.TRANSBACK,'D',sysdate);
END td_sw_banks;



/
ALTER TRIGGER BARS.TD_SW_BANKS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_SW_BANKS.sql =========*** End ***
PROMPT ===================================================================================== 
