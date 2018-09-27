CREATE OR REPLACE PROCEDURE BARS.CCK_351 (p_dat01 date, p_nd integer, p_mode integer  default 0 ) IS

/* Версия 15.0   10-09-2018  12-07-2018  20-04-2018  10-04-2018  26-03-2018  28-11-2017 16-11-2017  
   Розрахунок кредитного ризику по кредитах + БПК

   ----------------------------------------------
31) 10-09-2018(15.0) - ОВЕР - 2600 добавлен 
30) 12-07-2018(14.9) - Новые счета - ('SDI','SDA','SDM','SDF','SRR') по ОВЕРАМ выборка , как по кредитам
29) 20-04-2018(14.8) - По Крыму FIN = max, PD = 1 (COBUSUPABS-5846 (Крым), лист 18-04-2018 20:36, будет в COBUMMFO-7561)
28) 10-04-2018(14.7) - по оверам исключить залоги - a.tip <> 'ZAL' + по БПК исключить 3570,3578 -  b.tip not in ('SK9','ODB','OFR')
27) 26-03-2018(14.6) - По физикам при определении PD использ. l_idf вместо l_fp (не перехідні положення) + по оверам исключить 3570,3578
26) 28-11-2017(14.5) - Новый план счетов по ОВЕРАМ холдинга берем все счета + 9003 вместо 9023
25) 27-11-2017(14.4) - LGD 9129 для безризикових =1 , по ризиковим розраховується
24) 17-10-2017(14.3) - При удалении из таблицы добавила tipa = 90 - 9129 по оверам и 94 - 9129 по БПК
23) 03-10-2017(14.2) - Тип счета по БПК из REZ_W4_BPK
22) 06-09-2017 - Товары в обороте S240 - если срок действия договора < 1 года, иначе не учитывать
21) 30-08-2017 - ОВЕР из CC_DEAL по условию VIDD = 110
21) 25-07-2017 - Для бюджетних установ PD не через перехідні положення (IDF = 70)
20) 20-06-2017 - S240 - по дате окончания договора
20) 16-05-2017 - Параметр'UUDV' - при любой ошибке l_dv := 0; + проверка R013 в кавычках ('9')
19) 05-04-2017 - rnk = 90931101
18) 06-03-2017 - Исключен из кредитов 9601
17) 06-03-2017 - LGD (округление 8 знаков)
16) 03-03-2017 - Исключен из кредитов 9611
15) 03-03-2017 - if l_fin is null and d.tipa in (41,42) THEN l_fin := 5; VKR_ := 'Г'; end if; -- не санкционированный ОВЕРДРАФТ
14) 03-03-2017 - Если держ. власності >51 %, но клиент в таблице rnk_not_uudv считать как обычный
13) 23-02-2017 - ОСББ - f_fin_pd_grupa_ul  FIN	  PD	 LGD	LGDV
                                             1	0,15	0,95	1,00
12) 22-02-2017 - Фін.кдас по SNA, SDI
11) 15-02-2017 - Убрала p_nbu23_cr
10) 01-02-2017 - REAL ='Ні' Немає наявн.док.підтверд.ймовірності ралізації забезпеч.  z.kl_351 := 0;
 9) 24-01-2017 - Добавлены параметры s080,TIP_FIN,ddd_6B
 8) 10-01-2017 - Запись SNA, SDI в REZ_CR
 7) 21-12-2016 - Фин.стан установленный по ОКПО (FIN_RNK_OKPO)
 6) 21-12-2016 - ОСББ --> портфельный метод (< 30 дней просрочка до 250000.00 грн. задолженность)
 5) 23-11-2016 - zal_bv - #0.00
 4) 20-10-2016 - Недіючи кредити (REAL = Ні)
 3) 04-10-2016 - p_BLOCK_351(p_dat01 date); -- блокировка расчета
 2) 03-10-2016 - добавила nd_open - действующие кредитные договора
 1) 26-09-2016 - бюджет по CC_DEAL(PROD) TIPA = 4

  TIPA:
       3 - кредиты
       4 - бюджет
       9 - фінансові зобов`язання - кредиты (9129)
      10 - ОВЕРДРАФТЫ
      41 - старый процессинг (карточки)
      42 - новый  процессинг (карточки)
      90 - фінансові зобов`язання - ОВЕРДРАФТЫ (9129)
      94 - фінансові зобов`язання - БПК (9129)


  l_tip_fin:
       0 --> 1 - 2
       1 --> 1 - 5
       2 --> 1 - 10
*/

 l_istval specparam.istval%type; l_r013  specparam.r013%type; l_ovkr   rez_cr.ovkr%type   ;
 l_pdef   rez_cr.p_def%type    ; l_ovd   rez_cr.ovd%type    ; l_opd    rez_cr.opd%type    ; l_err_type  SREZERV_ERROR_TYPES.ERROR_TYPE%type;
 l_s080   specparam.s080%type  ; l_ddd   kl_f3_29.ddd%type  ; l_s240   specparam.s240%type; l_s250      rez_cr.s250%type;
 l_grp    rez_cr.grp%type      ; l_poci  rez_cr.poci%type   ;

 l_kol      INTEGER; acc8_     INTEGER; l_idf      INTEGER; l_fin     INTEGER; l_tipa     INTEGER; l_fin23     INTEGER; l_f      INTEGER;
 l_fp       INTEGER; l_pd_0    INTEGER; l_tip_fin  INTEGER; l_kz      INTEGER; srok       INTEGER;
 l_pd       NUMBER ; l_CRQ     NUMBER ; l_EAD      NUMBER ; l_zal     NUMBER ; l_EADQ     NUMBER ; l_LGD       NUMBER ; l_CR     NUMBER ;
 l_RC       NUMBER ; l_bv      NUMBER ; l_BVQ      NUMBER ; l_bv02    NUMBER ; l_BV02q    NUMBER ; l_ccf       NUMBER ; l_srok   NUMBER ;
 L_RCQ      NUMBER ; L_CR_LGD  NUMBER ; l_zalq     NUMBER ; l_zal_BV  NUMBER ; l_zal_BVq  NUMBER ; l_dv        NUMBER ; l_polis  NUMBER ;
 l_zal_lgd  NUMBER ; l_s       NUMBER ; l_EADR     NUMBER ; l_RZ      NUMBER ; l_tip_kv   NUMBER ; l_fin_okpo  NUMBER ; l_lgd_51 NUMBER := 0.3;

 VKR_  varchar2(3);  l_txt  varchar2(1000);  l_vkr   varchar2(50)  ;  l_real  varchar2(3);  l_text  VARCHAR2(250) ; l_kf varchar2(6);

 l_dat31  date;

 TYPE CurTyp IS REF CURSOR;
 c0   CurTyp;

