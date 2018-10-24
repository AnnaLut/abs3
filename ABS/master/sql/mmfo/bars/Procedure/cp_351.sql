CREATE OR REPLACE PROCEDURE BARS.CP_351 (p_dat01 date, p_mode integer  default 0 ) IS

/* Версия 12.7  23-10-2018  12-07-2018  03-01-2018 27-09-2017  21-09-2017  18-09-2017 31-07-2017   
   Розрахунок кредитного ризику по ЦП

23) 23-10-2018(12.7) - (COBUMMFO-7488) - Добавлено ОКПО в REZ_CR
22) 12-07-2018(12.6) - Новые счета ('SDI','SDA','SDM','SDF','SRR')
21) 26-01-2018(12.5) - PD_0 - для пассивных = l , было =0!
20) 03-01-2018(12.4) - R013='' - символьный
19) 27-09-2017 - уточнила таблиці для опредлеления PD
18) 21-09-2017 - Проверять 'UUDV' по всем (было по custtype=2)
17) 18-09-2017 - Новая ф-ция f_get_nd_val_n 
16) 31-07-2017 - Проверка наличия гарантий (PAWN=11) - может быть несколько записей
15) 19-05-2017 - S080 по SNA
14) 26-04-2017 - По ЦБ уточнение условия (d.active=1 or d.active = -1 and d.dazs >= p_dat01)
13) 05-04-2017 - rnk = 90931101
12) 06-03-2017 - LGD (округление 8 знаков)
11) 03-03-2017 - Если держ. власності >51 %, но клиент в таблице rnk_not_uudv считать как обычный
10) 15-02-2017 - p_error_351 уточнила РНК, NLS, ....
 9) 15-02-2017 - Исключить бал. 4203
 8) 14-02-2017 - ISTVAL из SPECPARAM
 7) 08-02-2017 - Добавлен счет accexpn
 6) 24-01-2017 - Добавлены параметры s080,TIP_FIN,ddd_6B
 5) 10-01-2017 - Запись SNA, SDI в REZ_CR
 4) 03-01-2017 - Добавлено WDATE
 3) 21-12-2016 - Фин.стан установленный по ОКПО (FIN_RNK_OKPO)
 2) 25-11-2016 - Державна власність был только по ЮО 'UUDV'
 1) 04-10-2016 - p_BLOCK_351(p_dat01 date); -- блокировка расчета 
*/

 kv_       accounts.kv%type    ; l_accd      cp_deal.accd%type    ; l_accexpn cp_deal.accexpn%type  ; l_ovd   rez_cr.ovd%type  ;
 l_istval specparam.istval%type; l_accs      cp_deal.accs%type    ; l_cus     customer.custtype%type; l_ovkr  rez_cr.ovkr%type ; 
 l_r013   specparam.r013%type  ; l_accr      cp_deal.accr%type    ; l_pawn    cc_pawn.pawn%type     ; l_pdef  rez_cr.p_def%type; 
 l_s080   specparam.s080%type  ; l_accunrec  cp_deal.accunrec%type; l_ddd     kl_f3_29.ddd%type     ; l_opd   rez_cr.opd%type  ; 
                                
 l_kol      INTEGER;  l_pd_0    INTEGER;  l_tip_fin   INTEGER;  acc8_       INTEGER;  l_idf     INTEGER;  l_fin      INTEGER;
 l_tipa     INTEGER;  l_fin23   INTEGER;                                
 l_pd       NUMBER ;  l_CRQ     NUMBER ;  l_EAD       NUMBER ;  l_zal       NUMBER ;  l_zalq    NUMBER ;  l_zal_BV   NUMBER ; 
 l_zal_BVq  NUMBER ;  l_EADQ    NUMBER ;  l_LGD       NUMBER ;  l_CR        NUMBER ;  l_RC      NUMBER ;  l_bv       NUMBER ;  
 l_BVQ      NUMBER ;  l_bv02    NUMBER ;  l_BV02q     NUMBER ;  cp_acc_     number ;  cp_accp_  number ;  cp_accd_   number ;  
 cp_accs_   number ;  cp_accr_  number ;  cp_accr2_   number ;  l_accexpr   number ;  l_accr3   number ;  l_RCQ      number ;  
 l_dv       NUMBER ;  l_CR_LGD  NUMBER ;  l_RZ        NUMBER ;  l_zal_lgd   NUMBER ;  l_fin_351 NUMBER ;  l_pd_351   NUMBER ;  
 l_fin_okpo NUMBER ;  l_s       NUMBER ;  l_lgd_51    NUMBER := 0.3;

 VKR_  varchar2(3);  l_txt  varchar2(1000); l_vkr  varchar2(50); l_nbs  char(4); l_kf varchar2(6);

 l_sdate  date;  l_dat31  date;  

