CREATE OR REPLACE PROCEDURE BARS.CCK_351 (p_dat01 date, p_nd integer, p_mode integer  default 0 ) IS

/* ������ 15.3   20-02-2019  19-11-2018  23-10-2018  10-09-2018  12-07-2018  20-04-2018  10-04-2018  26-03-2018  28-11-2017
   ���������� ���������� ������ �� �������� + ���

   ----------------------------------------------
34) 20-02-2019(15.3) - (COBUSUPABS-7264) - ������� �� ����������� ��������+KVED
33) 19-11-2018(15.2) - �������+���+����+����+����������
32) 23-10-2018(15.1) - (COBUMMFO-7488) - ��������� ���� � REZ_CR
31) 10-09-2018(15.0) - ���� - 2600 ��������
30) 12-07-2018(14.9) - ����� ����� - ('SDI','SDA','SDM','SDF','SRR') �� ������ ������� , ��� �� ��������
29) 20-04-2018(14.8) - �� ����� FIN = max, PD = 1 (COBUSUPABS-5846 (����), ���� 18-04-2018 20:36, ����� � COBUMMFO-7561)
28) 10-04-2018(14.7) - �� ������ ��������� ������ - a.tip <> 'ZAL' + �� ��� ��������� 3570,3578 -  b.tip not in ('SK9','ODB','OFR')
27) 26-03-2018(14.6) - �� ������� ��� ����������� PD �������. l_idf ������ l_fp (�� �������� ���������) + �� ������ ��������� 3570,3578
26) 28-11-2017(14.5) - ����� ���� ������ �� ������ �������� ����� ��� ����� + 9003 ������ 9023
25) 27-11-2017(14.4) - LGD 9129 ��� ������������ =1 , �� ��������� �������������
24) 17-10-2017(14.3) - ��� �������� �� ������� �������� tipa = 90 - 9129 �� ������ � 94 - 9129 �� ���
23) 03-10-2017(14.2) - ��� ����� �� ��� �� REZ_W4_BPK
22) 06-09-2017 - ������ � ������� S240 - ���� ���� �������� �������� < 1 ����, ����� �� ���������
21) 30-08-2017 - ���� �� CC_DEAL �� ������� VIDD = 110
21) 25-07-2017 - ��� ��������� ������� PD �� ����� �������� ��������� (IDF = 70)
20) 20-06-2017 - S240 - �� ���� ��������� ��������
20) 16-05-2017 - ��������'UUDV' - ��� ����� ������ l_dv := 0; + �������� R013 � �������� ('9')
19) 05-04-2017 - rnk = 90931101
18) 06-03-2017 - �������� �� �������� 9601
17) 06-03-2017 - LGD (���������� 8 ������)
16) 03-03-2017 - �������� �� �������� 9611
15) 03-03-2017 - if l_fin is null and d.tipa in (41,42) THEN l_fin := 5; VKR_ := '�'; end if; -- �� ����������������� ���������
14) 03-03-2017 - ���� ����. �������� >51 %, �� ������ � ������� rnk_not_uudv ������� ��� �������
13) 23-02-2017 - ���� - f_fin_pd_grupa_ul  FIN	  PD	 LGD	LGDV
                                             1	0,15	0,95	1,00
12) 22-02-2017 - Գ�.���� �� SNA, SDI
11) 15-02-2017 - ������ p_nbu23_cr
10) 01-02-2017 - REAL ='ͳ' ���� �����.���.�������.��������� �������� ��������.  z.kl_351 := 0;
 9) 24-01-2017 - ��������� ��������� s080,TIP_FIN,ddd_6B
 8) 10-01-2017 - ������ SNA, SDI � REZ_CR
 7) 21-12-2016 - ���.���� ������������� �� ���� (FIN_RNK_OKPO)
 6) 21-12-2016 - ���� --> ����������� ����� (< 30 ���� ��������� �� 250000.00 ���. �������������)
 5) 23-11-2016 - zal_bv - #0.00
 4) 20-10-2016 - ������ ������� (REAL = ͳ)
 3) 04-10-2016 - p_BLOCK_351(p_dat01 date); -- ���������� �������
 2) 03-10-2016 - �������� nd_open - ����������� ��������� ��������
 1) 26-09-2016 - ������ �� CC_DEAL(PROD) TIPA = 4

  TIPA:
       3 - �������
       4 - ������
       5 - ����
       6 - ���������
       9 - �������� �����`������ - ������� (9129)
      10 - ����������
      41 - ������ ���������� (��������)
      42 - �����  ���������� (��������)
      44 -        ���������� (instolment)
      90 - �������� �����`������ - ���������� (9129)
      94 - �������� �����`������ - ��� (9129)


  l_tip_fin:
       0 --> 1 - 2
       1 --> 1 - 5
       2 --> 1 - 10
*/

 l_istval specparam.istval%type; l_r013  specparam.r013%type; l_err_type  SREZERV_ERROR_TYPES.ERROR_TYPE%type;
 l_s080   specparam.s080%type  ; l_ddd   kl_f3_29.ddd%type  ; l_s240      specparam.s240%type; l_s250      rez_cr.s250%type;
 l_grp    rez_cr.grp%type      ; l_poci  rez_cr.poci%type   ;

 l_kol         NUMBER; acc8_     NUMBER; l_idf      NUMBER; l_fin      NUMBER; l_tipa     NUMBER; l_fin23     NUMBER; l_f        NUMBER;
 l_fp          NUMBER; l_pd_0    NUMBER; l_tip_fin  NUMBER; l_kz       NUMBER; srok       NUMBER; l_pd        NUMBER; l_CRQ      NUMBER;
 l_EAD         NUMBER; l_zal     NUMBER; l_EADQ     NUMBER; l_LGD      NUMBER; l_CR       NUMBER; l_RC        NUMBER; l_bv       NUMBER;
 l_BVQ         NUMBER; l_bv02    NUMBER; l_BV02q    NUMBER; l_ccf      NUMBER; l_srok     NUMBER; L_RCQ       NUMBER; L_CR_LGD   NUMBER;
 l_zalq        NUMBER; l_zal_BV  NUMBER; l_zal_BVq  NUMBER; l_dv       NUMBER; l_polis    NUMBER; l_zal_lgd   NUMBER; l_s        NUMBER;
 l_EADR        NUMBER; l_RZ      NUMBER; l_tip_kv   NUMBER; l_fin_okpo NUMBER; l_lgd_51   NUMBER; l_cnt       NUMBER;
 l_kol_fin_max NUMBER; l_k       NUMBER; l_g_kved   NUMBER;

 VKR_       varchar2(3);  l_txt  varchar2(1000);  l_vkr   varchar2(50)  ;  l_real  varchar2(3);  l_text  VARCHAR2(250) ; l_kf varchar2(6);
 l_poci_    varchar2(3);
 l_kved     varchar2(5);

 l_dat31        date;
 l_dat_fin_max  date;

 TYPE CurTyp IS REF CURSOR;
 c0   CurTyp;

