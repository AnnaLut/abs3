
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/k_acc.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.K_ACC (REF_ INTEGER, TT_ CHAR, s_ numeric)
RETURN VARCHAR2 IS
KK_ varchar2(9);
BEGIN
   SELECT g.nls INTO KK_
   FROM OPLdok o, geo_tab g
   WHERE o.REF=REF_ AND
         o.TT=TT_   AND
         o.s=S_     AND
         o.dk=1     AND
         o.acc=g.acc ;
   RETURN kk_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN  RETURN '';
END K_ACC;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/k_acc.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 