begin                                                                                    
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   p_BLOCK_351(p_dat01);
   l_kf := sys_context('bars_context','user_mfo');
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало ЦП 351 ');
   dbms_application_info.set_client_info('CR_351_JOB:'|| l_kf ||': ЦП 351');
   l_tipa := 15;
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   delete from REZ_CR where fdat=p_Dat01 and tipa = l_tipa;
   for d in ( SELECT a.rnk, a.acc, a.kv, d.id,  d.REF,  d.erat, a.nls, a.tobo, d.accs,kk.vncrr,kk.emi,kk.fin23,kk.cp_id,kk.datp,kk.dox,
                     c.custtype, substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK, 
                     DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, c.okpo  
              FROM cp_deal d,  accounts a, CP_KOD KK, customer c
              WHERE D.ID = KK.ID AND (d.acc = a.acc AND KK.DOX > 1    OR     d.accp = a.acc  AND KK.DOX = 1 ) and 
                   (d.active=1 or d.active = -1 and d.dazs >= p_dat01) and a.rnk = c.rnk and substr(a.nls,1,4) not in ('3541')
             --SELECT a.acc, v.*,  c.custtype, substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK, 
             --       DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ    
             --FROM V_CP_MANY v,customer c,accounts a where v.rnk=c.rnk and v.nls=A.NLS and v.kv=a.kv
            )
   LOOP 
      l_dv := 0;
      l_vkr:= 'Ценные бумаги ';

      begin 
         SELECT  CASE WHEN REGEXP_LIKE(value,'^[ |.|,|0-9]+$')  THEN 0+REPLACE(REPLACE(value ,' ',''),',','.') 
                 ELSE                                                0 END
                 INTO l_dv 
         FROM customerw WHERE rnk=d.rnk AND trim(tag)='UUDV';
      EXCEPTION WHEN OTHERS THEN l_dv := 0;  
      END; 
      begin
         select pawn into l_pawn from tmp_rez_obesp23 where dat = p_dat01 and nd = d.ref and pawn = 11 and rownum=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_pawn := 0;          
      end;
      begin 
         SELECT  fin_351,pd INTO l_fin_351,l_pd_351 
         FROM cp_kod WHERE id = d.id;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_fin_351 := NULL; l_pd_351 := NULL; 
      END; 

      l_ovkr := null; --f_ovkr(d.rnk,d.ref); --    ознаки високого кредитного ризику:-
      l_pdef := null; --f_pdef(d.rnk,d.ref); --    події дефолту;
      l_ovd  := null; --f_ovd (d.rnk,d.ref); --    ознаки визнання дефолту;
      l_opd  := null; --f_opd (d.rnk,d.ref); --    ознаки припинення дефолту;

      l_sdate:=null;
      select  acc ,    accp ,    accd ,    accs ,    accr ,    accr2 ,   accr3,   accexpr,   accunrec, accexpn
      into cp_acc_, cp_accp_, cp_accd_, cp_accs_, cp_accr_, cp_accr2_, l_accr3, l_accexpr, l_accunrec, l_accexpn
      from cp_deal where ref = d.ref;

      begin      
         select  cp_acc into cp_accp_  from cp_accounts c  where  CP_ACCTYPE in ('S2') and cp_ref = d.ref;
      EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
      end;  

      for s in (select kv, acc, rnk, NVL(nbs,SUBSTR(NLS,1,4)) NBS, tip, nls, ob22, BV, f_bv_sna_cp (p_dat01 , d.ref , acc) osta
                from ( select kv, acc, rnk, nbs, tip, nls, nvl(ob22,'01') ob22, -ost_korr (acc,l_dat31,z23.di_,nbs)  BV from  accounts
                       where acc in (select cp_acc from cp_accounts c where c.cp_ref = d.ref and c.cp_acctype in ('N','D','RD','EXPN','EXPR','P','R','R2','R3','S','S2','UNREC'))  
                         and nls not like '8%' and substr(nls,1,4) not in ('4103','4203')
                             --and ost_korr (acc,l_dat31,null,nbs) < 0
                      )
                 )
   
      loop
