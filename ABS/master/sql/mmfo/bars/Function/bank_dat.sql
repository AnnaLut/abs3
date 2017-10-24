
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bank_dat.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BANK_DAT RETURN DATE IS
dd_   date;
BEGIN
SELECT  TO_DATE(val,'MM-DD-YYYY')
INTO  dd_
FROM  params
WHERE par='BANKDATE';
IF dd_ IS NULL THEN
   dd_:=sysdate;
END IF;
RETURN dd_;
END BANK_DAT;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bank_dat.sql =========*** End *** =
 PROMPT ===================================================================================== 
 