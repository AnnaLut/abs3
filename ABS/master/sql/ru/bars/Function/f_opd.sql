
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_opd.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OPD (p_rnk integer, p_nd integer) RETURN varchar2 IS

 --    ознаки припинення дефолту;

l_OPD   rez_cr.OPD%type;

BEGIN
   begin
      select LISTAGG(ord ,',') WITHIN GROUP (ORDER BY ord)  into l_OPD
      from fin_nd d , fin_question k where d.idf = k.idf and d.kod = k.kod and d.idf = 55 and rnk = p_rnk and nd = p_nd and d.s = 1;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_OPD := NULL;
   END;
   return l_OPD;

end;
/
 show err;
 
PROMPT *** Create  grants  F_OPD ***
grant EXECUTE                                                                on F_OPD           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OPD           to RCC_DEAL;
grant EXECUTE                                                                on F_OPD           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_opd.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 