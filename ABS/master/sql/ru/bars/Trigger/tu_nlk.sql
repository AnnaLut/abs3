

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_NLK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_NLK ***

  CREATE OR REPLACE TRIGGER BARS.TU_NLK 
   BEFORE UPDATE OF ostc ON accounts FOR EACH ROW
 WHEN (
old.tip like 'NL_' AND NEW.ostc > OLD.ostc AND NEW.pap = 2
      ) DECLARE
  nTmp_ number;
BEGIN
  --Сумма Баланса
  select Nvl(sum(decode(dk,1,1,-1)*s) ,0)   into nTmp_  from opldok
  where ref=gl.Aref and acc=:OLD.acc;

  If nTmp_<>0 then
     BEGIN
       INSERT INTO nlk_ref (acc, ref1, kf, amount) VALUES (:OLD.acc, gl.Aref, :OLD.kf, nTmp_);
     EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
     END;
  end if;

  Return;

END tu_nlk;
/
ALTER TRIGGER BARS.TU_NLK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_NLK.sql =========*** End *** ====
PROMPT ===================================================================================== 
