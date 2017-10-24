

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_SBN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_SBN ***

  CREATE OR REPLACE TRIGGER BARS.TU_SBN 
   BEFORE UPDATE OF OSTC
   ON ACCOUNTS
   REFERENCING FOR EACH ROW
  WHEN (
UPPER(OLD.tip) = 'SBN' AND NEW.ostc>OLD.ostc
      ) DECLARE
 nTmp_ number;
BEGIN
  BEGIN
    select Nvl(sum(decode(dk,1,1,-1)*s) ,0)   into nTmp_
    from opldok where ref=gl.Aref and acc=:OLD.acc;
    If nTmp_<>0 then
       INSERT INTO NLK_REF(acc,ref1) VALUES (:OLD.acc,gl.Aref);
    end if;
  EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
  END;
  Return;
END tu_sbn;



/
ALTER TRIGGER BARS.TU_SBN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_SBN.sql =========*** End *** ====
PROMPT ===================================================================================== 
