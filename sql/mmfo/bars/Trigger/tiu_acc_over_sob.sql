

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_OVER_SOB.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACC_OVER_SOB ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACC_OVER_SOB 
BEFORE UPDATE ON acc_over FOR EACH ROW
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Триггер для модуля овердрафтов. Отслеживание событий.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
BEGIN


 IF round(nvl(:NEW.FLAG,0)/2-0.1)<>round(nvl(:OLD.FLAG,0)/2-0.1) THEN
       if round(:NEW.FLAG/2-0.1)=1 then
         ovr.p_oversob ( :new.acc_9129,:new.nd,null,11,null,null);
    else
         ovr.p_oversob ( :new.acc_9129,:new.nd,null,12,null,null);
    end if;
   end if;

END tiu_acc_over_sob;




/
ALTER TRIGGER BARS.TIU_ACC_OVER_SOB DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_OVER_SOB.sql =========*** En
PROMPT ===================================================================================== 
