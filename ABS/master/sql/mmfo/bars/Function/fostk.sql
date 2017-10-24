
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostk.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTK (acc_ INTEGER, fdat_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
BEGIN
   SELECT ost
   INTO nn_
   FROM  sal
   WHERE acc  = acc_  AND
         fdat = fdat_ AND
         ost>0 ;
   if nn_ is null THEN
      nn_:=0;
   end if;
   RETURN nn_;
END FOSTK;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostk.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 