--logger.info('REZ_351_cp 1   : nd = ' || d.ref || ' s.acc = '|| s.acc || ' bv = '|| s.bv) ;   
         if D.vncrr is null or f_vkr_correct (D.vncrr) = 0 THEN
            p_error_351( P_dat01, d.ref, user_id, 16, null, s.acc, s.kv, null, l_vkr, s.rnk, s.nls); 
         end if;


            l_ddd  := f_ddd_6B(s.nbs);
            s.tip  := f_get_tip (substr(s.nls,1,4), s.tip);
            l_pd_0 := 0; l_istval := 0; l_lgd := 0;
            begin
               select dat_ug into l_sdate  from   cp_arch where  ref = d.ref and rownum=1;
            exception when no_data_found then l_sdate:=null;
            end;
   
            if s.kv = 980 THEN l_istval := 0;
            else               
               --istval_ := f_get_istval_351(p_dat01,d.ref,15,d.rnk);
               begin 
                  SELECT nvl(istval,0) INTO l_istval FROM specparam p  WHERE  s.acc = p.acc (+);
               EXCEPTION WHEN NO_DATA_FOUND THEN l_istval := 0;  
               END; 
            end if; 

            if    d.custtype = 1 and d.RZ =2   THEN l_idf := 81; l_tip_fin := 1;
            elsif d.custtype = 1 and d.RZ =1   THEN l_idf := 80; l_tip_fin := 1;  
            elsif d.custtype = 2               THEN l_idf := 50; l_tip_fin := 2;
            elsif d.custtype = 3 and d.kv<>980 THEN l_idf := 65; l_tip_fin := 1;
            else                                    l_idf := 62; l_tip_fin := 1;
            end if;
   
            l_fin      := f_rnk_maxfin(p_dat01, d.rnk, l_tip_fin, d.ref, 1);
            l_fin_okpo := f_get_fin_okpo (d.rnk);
            if l_fin_okpo is not null THEN l_fin := least(l_fin,l_fin_okpo); end if;
      
            if d.emi in (0,6)       or
               s.nls like '30%'     or
               s.nls like '140%'    
               --d.emi =10 and d.dox=1  -Убрали 07-04-2017  
                    then l_pd := 0; l_pd_0 := 1; l_fin := 1; 
            else 
               l_pd := l_pd_351;
               if l_pd is null THEN
                  l_pd := fin_nbu.get_pd(d.rnk, d.ref, p_dat01, l_fin, d.VNCRR, l_idf);
               end if; 
            end if;
            if s.nbs='3102' and s.rnk = 90931101 THEN l_fin := 1; l_PD := 0; end if;  -- COBUSUPABS-5538
            if s.nbs='3102' and s.rnk = 10020901 THEN l_PD  := 0; end if;             -- Лист 24-02-2017 (16:00) Кузьменко Віталій
            if s.nbs='3105' THEN
               begin 
                  SELECT r013 INTO l_r013 FROM specparam p  WHERE  s.acc = p.acc (+);
               EXCEPTION WHEN NO_DATA_FOUND THEN l_r013 := NULL;  
               END; 
               if l_r013 in ('2','V') THEN l_pd := 0; end if;
            end if;

            if l_pawn = 11 THEN l_pd := 0; l_pd_0 := 1; l_fin := 1; end if;

            l_s080 := f_get_s080 (p_dat01,l_tip_fin, l_fin);             