begin
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   p_BLOCK_351(p_dat01);
   l_kf := sys_context('bars_context','user_mfo');
   z23.to_log_rez (user_id , 351 , p_dat01 ,'������ ������� + ��� + ���� + ���� + ����������');
   dbms_application_info.set_client_info('CR_351:'|| l_kf ||': ������� + ��� + ���� + ���� + ����������');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- ��������� ������� ���� ������
   if p_mode = 0 Then
      p_kol_nd(p_dat01, 0, 0);
      p_kol_nd_bpk(p_dat01, 0);
      p_kol_nd_MBDK(p_dat01, 0);
   end if;
   delete from ex_kl351;
   --delete from REZ_CR where fdat=p_Dat01 and tipa in ( 3, 4, 5, 6, 9, 10, 41, 42, 90, 94);
   l_lgd_51 := GET_REZ_PAR( 'LGD' );
   for d in (
             SELECT e.nd, e.cc_id, e.vidd, e.fin23, decode(e.vidd, 110, 10, 3) tipa, sdate, wdate, e.prod, e.rnk, e.pd, cck_app.get_nd_txt(e.nd, 'VNCRR') vkr,
                    decode(trim(c.sed),'91',3,c.custtype) custtype, trim(c.sed) sed, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, F_RNK_gcif (c.okpo, c.rnk) okpo,
                    substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK
             FROM CC_DEAL e, nd_open n, customer c
             WHERE  e.VIDD IN (1,2,3,110,11,12,13)  AND e.SDATE  <  p_DAT01 and  p_nd in (0, e.nd) and e.rnk = c.rnk
               and  n.fdat = p_dat01 and e.nd = n.nd -- �����������
             union all
             select distinct b.nd, null cc_id, 11, fin23, tip_kart tipa, null dat_begin, null dat_end, '2203' prod, b.RNK, null pd, vkr,
                    decode(trim(c.sed),'91',3,c.custtype) custtype, trim(c.sed) sed, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, F_RNK_gcif (c.okpo, c.rnk) okpo,
                    substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK
             from rez_w4_bpk b, customer c where b.nbs not in ('3570','3578') and b.rnk = c.rnk
             union all
             SELECT d.nd, d.cc_id,  d.vidd, D.FIN23, 5 tipa, d.sdate, d.wdate, d.prod, d.rnk, PD, f_vkr_MBDK(d.rnk) VKR, decode(trim(c.sed),'91',3,c.custtype) custtype,
                    trim(c.sed) sed, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, F_RNK_gcif (c.okpo, c.rnk) okpo,substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK
             FROM (select * from accounts where  nbs >'1500' and nbs < '1600') a,
                  (select e.* from cc_deal e,nd_open n
                   where n.fdat = p_dat01 and e.nd = n.nd and (vidd> 1500  and vidd<  1600 ) and sdate< p_dat01 and vidd<>1502 and
                        (sos>9 and sos< 15 or wdate >= l_dat31 )) d, cc_add ad, customer c
             WHERE a.acc = ad.accs  and d.nd = ad.nd  and ad.adds = 0  and  ost_korr(a.acc,l_dat31,null,a.nbs)<0  and  d.rnk = c.rnk and
                   d.nd=(select max(n.nd) from nd_acc n,cc_deal d1  where n.acc=a.acc and n.nd=d1.nd and (d1.vidd> 1500  and d1.vidd<  1600 )
                   and d1.vidd<>1502 and d1.sdate< p_dat01 and  (sos>9 and sos< 15 or d1.wdate >= l_dat31 ) )
             union all
             select d.nd, d.cc_id,  d.vidd, nvl(d.fin23,1) FIN23, 6 tipa, d.sdate, d.wdate, d.prod,d.rnk, PD, cck_app.get_nd_txt(d.nd, 'VNCRR') VKR,
                    decode(trim(c.sed),'91',3,c.custtype) custtype, trim(c.sed) sed, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, F_RNK_gcif (c.okpo, c.rnk) okpo,
                    substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK
             from  cc_deal d, customer c  where vidd = 150 and d.rnk = c.rnk
            )
   LOOP
      --logger.info('REZ_351 1 : nd = ' || d.nd || ' d.vidd = '|| d.vidd ) ;
      vkr_:= d.vkr;
      l_real := null; l_poci_:= NULL; l_dv   := 0;
      if d.prod like '21%' THEN d.tipa  := 4; l_tip_fin := 1; end if;
      if d.tipa in (41,42) THEN l_VKR   :='��� ';
      elsif d.tipa in (10) THEN l_VKR   :='����';
      elsif d.tipa in (5)  THEN l_VKR   :='����';
      elsif d.tipa in (6)  THEN l_VKR   :='����������';
      else                      l_VKR   :='������';
                                l_real  := substr(trim(cck_app.get_nd_txt(d.nd, 'REAL')),1,3);
                                l_poci_ := substr(trim(cck_app.get_nd_txt(d.nd, 'POCI')),1,3);
      end if;

      if    VKR_ is null             THEN  l_err_type := 16;
      elsif f_vkr_correct (vkr_) = 0 THEN  l_err_type := 17;
      end if;
      if l_err_type is not null THEN
         p_error_351( P_dat01, d.nd, user_id, l_err_type, null, null, null, null, l_vkr || '-"' || vkr_ ||'"', d.rnk, null);
      end if;

      If l_poci_ = '���' then l_poci := 1;
      else                    l_poci := 0;
      end if;

      if     d.tipa in (41,42,44,10) and d.custtype = 2 THEN d.vidd := 1 ;
      elsif  d.tipa in (41,42,44,10)                    THEN d.vidd := 11;
      elsif  d.sed = '91'                               THEN d.vidd := 11;
      end if;

      if d.custtype in (1, 2) THEN
         l_dv := get_custw_uudv (d.rnk, 'UUDV');
      end if;
      if    d.custtype = 2 and d.tipa = 4 THEN l_tip_fin := 1;  -- ���������
      elsif d.custtype = 2                THEN l_tip_fin := 2;
      else                                     l_tip_fin := 1;
      end if;
      l_kol  := f_get_nd_val_n('KOL', d.nd, p_dat01, d.tipa, d.okpo);
      l_s240 := case when (p_dat01 >= d.wdate ) THEN 'Z' else  F_SROK (D.SDATE, d.wdate, 2) end;
      --logger.info('S080 1 : nd = ' || d.nd || ' l_tip_fin = '||l_tip_fin || ' l_fin = ' || l_fin || ' s080 = ' || l_s080 ) ;
      l_tipa := d.tipa;

      l_kved   := fin_nbu.GET_KVED (d.RNK, FIN_NBU.ZN_P_ND_DATE_HIST('ZVTP', 51, p_DAT01, d.nd, d.rnk),1);
      l_g_kved := fin_nbu.GET_GVED (d.rnk, FIN_NBU.ZN_P_ND_DATE_HIST('ZVTP', 51, p_dat01, d.nd, d.rnk)  );
      --logger.info('KVED 1 : nd = ' || d.nd || ' rnk = '||d.rnk || ' l_kved = ' || l_kved || ' g_kved = ' || l_g_kved ) ;

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
              branch    accounts.branch%type
             );
      s r0Typ;
      begin
         if    d.tipa in ( 3, 4, 5, 6, 10)  THEN
            OPEN c0 FOR
               select a.tip, a.ob22, a.nls, a.acc, a.kv,  a.nbs, - ost_korr(a.acc,l_dat31,null,a.nbs) S, a.rnk, a.branch
               from   nd_acc n, accounts a
               where  n.nd = d.nd and n.acc = a.acc and nls not like '3%' and nls not like '8%' and a.nbs not in ('2620','9611','9601')
                 and  ((a.tip in  ('SNO','SN ','SL ','SLN','SPN','SS ','SP ','SK9','SK0','CR9','SNA','SDI','SDA','SDM','SDF','SRR') or a.nbs like '15%')
                 and  ost_korr(a.acc,l_dat31,null,a.nbs) <>0 or a.nbs='2600' and ost_korr(a.acc,l_dat31,null,a.nbs) <0)
               order by a.tip desc;
         else
            OPEN c0 FOR
               select b.tip, a.ob22, a.nls, a.acc, a.kv,  a.nbs, - ost_korr(a.acc,l_dat31,null,a.nbs) S, a.rnk, a.branch
               from   rez_w4_bpk b, accounts a
               where  b.acc = a.acc  and b.nd=d.nd and b.tip not in ('SK9','ODB','OFR');
         end if;
         loop
            FETCH c0 INTO s;
            EXIT WHEN c0%NOTFOUND;
            l_ccf := 100;
            l_grp   := f_get_port (d.nd, d.rnk);
            if  l_grp <>0 THEN  l_s250 := '8';
            else                l_s250 := null; l_grp := null;
            end if;

            l_fin      := f_rnk_maxfin(p_dat01, d.okpo, l_tip_fin, d.nd, 1);
            l_fin_okpo := f_get_fin_okpo (d.rnk);
            if l_fin_okpo is not null THEN l_fin := least(l_fin,l_fin_okpo); end if;
            IF    l_S250 = 8 and d.vidd     in ( 1, 2, 3) THEN  l_fin := 1;
            elsif l_S250 = 8 and d.vidd not in ( 1, 2, 3) THEN  l_fin := f_fin_pd_grupa (1, l_kol);
            end if;
            if l_fin is null and d.tipa in (41,42) THEN l_fin := 5; VKR_ := '�'; end if; -- �� ����������������� ���������
            l_s080 := f_get_s080 (p_dat01,l_tip_fin, l_fin);

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

            if l_tip_fin = 2 and l_fin = 10 or l_tip_fin = 1 and l_fin = 5 THEN
               l_dat_fin_max := F_FIN_MAX (p_dat01, d.nd, l_fin, l_tipa);
               l_kol_fin_max := p_dat01 - l_dat_fin_max;
            else
               l_dat_fin_max := null;
               l_kol_fin_max := 0;
            end if;

            if l_s240 in ('C','D','E','F','G','H','Z') and d.tipa not in (5, 6, 41, 42, 44) THEN
               update ex_kl351 set kl_351 = 0 where acc = s.acc and pawn = 28;
               IF SQL%ROWCOUNT=0 then
                  insert into ex_kl351 (acc,pawn,kl_351) values (s.acc , 28, 0);
               end if;
               update ex_kl351 set kl_351 = 0 where acc = s.acc and pawn = 282;
               IF SQL%ROWCOUNT=0 then
                  insert into ex_kl351 (acc,pawn,kl_351) values (s.acc , 282, 0);
               end if;
            end if;

            if s.kv = 980 THEN l_istval := 0;
            else               l_istval := nvl(f_get_specparam ( 'ISTVAL', null, s.acc, null),0);
            end if;

            if s.nbs in ('9129','9122','9023','9003','9000') THEN
               begin
                  SELECT R013 INTO l_r013 FROM specparam p  WHERE  s.acc = p.acc (+);
               EXCEPTION WHEN NO_DATA_FOUND THEN l_r013:= NULL;
               END;
            end if;
            l_eadr := s.s/100;
            l_ddd      := f_ddd_6B(s.nbs);

          if s.s > 0 and s.tip not in ('SDI','SDA','SDM','SDF') THEN
            --logger.info('REZ_351 1 : nd = ' || d.nd || ' s.acc = '|| s.acc || ' VKR = ' || VKR_ || '������� = ' || s.s) ;
            for z in ( select NVL(f_zal_accs (p_dat01, d.nd, a.acc,s.rnk,l_kol_fin_max),0) zal_lgd, a.acc, a.kv, -ost_korr(a.acc,l_dat31,null,a.nbs) BV02,
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

               l_pd_0 := 0; l_text := NULL; l_ccf := 100;
               
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

               if    d.vidd in ( 1, 2, 3) and d.prod like '21%'                THEN l_idf := 70; l_f := 76; l_fp := 48;
               elsif d.vidd in ( 1, 2, 3)                                      THEN l_idf := 50; l_f := 56;
               elsif d.vidd in (11,12,13) and z.kv  = 980 and nvl(z.tip,0) = 0 THEN l_idf := 62; l_f := 60; l_fp := 42;
               elsif d.vidd in (11,12,13) and z.kv  = 980 and nvl(z.tip,0) = 1 THEN l_idf := 60; l_f := 60; l_fp := 40;
               elsif d.vidd in (11,12,13) and z.kv  = 980 and nvl(z.tip,0) = 2 THEN l_idf := 61; l_f := 60; l_fp := 41;
               elsif d.vidd in (11,12,13) and z.kv <> 980 and nvl(z.tip,0) = 1 THEN l_idf := 63; l_f := 60; l_fp := 43;
               elsif d.vidd in (11,12,13) and z.kv <> 980 and nvl(z.tip,0) = 2 THEN l_idf := 64; l_f := 60; l_fp := 44;
               elsif d.tipa in (5, 6)     and d.RZ =2                          THEN l_idf := 81;            l_fp := 47;
               elsif d.tipa in (5, 6)     and d.RZ =1                          THEN l_idf := 80;            l_fp := 46;
               else                                                                 l_idf := 65; l_f := 60; l_fp := 45;
               end if;


               l_k := F_K_ZAL (s.rnk, d.nd, z.kod_351, l_kol_fin_max);
               --logger.info('ZAL_351 1 : nd = ' || ' l_k :=' || l_k || ' kod_351 = ' || z.kod_351 || ' kol_max = ' ||l_kol_fin_max ) ;
               l_text := l_text || ' l_k :=' || l_k || ' kod_351 = ' || z.kod_351 || ' kol_max = ' ||l_kol_fin_max;
               --if l_k = 0 THEN
               --   z.zal_lgd:=0;
               --end if;
               l_zal  := (nvl(z.sall,0) * nvl(z.kl_351,0) * nvl(l_k,1))/100; l_zal_lgd := z.zal_lgd/100;

               --logger.info('REZ_351 4 : nd = ' || d.nd || ' s.rnk=' || s.rnk ||  ' l_fin=' || l_fin || ' VKR = ' || VKR_  ||' l_idf='|| l_idf ) ;
               if l_real ='ͳ' and z.kod_351 BETWEEN 12 AND 27 THEN  l_text := 'REAL = ͳ, pawn = ' || z.pawn ;
                                                                     --l_zal  :=  0; l_zal_lgd := 0 ; z.tip :=  0; z.kl_351 := 0;
                  if     d.vidd in (11,12,13) and z.kv  = 980  THEN  l_idf  := 62; l_f       := 60; l_fp  := 42;
                  elsif  d.vidd in (11,12,13) and z.kv <> 980  THEN  l_idf  := 65; l_f       := 60; l_fp  := 45;
                  end if;
               --else                                                  l_zal  := (nvl(z.sall,0) * nvl(z.kl_351,0))/100; l_zal_lgd := z.zal_lgd/100;
               end if;

               --logger.info('REZ_351 40 : nd = ' || d.nd || ' vidd =' || d.vidd || ' tipa =' || d.tipa || ' s.custtype=' ||s.custtype ) ;
               if d.pd is not null THEN 
                  begin
                     select count(*) into l_cnt from range_pd 
                     where tip = d.tipa and fin = l_fin and tip_fin = l_tip_fin and rz = d.rz and  d.pd between min  and max;
                     if l_cnt <> 0 THEN l_pd := d.pd; 
                     else
                        IF l_S250  = 8 and d.vidd in ( 1, 2, 3) THEN
                           l_pd := f_fin_pd_grupa_ul (1, l_fin, nvl(z.rpb,0));
                           --logger.info('2401 3 : nd = ' || d.nd || ' l_pd =' || l_pd || ' l_fin =' || l_fin || ' z.rpb ='|| z.rpb ) ;
                        elsif  l_S250  = 8 and d.vidd not in ( 1, 2, 3) THEN
                           l_pd := f_fin_pd_grupa (2, l_kol);
                        else
                           --if s.custtype = 3   THEN   --or d.prod like '21%' THEN
                           l_pd  := fin_nbu.get_pd(s.rnk, d.nd, p_dat01,l_fin, VKR_,l_idf);
                        end if; 
                     end if;
                  end; 
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
               if (( l_ead = 0 or l_ead is null ) and z.sall is null and d.tipa in (41, 42, 44, 10) ) or s.nbs='9129'  THEN
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
               if sys_context('bars_context','user_mfo') = '324805'  THEN -- COBUSUPABS-5846 (����), ���� 18-04-2018 20:36
                  if    l_tip_fin = 1 THEN l_fin :=  5;
                  elsif l_tip_fin = 2 THEN l_fin := 10;
                  else                     l_fin :=  2;
                  end if;
                  l_pd := 1;
               end if;

               --logger.info('REZ_351 44: nd = ' || d.nd || ' l_EAD = '|| l_EAD || ' l_pd = ' || l_pd  || ' L_zal=' ||L_zal) ;
               --          l_CR   := round(greatest(l_pd * (l_EAD - l_zal),0),2);
               L_CR      := round(l_pd * L_LGD *l_EAD,2);
               l_CRQ     := p_icurval(s.kv,L_CR*100,l_dat31)/100;
               -- logger.info('REZ_351 45 : nd = ' || d.nd || ' l_pd =' || l_pd || ' l_ead =' || l_ead || ' l_LGD =' || l_LGD ) ;
               l_zal     := round(l_zal,2);
               l_zalq    := p_icurval(s.kv,l_zal*100,l_dat31)/100;
               l_BV      := nvl(z.bv_all,nvl(z.bv02,z.bv))/100;
               l_BVQ     := p_icurval(s.kv,l_bv*100,l_dat31)/100;
               l_BV02    := z.bv02/100;
               l_BV02q   := p_icurval(s.kv,l_bv02*100,l_dat31)/100;
               l_CR_LGD  := l_ead*l_pd*l_lgd;
               l_zal_bv  := z.sall/100;
               l_zal_bvq := p_icurval(s.kv,l_zal_bv*100,l_dat31)/100;
               if  l_tipa not in ( 9, 90) THEN l_ccf  := NULL; end if;
               if  l_tipa     in ( 9, 90) THEN l_s250 := NULL; l_grp := NULL; end if;
               --logger.info('REZ_351 4 : acc = ' || s.acc || ' l_ccf = '|| l_ccf || ' l_tipa = ' || l_tipa  ) ;
               INSERT INTO REZ_CR (fdat   , RNK   , NMK    , ND    , KV      , NLS    , ACC       , EAD     , EADQ    , FIN     , PD       ,
                                   CR     , CRQ   , bv     , bvq   , VKR     , IDF    , KOL       , FIN23   , TEXT    , tipa    , pawn     ,
                                   zal    , zalq  , kpz    , vidd  , tip_zal , LGD    , CUSTTYPE  , CR_LGD  , nbs     , zal_bv  , zal_bvq  ,
                                   S250   , dv    , RC     , RCQ   , BV02    , tip    , bv02q     , KL_351  , sdate   , RZ      , s080     ,
                                   ob22   , grp   , cc_id  , pd_0  , istval  , wdate  , CCF       , okpo    , poci    , ddd_6B  , tip_fin  , rpb,
                                   k_ZAL  , kved  , g_kved , dat_fin_max     , kol_fin_max     )
                           VALUES (p_dat01, s.RNK , d.NMK  , d.nd  , s.kv    , s.nls  , s.acc     , l_ead   , l_eadq  , l_fin   , l_pd     ,
                                   l_CR   , l_CRQ , l_bv   , l_bvq , VKR_    , l_idf  , l_kol     , d.fin23 , l_text  , l_tipa  , z.pawn   ,
                                   l_zal  , l_zalq, z.kpz  , d.vidd, z.tip   , l_LGD  , d.CUSTTYPE, l_CR_LGD, s.nbs   , l_zal_bv, l_zal_bvq,
                                   l_S250 , l_dv  , l_RC   , l_RCQ , l_bv02  , s.tip  , l_bv02q   , z.kl_351, d.sdate , d.RZ    , l_s080   ,
                                   s.ob22 , l_grp , d.cc_id, l_pd_0, l_istval, d.wdate, l_ccf     , d.okpo  , l_poci  , l_ddd   , l_tip_fin, nvl(z.rpb,0),
                                   L_K    , l_kved, l_g_kved, l_dat_fin_max, l_kol_fin_max );

            end LOOP;
           elsif s.s <> 0  and s.tip in ('SNA','SDI','SDA','SDM','SDF','SRR') THEN
                --for i in (select a.*, -ost_korr(a.acc,l_dat31,null,a.nbs) BV from nd_acc n,accounts a
                --          where  n.nd = d.nd and n.acc=a.acc and a.tip in ('SNA','SDI','SDA','SDM','SDF','SRR') and nbs not in (3648))
                --LOOP
                --   if  i.bv <> 0 THEN
                --      l_ddd  := f_ddd_6B(i.nbs);
                      l_BV   := s.s / 100;
                      l_BVQ  := p_icurval(s.kv,s.s,l_dat31)/100;
                      update rez_cr set tip = s.tip where fdat = p_dat01 and acc = s.acc;
                      IF SQL%ROWCOUNT=0 then
                         INSERT INTO REZ_CR (fdat   , RNK       , NMK     , ND           , KV    , NLS    , ob22    , ACC    , EAD    , EADQ  , FIN   ,
                                             PD     , CR        , CRQ     , bv           , bvq   , VKR    , IDF     , KOL    , FIN23  , TEXT  , tipa  ,
                                             vidd   , CUSTTYPE  , nbs     , S250         , dv    , BV02   , tip     , bv02q  , sdate  , RZ    , grp   ,
                                             okpo   , poci      , ddd_6B  , tip_fin      , s080  , cc_id  , istval  , wdate  , pd_0   ,
                                             k_ZAL  , kved      , g_kved  , dat_fin_max  , kol_fin_max    )
                                     VALUES (p_dat01, s.RNK     , d.NMK   , d.nd         , s.kv  , s.nls  , s.ob22  , s.acc  , 0      , 0     , l_fin ,
                                             l_pd   , 0         , 0       , l_bv         , l_bvq , VKR_   , l_idf   , l_kol  , d.fin23, l_text, d.tipa,
                                             d.vidd , d.CUSTTYPE, s.nbs   , l_S250       , l_dv  , l_bv   , s.tip   , l_bvq  , d.sdate, d.RZ  , l_grp ,
                                             d.okpo , l_poci    , l_ddd   , l_tip_fin    , l_s080, d.cc_id, l_istval, d.wdate, 0      ,
                                             L_K    , l_kved    , l_g_kved, l_dat_fin_max, l_kol_fin_max );
                      end if;
                   --end if;
                --END LOOP;
                   end if;
         end LOOP;
      end;
   End LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'������� + ��� + ���� + ���� + ����������');
   --if not f_mmfo THEN over_351 (p_dat01,1); end if;
end;
/

show err;

grant EXECUTE   on CCK_351  to BARS_ACCESS_DEFROLE;
grant EXECUTE   on CCK_351  to RCC_DEAL;
grant EXECUTE   on CCK_351  to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_351.sql =========*** 
PROMPT ===================================================================================== 
