

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_RNK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ACCOUNTS_RNK ***

  CREATE OR REPLACE TRIGGER BARS.TU_ACCOUNTS_RNK 
BEFORE UPDATE OF RNK ON accounts
FOR EACH ROW
BEGIN

-- Для случаев перерегистрации счета 8999 необходимо перерегистрировать и кредит
-- иначе он исчезнет из КП

if :NEW.tip='LIM' then
   Update cc_deal d
      set d.rnk=:NEW.RNK
      where d.nd = (select n.nd from nd_acc n where n.acc=:NEW.acc);
end if;

END TU_ACCOUNTS_RNK;
/
ALTER TRIGGER BARS.TU_ACCOUNTS_RNK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_RNK.sql =========*** End
PROMPT ===================================================================================== 
