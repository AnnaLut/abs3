

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_RNK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ACCOUNTS_RNK ***

  CREATE OR REPLACE TRIGGER BARS.TU_ACCOUNTS_RNK 
   BEFORE UPDATE OF RNK
   ON accounts
   FOR EACH ROW
BEGIN
   -- Для случаев перерегистрации счета 8999 необходимо перерегистрировать и кредит
   -- иначе он исчезнет из КП

   IF :NEW.tip = 'LIM'
   THEN
      UPDATE cc_deal d
         SET d.rnk = :NEW.RNK
       WHERE d.nd = (SELECT n.nd
                       FROM nd_acc n
                      WHERE n.acc = :NEW.acc);
   END IF;
END TU_ACCOUNTS_RNK;



/
ALTER TRIGGER BARS.TU_ACCOUNTS_RNK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_RNK.sql =========*** End
PROMPT ===================================================================================== 