--logger.info('REZ_351_cp 2   : nd = ' || d.ref || ' s.acc = '|| s.acc || ' bv = '|| s.bv || ' s.tip = '|| s.tip) ;   
         if s.bv > 0 and s.tip not in ('SDI','SDA','SDM','SDF')  THEN      
            for z in (select NVL(f_zal_accs (p_dat01, d.ref, a.acc),0) zal_lgd, a.acc, a.kv, -ost_korr(a.acc,l_dat31,null,a.nbs) BV02, 
                             f_bv_sna_cp  (p_dat01, d.ref ,a.acc) osta, m.* 
                      from   accounts a,  
                            (select accs, ost, round (ost*sall / sum(sall) over  (partition by 1), 0) bv, sall, nvl(tip,0) tip, pawn, 
                                    kl_351, kpz, rpb, round (bv_all*sall / sum(sall) over  (partition by 1), 0) bv_all, kod_351
                             FROM ( select  ost, accs, nvl(sum(sall),0) sall,tip, pawn, kl_351, kpz, rpb, kod_351,bv_all 
                                    from   (select  f_bv_sna_cp (p_dat01, d.ref , t.accs) ost,-ost_korr(t.accs,l_dat31,null,
                                                    substr(t.accs,1,4)) BV_ALL, t.accs,t.accz,t.nd,t.pawn,p.name,t.sall, t.kpz, t.rpb, 
                                                    f_kl_351 (t.accs, t.pawn) kl_351, nvl(w.tip,0) tip,p.kod_351 
                                            from    tmp_rez_obesp23 t,cc_pawn p,cc_pawn23add c, pawn_tip w 
                                            where   dat = p_dat01 and t.sall<>0 and t.pawn = p.pawn and p.pawn = c.pawn (+) and p.pawn = w.pawn(+)  
                                                    and t.nd = d.ref and t.accs = s.acc)
                                    group by bv_all, ost, accs, tip, pawn, kl_351, kpz, rpb, kod_351)) m
                             where  a.acc=m.accs (+) and a.acc=s.acc     
                      )
            
            LOOP         
               --if s.bv > 0 THEN
               --l_EAD  := nvl(s.osta,s.bv); 
               l_lgd     := 0;
               l_zal_lgd := 0; 
               l_EAD     := nvl(z.bv,z.osta);
               l_EAD     := greatest(l_EAD,0); 
               l_EAD     := round(l_EAD / 100,2);
               --l_zal  := 0;
               l_zal     := (nvl(z.sall,0) * nvl(z.kl_351,0))/100; l_zal_lgd := z.zal_lgd/100;
               l_zal     := round(l_zal,2);
               l_zalq    := p_icurval(s.kv,l_zal*100,l_dat31)/100;      
               l_s       := z.osta/100;
               if l_ead = 0 or nvl(l_zal,0) + nvl(L_RC,0) = 0 THEN L_LGD := 1;
               else                                                l_LGD := round(greatest(0,1 - (l_zal_lgd + L_RC) / l_s),8); 
                                                                 --l_LGD := round(greatest(0,1 - (l_zal + L_RC) / l_ead),8);     
               end if;
   
               if l_dv >=51 and l_LGD>= l_lgd_51 THEN 
                  if f_rnk_not_uudv(s.rnk) = 0 THEN l_LGD  := l_lgd_51; end if;
                  L_CR   := round(l_pd * L_LGD *l_EAD,2);
                  --logger.info('REZ_351_cp 445   : nd = ' || d.ref || ' l_EAD = '|| l_EAD || ' l_pd = ' || l_pd || ' l_CR = ' || l_CR ||' l_zal = ' || l_zal ) ;   
               else   
                  l_CR   := round(l_pd * (l_EAD - l_zal),2);
               end if;
               --logger.info('REZ_351_cp 44 : nd = ' || d.ref || ' l_EAD = '|| l_EAD || ' l_pd = ' || l_pd || ' l_lgd = ' || l_lgd ||' l_s = ' || l_s ) ;   
               l_CRQ     := p_icurval(d.kv,L_CR*100,l_dat31)/100; 
               if s.tip = 'SPI' THEN l_EAD := 0; end if;  -- Премія не входит в експозицію під ризиком
               l_EADQ    := p_icurval(d.kv,l_EAD*100,l_dat31)/100;      
               l_BV      := nvl(z.bv_all,z.bv02)/100; 
               l_BVQ     := p_icurval(d.kv,l_bv*100,l_dat31)/100; 
               l_RC      := 0;
               l_RCQ     := 0;
               l_CR_LGD  := l_ead*l_pd*l_lgd;
               l_nbs     := substr(s.nls,1,4);
               l_kol     := f_get_nd_val_n('KOL', d.ref, p_dat01, l_tipa, d.rnk);
               l_zal_bv  := z.sall/100;
               l_zal_bvq := p_icurval(s.kv,l_zal_bv*100,l_dat31)/100;      
               --logger.info('REZ_351_cp 4 : nd = ' || d.ref || ' l_fin = '|| l_fin || ' l_pd = ' || l_pd  ) ;   
               INSERT INTO REZ_CR (fdat   , RNK   , NMK     , ND    , SDATE   , KV       , NLS     , ACC      , EAD   , EADQ      , 
                                   FIN    , PD    , CR      , CRQ   , bv      , bvq      , VKR     , IDF      , KOL   , FIN23     , 
                                   tipa   , pawn  , zal     , zalq  , kpz     , vidd     , tip_zal , LGD      , OVKR  , P_DEF     , 
                                   OVD    , OPD   , istval  , dv    , CR_LGD  , nbs      , zal_bv  , zal_bvq  , tip   , custtype  , 
                                   RC     , RCQ   , cc_id   , s080  , ddd_6B  , tip_fin  , ob22    , pd_0     , RZ    , KL_351    , 
                                   okpo   , wdate )     
                           VALUES (p_dat01, d.RNK , d.NMK   , d.ref , l_sdate , d.kv     , s.nls   , s.acc    , l_ead , l_eadq    , 
                                   l_fin  , l_pd  , l_CR    , l_CRQ , l_bv    , l_bvq    , D.vncrr , l_idf    , l_kol , d.fin23   , 
                                   l_tipa , z.pawn, l_zal   , l_zalq, z.kpz   , null     , z.tip   , l_LGD    , l_OVKR, l_PDEF    , 
                                   l_OVD  , l_OPD , l_istval, l_dv  , l_CR_LGD, l_nbs    , l_zal_bv, l_zal_bvq, s.tip , d.custtype, 
                                   l_RC   , L_RCQ , d.cp_id , l_s080, l_ddd   , l_tip_fin, s.ob22  , l_pd_0   , d.rz  , z.kl_351  , 
                                   d.okpo , d.datp);  
            end loop;
         elsif s.bv<>0 THEN
