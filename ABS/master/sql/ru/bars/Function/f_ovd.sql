
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ovd.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OVD (p_rnk integer, p_nd integer) RETURN varchar2 IS

 -- §    ознаки визнання дефолту;

l_OVD   rez_cr.OVD%type;

BEGIN
   begin
      select LISTAGG(ord ,',') WITHIN GROUP (ORDER BY ord) into l_OVD
      from fin_nd d , fin_question k where d.idf = k.idf and d.kod = k.kod and d.idf = 54 and rnk = p_rnk and nd = p_nd and d.s = 1;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_OVD := NULL;
   END;

   return l_OVD;

end;
/
 show err;
 
PROMPT *** Create  grants  F_OVD ***
grant EXECUTE                                                                on F_OVD           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OVD           to RCC_DEAL;
grant EXECUTE                                                                on F_OVD           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ovd.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 