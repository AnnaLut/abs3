

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SOS_SSD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_SOS_SSD ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_SOS_SSD 
   BEFORE UPDATE OF sos ON BARS.OPER
FOR EACH ROW
    WHEN (
OLD.sos>0 AND
      NEW.sos<0 AND
      OLD.TT ='SSD'
      -- условие на счета снимаем
      --and OLD.nlsb like '2906%' and OLD.nlsa like '2906%'
      ) declare
-- Автоматическая реакция депозитария (ОТКАТ) на снятие с визы (или БЭК) в ГРЦ
begin

  execute immediate 'begin ussr_payoff.repair_after_debit@depdb(:p_ref); end;'
  using :old.ref;

end tu_oper_sos_ssd;


/
ALTER TRIGGER BARS.TU_OPER_SOS_SSD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SOS_SSD.sql =========*** End
PROMPT ===================================================================================== 
