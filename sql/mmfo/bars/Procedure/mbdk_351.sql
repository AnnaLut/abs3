

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MBDK_351.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MBDK_351 ***

  CREATE OR REPLACE PROCEDURE BARS.MBDK_351 (p_dat01 date, p_mode integer  default 0 ) IS

/* Версия 11.3  23-10-2018  27-09-2017  14-09-2017  05-04-2017  10-03-2017  06-03-2017  03-03-2017 
   Розрахунок кредитного ризику по МБДК + коррахунки
14) 23-10-2018(11.3) - (COBUMMFO-7488) - Добавлено ОКПО в REZ_CR
13) 27-09-2017(11.2)  - Запись IDF <-- l_idf, было l_fp
12) 14-09-2017 - PD по l_idf ,было по l_fp
11) 05-04-2017 - rnk = 90931101
10) 10-03-2017 - К-во дней (убрала проверку на дату окончания договора)
 9) 06-03-2017 - LGD (округление 8 знаков)
 8) 03-03-2017 - Если держ. власності >51 %, но клиент в таблице rnk_not_uudv считать как обычный
 7) 15-02-2017 - p_error_351 уточнила РНК, NLS, ....
 6) 08-02-2017 - Определение ВКР по МБДК через F_VKR_MBDK
 5) 24-01-2017 - Добавлены параметры s080,TIP_FIN,ddd_6B
 4) 10-01-2017 - Запись SNA, SDI в REZ_CR
 3) 25-11-2016 - Державна власність был только по ЮО 'UUDV'
 2) 23-11-2016 - zal_bv - #0.00
 1) 06-10-2016 - p_BLOCK_351(p_dat01 date); -- блокировка расчета
*/

--  p_kol_nd_mbdk - один параметр дата
 l_istval specparam.istval%type; kv_    accounts.kv%type; l_ovkr  rez_cr.ovkr%type   ; l_pdef  rez_cr.p_def%type;
 l_ovd    rez_cr.ovd%type      ; l_opd  rez_cr.opd%type ; l_s080  specparam.s080%type; l_ddd   kl_f3_29.ddd%type;


 l_pd      NUMBER ; l_CRQ    NUMBER ; l_zalq  NUMBER ; l_EAD     NUMBER ; l_zal    NUMBER ; l_dv     NUMBER ;  l_EADQ    NUMBER ;
 l_LGD     NUMBER ; l_zal_BV NUMBER ; l_CR    NUMBER ; l_RC      NUMBER ; l_CR_LGD NUMBER ; l_bv     NUMBER ;  l_BVQ     NUMBER ;
 l_zal_BVq NUMBER ; l_bv02   NUMBER ; l_BV02q NUMBER ; l_zal_lgd NUMBER ; l_s      NUMBER ; l_lgd_51 NUMBER := 0.3;
 acc8_     INTEGER; l_idf    INTEGER; l_fin   INTEGER; l_tipa    INTEGER; l_fin23  INTEGER;  l_fp    INTEGER;  l_tip_fin INTEGER;
 --l_kol   INTEGER;

 VKR_  varchar2(3);  l_txt   varchar2(1000);

 l_dat31 date;

