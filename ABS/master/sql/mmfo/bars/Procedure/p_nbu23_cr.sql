PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NBU23_CR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NBU23_CR ***

  CREATE OR REPLACE PROCEDURE BARS.P_NBU23_CR (p_dat01 date) IS

/* Версия 6.5   21-02-2019   19-07-2018  08-02-2018  29-01-2018  28-12-2017  14-07-2017  14-03-2017  03-03-2017  07-02-2017  01-02-2017 
   Заполнение данных в NBU23_REZ
   -------------------------------------
13) 21-02-2019(6.5)/COBUSUPABS-7263(COBUSUPABS-7190)/ - kol26 для МБДК и коррахунків
12) 19-07-2018(6.4) - rez_cr.poci => nbu23_rez.arjk
11) 26-02-2018(6.3)/COBUMMFO-6811/ - уточнено условие для параметра tag='ISSPE' and nvl(trim(value),'0') = '1' и кроме дебиторки tipa not in (17,21)
10) 29-01-2018(6.2) - s080 Для клиентов SPE 
 9) 28-12-2017(6.1) - Дополнительные параметры
 8) 14-09-2017 - S180 из ND_VAL
 7) 13-09-2017 - Z из REZ_CR в NBU23_REZ
 6) 14-07-2017 - Хоз.дебиторка из модуля tipa = 21 в ID nd вместо acc
 5) 14-03-2017 - Убрала условие при удалении из NBU23_REZ
 4) 03-03-2017 specparam 
 3) 07-02-2017 Вернула REZERV_23
 2) 01-02-2017 Если ОБ22 не заполнен, то = '01'
 1) 21-12-2016 Добавлен rpb - рівень покриття боргу
*/


 l_fin      REZ_CR.fin%type        ;  l_pd_0     REZ_CR.pd_0%type      ;  l_tipa    REZ_CR.tipa%type      ;  l_fin_z    REZ_CR.fin_z%type     ;  
 l_ISTVAL   REZ_CR.istval%type     ;  p_branch   accounts.BRANCH%type  ;  P_FIN     nbu23_rez.fin%type    ;  P_OBS      nbu23_rez.obs%type    ;  
 P_KAT      nbu23_rez.kat%type     ;  P_K        nbu23_rez.k%type      ;  P_IRR     nbu23_rez.irr%type    ;  P_ZAL      TMP_REZ_OBESP23.s%type;
 r012_      specparam.r011%type    ;  P_isp      accounts.ISP%type     ;  p_ob22    accounts.OB22%type    ;  l_spec     nbu23_rez.spec%type   ;  
 P_ZAL_BL   nbu23_rez.ZAL_BL%type  ;  P_ZAL_BLQ  nbu23_rez.ZAL_BLQ%type;  P_ZALQ    TMP_REZ_OBESP23.s%type;  p_SUM_IMP  nbu23_rez.SUM_IMP%type;  
 p_SUMQ_IMP nbu23_rez.SUMQ_IMP%type;  l_nd_cp    nbu23_rez.nd_cp%type  ;  P_ZAL_SV  nbu23_rez.ZAL_SV%type ;  P_ZAL_SVQ  nbu23_rez.ZAL_BLQ%type;  
 DDD_       nbu23_rez.DDD%type     ;  DD_        nbu23_rez.DD%type     ;  L_ID      nbu23_rez.ID%type     ;  L_OKPO     CUSTOMER.OKPO%type    ;  
 L_IDR      nbu23_rez.IDR%type     ;  L_R013     nbu23_rez.R013%type   ;  L_r011    nbu23_rez.r011%type   ;  L_s180     nbu23_rez.s180%type   ;  
 l_EAD      REZ_CR.EAD%type        ;  l_EADQ     REZ_CR.eadq%type      ;  l_ta      nbu23_rez.tipa%type   ;
 l_commit   Integer := 0;             l_s080     specparam.s080%type   ;

 L_OVKR   VARCHAR2(50);   L_OPD    VARCHAR2(50);   L_KOL24  VARCHAR2(50);   L_KOL27  VARCHAR2(50);   L_KOL29  VARCHAR2(50);   
 L_KOL23  VARCHAR2(50);   L_P_DEF  VARCHAR2(50);   L_KOL25  VARCHAR2(50);   l_kol17  VARCHAR2(50);   L_KOL28  VARCHAR2(50);                                         
 L_OVD    VARCHAR2(50);   L_KOL26  VARCHAR2(50);   l_kol31  VARCHAR2(50);   

 l_dat31  date;

 TYPE     D354 IS RECORD (ddd char(3) );                
 TYPE     M354 IS TABLE  OF D354 INDEX BY varchar2(1);  
 t35      M354;                                         
                                                        
 TYPE DDDR IS  RECORD (r020 char(4), ddd char(3) );     
 TYPE DDDM IS  TABLE  OF DDDR INDEX BY varchar2(4);     
 tmp  DDDM ;                                            

