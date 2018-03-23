declare 
dat01_   date := to_date('01-10-2017','dd-mm-yyyy');
l_dat31  date := Dat_last_work (dat01_ - 1);  -- последний рабочий день месяца
l_pd     number;  l_fin number; l_s080 specparam.s080%type; l_mf number;
begin
   tuda;	
   for k in ( select  f_rnk_maxfin (dat01_, r.rnk  , r.tip_fin, r.nd, 1) fin_n, r.rowid RI, r.* 
              from rez_cr r where r.fdat = dat01_ and r.tipa=17 and r.tip_fin<>0 and r.s250=8 )
   LOOP
      l_fin  := f_rez_kol_fin_pd(1, 1, k.kol);
      l_s080 := f_get_s080 (dat01_,k.tip_fin, l_fin);
      begin
         select nvl(max(fin),10) into L_mf from nd_val where fdat=dat01_ and rnk=k.rnk and nd<>k.nd;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN l_mf := 1;
      end;
      --      logger.info('S250 17 1 : acc = ' || k.acc || ' k.rnk = '|| k.rnk || ' nd = '|| k.nd || ' l_mf = '|| l_mf || ' k.fin_n = '|| k.fin_n   ) ;
      if l_mf < k.fin_n THEN NULL;
      --      logger.info('S250 17 2 : acc = ' || k.acc || ' k.rnk = '|| k.rnk || ' nd = '|| k.nd || ' l_mf = '|| l_mf || ' k.fin_n = '|| k.fin_n   ) ;
      else  
      --      logger.info('S250 17 3 : acc = ' || k.acc || ' k.rnk = '|| k.rnk || ' nd = '|| k.nd || ' l_mf = '|| l_mf || ' k.fin_n = '|| k.fin_n   ) ;
         p_get_nd_val(dat01_, k.acc, k.tipa, k.kol, k.rnk, k.tip_fin, l_fin, l_s080, k.s180);  --nd = k.acc в nd_val по дебиторке всегда  acc
      end if;
      k.fin  := f_rnk_maxfin (dat01_, k.rnk  , k.tip_fin, k.nd, 1) ;
      l_pd   := f_rez_fin_pd (k.tip_fin, nvl(k.fin,f_fin23_fin351(k.fin23,k.kol)), k.kol);
      k.cr   := round(k.ead * l_pd,2);
      k.crq  := p_icurval(k.kv, k.cr * 100, l_dat31)/100 ;
      k.s080 := f_get_s080 (dat01_,k.tip_fin, k.fin);
      update rez_cr    set fin = k.fin, pd = l_pd, s080 = k.s080, s250    = null, grp = null, cr = k.cr, crq = k.crq  where rowid = k.RI;
      update nbu23_rez set fin = k.fin,            s080 = k.s080, s250_23 = null, grp = null, cr = k.cr, crq = k.crq, rez23 = k.cr, rezq23 = k.crq  where fdat = k.fdat and acc = k.acc;
   end loop;
   commit;
end;
/  


