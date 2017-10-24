
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_istval_351.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ISTVAL_351 (p_dat01 date, p_nd integer, p_tipa integer, p_rnk   integer) RETURN number is
/* Версия 1.0 05-12-2016
   Источник валютной выручки по постанове 351 НБУ
   -------------------------------------


*/

l_kod     fin_nd.kod%type;  l_istval  integer;
l_idf     fin_nd.idf%type;

BEGIN
   l_ISTVAL := 1; -- 1 - есть валютная выручка или гривна, 0 - нет выручки

   if p_tipa = 4 THEN  l_kod := 'KP6' ;  l_idf := 72;  -- Бюджетные организации
   else                l_kod := 'KP61';  l_idf := 5 ;
   end if;

   begin
      select nvl(s,0) into l_ISTVAL from fin_nd  where  nd = p_nd and rnk = p_rnk  and kod = l_kod and idf = l_idf;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_istval := 0;
   end;
   RETURN(l_istval);
END;
/
 show err;
 
PROMPT *** Create  grants  F_GET_ISTVAL_351 ***
grant EXECUTE                                                                on F_GET_ISTVAL_351 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_ISTVAL_351 to RCC_DEAL;
grant EXECUTE                                                                on F_GET_ISTVAL_351 to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_istval_351.sql =========*** E
 PROMPT ===================================================================================== 
 