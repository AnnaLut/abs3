
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ovkr.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OVKR (p_rnk integer, p_nd integer) RETURN varchar2 IS

--    ознаки високого кредитного ризику:-
l_OVKR   rez_cr.OVKR%type;

BEGIN
   begin
      select LISTAGG(ord ,',') WITHIN GROUP (ORDER BY ord)  into l_OVKR
      from fin_nd d , fin_question k where d.idf = k.idf and d.kod = k.kod and d.idf = 52 and rnk = p_RNK and nd = p_ND and d.s = 1;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_OVKR := NULL;
   END;

   return l_OVKR;

end;
/
 show err;
 
PROMPT *** Create  grants  F_OVKR ***
grant EXECUTE                                                                on F_OVKR          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OVKR          to RCC_DEAL;
grant EXECUTE                                                                on F_OVKR          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ovkr.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 