begin
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   p_BLOCK_351(p_dat01);
   l_kf := sys_context('bars_context','user_mfo');
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало Кредиты + БПК 351 ');
   dbms_application_info.set_client_info('CR_351_JOB:'|| l_kf ||': Кредиты + БПК 351');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   if p_mode = 0 Then
      p_kol_nd(p_dat01, 0, 0);
      p_kol_nd_bpk(p_dat01, 0);
   end if;
   delete from ex_kl351;
   delete from REZ_CR where fdat=p_Dat01 and tipa in ( 3, 9, 41, 42, 4, 10, 90, 94);
   for d in (SELECT e.nd, e.cc_id, e.vidd, e.fin23, decode(e.vidd, 110, 10, 3) tipa, sdate, wdate, e.prod, e.rnk, e.pd,
                    cck_app.get_nd_txt(e.nd, 'VNCRR') vkr
             FROM CC_DEAL e, nd_open n
             WHERE  e.VIDD IN (1,2,3,110,11,12,13)  AND e.SDATE  <  p_DAT01 and  p_nd in (0, e.nd)
               and  n.fdat = p_dat01 and e.nd = n.nd -- действующие
             union all
             select distinct nd, null cc_id, 11, fin23, tip_kart tipa, null dat_begin, null dat_end, '2203' prod, null RNK, null pd, vkr
             from rez_w4_bpk b
            )
   LOOP
      --logger.info('REZ_351 1 : nd = ' || d.nd || ' d.vidd = '|| d.vidd ) ;
      vkr_:= d.vkr;
      if d.prod like '21%' THEN d.tipa := 4; l_tip_fin := 1; end if;
      if d.tipa in (41,42) THEN l_VKR  :='БПК ';
      elsif d.tipa in (10) THEN l_VKR  :='ОВЕР';
      else                      l_VKR  :='Кредит ';
                                l_real := substr(trim(cck_app.get_nd_txt(d.nd, 'REAL')),1,3);
      end if;

      If trim(cck_app.get_nd_txt(d.nd, 'POCI')) = 'Так' then l_poci := 1;
      else                                                   l_poci := 0;
      end if;

      DECLARE
         TYPE r0Typ IS RECORD
            ( TIP       accounts.tip%type,
              OB22      accounts.ob22%type,
              NLS       accounts.nls%type,
              acc       accounts.acc%type,
              kv        accounts.kv%type,
              nbs       accounts.nbs%type,
              S         NUMBER,
              rnk       accounts.rnk%type,
              nmk       customer.nmk%type,
              custtype  customer.custtype%type,
              branch    accounts.branch%type,
              RZ        number,
              sed       customer.sed%type
             );
      s r0Typ;
      begin
         if    d.tipa in ( 3, 4, 10)  THEN
            OPEN c0 FOR
               select a.tip, a.ob22, a.nls, a.acc, a.kv,  a.nbs, - ost_korr(a.acc,l_dat31,null,a.nbs) S, a.rnk,
                      substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK, decode(trim(c.sed),'91',3,c.custtype) custtype,
                      a.branch, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ,trim(c.sed) sed
               from   nd_acc n, accounts a, customer c
               where  n.nd = d.nd and n.acc = a.acc and nls not like '3%' and a.nbs not in ('2620','9611','9601')
                 and  (a.tip in  ('SNO','SN ','SL ','SLN','SPN','SS ','SP ','SK9','SK0','CR9','SNA','SDI','SDA','SDM','SDF','SRR')
                 and  ost_korr(a.acc,l_dat31,null,a.nbs) <>0 or a.nbs='2600' and ost_korr(a.acc,l_dat31,null,a.nbs) <0)  
                 and a.rnk = c.rnk order by a.tip desc;
         else
            OPEN c0 FOR
               select b.tip, a.ob22, a.nls, a.acc, a.kv,  a.nbs, - ost_korr(a.acc,l_dat31,null,a.nbs) S, a.rnk,
                      substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK, c.custtype,
                      a.branch, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, '00' sed
               from   rez_w4_bpk b, accounts a, customer c
               where  b.acc = a.acc  and a.rnk=c.rnk and b.nd=d.nd and b.tip not in ('SK9','ODB','OFR');
         end if;
         loop
            FETCH c0 INTO s;
            EXIT WHEN c0%NOTFOUND;
            l_grp   := f_get_port (d.nd, s.rnk);
            if  l_grp <>0 THEN  l_s250 := '8';
            else                l_s250 := null; l_grp := null;
            end if;

            --if s.s > 0 THEN
            l_dv   := 0;
            l_eadr := s.s/100;
            l_ovkr := null; --f_ovkr(s.rnk,d.nd); --    ознаки високого кредитного ризику:-
            l_pdef := null; --f_pdef(s.rnk,d.nd); --    події дефолту;
            l_ovd  := null; --f_ovd (s.rnk,d.nd); --    ознаки визнання дефолту;
            l_opd  := null; --f_opd (s.rnk,d.nd); --    ознаки припинення дефолту;
            l_kol  := f_get_nd_val_n('KOL', d.nd, p_dat01, d.tipa, s.rnk);
            l_s240 := case when (p_dat01 >= d.wdate ) THEN 'Z' else  F_SROK (D.SDATE, d.wdate, 2) end;
            --l_s240 := Fs240 (p_dat01, s.acc );

            if l_s240 in ('C','D','E','F','G','H','Z') and d.tipa not in (41,42) THEN
               update ex_kl351 set kl_351 = 0 where acc = s.acc and pawn = 28;
               IF SQL%ROWCOUNT=0 then
                  insert into ex_kl351 (acc,pawn,kl_351) values (s.acc , 28, 0);
               end if;
               update ex_kl351 set kl_351 = 0 where acc = s.acc and pawn = 282;
               IF SQL%ROWCOUNT=0 then
                  insert into ex_kl351 (acc,pawn,kl_351) values (s.acc , 282, 0);
               end if;
            end if;

            if    VKR_ is null             THEN  l_err_type := 16;
            elsif f_vkr_correct (vkr_) = 0 THEN  l_err_type := 17;
            end if;

            --if l_err_type is not null THEN
            --   p_error_351( P_dat01, d.nd, user_id, l_err_type, s.acc, s.custtype, s.kv, s.branch, l_vkr, s.rnk, s.nls);
            --end if;

            if s.kv = 980 THEN l_istval := 0;
            else
               --istval_ := f_get_istval_351(p_dat01,d.nd,d.tipa,d.rnk);
               begin
                  SELECT nvl(istval,0) INTO l_istval FROM specparam p  WHERE  s.acc = p.acc (+);
               EXCEPTION WHEN NO_DATA_FOUND THEN l_istval := 0;
               END;

            end if;

            if s.nbs in ('9129','9122','9023','9003','9000') THEN
               begin
                  SELECT R013 INTO l_r013 FROM specparam p  WHERE  s.acc = p.acc (+);
               EXCEPTION WHEN NO_DATA_FOUND THEN l_r013:= NULL;
               END;
            end if;

            if s.custtype=2 THEN
               begin
                  SELECT  CASE WHEN REGEXP_LIKE(value,'^[ |.|,|0-9]+$')
                          THEN 0+REPLACE(REPLACE(value ,' ',''),',','.')
                          ELSE 0 END
                          INTO l_dv
                  FROM customerw WHERE rnk=s.rnk AND trim(tag)='UUDV';
               EXCEPTION WHEN OTHERS THEN l_dv := 0;
               END;
            end if;
            if    s.custtype = 2 and d.tipa = 4 THEN l_tip_fin := 1;  -- Бюджетные
            elsif s.custtype = 2                THEN l_tip_fin := 2;
            else                                     l_tip_fin := 1;
            end if;
            l_ddd      := f_ddd_6B(s.nbs);
            l_fin      := f_rnk_maxfin(p_dat01, s.rnk, l_tip_fin, d.nd, 1);
            l_fin_okpo := f_get_fin_okpo (s.rnk);
            if l_fin_okpo is not null THEN l_fin := least(l_fin,l_fin_okpo); end if;
            IF    l_S250 = 8 and d.vidd     in ( 1, 2, 3) THEN  l_fin := 1;
            elsif l_S250 = 8 and d.vidd not in ( 1, 2, 3) THEN  l_fin := f_fin_pd_grupa (1, l_kol);
            end if;
            if l_fin is null and d.tipa in (41,42) THEN l_fin := 5; VKR_ := 'Г'; end if; -- не санкционированный ОВЕРДРАФТ
            l_s080 := f_get_s080 (p_dat01,l_tip_fin, l_fin);
            --logger.info('S080 1 : nd = ' || d.nd || ' l_tip_fin = '||l_tip_fin || ' l_fin = ' || l_fin || ' s080 = ' || l_s080 ) ;

          if s.s > 0 and s.tip not in ('SDI','SDA','SDM','SDF') THEN
            --logger.info('REZ_351 1 : nd = ' || d.nd || ' s.acc = '|| s.acc || ' VKR = ' || VKR_ || 'Остаток = ' || s.s) ;
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

               --l_fin := null;
               l_ccf := 100; l_pd_0 := 0; l_text := NULL;
               --logger.info('REZ_351 44 : nd = ' || d.nd || ' z.pawn = '|| z.pawn || ' d.vidd='||d.vidd ) ;
               if     d.tipa in (41,42,10) and s.custtype = 2 THEN d.vidd := 1 ;
               elsif  d.tipa in (41,42,10)                    THEN d.vidd := 11;
               elsif  s.sed = '91'                            THEN d.vidd := 11;
               end if;
               if    d.vidd in ( 1, 2, 3) and d.prod like '21%'                THEN l_idf:=70; l_f := 76; l_fp := 48;
               elsif d.vidd in ( 1, 2, 3)                                      THEN l_idf:=50; l_f := 56;
               elsif d.vidd in (11,12,13) and z.kv  = 980 and nvl(z.tip,0) = 0 THEN l_idf:=62; l_f := 60; l_fp := 42;
               elsif d.vidd in (11,12,13) and z.kv  = 980 and nvl(z.tip,0) = 1 THEN l_idf:=60; l_f := 60; l_fp := 40;
               elsif d.vidd in (11,12,13) and z.kv  = 980 and nvl(z.tip,0) = 2 THEN l_idf:=61; l_f := 60; l_fp := 41;
               elsif d.vidd in (11,12,13) and z.kv <> 980 and nvl(z.tip,0) = 1 THEN l_idf:=63; l_f := 60; l_fp := 43;
               elsif d.vidd in (11,12,13) and z.kv <> 980 and nvl(z.tip,0) = 2 THEN l_idf:=64; l_f := 60; l_fp := 44;
               else                                                                 l_idf:=65; l_f := 60; l_fp := 45;
               end if;

               if s.nbs like '9%' THEN
                  if d.tipa = 10 THEN l_tipa := 90;
                  else                l_tipa :=  9;
                  end if;
                  if s.nbs in ('9000','9001','9122') and f_zal_ccf(p_dat01, d.nd) = 1 THEN l_CCF := 0;   -- COBUMMFO-7561
                  else
                     if d.wdate is not null and d.sdate is not null THEN
                        l_srok := d.wdate-d.sdate;
                        if    l_srok <  365 THEN srok := 1;
                        elsif l_srok < 1095 THEN srok := 2;
                        else                     srok := 3;
                        end if;
                     else                        srok := 3;
                     end if;
                     l_CCF := F_GET_CCF (s.nbs, s.ob22, srok);
                  end if;
               else l_tipa := d.tipa;
               end if;

