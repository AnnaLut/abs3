

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OVER_351.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OVER_351 ***

  CREATE OR REPLACE PROCEDURE BARS.OVER_351 (p_dat01 date, p_mode integer  default 0 ) IS

/* Версия 10.5  26-03-2018  03-01-2018  28-11-2017  16-11-2017  12-09-2017  04-05-2017   05-04-2017  06-03-2017
 Розрахунок кредитного ризику по ОВЕРДРАФТАХ
-------------------------------------------
15) 26-03-2018(10.5) - 9129 не ризиковий (fin=1) + s080
14) 03-01-2018(10.4) - тормозился расчет
13) 28-11-2017(10.3) - Новый план счетов через REZ_DEB (2069 --> SPN)
12) 27-11-2017(10.2) - LGD для 9129 безризикових =1 , по ризиковим розраховується
11) 12-09-2017 - L_CR := round(l_pd * L_LGD *l_EAD,2);
10) 04-05-2017 - Если есть две строки по одному договору и один счет начисл. %, то писало  2 строки нач. %
 9) 05-04-2017 - rnk = 90931101
 8) 06-03-2017 - LGD (округление 8 знаков)
 7) 03-03-2017 - Если держ. власності >51 %, но клиент в таблице rnk_not_uudv считать как обычный
 6) 06-02-2017 - l_s =0 (деление на ноль)
 5) 24-01-2017 - Добавлены параметры s080,TIP_FIN,ddd_6B
 4) 10-01-2017 - Запись SNA, SDI в REZ_CR
 3) 03-01-2017 - wdate, sdate по договору
 2) 25-11-2016 - Державна власність был только по ЮО 'UUDV'
 1) 23-11-2016 - zal_bv - #0.00
*/

 l_istval specparam.istval%type; kv_    accounts.kv%type; l_r013  specparam.r013%type; l_ovkr  rez_cr.ovkr%type   ;
 l_pdef   rez_cr.p_def%type    ; l_ovd  rez_cr.ovd%type ; l_opd   rez_cr.opd%type    ; l_s080  specparam.s080%type;
 l_ddd    kl_f3_29.ddd%type    ; l_nd   rez_cr.nd%type  ;

 l_pd      NUMBER ; l_CRQ     NUMBER ; l_EAD      NUMBER ; l_zal  NUMBER ; l_EADQ   NUMBER ;  l_LGD    NUMBER ; l_CR    NUMBER ;
 l_RC      NUMBER ; l_bv      NUMBER ; l_BVQ      NUMBER ; l_bv02 NUMBER ; l_BV02q  NUMBER ;  l_ccf    NUMBER ; l_srok  NUMBER ;
 l_zalq    NUMBER ; l_zal_BV  NUMBER ; l_zal_BVq  NUMBER ; l_dv   NUMBER ; l_f      NUMBER ;  l_CR_LGD NUMBER ; l_s     NUMBER ;
 l_RZ      NUMBER ; l_zal_lgd NUMBER ; l_lgd_51   NUMBER := 0.3;
 l_kol     INTEGER; acc8_     INTEGER; l_idf      INTEGER; l_fin  INTEGER; l_tipa   INTEGER;  l_fin23  INTEGER; l_pd_0  INTEGER;
 L_tip_fin INTEGER; srok      INTEGER;

 VKR_      varchar2(3); l_txt  varchar2(1000); l_vkr  varchar2(50); l_dat31    date;

