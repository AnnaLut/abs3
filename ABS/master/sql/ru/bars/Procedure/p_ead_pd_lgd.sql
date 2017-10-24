

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_EAD_PD_LGD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_EAD_PD_LGD ***

  CREATE OR REPLACE PROCEDURE BARS.P_EAD_PD_LGD (p_dat01 date, p_RNK integer, p_ND integer, P_PD NUMBER, P_LGD NUMBER, p_fin integer) IS

/* Версия 1.0 08-02-2017
   Ручной резерв (корректировка)
   -------------------------------------

*/

l_s080   specparam.s080%type  ;
L_CR     number;  l_CRQ number;
l_dat31  date  ;

begin
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   for k in ( select r.ROWID RI, r.* from rez_cr r where r.fdat = p_dat01 and r.rnk = p_rnk and r.nd = p_nd )
   LOOP
      L_CR   := round(p_pd * p_LGD * k.EAD,2);
      l_CRQ  := p_icurval(k.kv,L_CR*100,l_dat31)/100;
      l_s080 := f_get_s080 (p_dat01, k.tip_fin, p_fin);
      update rez_cr set pd = p_pd, lgd = p_lgd, fin = p_fin, CR = l_cr, CRQ = l_CRQ ,s080 = l_s080 where rowid = k.RI;
   end loop;
   for k in (select   FDAT   , RNK  , ACC   , KV   , NLS   , NBS , ND      , VIDD, FIN  , bv02q , sum( BV  ) bv  , sum( BVQ  ) bvq , sum( EAD ) ead,
                      bv02   , KOL  , kpz   , SDATE, wdate , TIPA, LGD     , OVKR, P_DEF, OVD   , sum( EADQ) eadq, sum( CR   ) cr  , sum( CRQ ) crq,
                      RZ     , FIN_Z, CCF   , PD_0 , istval, rpb , CC_ID   , s250, TIP  , TEXT  , sum( RC  ) rc  , nvl(sum( ZAL    ),0) zal   ,
                      GRP    , S080 , DDD_6B, VKR  , OPD   , NMK , custtype, nvl(ob22,'01') ob22, sum( RCQ ) RCQ , NVL(sum( ZALQ   ),0) zalq  ,
                      tip_fin,                                                                                     nvl(sum( ZAL_BV ),0) zal_BV,
                                                                                                                   nvl(sum( ZAL_BVQ),0) zal_BVQ
             from     REZ_CR where fdat = p_dat01 and rnk = p_rnk and nd=p_nd
             group by FDAT, RNK , ACC  , KV    , NLS     , nbs  , ND , VIDD, FIN, VKR , KOL, FIN23, kpz  , NMK   , SDATE, wdate, TIPA,
                      LGD , bv02, bv02q, OVKR  , tip_fin , P_DEF, OVD, OPD , CCF, PD_0, RZ , FIN_Z, cc_id, ISTVAL, RPB  , S250 , TIP ,
                      TEXT, GRP , S080 , DDD_6B, custtype, OB22 )
   LOOP
      l_s080 := f_get_s080 (p_dat01, k.tip_fin, p_fin);
      update NBU23_rez set CR = k.cr, CRQ = k.crq, FIN_351 = k.fin, LGD = k.LGD, FIN = k.fin, rez23 = k.cr, REZq23 = k.crq, s080 = l_s080
      where  fdat = p_dat01 and acc=k.acc and rownum=1;
   end loop;

end;
/
show err;

PROMPT *** Create  grants  P_EAD_PD_LGD ***
grant EXECUTE                                                                on P_EAD_PD_LGD    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_EAD_PD_LGD    to RCC_DEAL;
grant EXECUTE                                                                on P_EAD_PD_LGD    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_EAD_PD_LGD.sql =========*** End 
PROMPT ===================================================================================== 
