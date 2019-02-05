
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_rnk_maxfin.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RNK_MAXFIN (p_dat01 date, p_okpo varchar2, p_tip_fin number, P_ND number,p_max number) RETURN integer IS

/* Версия 3.0 09-03-2017  10-01-2017   06-10-2016
   Максимальный фин.стан (FIN) по РНК
   -------------------------------------
   09-03-2017 - Худший фин.стан если не определен
   10-01-2017 - p_max - 0 - не приводить к единой категории
   27-10-2016 - Введен текущий фин.стан
*/

l_fin number; l_rating number; p_fin number; l_istval number; l_RNK_FIN char(1);

begin
   begin
      begin
         select max(fin),istval into p_fin,l_istval from nd_val n where n.fdat = P_dat01 and okpo = p_okpo and nd = p_nd group by istval;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN p_fin := null; l_istval := 1;
         p_error_351( P_dat01, p_nd, user_id, 33, null, null, null, null, 'Не нашла fin в nd_val, OKPO = ' || p_okpo , 999, null);
      end;

      if p_max = '0' THEN return (p_fin); end if;  -- не приводить к единой категории

      select max(decode(n.tip_fin,0,decode(n.fin,1,p_fin,r.rating),r.rating)) into l_rating from nd_val n, fin_rating r
      where n.fdat=p_dat01 and n.tip_fin = r.tip_fin and n.fin = r.fin and okpo = p_okpo and n.istval = l_istval;

      l_rating := nvl(l_rating, 10);

      if    p_tip_fin = 1 THEN select x1 into l_fin  from fin_all  where x2 = l_rating ;
      elsif p_tip_fin = 0 THEN select x0 into l_fin  from fin_all  where x2 = l_rating ;
      else                     select x2 into l_fin  from fin_all  where x2 = l_rating ;
      end if;

   EXCEPTION  WHEN NO_DATA_FOUND  THEN l_fin := null;
   end;
   return (l_fin);
end;
/
 show err;
 
PROMPT *** Create  grants  F_RNK_MAXFIN ***
grant EXECUTE                                                                on F_RNK_MAXFIN    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_RNK_MAXFIN    to RCC_DEAL;
grant EXECUTE                                                                on F_RNK_MAXFIN    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_rnk_maxfin.sql =========*** End *
 PROMPT ===================================================================================== 
 