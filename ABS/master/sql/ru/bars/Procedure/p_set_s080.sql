

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SET_S080.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SET_S080 ***

  CREATE OR REPLACE PROCEDURE BARS.P_SET_S080 
 (p_tip    in customer.custtype%type,    -- тип клиента 2 = ЮЛ, 3 = ФЛ
  p_branch in cc_deal.branch%type  )     -- маска бранча

IS

/* 02-08-2011 Сухова.
   Пересчет категории риска S080 для счетов по КД указанного бранча,
   исходя из класса заемщика,  который берем из карточки Кред.дог
   cc_deal.FIN
*/
BEGIN
   P_279_6_2( to_char(p_tip), 6, translate(p_branch,'*','%') || '%' );

   If p_tip = 2 then
      update v_s080_2 set otm=1 ;
   elsIf p_tip = 3 then
      update v_s080_3 set otm=1 ;
   end if;

end p_set_s080;
/
show err;

PROMPT *** Create  grants  P_SET_S080 ***
grant EXECUTE                                                                on P_SET_S080      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_SET_S080      to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SET_S080.sql =========*** End **
PROMPT ===================================================================================== 