begin
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало ОВЕР 351 ');
   l_tipa  := 10;
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   if p_mode = 0 THEN p_kol_nd_over(p_dat01, 0); end if;
   delete from REZ_CR where fdat = p_Dat01 and tipa in (10,90);
   for d in ( select * from acc_over )
   LOOP

      vkr_  := cck_app.get_nd_txt(d.nd, 'VNCRR') ;
      l_vkr := 'ОВЕР ';
      if d.datd2 is null THEN
         begin
            select datd, datd2 into d.datd, d.datd2 from acc_over where nd = d.nd and datd2 is not null;
         EXCEPTION  WHEN NO_DATA_FOUND  THEN d.datd := null; d.datd2 := null;
         end;
      end if;

      for s in (select o.*, d.datd sdate, d.datd2 wdate
                from (select a.acc, a.ob22, a.nls, a.kv, a.tip, a.nbs,- ost_korr(a.acc,l_dat31,null,a.nbs) S, a.rnk,
                             substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK, c.custtype, a.branch,
                             DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ
                      from accounts a, customer c where acc= d.acco and a.rnk=c.rnk
                      union all
                      select a.acc, a.ob22, a.nls, a.kv, a.tip, a.nbs,- ost_korr(a.acc,l_dat31,null,a.nbs) S, a.rnk,
                             substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) nmk, c.custtype, a.branch,
                             DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ
                      from accounts a, customer c
                      where acc = (select acra from int_accn where id=0 and acc=d.acco) and nbs not like '8%'   and a.rnk=c.rnk
                      union all
                      select  a.acc, a.ob22, a.nls, a.kv, a.tip, a.nbs,- ost_korr(a.acc,l_dat31,null,a.nbs) S, a.rnk,
                              substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK, c.custtype, a.branch,
                              DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ
                      from accounts  a, customer c
                      where  acc in (select acc from nd_acc where nd=d.nd)
                        and  a.NBS IN (select nbs from rez_deb  where (grupa = 4 and ( d_close is null or d_close > p_dat01)) or a.tip in ('SPN'))   --and nbs='2069'
                      and acc not in ( select a.acc from accounts a
                                       where acc = (select acra from int_accn where id=0 and acc=d.acco) and nbs not like '8%'   and a.rnk=c.rnk)
                      and acc not in (select acc from rez_cr where fdat=p_dat01)
                      and a.rnk=c.rnk
                      union all
                      select a.acc, a.ob22, a.nls, a.kv, a.tip, a.nbs,- ost_korr(a.acc,l_dat31,null,a.nbs) S, a.rnk,
                             substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK, c.custtype, a.branch,
                             DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ
                      from accounts  a, customer c  where acc= d.acc_9129 and a.rnk=c.rnk) o
                where s > 0
               )
      loop
         if VKR_ is null or f_vkr_correct (vkr_) = 0 THEN
            p_error_351( P_dat01, d.nd, user_id, 16, null, null, null, null, l_vkr, s.rnk, null);
         end if;

         if s.s > 0 THEN s.tip := f_get_tip(s.nbs, s.tip); end if;
         l_ddd   := f_ddd_6B(s.nbs);
         begin
            SELECT nvl(kol,0) INTO l_kol FROM nd_val v
            WHERE  v.nd =d.nd and v.fdat = p_dat01 and tipa = l_tipa and v.rnk = s.rnk;
         EXCEPTION WHEN NO_DATA_FOUND THEN l_kol := 0;
         END;

         l_dv := 0;
         if s.nbs in ('9129','9122') THEN
            begin
               SELECT R013 INTO l_r013 FROM specparam p  WHERE  s.acc = p.acc (+);
            EXCEPTION WHEN NO_DATA_FOUND THEN l_kol := 0;
            END;
         end if;
         if s.kv = 980 THEN l_istval := 0;
         else
            --istval_ := f_get_istval_351(p_dat01,d.nd,d.tipa,d.rnk);
            begin
               SELECT nvl(istval,0) INTO l_istval FROM specparam p  WHERE  s.acc = p.acc (+);
            EXCEPTION WHEN NO_DATA_FOUND THEN l_istval := 0;
            END;
         end if;
         logger.info('OVER_351 1 : nd = ' || d.nd || ' rnk = '|| s.rnk ) ;
         begin
            SELECT  CASE WHEN REGEXP_LIKE(value,'^[ |.|,|0-9]+$')
                    THEN 0+REPLACE(REPLACE(value ,' ',''),',','.')
                    ELSE 0 END
               INTO l_dv FROM customerw WHERE rnk=s.rnk AND trim(tag)='UUDV';
         EXCEPTION WHEN OTHERS THEN l_dv := 0;
         END;

         l_ovkr := null; --f_ovkr(s.rnk,d.nd); --    ознаки високого кредитного ризику:-
         l_pdef := null; --f_pdef(s.rnk,d.nd); --    події дефолту;
         l_ovd  := null; --f_ovd (s.rnk,d.nd); --    ознаки визнання дефолту;
         l_opd  := null; --f_opd (s.rnk,d.nd); --    ознаки припинення дефолту;

         --logger.info('REZ_351 2 : nd = ' || d.nd || ' s.acc = '|| s.acc || ' VKR = ' || VKR_ || 'Остаток = ' || s.s) ;
