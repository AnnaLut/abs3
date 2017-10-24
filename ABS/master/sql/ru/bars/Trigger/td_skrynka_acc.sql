

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_SKRYNKA_ACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_SKRYNKA_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TD_SKRYNKA_ACC 
   after delete
   ON skrynka_acc
   FOR EACH ROW
DECLARE
BEGIN
   insert into skrynka_acc_arc(acc, n_sk, tip)
   values (:OLD.acc, :OLD.n_sk, :OLD.tip);
END;
/
ALTER TRIGGER BARS.TD_SKRYNKA_ACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_SKRYNKA_ACC.sql =========*** End 
PROMPT ===================================================================================== 
