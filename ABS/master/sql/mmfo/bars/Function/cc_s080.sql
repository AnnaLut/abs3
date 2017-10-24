
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_s080.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_S080 (ND_ cc_deal.ND%type ) -- реф КД
 RETURN varchar2 IS

 l_s080 specparam.s080%type ;

BEGIN
 /* 06-07-2011 Сухова.
   Расчет категории риска S080 для одного указанного КД указанного,
   исходя из класса заемщика,  который берем из карточки Кред.дог
   cc_deal.FIN
*/

 begin
   SELECT f.s080
   INTO l_s080
   FROM cc_deal d, customer c, fin_obs_s080 f
   WHERE d.nd  = ND_
     AND d.rnk = c.rnk
     AND nvl(d.FIN, c.crisk) = f.fin
     AND d.obs = f.obs;
 EXCEPTION WHEN INVALID_NUMBER  THEN NULL ;
                   WHEN NO_DATA_FOUND  THEN NULL ;
 end;
 RETURN l_s080;
end cc_s080;
/
 show err;
 
PROMPT *** Create  grants  CC_S080 ***
grant EXECUTE                                                                on CC_S080         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_S080         to RCC_DEAL;
grant EXECUTE                                                                on CC_S080         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_s080.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 