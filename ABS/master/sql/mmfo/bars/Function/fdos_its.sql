
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fdos_its.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FDOS_ITS (nls_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
BEGIN
   SELECT sum(dos) INTO nn_ FROM vypiska WHERE nls=nls_ AND
         fdat >= fdat1_ AND fdat <= fdat2_ ;
   if nn_ is null THEN  nn_:=0; end if;  RETURN nn_;
END FDOS_its;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fdos_its.sql =========*** End *** =
 PROMPT ===================================================================================== 
 