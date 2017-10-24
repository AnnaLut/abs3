
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/pok_mfo.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.POK_MFO (fdat_ date, pok_ INTEGER, mfo_ varchar2)
RETURN decimal IS
s_ decimal(24,2);
BEGIN
   SELECT s/100
   INTO s_
   FROM ek_pok_mfo
   WHERE pok=pok_ AND
         mfo=mfo_ AND
         fdat in ( select max(fdat)
                   FROM ek_pok_mfo
                   WHERE pok=pok_ AND
                         mfo=mfo_ AND
                         fdat<=fdat_ );
   RETURN s_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN  RETURN NULL ;
END POK_MFO;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/pok_mfo.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 