BEGIN

   z23.to_log_rez (user_id , 351 , p_dat01   ,'Начало REZ_CR --> NBU23_REZ  351 ');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца

   z23.to_log_rez (user_id , 351 , p_dat01   ,'Подготовка таблицы NBU23_REZ');
   DELETE FROM NBU23_REZ WHERE FDAT = p_dat01;
   DELETE FROM acc_nlo;  
   commit;
   z23.to_log_rez (user_id , 351 , p_dat01   ,'Додаткові параметри');
   FIN_REP.KOL_REZCR(p_dat01);
   if sys_context('bars_context','user_mfo') = '300465' THEN
      for k in (select  r.rowid ri , nd, REPLACE( ( select ConcatStr(KOD) from nd_oznaka_351 where nd = r.nd) ,',',';') kol_26 from rez_cr r where r.fdat = p_dat01 and r.tipa in (5, 6))
      LOOP
         if k.kol_26 is not null THEN
            update rez_cr set kol26 = k.kol_26 where rowid=k.RI;
         end if;
      end loop;
   end if;
   for k in (select r.rowid RI ,r.* from rez_cr r where fdat = p_dat01 and fin_z is not null)
   LOOP
      if k.tipa = 17               THEN l_s080 := null; k.fin_z := NULL; 
      elsif substr(k.nls,1,2)='21' THEN k.fin_z:= least(k.fin_z,5);  l_s080 := f_get_s080 (p_dat01,k.tip_fin, k.fin_z);
      else                              l_s080 := f_get_s080 (p_dat01,k.tip_fin, k.fin_z);
      end if; 
      update rez_cr set s080_z = l_s080, fin_z = k.fin_z where rowid=k.RI;
   end loop;
   for k in (select r.rowid RI ,r.* from rez_cr r 
             where fdat = p_dat01 and tipa not in (17,21) and rnk in (select rnk from customerw where tag='ISSPE' and nvl(trim(value),'0') = '1'))
   LOOP
      k.tip_fin :=1;
      k.s080 := f_get_s080 (k.fdat,k.tip_fin, k.fin);
      update rez_cr set s080 = k.s080, tip_fin = k.tip_fin where rowid=k.RI;
   end loop;
   z23.to_log_rez (user_id , 351 , p_dat01   ,'Заполнение таблицы NBU23_REZ' );
   for D in (select r020, ddd, r012 from kl_f3_29 where kf='1B' )
   loop        

      If d.r020  = '3548' then t35(d.r012).ddd := d.DDD ;  
      else                     tmp(d.r020).ddd := d.ddd ;      
      end if;

   end loop;
   z23.to_log_rez (user_id , 351 , p_dat01   ,'Новые параметры' );
   for k in (select r.rowid RI,nls,nd,rnk,kol26,
             fin_nbu.zn_p('PIPB',6,(Select max(fdat) 
                                    from fin_fm 
                                    where okpo = (Select okpo 
                                                  from   fin_cust
                                                  where  okpo like '_'||lpad(lpad(FIN_NBU.ZN_P_ND_HIST('NUMG', 51, p_dat01, nd, rnk),10,'0'),11,'9') 
                                                         and  custtype = 5 and rownum = 1)),
                                   (Select okpo l_okpo_grp 
                                    from   fin_cust
                                    where  okpo like '_'||lpad(lpad(FIN_NBU.ZN_P_ND_HIST('NUMG', 51, p_dat01, nd, rnk),10,'0'),11,'9') 
                                           and  custtype = 5 and rownum = 1)) Z_GRP,
             fin_nbu.zn_p('CLAS',6,(Select max(fdat) 
                                    from fin_fm 
                                    where okpo = (Select okpo 
                                                  from   fin_cust
                                                  where  okpo like '_'||lpad(lpad(FIN_NBU.ZN_P_ND_HIST('NUMG', 51, p_dat01, nd, rnk),10,'0'),11,'9') 
                                                         and  custtype = 5 and rownum = 1)),
                                   (Select okpo l_okpo_grp 
                                    from   fin_cust
                                    where  okpo like '_'||lpad(lpad(FIN_NBU.ZN_P_ND_HIST('NUMG', 51, p_dat01, nd, rnk),10,'0'),11,'9') 
                                           and  custtype = 5 and rownum = 1)) FIN_GRP,          
              FIN_NBU.ZN_P_ND_HIST('GRKL',51,p_dat01, nd, rnk) FIN_GRP_KOR, 
              FIN_NBU.ZN_P_ND_HIST('CLS1',56,p_dat01, nd, rnk) FIN_RNK_KOR,
              FIN_NBU.ZN_P_ND_HIST('CLS2',56,p_dat01, nd, rnk) FIN_RNK,
              rez_oznaka (kol26,1) oz_165_not,
              FIN_NBU.ZN_P_ND_date_hist('VDD1',56,p_dat01, nd, rnk) dat_165_not ,
              rez_oznaka (kol26,2) oz_166_not,
              FIN_NBU.ZN_P_ND_date_hist('ZDD1',56,p_dat01, nd, rnk) dat_166_not,
              rez_oznaka (kol26,3) oz_165,
              FIN_NBU.ZN_P_ND_date_hist('VDD1',56,p_dat01, nd, rnk) dat_165 
      from rez_cr r
      where fdat = p_dat01 and kol24 = '100' )
   LOOP
      update rez_cr set z_grp     = k.z_grp     , FIN_GRP    = k.FIN_GRP   , FIN_GRP_KOR = k.FIN_GRP_KOR, FIN_RNK_KOR = k.FIN_RNK_KOR, FIN_RNK     = k.FIN_RNK_KOR,
                        oz_165_not= k.oz_165_not, oz_166_not = k.oz_166_not, oz_165      = k.oz_165     , dat_165_not = k.dat_165_not, dat_166_not = k.dat_166_not, 
                        dat_165   = k.dat_165  where rowid = k.RI;
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01   ,'Новые параметры' );
   p_bv_balans(p_dat01);
   p_sna_pd(p_dat01);

   for k in (select   FDAT  , RNK    , ACC    , KV      , NLS   , NBS , ND      , VIDD, FIN  , bv02q , sum( BV  ) bv  , sum( BVQ  ) bvq , sum( EAD ) ead,
                      bv02  , KOL    , kpz    , SDATE   , wdate , TIPA, LGD     , OVKR, P_DEF, OVD   , sum( EADQ) eadq, sum( CR   ) cr  , sum( CRQ ) crq,
                      RZ    , FIN_Z  , CCF    , PD_0    , istval, rpb , CC_ID   , s250, TIP  , TEXT  , sum( RC  ) rc  , nvl(sum( ZAL    ),0) zal   , 
                      GRP   , S080   , DDD_6B , VKR     , OPD   , NMK , custtype, nvl(ob22,'01') ob22, sum( RCQ ) RCQ , NVL(sum( ZALQ   ),0) zalq  , 
                      S080_z, FIN_KOL, FIN_KOR, Z       , poci  , OKPO,                                                 nvl(sum( ZAL_BV ),0) zal_BV,
                                                                                                                        nvl(sum( ZAL_BVQ),0) zal_BVQ
             from     REZ_CR where fdat = p_dat01 
             group by FDAT  , RNK    , ACC    , KV      , NLS   , nbs   , ND     , VIDD   , FIN , VKR , KOL  , FIN23, kpz   , NMK, SDATE, wdate, TIPA, 
                      LGD   , bv02   , bv02q  , OVKR    , P_DEF , OVD   , OPD    , CCF    , PD_0, RZ  , FIN_Z, cc_id, ISTVAL, RPB, S250 , TIP  , TEXT, 
                      GRP   , S080   , DDD_6B , custtype, OB22  , s080_z, FIN_KOL, FIN_KOR, Z   , POCI, OKPO )
   LOOP
      begin
         select DECODE (TRIM (sed),'91', DECODE (custtype, 3, 2, custtype), custtype) 
         into   k.custtype from customer where rnk = k.rnk;
      EXCEPTION WHEN NO_DATA_FOUND THEN  null;
      end;

      If (k.nbs like '9%' and k.nbs not in ('9100','9001','9129') or k.nbs='2607') then
         -- По 9100 Батюк Лариса (ГОУ СБЕРБАНК) 14-05-2013 просила ничего не проставлять в DD
         -- Добавлено decode(trim(sed),'91',2,3) для СПД(ФОП) в рамках (351) Петращук
         begin
            select decode(custtype,1,2,2,2,decode(trim(sed),'91',2,3)),DECODE (TRIM (sed),'91', DECODE (custtype, 3, 2, custtype), custtype) 
            into   dd_, k.custtype from customer where rnk = k.rnk;
         EXCEPTION WHEN NO_DATA_FOUND THEN  null;
         end;
      end if;
      if k.tipa= 15 THEN l_nd_cp := trim(k.text);
      else               l_nd_cp := k.nd;
      end if;

      if    k.tipa =  6                                       THEN l_id := k.nbs  ||                k.acc; l_ta := 3;
      elsif k.tipa =  9 and k.nbs IN ('9129')                 THEN l_id := 'CCK9/'|| k.nd || '/' || k.acc; l_ta := 3;     
      elsif k.tipa =  9 and k.nbs IN ('9000', '9002', '9003',
                                      '9020', '9023', '9122') THEN l_id := k.nbs  || k.nd ||        k.acc; l_ta := 3;     
      elsif k.tipa = 15                                       THEN l_id := 'CACP' || k.nd ||        k.acc; l_ta := 9;     
      elsif k.tipa in (3, 4)                                  THEN l_id := 'CCK2/'|| k.nd || '/' || k.acc; l_ta := 3;          
      elsif k. nbs in ('1811','1819','2800','2801','2805',
                       '2806','2809','3540','3541','3548',
                       '3570','3578','3579','3710')           THEN l_id := 'DEBF' ||                k.acc; l_ta := 17; k.fin_z := NULL; k.s080_Z := null;
      elsif k. nbs in ('3510','3519','3550','3551','3552',
                       '3559')                                THEN l_id := 'DEBH' ||                k.nd ; l_ta := k.tipa;          
      elsif k.tipa =  5                                       THEN l_id := 'MBDK' || k.nd ||        k.acc; l_ta := 3;               
      elsif k.tipa in (10, 90)                                THEN l_id := 'OVER' || k.nd ||        k.acc; l_ta :=10;                    
      elsif k.tipa in (42)                                    THEN l_id := 'W4'   || k.nd ||        k.acc; l_ta := 4;                         
      elsif k.tipa in (41)                                    THEN l_id := 'BPK'  || k.nd ||        k.acc; l_ta := 4;                         
      elsif k.tipa in (44)                                    THEN l_id := 'INS'  || k.nd ||        k.acc; l_ta :=23;                         
      else                                                         l_id := 'NNN'  || k.nd ||        k.acc; l_ta := NULL;                  
      end if;

      l_okpo   := f_rnk_okpo   (k.rnk);
      l_idr    := nvl(rez1.id_nbs(k.nbs),0);

      if k.tipa in ( 17) THEN
         l_s180 := f_get_nd_val_s('S180', k.nd, p_dat01, k.tipa, k.rnk);
      end if;

      begin
         select r013, r011, nvl(l_s180,s180), r011 into l_r013, l_r011, l_s180, r012_ from specparam where acc=k.acc;
      exception when no_data_found then null;
      end;

      If  tmp.EXISTS(k.nbs) then DDD_:= tmp(k.nbs).ddd;
      else                       DDD_:= null;
      end if;
      

      If k.nbs = '3548' and r012_ is not null then
         if t35.EXISTS(r012_) then  ddd_ := t35(r012_).ddd ; end if;
      else
         if tmp.EXISTS(k.nbs) then  ddd_ := tmp(k.nbs).ddd ; end if;
      end if;

      --if k.fin is null THEN 
      --   k.fin  := 1; 
      --   k.s080 := f_get_s080 (p_dat01, f_pd(p_dat01,k.rnk,k.acc,k.custtype,k.kv,k.nbs,k.fin, 1), k.fin);
      --end if;

      dd_ := f_rnk_custtype ( k.rnk );

      l_spec   := rez.id_specrez(k.sdate, k.istval, k.kv, l_idr, k.custtype);
      --p_par_23(to_date('01-01-2017','dd-mm-yyyy'), k.acc, k.nd, l_ta, p_fin, p_obs, p_kat, p_k, p_irr);
      p_par_accounts(k.acc, p_isp, p_branch, p_ob22);

      if k.zal_bv<>0 THEN
         p_par_zalog(p_dat01, k.acc, p_zal_bl, p_zal_blq, p_zal, p_zalQ, p_SUM_IMP, p_SUMQ_IMP, p_zal_sv, p_zal_svq);
      else    
         p_zal_bl  := 0;  p_zal_blq := 0; 
         p_zal     := 0;  p_zalQ    := 0;
         p_SUM_IMP := 0;  p_SUMQ_IMP:= 0; 
         p_zal_sv  := 0;  p_zal_svq := 0;
      end if;

      begin
      INSERT INTO NBU23_REZ 
           ( FDAT    , ID       , RNK    , NBS      , KV        , ND       , CC_ID    , ACC       , NLS    , BRANCH    , FIN    , KAT   , 
             ZAL     , BV       , REZ    , REZQ     , DD        , DDD      , BVQ      , CUSTTYPE  , IDR    , WDATE     , OKPO   , NMK   , 
             RZ      , ISTVAL   , R013   , ZALQ     , SDATE     , R011     , S180     , S250      , ISP    , OB22      , TIP    , SPEC  , 
             ZAL_BL  , ZAL_BLQ  , ND_CP  , SUM_IMP  , SUMQ_IMP  , VKR      , ZAL_SV   , ZAL_SVQ   , GRP    , REZ23     , REZQ23 , KAT23 , 
             S250_23 , EAD      , EADQ   , CR       , CRQ       , KOL_351  , FIN_351  , KPZ       , LGD    , OVKR      , P_DEF  , OVD   , 
             OPD     , RC       , RCQ    , ZAL_351  , ZALQ_351  , CCF      , TIP_351  , PD_0      , FIN_Z  , ISTVAL_351, RPB    , S080  , 
             arjk    , DDD_6B   , PVZ    , PVZQ     , tipa      , S080_z   , FIN_P    , FIN_D     , Z      , OKPO_GCIF )
      values                                                                                                       
           ( k.FDAT  , l_ID     , k.RNK  , k.NBS    , k.kv      , k.ND     , k.CC_ID  , k.ACC     , k.NLS  , P_BRANCH  , k.FIN  , 1     , 
             P_ZAL   , k.BV     , k.CR   , k.CRQ    , DD_       , DDD_     , k.BVQ    , k.CUSTTYPE, l_IDR  , k.WDATE   , l_OKPO , k.NMK , 
             k.RZ    , k.ISTVAL , l_R013 , P_ZALQ   , k.SDATE   , l_r011   , l_S180   , k.S250    , P_ISP  , k.OB22    , k.TIP  , l_SPEC, 
             P_ZAL_BL, P_ZAL_BLQ, L_ND_CP, P_SUM_IMP, P_SUMQ_IMP, k.VKR    , P_ZAL_SV , P_ZAL_SVQ , k.GRP  , k.CR      , k.CRQ  , P_KAT , 
             k.s250  , k.EAD    , k.EADQ , k.CR     , k.CRQ     , k.KOL    , k.FIN    , k.KPZ     , k.LGD  , k.OVKR    , k.P_DEF, k.OVD , 
             k.OPD   , k.RC     , k.RCQ  , k.ZAL_BV , k.ZAL_BVQ , k.CCF    , k.TIPA   , k.PD_0    , k.FIN_Z, k.ISTVAL  , k.RPB  , k.s080, 
             k.poci  , k.DDD_6B , k.zal  , k.zalq   , l_ta      , k.s080_z , k.FIN_KOL, k.FIN_KOR , k.Z    , k.OKPO   );
      exception when others then
           --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
           if SQLCODE = -00001 then NULL;
           else raise;
           end if;
     end;

     l_commit := l_commit + 1; 
     If l_commit >= 1000 then  commit;  l_commit:= 0 ; end if;

   end LOOP;
