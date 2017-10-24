
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/npv.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NPV (r_ NUMBER, cf_ CF) RETURN NUMBER IS
-- Чистый приведенный эффект
   S NUMBER := 0;
   R NUMBER := 1;
BEGIN
   FOR t IN 1..cf_.COUNT
   LOOP
      R:=R*(1+r_);  S:=S+cf_(t)/R;
   END LOOP;
   return S;
END NPV;
 
/
 show err;
 
PROMPT *** Create  grants  NPV ***
grant EXECUTE                                                                on NPV             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NPV             to RCC_DEAL;
grant EXECUTE                                                                on NPV             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/npv.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 