/*
               if s.nbs in ('9129','9122') and l_r013 = '1' THEN  -- 351 (п.104)
                  if d.wdate is not null and d.sdate is not null THEN
                     l_srok := d.wdate-d.sdate;
                     if    l_srok <  365 THEN l_CCF :=  20;
                     elsif l_srok < 1095 THEN l_CCF :=  50;
                     else                     L_CCF := 100;
                     end if;
                  end if;
               elsif s.nbs in ('9000') and s.rnk = 274267401 and d.nd in (18023180901,18023181501,18023182001) THEN
                  l_CCF :=  50;
               end if;
*/
               --logger.info('REZ_351 4 : nd = ' || d.nd || ' s.rnk=' || s.rnk ||  ' l_fin=' || l_fin || ' VKR = ' || VKR_  ||' l_idf='|| l_idf ) ;
               if l_real ='Ні' and z.kod_351 BETWEEN 11 AND 26 THEN  l_text := 'REAL = Ні, pawn = ' || z.pawn ;
                                                                     l_zal  :=  0; l_zal_lgd := 0 ; z.tip :=  0; z.kl_351 := 0;
                  if     d.vidd in (11,12,13) and z.kv  = 980  THEN  l_idf  := 62; l_f       := 60; l_fp  := 42;
                  elsif  d.vidd in (11,12,13) and z.kv <> 980  THEN  l_idf  := 65; l_f       := 60; l_fp  := 45;
                  end if;
               else                                                  l_zal  := (nvl(z.sall,0) * nvl(z.kl_351,0))/100; l_zal_lgd := z.zal_lgd/100;
               end if;
               --logger.info('REZ_351 40 : nd = ' || d.nd || ' vidd =' || d.vidd || ' tipa =' || d.tipa || ' s.custtype=' ||s.custtype ) ;
               if d.pd is not null THEN l_pd := d.pd;
               else
                  IF l_S250  = 8 and d.vidd in ( 1, 2, 3) THEN
                     l_pd := f_fin_pd_grupa_ul (1, l_fin, nvl(z.rpb,0));
                     --logger.info('2401 3 : nd = ' || d.nd || ' l_pd =' || l_pd || ' l_fin =' || l_fin || ' z.rpb ='|| z.rpb ) ;
                  elsif  l_S250  = 8 and d.vidd not in ( 1, 2, 3) THEN
                     l_pd := f_fin_pd_grupa (2, l_kol);
                  else
                     --if s.custtype = 3   THEN   --or d.prod like '21%' THEN
                     l_pd  := fin_nbu.get_pd(s.rnk, d.nd, p_dat01,l_fin, VKR_,l_idf);
                        --l_idf := l_fp;
                     --else
                     --   l_pd  := fin_nbu.get_pd(s.rnk, d.nd, p_dat01,l_fin, VKR_,l_idf);
                     --end if;
                  end if;
               end if;
               if s.rnk = 90931101 and sys_context('bars_context','user_mfo') = '300465' THEN  -- COBUSUPABS-5538
                  l_fin  := 1;
                  l_PD   := 0;
                  l_s080 := f_get_s080 (p_dat01,l_tip_fin, l_fin);
               end if;
               l_EAD     := nvl(z.bv,z.osta);
               l_RC      := 0;
               l_RCQ     := 0;
               --logger.info('REZ_351 40 : nd = ' || d.nd || ' l_idf =' || l_idf || ' l_pd =' || l_pd || ' s.rnk=' ||s.rnk ) ;
               if (( l_ead = 0 or l_ead is null ) and z.sall is null and d.tipa in (41,42,10) ) or s.nbs='9129'  THEN
                  l_EAD  := nvl(z.bv_all,z.bv02);
               end if;
               l_EAD     := greatest(l_EAD,0);
               l_s       := z.osta*(l_CCF/100)/100;
               --logger.info('REZ_351 4 : nd = ' || d.nd || ' l_zal_lgd =' || l_zal_lgd || ' l_s =' || l_s ) ;
               l_EAD     := l_EAD * l_CCF/100;
               l_EAD     := round(l_EAD / 100,2);
               --logger.info('REZ_351 40 : nd = ' || d.nd || ' l_zal_lgd =' || l_zal_lgd || ' l_s =' || l_s || ' l_ead =' || l_ead ) ;
               l_eadr    := l_eadr-l_EAD;

               --  IF abs(l_eadr) < 0.2 THEN
               --     l_EAD := L_EAD + l_eadr;
               --  end if;
               l_EADQ    := p_icurval(s.kv,l_EAD*100,l_dat31)/100;
               if (l_ead = 0 and z.pawn is null) or nvl(l_s,0) + nvl(L_RC,0) = 0 THEN L_LGD := 1;
                   --logger.info('REZ_351 41 : nd = ' || d.nd || ' l_zal_lgd =' || l_zal_lgd || ' l_s =' || l_s || ' l_LGD =' || l_LGD ) ;
               else                                                                   l_LGD := round(greatest(0,1 - (l_zal_lgd + L_RC) / l_s),8);
                   --logger.info('REZ_351 42 : nd = ' || d.nd || ' l_zal_lgd =' || l_zal_lgd || ' l_s =' || l_s || ' l_LGD =' || l_LGD ) ;
               end if;

               if z.kv = 980 THEN l_tip_kv := 2;
               else               l_tip_kv := 3;
               end if;

               IF    l_S250  = 8 and d.vidd     in (1,2,3) THEN  l_lgd  := f_fin_pd_grupa_ul (l_tip_kv, l_fin, nvl(z.rpb,0));
               elsif l_S250  = 8 and d.vidd not in (1,2,3) THEN  l_lgd  := 0.90;
               END IF;

               --logger.info('REZ_351 34 : nd = ' || d.nd || ' l_fp =' || l_fp || ' l_pd =' || l_pd  ) ;
               if (s.nbs in ('9129','9122') and l_r013 = '9') or s.nbs in ('9023','9003') and l_r013 = '1' THEN
                  l_pd := 0; l_fin := 1; l_pd_0 := 1; l_lgd := 1;
                  l_s080    := f_get_s080 (p_dat01,l_tip_fin, l_fin);
               end if;

               IF l_dv >= 51 and  l_lgd >=l_lgd_51 then
                  if f_rnk_not_uudv(s.rnk) = 0 THEN l_LGD  := l_lgd_51; end if;
               end if;
               if sys_context('bars_context','user_mfo') = '324805'  THEN -- COBUSUPABS-5846 (Крым), лист 18-04-2018 20:36
                  if    l_tip_fin = 1 THEN l_fin :=  5;
                  elsif l_tip_fin = 2 THEN l_fin := 10;
                  else                     l_fin :=  2;
                  end if;
                  l_pd := 1;
               end if;

               --logger.info('REZ_351 44: nd = ' || d.nd || ' l_EAD = '|| l_EAD || ' l_pd = ' || l_pd  || ' L_zal=' ||L_zal) ;
               --          l_CR   := round(greatest(l_pd * (l_EAD - l_zal),0),2);
               L_CR      := round(l_pd * L_LGD *l_EAD,2);
               -- logger.info('REZ_351 45 : nd = ' || d.nd || ' l_pd =' || l_pd || ' l_ead =' || l_ead || ' l_LGD =' || l_LGD ) ;
               l_zal     := round(l_zal,2);
               l_zalq    := p_icurval(s.kv,l_zal*100,l_dat31)/100;
               l_CRQ     := p_icurval(s.kv,L_CR*100,l_dat31)/100;
               l_BV      := nvl(z.bv_all,nvl(z.bv02,z.bv))/100;
               l_BV02    := z.bv02/100;
               l_BVQ     := p_icurval(s.kv,l_bv*100,l_dat31)/100;
               l_BV02q   := p_icurval(s.kv,l_bv02*100,l_dat31)/100;
               l_CR_LGD  := l_ead*l_pd*l_lgd;
               l_zal_bv  := z.sall/100;
               l_zal_bvq := p_icurval(s.kv,l_zal_bv*100,l_dat31)/100;
               if  l_tipa not in ( 9, 90) THEN l_ccf  := NULL; end if;
               if  l_tipa     in ( 9, 90) THEN l_s250 := NULL; l_grp := NULL; end if;
               --logger.info('REZ_351 4 : acc = ' || s.acc || ' l_ccf = '|| l_ccf || ' l_tipa = ' || l_tipa  ) ;
               INSERT INTO REZ_CR (fdat   , RNK   , NMK      , ND     , KV     , NLS   , ACC       , EAD     , EADQ    , FIN     , PD       ,
                                   CR     , CRQ   , bv       , bvq    , VKR    , IDF   , KOL       , FIN23   , TEXT    , tipa    , pawn     ,
                                   zal    , zalq  , kpz      , vidd   , tip_zal, LGD   , CUSTTYPE  , CR_LGD  , nbs     , zal_bv  , zal_bvq  ,
                                   S250   , dv    , RC       , RCQ    , BV02   , tip   , bv02q     , KL_351  , sdate   , RZ      , OVKR     ,
                                   s080   , ob22  , grp      , cc_id  , pd_0   , P_DEF , OVD       , OPD     , istval  , wdate   , CCF      ,
                                   poci   , ddd_6B, tip_fin  , rpb    )
                           VALUES (p_dat01, s.RNK , s.NMK    , d.nd   , s.kv   , s.nls , s.acc     , l_ead   , l_eadq  , l_fin   , l_pd     ,
                                   l_CR   , l_CRQ , l_bv     , l_bvq  , VKR_   , l_idf , l_kol     , d.fin23 , l_text  , l_tipa  , z.pawn   ,
                                   l_zal  , l_zalq, z.kpz    , d.vidd , z.tip  , l_LGD , s.CUSTTYPE, l_CR_LGD, s.nbs   , l_zal_bv, l_zal_bvq,
                                   l_S250 , l_dv  , l_RC     , l_RCQ  , l_bv02 , s.tip , l_bv02q   , z.kl_351, d.sdate , s.RZ    , l_OVKR   ,
                                   l_s080 , s.ob22, l_grp    , d.cc_id, l_pd_0 , l_PDEF, l_OVD     , l_OPD   , l_istval, d.wdate , l_ccf    ,
                                   l_poci , l_ddd , l_tip_fin, nvl(z.rpb,0));

            end LOOP;
           else
                for i in (select a.*, -ost_korr(a.acc,l_dat31,null,a.nbs) BV from nd_acc n,accounts a
                          where  n.nd = d.nd and n.acc=a.acc and a.tip in ('SNA','SDI','SDA','SDM','SDF','SRR') and nbs not in (3648))
                LOOP
                   if  i.bv <> 0 THEN
                      l_ddd  := f_ddd_6B(i.nbs);
                      l_BV   := i.bv / 100;
                      l_BVQ  := p_icurval(i.kv,i.bv,l_dat31)/100;
                      update rez_cr set tip = i.tip where fdat = p_dat01 and acc = i.acc;
                      IF SQL%ROWCOUNT=0 then
                         INSERT INTO REZ_CR (fdat   , RNK       , NMK      , ND    , KV     , NLS     , ob22   , ACC  , EAD    , EADQ  , FIN   ,
                                             PD     , CR        , CRQ      , bv    , bvq    , VKR     , IDF    , KOL  , FIN23  , TEXT  , tipa  ,
                                             vidd   , CUSTTYPE  , nbs      , S250  , dv     , BV02    , tip    , bv02q, sdate  , RZ    , grp   ,
                                             poci   , ddd_6B    , tip_fin  , s080  , cc_id  , istval  , wdate  , pd_0 )
                                     VALUES (p_dat01, s.RNK     , s.NMK    , d.nd  , i.kv   , i.nls   , i.ob22 , i.acc, 0      , 0     , l_fin ,
                                             l_pd   , 0         , 0        , l_bv  , l_bvq  , VKR_    , l_idf  , l_kol, d.fin23, l_text, d.tipa,
                                             d.vidd , s.CUSTTYPE, i.nbs    , l_S250, l_dv   , l_bv    , i.tip  , l_bvq, d.sdate, s.RZ  , l_grp ,
                                             l_poci , l_ddd     , l_tip_fin, l_s080, d.cc_id, l_istval, d.wdate, 0    );
                      end if;
                   end if;
                END LOOP;
           end if;
         end LOOP;
      end;
   End LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец Кредиты + БПК 351 ');
   if not f_mmfo THEN over_351 (p_dat01,1); end if;
end;
/
show err;

grant EXECUTE   on CCK_351  to BARS_ACCESS_DEFROLE;
grant EXECUTE   on CCK_351  to RCC_DEAL;
grant EXECUTE   on CCK_351  to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_351.sql =========*** 
PROMPT ===================================================================================== 
