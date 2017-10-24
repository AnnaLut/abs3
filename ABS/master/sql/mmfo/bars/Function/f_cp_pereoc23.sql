
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cp_pereoc23.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CP_PEREOC23 
         (p_fl_alg23 IN NUMBER,
          P_rez23    IN NUMBER,
          p_n1       IN NUMBER,
          p_d1       IN NUMBER,
          p_p1       IN NUMBER,
          p_r1       IN NUMBER,
          p_unrec1   IN NUMBER,
          p_r21      IN NUMBER,
          p_r31      IN NUMBER,
          p_expr1    IN NUMBER,
          p_expn1    IN NUMBER,
          p_cena     IN NUMBER,
          p_kolk     IN NUMBER
        ) RETURN NUMBER IS

-- 19-07-2016 LUDA Новая ф-ция расчета переоценки по ЦБ (23)
l_pereoc23 NUMBER;

begin
   if p_fl_alg23 = 1 THEN
      if p_rez23 = 0 THEN
         l_pereoc23 := ABS ( p_N1 + p_D1 + p_P1 + (p_R1 + p_UNREC1) + p_R21 + p_R31 + p_expR1 + p_expN1);
      else
         l_pereoc23 := ROUND ((p_rez23 - ABS (( p_N1 + p_D1 + p_P1 + (p_R1 + p_UNREC1) + p_R21 + p_R31 + p_expR1 + p_expN1)
                       / ABS (NVL (p_N1 / p_CENA, 1)))),2) * p_kolk;
      end if;
   elsif p_fl_alg23=2 THEN
         l_pereoc23 := ROUND ((p_rez23 + ABS (( p_R1 + p_R21 + p_R31) / p_kolk) - ABS ((p_N1 + p_D1 + p_P1 + p_R1 + p_R21 + p_R31 + p_expR1 + p_expN1)
                       / ABS (NVL (p_N1 / p_CENA, 1)))),2) * p_kolk;
   else
         l_pereoc23 := 0;
   end if;
   RETURN(l_pereoc23);
end;
/
 show err;
 
PROMPT *** Create  grants  F_CP_PEREOC23 ***
grant EXECUTE                                                                on F_CP_PEREOC23   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CP_PEREOC23   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cp_pereoc23.sql =========*** End 
 PROMPT ===================================================================================== 
 