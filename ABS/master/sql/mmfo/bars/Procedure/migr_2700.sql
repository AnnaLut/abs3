create or replace procedure Migr_2700 is

nd_   cc_deal.nd%type ;  l_acc   accounts.acc%type     ; l_accn   int_accn.acra%type; l_cc_id   cc_deal.cc_id%type; l_dat_start  date; l_bdate  date;
mm    MBK_GPK0%rowtype;  l_freq  cc_add.freq%type := 5 ; l_mm     integer := 1      ; l_basey   int               ; l_dat        date; 
l_dat_3660 date := to_date('19-01-2007','dd-mm-yyyy'); --  письмо 15-09-2017 (13:46)  


begin
   
   bc.go('300465');
   FOR k in (select  a.*, acrn.fprocn ( a.acc, 1, gl.bd) ir, substr(p.name,1,70) n_vidd from accounts a, ps p 
             where   a.nbs in ('2700','2701','3660','3661') and ostc<>0 and not exists (select 1 from nd_acc where acc=a.acc) and a.nbs = p.nbs
            )
   LOOP
      l_dat := gl.bdate;
      if    k.acc in (54852101, 54852301) THEN l_freq :=   7; l_dat := to_date('01-01-2018','dd-mm-yyyy'); l_dat_start := to_date('01-07-2017','dd-mm-yyyy');     
      elsif k.acc in (46941001)           THEN l_freq := 180; l_dat := to_date('19-01-2018','dd-mm-yyyy'); l_dat_start := to_date('19-07-2017','dd-mm-yyyy');     
      end if;

      begin 
         select basey into l_basey from int_accn where acc=k.acc;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_basey := NULL;
      end;

      if     l_freq =   5 THEN l_mm := 1;
      elsif  l_freq =   7 THEN l_mm := 3;
      elsif  l_freq = 180 THEN l_mm := 6;
      elsif  l_freq = 360 THEN l_mm := 12;
      end if;

      nd_ := bars_sqnc.get_nextval('S_CC_DEAL');
      l_cc_id := substr(k.nms,1,50); 
      begin 
         insert into cc_vidd (VIDD, CUSTTYPE, TIPD, NAME) values (k.nbs, 2, 2, k.n_vidd);
      exception when others then
      if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
      end;

      if k.nbs = '3660' THEN l_bdate := l_dat_3660; l_cc_id := 'Б/Н';
      else                   l_bdate := k.daos;
      end if;
      if    k.acc in (54852101) then l_cc_id := '013/1-01'; end if;
      if    k.acc in (54852301) then l_cc_id := '013/3-02'; end if;

      insert into cc_deal (nd , vidd , rnk  , user_id, cc_id  , sos, wdate  , sdate , limit , kprolog)
                   values (nd_, k.nbs, k.rnk, k.isp  , l_cc_id, 10 , k.mdate, k.daos, k.ostc/100, 0      );
      insert into cc_add
             (nd  , adds   , s         , kv     , bdate  , wdate     , accs      , sour    , acckred   , mfokred   , freq       , accperc    , mfoperc, 
              refp, swi_bic, swi_acc   , swo_bic, swo_acc, int_amount, alt_partyb, interm_b, int_partya, int_partyb, int_interma, int_intermb)
      values (nd_ , 0      , k.ostc/100, k.kv   , l_bdate, k.daos    , k.acc     , 4       , null      , null      , 2          , null       , null   , 
              null, null   , null      , null   , null   , null      , null      , null    , null      , null      , null       , null       );
         insert into nd_acc ( nd, acc) values (nd_, k.acc);

      begin 
         select acra into l_accn from int_accn where acc = k.acc;
         begin 
            insert into nd_acc ( nd, acc) values (nd_, l_accn);
         exception when others then
         if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
         end;
      EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
      end;

      begin
         select acc into l_acc from accounts where nls like substr(k.nls,1,3)||'6_'|| substr(k.nls,6,9) and kv = k.kv;
         begin 
            insert into nd_acc ( nd, acc) values (nd_, l_acc);
         exception when others then
         if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
         end;
      EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
      end;

      begin
         select acc into l_acc from accounts where nls like substr(k.nls,1,3)||'7_'|| substr(k.nls,6,9) and kv = k.kv;
         begin 
            insert into nd_acc ( nd, acc) values (nd_, l_acc);
         exception when others then
         if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
         end;
      EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
      end;
      begin 
         insert into CUSTBANK ( RNK  , BKI) values ( k.rnk, 1 );
      exception when others then
      if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
      end;
      delete from MBK_GPK0 ; -- where fdat < gl.bdate ;

      --insert into MBK_GPK0 ( nd, fdat, sumT, lim2 ) values ( ND_, gl.bdate, 0, k.ostc );
      insert into MBK_GPK0 ( nd, fdat, sumT )       values ( nd_, k.mdate, k.ostc );
      if l_freq <> 400 THEN
         insert into MBK_GPK0 ( nd, fdat, sumT ) 
                        select ND_, FDAT, 0
                        from  (select  least(add_months(l_dat, l_mm*(c.num-1)),  k.mdate) FDAT  
                               from conductor c where c.num< 1000 and add_months(l_dat, l_mm*(c.num-2)) <= k.mdate  and k.mdate > l_dat )    
                               where fdat not in (select fdat from MBK_GPK0);  
      end if;
      mm.npp  := 0 ;
      --mm.dat1 := trunc ( gl.bdate, 'MM') ;
      mm.dat1 := l_dat_start;
      for g in (select * from MBK_GPK0 order by fdat)
      loop mm.npp := mm.npp + 1 ;
           mm.dat2:= g.fdat - 1 ; 
           update MBK_GPK0 set  npp = mm.npp, dat1 = mm.dat1, dat2 = mm.dat2 where fdat = g.fdat;
           mm.dat1:= g.fdat     ; 
      end loop ; -- g

      --2.Балансування тіла та Рохрахунок %% 	
      update MBK_GPK0 x set x.lim1 = (select nvl(sum(y.sumT),0) from MBK_GPK0 y where y.npp >=  x.npp );
      update MBK_GPK0 x set x.lim2 = x.lim1 - x.sumt ;  --, x.ostc = fost (a1523.acc, x.FDAT) /100;

      -- пересчет процентов
      update MBK_GPK0 x set sump = calp_ar ( x.lim1,  -- проц.база (тело)
                                             k.IR  , -- проц.ставка
                                             x.dat1, -- датв С
                                             x.dat2, -- дата по
                                             l_basey -- базовій год
                                            );

     delete from cc_lim where nd = ND_;
     commit;
     insert into cc_lim (nd, acc, fdat, lim2, sumg, sumo, sumk) select ND_, k.acc, FDAT, lim2, sumT, (sumP+sumT), 0 from MBK_GPK0;
     commit;
     delete from MBK_GPK0 ;
     commit;
   end loop;
end;
/   
show err;

grant execute on Migr_2700 to RCC_DEAL;
grant execute on Migr_2700 to start1;
grant execute on Migr_2700 to BARS_ACCESS_DEFROLE;

      

      


