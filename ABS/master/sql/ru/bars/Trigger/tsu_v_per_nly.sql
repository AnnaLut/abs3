

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TSU_V_PER_NLY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TSU_V_PER_NLY ***

  CREATE OR REPLACE TRIGGER BARS.TSU_V_PER_NLY 
INSTEAD OF DELETE ON BARS.v_per_nly FOR EACH ROW
DECLARE
  sos_ NUMBER;
BEGIN
delete nlk_ref nn WHERE ref1=:OLD.ref AND (ref2 is null or exists (select 1 from oper where ref = nn.REF2 and sos < 0)) and acc = :OLD.acc;
    IF SQL%ROWCOUNT=0 THEN
      raise_application_error(-(20000+999),'Увага!!! Документ вже був оплачений, обновіть екрану форму ',TRUE);
	  else
	  bars_audit.info(' Вилучено документ з картотеки  - ref: '||:OLD.ref );
   END IF;

END;
/
ALTER TRIGGER BARS.TSU_V_PER_NLY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TSU_V_PER_NLY.sql =========*** End *
PROMPT ===================================================================================== 
