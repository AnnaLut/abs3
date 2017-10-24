
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kaz1.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KAZ1 (acc_ INTEGER) RETURN DECIMAL IS

ost1_ NUMBER;
pap_  NUMBER;
nbs_  VARCHAR2(4);
BEGIN

  BEGIN
     SELECT ost,nbs INTO ost1_,nbs_ FROM sal WHERE acc=acc_ and fdat=bankdate;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN RETURN 0;
  END;

  BEGIN
     SELECT pap INTO pap_ FROM ps WHERE nbs=nbs_;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN RETURN 0;
  END;

  IF (pap_=1 AND ost1_<0) OR
     (pap_=2 AND ost1_>0) OR
	  pap_=3 THEN
     RETURN ost1_;
--  ELSIF pap_=2 AND ost1_>0 THEN
--     RETURN ost1_;
  ELSE
     RETURN 0;
  END IF;

END KAZ1;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kaz1.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 