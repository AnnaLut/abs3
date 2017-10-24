

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_OPER_SOS_RKO.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_OPER_SOS_RKO ***

  CREATE OR REPLACE TRIGGER BARS.TIU_OPER_SOS_RKO 
AFTER UPDATE OF SOS ON BARS.OPER FOR EACH ROW
    WHEN (
old.tt='RKO' and new.sos<0 and SUBSTR(old.nlsb,1,4)='6110'
      ) DECLARE
acc_ NUMBER := NULL;
BEGIN
   BEGIN
      SELECT acc INTO acc_ FROM accounts WHERE nls=:OLD.nlsa AND kv=:OLD.kv;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN NULL;
   END;
   IF acc_ IS NOT NULL THEN
      UPDATE rko_lst SET s0=s0+:OLD.s WHERE
      ACC=acc_  OR  ACC1=acc_  OR  nvl(ACCD,ACC)=acc_;
   END IF;
END;



/
ALTER TRIGGER BARS.TIU_OPER_SOS_RKO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_OPER_SOS_RKO.sql =========*** En
PROMPT ===================================================================================== 