--logger.info('REZ_351_cp 4   : nd = ' || d.ref ) ;   
            --select    accd, accs, accr, accunrec into l_accd, l_accs, l_accr, l_accunrec from cp_deal where ref = d.ref;
            --for i in (select a.*, -ost_korr(a.acc,l_dat31,null,a.nbs) BV
            --          from  accounts a
            --          where a.acc in (select cp_acc from cp_accounts c where c.cp_ref = d.ref and c.cp_acctype in ('P','D','UNREC','R','S','S2') )   and nls not like '8%' and 
            --                ost_korr(a.acc,l_dat31,null,a.nbs) <> 0 and  not exists (select 1 from rez_cr r  where r.fdat=p_dat01 and r.acc = a.acc)--and a.tip  in ('SNA','SDI','SDA','SDM','SDF')                                        
                                     
            --         )
            --loop

--logger.info('REZ_351_cp 3   : nd = ' || d.ref || ' acc = '|| s.acc || ' bv = '|| s.bv) ;  
               --l_nbs  := substr(i.nls,1,4);
               l_ddd  := f_ddd_6B(s.nbs);
               l_BV   := s.bv / 100;             
               l_BVQ  := p_icurval(s.kv,s.bv,l_dat31)/100; 
               update rez_cr set tip = s.tip where fdat = p_dat01 and acc = s.acc;
               IF SQL%ROWCOUNT=0 then                                                                             
                  INSERT INTO REZ_CR (fdat    , RNK   , NMK  , ND    , KV     , NLS      , ACC  , EAD    , EADQ   , FIN  , PD        , 
                                      CR      , CRQ   , bv   , bvq   , VKR    , IDF      , KOL  , FIN23  , tipa   , vidd , CUSTTYPE  , 
                                      nbs     , dv    , BV02 , s080  , ddd_6B , tip_fin  , tip  , bv02q  , sdate  , RZ   , cc_id     , 
                                      okpo   , istval  , wdate , pd_0  , ob22   )                                        
                              VALUES (p_dat01, d.RNK   , d.NMK , d.ref , s.kv   , s.nls    , s.acc, 0      , 0      , l_fin, l_pd      ,
                                      0       , 0     , l_bv , l_bvq , D.vncrr, l_idf    , l_kol, d.fin23, l_tipa , null , d.CUSTTYPE, 
                                      s.nbs  , l_dv    , l_bv  , l_s080, l_ddd  , l_tip_fin, s.tip, l_bvq  , l_sdate, d.RZ , d.cp_id   , 
                                      d.okpo , l_istval, d.datp, l_pd_0, nvl(s.ob22,'01') ) ;  
               END IF;
            --END LOOP;
         end if;
      end loop;    
   End LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец ЦП 351 ');
end;
/
show err;

PROMPT *** Create  grants  CP_351 ***
grant EXECUTE                                                                on CP_351          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_351          to RCC_DEAL;
grant EXECUTE                                                                on CP_351          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_351.sql =========*** End *** ==
PROMPT ===================================================================================== 