/*
         for z in ( select NVL(f_zal_accs (p_dat01, d.nd, a.acc),0) zal_lgd,a.acc,-ost_korr(a.acc,l_dat31,null,a.nbs) osta,m.*
                    from accounts a, ( select accs, ost, round (ost*sall / sum(sall) over  (partition by 1), 0) bv, sall, nvl(tip,0) tip, pawn, kl_351, kpz
                                       from ( select ost, accs, nvl(sum(sall),0) sall,tip, pawn, nvl(kl_351,0) kl_351, kpz
                                              from ( select f_bv_sna (p_dat01, d.nd , t.accs, t.kv) ost,t.accs,t.accz,t.nd,t.pawn,p.name,t.sall, t.kpz,
                                                     c.kl_351, nvl(w.tip,0) tip
                                                     from   tmp_rez_obesp23 t,cc_pawn p,cc_pawn23add c, pawn_tip w
                                                     where  dat = p_dat01 and t.sall<>0 and t.pawn = p.pawn and p.pawn = c.pawn (+) and p.pawn = w.pawn(+)
                                                            and t.nd = d.nd and t.accs = s.acc)
                                                     group by  ost,accs,tip, pawn, kl_351, kpz)) m
                                       where a.acc=m.accs (+) and a.acc=s.acc
                   )
         LOOP
*/
            for z in ( select NVL(f_zal_accs (p_dat01, d.nd, a.acc),0) zal_lgd, a.acc, a.kv, -ost_korr(a.acc,l_dat31,null,a.nbs) BV02,
                              f_bv_sna   (p_dat01, d.nd ,a.acc, kv) osta, m.*
                       from   accounts a,
                            ( select accs, ost, round (ost*sall / sum(sall) over  (partition by 1), 0) bv, sall, nvl(tip,0) tip, pawn, kl_351, kpz, rpb,
                                     round (bv_all*sall / sum(sall) over  (partition by 1), 0) bv_all, kod_351
                              from ( select ost, accs, nvl(sum(sall),0) sall,tip, pawn, kl_351, kpz, rpb, kod_351,bv_all
                                     from ( select f_bv_sna (p_dat01, d.nd , t.accs, t.kv) ost,-ost_korr(t.accs,l_dat31,null,
                                                   substr(t.accs,1,4)) BV_ALL, t.accs,t.accz,t.nd,t.pawn,p.name,t.sall, t.kpz, t.rpb,
                                                   f_kl_351 (t.accs, t.pawn) kl_351, nvl(w.tip,0) tip,p.kod_351
                                            from   tmp_rez_obesp23 t,cc_pawn p,cc_pawn23add c, pawn_tip w
                                            where  dat = p_dat01 and t.sall<>0 and t.pawn = p.pawn and p.pawn = c.pawn (+) and p.pawn = w.pawn(+)
                                                   and t.nd = d.nd and t.accs = s.acc)
                                            group by bv_all, ost, accs, tip, pawn, kl_351, kpz, rpb, kod_351)) m
                              where a.acc=m.accs (+) and a.acc=s.acc
                      )
            LOOP

            l_tipa := 10; l_pd_0 := 0;
            --logger.info('REZ_351 3 : nd = ' || d.nd || ' z.pawn = '|| z.pawn ) ;
            l_ccf := 100;
            if   s.custtype = 2 THEN d.vidd := 1 ; l_tip_fin := 2;
            else                     d.vidd := 11; l_tip_fin := 1;
            end if;
            if    d.vidd in ( 1, 2, 3)                                      THEN l_idf:=50; l_f := 56;
            elsif d.vidd in (11,12,13) and s.kv  = 980 and nvl(z.tip,0) = 0 THEN l_idf:=60; l_f := 60;
            elsif d.vidd in (11,12,13) and s.kv  = 980 and nvl(z.tip,0) = 1 THEN l_idf:=61; l_f := 60;
            elsif d.vidd in (11,12,13) and s.kv  = 980 and nvl(z.tip,0) = 2 THEN l_idf:=62; l_f := 60;
            elsif d.vidd in (11,12,13) and s.kv <> 980 and nvl(z.tip,0) = 1 THEN l_idf:=63; l_f := 60;
            elsif d.vidd in (11,12,13) and s.kv <> 980 and nvl(z.tip,0) = 2 THEN l_idf:=64; l_f := 60;
            else                                                                 l_idf:=65; l_f := 60;
            end if;
            l_fin  := f_rnk_maxfin(p_dat01, s.rnk, l_tip_fin, d.nd, 1);
            if s.nbs like '9%' THEN l_tipa := 90;
               if s.wdate is not null and s.sdate is not null THEN
                  l_srok := s.wdate-s.sdate;
                  if    l_srok <  365 THEN srok := 1;
                  elsif l_srok < 1095 THEN srok := 2;
                  else                     srok := 3;
                  end if;
               else                        srok := 3;
               end if;
               l_CCF := F_GET_CCF (s.nbs, s.ob22, srok); 
            end if;
            --logger.info('REZ_351 4 : nd = ' || d.nd || ' s.rnk=' || s.rnk ||  ' l_fin=' || l_fin || ' VKR = ' || VKR_  ||' l_idf='|| l_idf ) ;
            l_pd      := fin_nbu.get_pd(s.rnk, d.nd, p_dat01,l_fin, VKR_,l_idf);
            -- l_EAD     := z.osta;

            if s.rnk = 90931101 and sys_context('bars_context','user_mfo') = '300465' THEN   -- COBUSUPABS-5538
               l_fin := 1;
               l_PD  := 0;
            end if;
            l_s080    := f_get_s080  (p_dat01,l_tip_fin, l_fin);
            l_EAD     := nvl(z.bv,z.osta);
            if ((l_ead = 0 or l_ead is null ) and z.sall is null and l_tipa in (41,42,10) ) or s.nbs='9129'  THEN
               l_EAD  := nvl(z.bv_all,z.bv02);
            end if;
            l_zal     := round((nvl(z.sall,0) * nvl(z.kl_351,0))/100,2);
            l_zal_lgd := z.zal_lgd/100;
            l_s       := z.osta/100;
            l_zalq    := p_icurval(s.kv,l_zal*100,l_dat31)/100;
            l_RC      := 0;
            --logger.info('REZ_351 4 : nd = ' || d.nd || ' l_pd =' || l_pd || ' l_EAD=' || l_EAD ) ;

            l_EAD     := l_EAD * l_CCF/100;
            l_EAD     := round(l_EAD / 100,2);
            l_EADQ    := p_icurval(s.kv,l_EAD*100,l_dat31)/100;

            if l_ead = 0 or nvl(l_s,0) + nvl(L_RC,0) = 0 THEN L_LGD := 1;
            else                                              l_LGD := round(greatest(0,1 - (l_zal_lgd + L_RC) / l_s),8);
            end if;

            if s.nbs in ('9129','9122') and l_r013 = 9 THEN 
               l_pd   :=0; l_pd_0 := 1; l_lgd := 1; l_fin := 1;
               l_s080 := f_get_s080 (p_dat01,l_tip_fin, l_fin);
            end if;
            IF l_dv >= 51 and  l_lgd >=l_lgd_51 then
               if f_rnk_not_uudv(s.rnk) = 0 THEN l_LGD  := l_lgd_51; end if;
            end if;

            L_CR      := round(l_pd * L_LGD *l_EAD,2);
            l_CRQ     := p_icurval(s.kv,L_CR*100,l_dat31)/100;
            l_BV      := nvl(z.bv_all,nvl(z.bv02,z.bv))/100;
            l_BV02    := z.osta /100;
            l_BVQ     := p_icurval(s.kv,l_bv*100,l_dat31)/100;
            l_BV02q   := p_icurval(s.kv,l_bv02*100,l_dat31)/100;
            --logger.info('REZ_351 4 : nd = ' || d.nd || ' l_fin = '|| l_fin || ' l_pd = ' || l_pd  ) ;
            l_zal_bv  := z.sall/100;
            l_zal_bvq := p_icurval(s.kv,l_zal_bv*100,l_dat31)/100;
            l_CR_LGD  := l_ead*l_pd*l_lgd;
            if l_tipa  <> 90 THEN l_ccf := NULL; end if;
            begin
               select nd into l_nd from REZ_CR where fdat = p_dat01 and acc = s.acc and (pawn = z.pawn or pawn is null and z.pawn is null);
            EXCEPTION WHEN NO_DATA_FOUND THEN

               INSERT INTO REZ_CR (fdat    , RNK      , NMK     , ND    , KV      , NLS      , ACC    , EAD   , EADQ      , FIN   , PD    , CR     ,
                                   CRQ     , bv       , bvq     , VKR   , IDF     , KOL      , FIN23  , TEXT  , tipa      , pawn  , zal   , zalq   ,
                                   zal_bv  , zal_bvq  , kpz     , vidd  , tip_zal , LGD      , nbs    , tip   , custtype  , RC    , BV02  , bv02q  ,
                                   KL_351  , sdate    , wdate   , s080  , ddd_6B  , tip_fin  , ob22   , pd_0  , cc_id     , RZ    , OVKR  , P_DEF  ,
                                   OVD     , OPD      , CR_LGD  , dv    , istval  , CCF      )
                           VALUES (p_dat01 , s.RNK    , s.NMK   , d.nd  , s.kv    , s.nls    , s.acc  , l_ead , l_eadq    , l_fin , l_pd  , l_CR   ,
                                   l_CRQ   , l_bv     , l_bvq   , VKR_  , l_idf   , l_kol    , d.fin23, null  , l_tipa    , z.pawn, l_zal , l_zalq ,
                                   l_zal_bv, l_zal_bvq, z.kpz   , d.vidd, z.tip   , l_LGD    , s.nbs  , s.tip , s.custtype, l_RC  , l_bv02, l_bv02q,
                                   z.kl_351, S.sdate  , S.wdate , l_s080, l_ddd   , l_tip_fin, s.ob22 , l_pd_0, d.ndoc    , s.RZ  , l_OVKR, l_PDEF ,
                                   l_OVD   , l_OPD    , l_CR_LGD, l_dv  , l_istval, l_ccf    );
            end;

            for i in (select a.*, -ost_korr(a.acc,l_dat31,null,a.nbs) BV from nd_acc n,accounts a
                      where  n.nd = d.nd and n.acc=a.acc and a.tip in ('SNA','SDI') and nbs not in (3648))
            LOOP
               l_ddd  := f_ddd_6B(i.nbs);
               l_BV   := i.bv / 100;
               l_BVQ  := p_icurval(i.kv,i.bv,l_dat31)/100;
               update rez_cr set tip = i.tip where fdat = p_dat01 and acc = i.acc;
               IF SQL%ROWCOUNT=0 then
                  INSERT INTO REZ_CR (fdat   , RNK   , NMK      , ND    , KV     , NLS    , ACC   , EAD       , EADQ    , FIN    , CR  , CRQ  ,
                                      bv     , bvq   , VKR      ,  KOL  , FIN23  , tipa   , vidd  , CUSTTYPE  , nbs     , dv     , BV02, tip  ,
                                      s080   , ddd_6B, tip_fin  , ob22  , bv02q  , sdate  , RZ    , cc_id     , istval  , wdate  , pd_0)
                              VALUES (p_dat01, s.RNK , s.NMK    , d.nd  , i.kv   , i.nls  , i.acc , 0         , 0       , l_fin  , 0   , 0    ,
                                      l_bv   , l_bvq , VKR_     , l_kol , d.fin23, l_tipa , d.vidd, s.CUSTTYPE, i.nbs   , l_dv   , l_bv, i.tip,
                                      l_s080 , l_ddd , l_tip_fin, i.ob22, l_bvq  , s.sdate, s.RZ  , d.ndoc    , l_istval, s.wdate, 0   );
               end if;
            END LOOP;
         end LOOP;
      end LOOP;
   End LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец ОВЕР 351 ');
   if p_mode = 0 THEN
      p_nbu23_cr(p_dat01);
   end if;
end;
/
show err;

PROMPT *** Create  grants  OVER_351 ***
grant EXECUTE                                                                on OVER_351        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OVER_351        to RCC_DEAL;
grant EXECUTE                                                                on OVER_351        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OVER_351.sql =========*** End *** 
PROMPT ===================================================================================== 