begin
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   p_BLOCK_351(p_dat01);
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало МБДК + Коррсчета 351 ');
   l_dat31   := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   l_tip_fin := 1;
   if p_mode = 0 THEN p_kol_nd_MBDK(p_dat01, 0); end if;
   delete from REZ_CR where fdat=p_Dat01 and tipa in ( 5, 6);
   for d in (SELECT d.nd, d.cc_id, d.sdate, d.wdate, d.vidd, D.FIN23, D.BRANCH,f_get_nd_val_n ('KOL', d.nd, p_dat01, 5, d.rnk) KOL, 5 tipa,
                    FIN_351, PD, f_vkr_MBDK(d.rnk) VKR, 'МБДК ' l_vkr
             FROM (select * from accounts where  nbs >'1500' and nbs < '1600') a,
                  (select e.* from cc_deal e,nd_open n
                   where n.fdat = p_dat01 and e.nd = n.nd and (vidd> 1500  and vidd<  1600 ) and sdate< p_dat01 and vidd<>1502 and
                        (sos>9 and sos< 15 or wdate >= l_dat31 )) d, cc_add ad
             WHERE a.acc = ad.accs  and d.nd = ad.nd  and ad.adds = 0  and  ost_korr(a.acc,l_dat31,null,a.nbs)<0  and
                   d.nd=(select max(n.nd) from nd_acc n,cc_deal d1  where n.acc=a.acc and n.nd=d1.nd and (d1.vidd> 1500  and d1.vidd<  1600 )
                   and d1.vidd<>1502 and d1.sdate< p_dat01 and  (sos>9 and sos< 15 or d1.wdate >= l_dat31 ) )
             union all
             select d.nd, d.cc_id, d.sdate, d.wdate, d.vidd, nvl(d.fin23,1) FIN23, D.BRANCH, f_get_nd_val_n ('KOL', d.nd, p_dat01, 6, d.rnk) KOL,6 tipa,
                    FIN_351, PD, cck_app.get_nd_txt(d.nd, 'VNCRR') VKR, 'Коррахунки ' l_vkr
             from  cc_deal d  where vidd = 150
            )
   LOOP
      --if d.VKR is null THEN  d.VKR := f_vkr_MBDK(k.rnk); end if;

      l_tipa := d.tipa;
      for s in (select a.tip, a.nls, a.ob22, a.acc, a.kv,  a.nbs, - ost_korr(a.acc,l_dat31,null,a.nbs) S, a.rnk,
                substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK, c.custtype cus,
                DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, c.okpo
                from nd_acc n, accounts a,customer c
                where n.nd=d.nd and n.acc=a.acc and a.nbs like '15%' and  ost_korr(a.acc,l_dat31,null,a.nbs)<0 and a.rnk=c.rnk
                )
      LOOP
         --l_fin := f_rnk_maxfin(p_dat01, s.rnk, 1, d.nd);
         if d.VKR is null or f_vkr_correct (d.vkr) = 0 THEN
            p_error_351( P_dat01, d.nd, user_id, 16, s.acc, s.cus, s.kv, null, d.l_vkr || ' ' || vkr_, s.rnk, s.nls);
         end if;

         l_dv := 0;
         begin
            SELECT  CASE WHEN REGEXP_LIKE(value,'^[ |.|,|0-9]+$')
                    THEN 0+REPLACE(REPLACE(value ,' ',''),',','.')
                    ELSE 0 END INTO l_dv FROM customerw WHERE rnk=s.rnk AND trim(tag)='UUDV';
         EXCEPTION WHEN NO_DATA_FOUND THEN l_dv := 0;
         END;
         if s.kv = 980 THEN l_istval := 0;
         else
            --istval_ := f_get_istval_351(p_dat01,d.nd,d.tipa,s.rnk);
            begin
               SELECT nvl(istval,0) INTO l_istval FROM specparam p  WHERE  s.acc = p.acc (+);
            EXCEPTION WHEN NO_DATA_FOUND THEN l_istval := 0;
            END;
         end if;

         l_ddd := f_ddd_6B(s.nbs);
         --l_kol := f_get_nd_val(d.nd, p_dat01, d.tipa, s.rnk);

         --logger.info('REZ_351 2 : nd = ' || d.nd || ' s.acc = '|| s.acc || ' VKR = ' || VKR_ || 'Остаток = ' || s.s) ;
         for z in ( select NVL(f_zal_accs (p_dat01, d.nd, a.acc),0) zal_lgd, a.acc, a.kv, -ost_korr(a.acc,l_dat31,null,a.nbs) BV02,
                           f_bv_sna   (p_dat01, d.nd ,a.acc, kv) osta, m.*
                    from   accounts a,( select accs, ost, round (ost*sall / sum(sall) over  (partition by 1), 0) bv, sall, nvl(tip,0) tip,
                                               pawn, kl_351, kpz, rpb, round (bv_all*sall / sum(sall) over  (partition by 1), 0) bv_all, kod_351
                                        from ( select ost, accs, nvl(sum(sall),0) sall,tip, pawn, kl_351, kpz, rpb, kod_351,bv_all
                                               from ( select f_bv_sna (p_dat01, d.nd , t.accs, t.kv) ost,-ost_korr(t.accs,l_dat31,null,
                                                             substr(t.accs,1,4)) BV_ALL, t.accs,t.accz,t.nd,t.pawn,p.name,t.sall, t.kpz,
                                                             t.rpb, f_kl_351 (t.accs, t.pawn) kl_351, nvl(w.tip,0) tip,p.kod_351
                                                      from   tmp_rez_obesp23 t,cc_pawn p,cc_pawn23add c, pawn_tip w
                                                      where  dat = p_dat01 and t.sall<>0 and t.pawn = p.pawn and p.pawn = c.pawn (+) and
                                                             p.pawn = w.pawn(+) and t.nd = d.nd and t.accs = s.acc)
                                               group by bv_all, ost, accs, tip, pawn, kl_351, kpz, rpb, kod_351)) m
                     where a.acc=m.accs (+) and a.acc=s.acc
                   )
         LOOP

            --logger.info('REZ_351 3 : nd = ' || d.nd || ' z.pawn = '|| z.pawn ) ;
            if    s.RZ =2 THEN l_idf := 81; l_fp := 47;
            else               l_idf := 80; l_fp := 46;
            end if;

            --l_fin23 := d.fin23;
            l_fin   := nvl(D.fin_351,l_fin);
            l_fin   := f_rnk_maxfin(p_dat01, s.rnk, l_tip_fin, d.nd, 1);
            l_pd    := d.pd;
            if l_pd is null  THEN
               l_pd := fin_nbu.get_pd(s.rnk, d.nd, p_dat01,l_fin, d.VKR,l_idf);
            else
               l_fp :=  NULL;
            end if;
            if s.rnk = 90931101 and sys_context('bars_context','user_mfo') = '300465' THEN   -- COBUSUPABS-5538
               l_fin := 1;
               l_PD  := 0;
            end if;
            l_EAD   := nvl(z.bv,z.osta);
            if (l_ead = 0 or l_ead is null) and z.sall is null and nvl(z.osta,0) <> 0  THEN
               l_EAD := nvl(z.bv_all,z.bv02);
            end if;
            l_EAD     := greatest(l_EAD,0);
            l_zal     := (nvl(z.sall,0) * nvl(z.kl_351,0))/100;
            l_zal_lgd := nvl(z.zal_lgd,0)/100;
            l_s       := z.osta/100;
            l_EAD     := round(l_EAD / 100,2);
            l_EADQ    := p_icurval(s.kv,l_EAD*100,l_dat31)/100;
            L_RC      := 0;
            if l_ead   = 0 or nvl(l_s,0) + L_RC = 0 THEN L_LGD := 1;
            else                                         l_LGD := round(greatest(0,1 - (l_zal_lgd + L_RC) / l_s),8);
            end if;

            IF l_dv >= 51 and  l_lgd >=l_lgd_51 then
               if f_rnk_not_uudv(s.rnk) = 0 THEN l_LGD  := l_lgd_51; end if;
            end if;

            l_s080    := f_get_s080 (p_dat01,l_tip_fin, l_fin);
            L_CR      := round(l_pd * L_LGD *l_EAD,2);
            l_zal     := round(l_zal,2);
            l_zalq    := p_icurval(s.kv,l_zal*100,l_dat31)/100;
            l_CRQ     := p_icurval(s.kv,L_CR*100,l_dat31)/100;
            l_BV      := nvl(z.bv_all,nvl(z.bv02,z.bv))/100;
            l_BV02    := z.bv02/100;
            l_BVQ     := p_icurval(s.kv,l_bv*100,l_dat31)/100;
            l_BV02q   := p_icurval(s.kv,l_bv02*100,l_dat31)/100;
            l_RC      := 0;
            --logger.info('REZ_351 4 : nd = ' || d.nd || ' l_fin = '|| l_fin || ' l_pd = ' || l_pd  ) ;
            l_zal_bv  := z.sall/100;
            l_zal_bvq := p_icurval(s.kv,l_zal_bv*100,l_dat31)/100;
            l_CR_LGD  := l_ead*l_pd*l_lgd;
            INSERT INTO REZ_CR (fdat   , RNK      , NMK     , ND       , SDATE   , wdate  , KV    , NLS     , ACC    , EAD     , EADQ    , FIN   ,
                                PD     , CR       , CRQ     , bv       , bvq     , VKR    , IDF   , KOL     , FIN23  , TEXT    , tipa    , pawn  ,
                                zal    , zalq     , zal_bv  , zal_bvq  , kpz     , OVKR   , P_DEF , OVD     , OPD    , istval  , CR_LGD  , dv    ,
                                cc_id  , pd_0     , vidd    , tip_zal  , LGD     , nbs    , tip   , custtype, RC     , BV02    , s080    , ddd_6B,
                                okpo   , tip_fin  , ob22    , bv02q    , KL_351  , RZ     )
                        VALUES (p_dat01, s.RNK    , s.NMK   , d.nd     , d.sdate , d.wdate, s.kv  , s.nls   , s.acc  , l_ead   , l_eadq  , l_fin ,
                                l_pd   , l_CR     , l_CRQ   , l_bv     , l_bvq   , d.VKR  , l_idf , d.kol   , d.fin23, null    , l_tipa  , z.pawn,
                                l_zal  , l_zalq   , l_zal_bv, l_zal_bvq, z.kpz   , l_OVKR , l_PDEF, l_OVD   , l_OPD  , l_istval, l_CR_LGD, l_dv  ,
                                d.cc_id, 0        , d.vidd  , z.tip    , l_LGD   , s.nbs  , s.tip , s.cus   , l_RC   , l_bv02  , l_s080  , l_ddd ,
                                s.okpo , l_tip_fin, s.ob22  , l_bv02q  , z.kl_351, s.RZ   );

            for i in (select a.*, -ost_korr(a.acc,l_dat31,null,a.nbs) BV from nd_acc n,accounts a
                      where  n.nd = d.nd and n.acc=a.acc and a.tip in ('SNA','SDI','SDA','SDM','SDF','SRR') and nbs not in (3648))
            LOOP
               if i.BV <> 0 THEN
                  l_ddd  := f_ddd_6B(i.nbs);
                  l_BV   := i.bv / 100;
                  l_BVQ  := p_icurval(i.kv,i.bv,l_dat31)/100;
                  update rez_cr set tip = i.tip where fdat = p_dat01 and acc = i.acc;
                  IF SQL%ROWCOUNT=0 then
                     INSERT INTO REZ_CR (fdat   , RNK   , NMK      , ND    , KV     , NLS    , ACC   , EAD     , EADQ    , FIN    , CR  , CRQ  ,
                                         bv     , bvq   , VKR      , KOL   , FIN23  , tipa   , vidd  , CUSTTYPE, nbs     , dv     , BV02, tip  ,
                                         s080   , ddd_6B, tip_fin  , ob22  , bv02q  , sdate  , RZ    , cc_id   , istval  , wdate  , pd_0, okpo )
                                 VALUES (p_dat01, s.RNK , s.NMK    , d.nd  , i.kv   , i.nls  , i.acc , 0       , 0       , l_fin  , 0   , 0    ,
                                         l_bv   , l_bvq , d.VKR    , d.kol , d.fin23, l_tipa , d.vidd, s.CUS   , i.nbs   , l_dv   , l_bv, i.tip,
                                         l_s080 , l_ddd , l_tip_fin, i.ob22, l_bvq  , d.sdate, s.RZ  , d.cc_id , l_istval, d.wdate, 0   , s.okpo);
                  end if;
               end if;
            END LOOP;
         end LOOP;
      end LOOP;
   End LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец МБДК + Коррсчета 351 ');
end;
/
show err;

PROMPT *** Create  grants  MBDK_351 ***
grant EXECUTE                                                                on MBDK_351        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MBDK_351        to RCC_DEAL;
grant EXECUTE                                                                on MBDK_351        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MBDK_351.sql =========*** End *** 
PROMPT ===================================================================================== 
