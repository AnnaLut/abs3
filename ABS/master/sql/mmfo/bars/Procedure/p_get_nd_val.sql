PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_GET_ND_VAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_GET_ND_VAL ***

  CREATE OR REPLACE PROCEDURE BARS.P_GET_ND_VAL (
       p_dat01   date,
       p_nd      number,
       p_tipa    number,
       p_kol     number,
       p_rnk     number,
       p_tip_fin number,
       p_fin     number,
       p_s080    varchar2,
       p_s180    varchar2 default null,
       p_okpo    varchar2) IS

/* Версия 3.1 11-09-2017  23-01-2017  05-12-2016
   Запись в таблицу кількість днів прострочки по договору
   -------------------------------------
 4) 11-09-2017 - Добавлен параметр S180
 3) 23-01-2017 - Добавлен параметр S080
 2) 05-12-2016 - l_ISTVAL := 1; (параметр отключен згідно листа НБУ від 23.11.2016 №22-0003/96212), было 1 - есть валютная выручка или гривна, 0 - нет выручки
 1) 27-10-2016 - В условие добавлено and rnk  = p_rnk

*/

l_kod     fin_nd.kod%type;  l_istval  integer;
l_idf     fin_nd.idf%type;

BEGIN
   l_ISTVAL := 1; -- (параметр отключен згідно листа НБУ від 23.11.2016 №22-0003/96212), было 1 - есть валютная выручка или гривна, 0 - нет выручки
/*
   if p_tipa = 4 THEN  l_kod := 'KP6' ;  l_idf := 72;  -- Бюджетные организации
   else                l_kod := 'KP61';  l_idf := 5 ;
   end if;

   begin
      select nvl(s,1) into l_ISTVAL from fin_nd  where  nd = p_nd and rnk = p_rnk  and kod = l_kod and idf = l_idf;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_istval := 1;
   end;
*/
   update nd_val    set fdat   = p_dat01 , nd   = p_nd  , tipa = p_tipa, kol  = p_kol, rnk = p_rnk, tip_fin = p_tip_fin, fin = p_fin,
                        istval = l_istval, s080 = p_s080, s180 = p_s180, okpo = p_okpo
   where  nd = p_nd and rnk  = p_rnk and fdat = p_dat01;

   IF SQL%ROWCOUNT=0 then
      Insert into BARS.nd_val (fdat   , nd  , tipa  , kol  , rnk  , tip_fin  , fin  , istval  , s080  , s180  , okpo  )
                       Values (p_dat01, p_nd, p_tipa, p_kol, p_rnk, p_tip_fin, p_fin, l_istval, p_s080, p_s180, p_okpo);
   END IF;
END;
/
show err;

PROMPT *** Create  grants  P_GET_ND_VAL ***
grant EXECUTE                                                                on P_GET_ND_VAL    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_GET_ND_VAL    to RCC_DEAL;
grant EXECUTE                                                                on P_GET_ND_VAL    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_GET_ND_VAL.sql =========*** End 
PROMPT ===================================================================================== 
