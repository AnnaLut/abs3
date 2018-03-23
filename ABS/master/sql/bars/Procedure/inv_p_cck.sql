CREATE OR REPLACE PROCEDURE inv_p_cck(p_dat01 date) IS

/* Версия 1.0   03-05-2017 0
   Отчет INV_CCK
   -------------------------------------
*/

 inv  inv_cck%rowtype; l_dat31 date;

begin
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   DELETE FROM inv_cck WHERE FDAT = P_DAT01;
   p_nd_open  (p_dat01);
   for k in (select c.nmk,c.okpo,c.rnk,d.nd,d.cc_id, d.sdate, d.wdate,ad.kv, f_cur(p_dat01,ad.kv) CUR, 
                    NVL(round(f_nd_procn(n.nd,ad.kv,p_dat01),8), 0) IR , cck_app.get_nd_txt(d.nd, 'VNCRR') VNCRR, 
                    NVL(round(ACRN.FPROCN(f_acc8  (ad.nd ),-2,l_DAT31),8), 0) IRR, cck_app.get_nd_txt(d.nd, 'VNCRP') VNCRP 
             from   cc_deal d, nd_open n, customer c, cc_add ad 
             where  d.vidd in (1, 2, 3, 11, 12, 13) and d.nd = n.nd and d.rnk = c.rnk and d.nd = ad.nd and ad.adds = 0 
               and  n.fdat = p_dat01 )
   LOOP
      for kv in (select distinct a.kv from nd_acc n,accounts A 
                 where n.nd = k.nd and n.acc=a.acc and fost(a.acc,p_dat01)<>0 and a.tip not in ('SD ','LIM', 'SG','SN8','S36','ISG','ODB','ZAL','DEP') 
                )
      LOOP
         inv.ACC_SP  := NULL; inv.ACC_SS  := NULL; inv.OST_9129_9  := 0;inv.OST_SP  := 0; inv.OST_SNO := 0; inv.kol_ss := 0;            
         inv.ACC_SNO := NULL; inv.ACC_SNA := NULL; inv.OST_9129_1  := 0;inv.OST_SS  := 0; inv.OST_SDI := 0; inv.kol_sn := 0;
         inv.ACC_SPN := NULL; inv.ACC_SDI := NULL; inv.OST_SK0_SK9 := 0;inv.OST_SPI := 0; inv.OST_SNA := 0;      
         inv.ACC_SN  := NULL; inv.ACC_SPI := NULL; inv.OST_SN      := 0;inv.OST_SPN := 0;
         inv.ir      := NVL(round(f_nd_procn(k.nd,kv.kv,p_dat01),8), 0);

         for s in (select a.nbs, a.ob22, a.acc, a.nls, a.kv, a.tip, a.ostc, nvl(abs(fost(a.acc,p_dat01)),0)/100 fost, 
		                  c.custtype, s.r013   
                   from   nd_acc n,accounts A, specparam s,customer c 
                   where  n.nd  = k.nd and a.kv = kv.kv and n.acc = a.acc and fost(a.acc,p_dat01) <> 0 and 
		          a.tip not in ('SD ','LIM', 'SG','SN8','S36','ISG','ODB','ZAL','DEP')  and a.acc = s.acc (+) and  a.rnk =c.rnk order by kv,tip)
         LOOP   
            logger.info('OTC-1 nd = ' || k.nd || ' s.nbs='|| s.nbs || ' s.ob22=' ||s.ob22 || ' s.nls=' ||s.nls || ' s.fost=' ||s.fost || ' s.custtype =' ||s.custtype ) ;
            if     s.tip = 'SS '  THEN  inv.ACC_SS  := s.acc;  inv.OST_SS     := inv.ost_ss     + s.fost; end if;
            if     s.tip = 'SP '  THEN  inv.ACC_SP  := s.acc;  inv.OST_SP     := inv.ost_sp     + s.fost; 
                   inv.kol_ss := greatest(inv.kol_ss, inv_f_days(p_dat01,s.acc)); end if;
            if     s.tip = 'SNO'  THEN  inv.ACC_SNO := s.acc;  inv.OST_SNO    := inv.ost_sno    + s.fost; end if;
            if     s.tip = 'SPN'  THEN  inv.ACC_SPN := s.acc;  inv.OST_SPN    := inv.ost_spn    + s.fost; 
                   inv.kol_SN := greatest(inv.kol_sn, inv_f_days(p_dat01,s.acc)); end if;
            if     s.tip = 'SN '  THEN  inv.ACC_SN  := s.acc;  inv.OST_SN     := inv.ost_sn     + s.fost; end if;
            if     s.tip = 'SNA'  THEN  inv.ACC_SNA := s.acc;  inv.OST_SNA    := inv.ost_sna    + s.fost; end if;
            if     s.tip = 'SDI'  THEN  inv.ACC_SDI := s.acc;  inv.OST_SDI    := inv.ost_sdi    + s.fost; end if;
            if     s.tip = 'SPI'  THEN  inv.ACC_SPI := s.acc;  inv.OST_SPI    := inv.ost_spi    + s.fost; end if; 
            if     s.tip in ('SK0','SK9') THEN                 inv.OST_SK0_SK9:= inv.ost_SK0_SK9+ s.fost; end if;
            if    (s.nbs = '9129' and s.ob22 ='02' and s.custtype = 2) or 
                  (s.nbs = '9129' and s.r013 = 9   and s.custtype = 3) THEN         
                                                               inv.OST_9129_9 := inv.OST_9129_9 + s.fost; 
            elsif (s.nbs = '9129' and s.ob22 in ('04','06','08','09') and s.custtype = 2) or 
                  (s.nbs = '9129' and s.r013 = 1   and s.custtype = 3) or 
                  (s.nbs in ('9020','9023','9122','9000','9003')) THEN       inv.OST_9129_1 := inv.OST_9129_1 + s.fost;
            end if; 
            inv.bv := inv.OST_SS + inv.OST_SP + inv.OST_SN + inv.OST_SNO + inv.OST_SPN - inv.OST_SDI + inv.OST_SPI - inv.OST_SNA;
            inv.kv := s.kv;
            logger.info('OTC-3 nd = ' || k.nd || ' inv.OST_9129_9='|| inv.OST_9129_9 || ' inv.OST_SNO=' ||inv.OST_SNO || ' inv.ACC_SNO =' ||inv.ACC_SNO  || ' inv.bv=' ||inv.bv  ) ;
         end LOOP;
         insert into inv_cck( FDAT       , RNK        , NMK           , OKPO          , ND             , CC_ID      , SDATE      , 
                              WDATE      , KV         , CUR           , IR            , IRR            , VNCRR      , VNCRP      , 
                              ACC_SS     , OST_SS     , ACC_SP        , OST_SP        , ACC_SN         , OST_SN     , ACC_SNO    , 
                              OST_SNO    , ACC_SPN    , OST_SPN       , KOL_SS        , KOL_SN         , ACC_SDI    , OST_SDI    , 
                              ACC_SPI    , OST_SPI    , OST_9129_9    , OST_9129_1    , OST_SK0_SK9    , ACC_SNA    , OST_SNA    , 
                              BV         )                         
                     values ( p_dat01    , k.rnk      , k.NMK         , k.OKPO        , k.ND           , k.CC_ID    , k.SDATE    , 
                              k.WDATE    , inv.KV     , k.CUR         , inv.ir        , k.IRR          , k.vncrr    , k.VNCRP    , 
                              inv.ACC_SS , inv.OST_SS , inv.ACC_SP    , inv.OST_SP    , inv.ACC_SN     , inv.OST_SN , inv.ACC_SNO, 
                              inv.OST_SNO, inv.ACC_SPN, inv.OST_SPN   , inv.KOL_SS    , inv.KOL_SN     , inv.ACC_SDI, inv.OST_SDI, 
                              inv.ACC_SPI, inv.OST_SPI, inv.OST_9129_9, inv.OST_9129_1, inv.OST_SK0_SK9, inv.ACC_SNA, inv.OST_SNA, 
                              inv.bv     );
      end loop;
   end LOOP;
end;
/

show err;

grant execute on inv_p_cck to BARS_ACCESS_DEFROLE;
grant execute on inv_p_cck to RCC_DEAL;
grant execute on inv_p_cck to start1;
