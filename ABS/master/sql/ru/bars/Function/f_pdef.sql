
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pdef.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PDEF (p_rnk integer, p_nd integer) RETURN varchar2 IS
--    події дефолту;
l_PDEF   rez_cr.P_DEF%type;

BEGIN
   begin
      select LISTAGG(ord ,',') WITHIN GROUP (ORDER BY ord)  into l_PDEF
      from fin_nd d , fin_question k where d.idf = k.idf and d.kod = k.kod and d.idf = 53 and rnk = p_rnk and nd = p_nd and d.s = 1;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_PDEF := NULL;
   END;

   return l_PDEF;

end;
/
 show err;
 
PROMPT *** Create  grants  F_PDEF ***
grant EXECUTE                                                                on F_PDEF          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_PDEF          to RCC_DEAL;
grant EXECUTE                                                                on F_PDEF          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pdef.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 