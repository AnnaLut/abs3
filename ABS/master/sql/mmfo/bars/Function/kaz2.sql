
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kaz2.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KAZ2 (acc_ INTEGER) RETURN DECIMAL IS

ost1_ NUMBER;
ost2_ NUMBER;

BEGIN

  BEGIN
     SELECT ostc INTO ost2_ FROM accounts WHERE ostc<0 AND acc=acc_;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN ost2_ := 0;
  END;

  BEGIN
     SELECT SUM(ostc) INTO ost1_ FROM accounts WHERE ostc>0 AND
      acc IN (SELECT acc FROM perekr_j WHERE accs=acc_);
  EXCEPTION
     WHEN NO_DATA_FOUND THEN ost1_ := 0;
  END;

  IF ost1_+ost2_ > 0 THEN
     RETURN ost1_+ost2_;
  ELSE
     RETURN 0;
  END IF;

END KAZ2;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kaz2.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 