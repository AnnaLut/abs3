
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kontr_acc.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KONTR_ACC (REF_ INTEGER, TT_ CHAR, s_ numeric)
RETURN VARCHAR2 IS
KK_ VARCHAR2(15);
BEGIN
   SELECT NLS INTO KK_
   FROM OPL
   WHERE REF=REF_ AND TT=TT_ AND s*(2*dk-1)= -S_ group by nls ;
   RETURN kk_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN  RETURN ' ';
END KONTR_ACC;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kontr_acc.sql =========*** End *** 
 PROMPT ===================================================================================== 
 