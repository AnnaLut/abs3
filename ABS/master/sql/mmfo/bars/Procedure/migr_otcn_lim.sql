create or replace procedure Migr_otcn_lim is

mm MBK_GPK0%rowtype;  l_basey int := 2; l_freq  cc_add.freq%type := 5 ; l_mm   integer := 1; l_dat date;  l_dat_start date;

begin 
   delete from MBK_GPK0 ;
   insert into MBK_GPK0 ( nd, fdat, sumT,osti ) 
   select n.nd, o.fdat, lim, n.acc from OTCN_LIM_SB o, nd_acc n where o.acc=n.acc ;

   --select basey into l_basey from int_ratn
   for k in (select distinct m.nd, m.osti,acrn.fprocn( m.osti, 1, gl.bd) ir,d.wdate from MBK_GPK0 m,cc_deal d 
             where m.nd=d.nd and m.osti is not null
            )
   LOOP 
      l_freq      := MBDK_2700_FREQ (k.nd);
      l_dat       := MBDK_2700_dat  (k.nd, 1);
      l_dat_start := MBDK_2700_dat  (k.nd, 0);

      begin 
         select basey into l_basey from int_accn where acc = k.osti;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_basey := NULL;
      end;

      if     l_freq =   5 THEN l_mm := 1;
      elsif  l_freq =   7 THEN l_mm := 3;
      elsif  l_freq = 180 THEN l_mm := 6;
      elsif  l_freq = 360 THEN l_mm := 12;
      end if;

      mm.npp  := 0 ;
      --mm.dat1 := trunc ( gl.bdate, 'MM') ;
      mm.dat1 := l_dat_start ;
      if l_freq <> 400 THEN
         insert into MBK_GPK0 ( nd , fdat, sumT ) 
                        select k.ND, FDAT, 0
                        from  (select  least(add_months(l_dat, l_mm*(c.num-1)),  k.wdate) FDAT  
                               from conductor c where c.num <1000 and add_months(l_dat, l_mm*(c.num-2)) <= k.wdate  and k.wdate > l_dat )    
                               where fdat not in (select fdat from MBK_GPK0 where nd=k.nd);  
      end if;

      for g in (select * from MBK_GPK0 where nd = k.nd order by fdat)
      loop mm.npp := mm.npp + 1 ;
           mm.dat2:= g.fdat - 1 ; 
           update MBK_GPK0 set  npp = mm.npp, dat1 = mm.dat1, dat2 = mm.dat2 where nd=k.nd and fdat = g.fdat;
           mm.dat1:= g.fdat     ; 
      end loop ; -- g

      --2.Балансування тіла та Рохрахунок %% 	
      update MBK_GPK0 x set x.lim1 = (select nvl(sum(y.sumT),0) from MBK_GPK0 y where nd=k.nd and y.npp >=  x.npp ) where nd=k.nd;
      update MBK_GPK0 x set x.lim2 = x.lim1 - x.sumt where nd=k.nd;  --, x.ostc = fost (a1523.acc, x.FDAT) /100;

      -- пересчет процентов
      update MBK_GPK0 x set sump = calp_ar ( x.lim1,  -- проц.база (тело)
                                             k.IR  , -- проц.ставка
                                             x.dat1, -- датв С
                                             x.dat2, -- дата по
                                             l_basey -- базовій год
                                           ) where nd=k.nd;
 
     delete from cc_lim where nd = k.ND;
     insert into cc_lim (nd, acc, fdat, lim2, sumg, sumo, sumk) select k.ND, k.osti, FDAT, lim2, sumT, (sumP+sumT), 0 from MBK_GPK0 where nd=k.nd;
     
  end loop;
  --delete from MBK_GPK0 ;
end;
/

show err;

grant execute on Migr_otcn_lim to RCC_DEAL;
grant execute on Migr_otcn_lim to start1;
grant execute on Migr_otcn_lim to BARS_ACCESS_DEFROLE;


