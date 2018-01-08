
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_dop.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DOP (REF_ INTEGER, TT_ CHAR) RETURN VARCHAR2 IS
  KK_ VARCHAR2(250);
BEGIN
 begin
   SELECT max(substr( TRIM(value),1,250))
   INTO KK_
   FROM operw WHERE REF=REF_ AND TAG=TT_;
   EXCEPTION WHEN NO_DATA_FOUND THEN  KK_:= null; -- ' ';
 end;
 RETURN kk_;
END F_DOP;
/
 show err;
 
PROMPT *** Create  grants  F_DOP ***
grant EXECUTE                                                                on F_DOP           to ABS_ADMIN;
grant EXECUTE                                                                on F_DOP           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DOP           to START1;
grant EXECUTE                                                                on F_DOP           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_dop.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 