/*  
   for sna in (select n.ROWID RI, n.* from nbu23_rez n where n.fin_351 is null and (tip='SNA' or (id like 'CACP%' and bv<0 )) and n.fdat=p_dat01)
   LOOP
      begin
         select   fin,   pd_0,   tipa,   fin_z, istval  into   l_fin, l_pd_0, l_tipa, l_fin_z, l_istval from rez_cr 
         where nd=sna.nd and fdat=sna.fdat and fin is not null and nbs <> '9129' and rownum=1;
         update NBU23_rez set FIN_351 = l_fin , TIP_351 = l_TIPA, PD_0 = l_PD_0, FIN_Z   = l_FIN_Z, istval = l_istval 
         where  rowid = sna.RI ;
      EXCEPTION WHEN NO_DATA_FOUND THEN 
         update NBU23_rez set FIN_351 = fin where  rowid = sna.RI ;
      END;

   end LOOP;
*/

   for k in ( select n.ROWID RI, n.* from nbu23_rez n where n.fdat = p_dat01 and n.ead is null)
   LOOP
     if k.bv < 0 THEN l_EAD := 0   ; l_EADQ := 0;
     else             l_EAD := k.bv; l_EADQ := k.bvq;
     end if;
     update nbu23_rez set ead = l_ead, eadq = l_eadq, CR = 0, CRQ = 0, pd_0 = 0, fin_351 = 1 where rowid = k.RI ;
   end LOOP;

   z23.to_log_rez (user_id ,  12 , p_dat01 ,'Начало резерв NLO ');
   p_INS_NLO_351  (p_dat01 => p_dat01 ); 
   --z23.kontrol1   (p_dat01 => p_dat01 , p_id => 'NLO%'  );
   z23.to_log_rez (user_id ,-12, p_dat01 ,'Конец резерв NLO ');
   commit; 
   z23.to_log_rez (user_id ,351, p_dat01 ,'Начало залоги для #6B');
   p_pvz(p_dat01);  -- ( pvz ) --> tmp_rez_obesp23 для отчетности #6B
   z23.to_log_rez (user_id ,351, p_dat01 ,'Конец залоги для #6B');
   if sys_context('bars_context','user_mfo') = '300465' THEN
      p_1200(p_dat01);
   end if;
   rezerv_23 ( p_dat01);
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец REZ_CR --> NBU23_REZ  351 ');                                                                                 
END;
/
show err;

PROMPT *** Create  grants  P_NBU23_CR ***
grant EXECUTE                                                                on P_NBU23_CR      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_NBU23_CR      to RCC_DEAL;
grant EXECUTE                                                                on P_NBU23_CR      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NBU23_CR.sql =========*** End **
PROMPT ===================================================================================== 
