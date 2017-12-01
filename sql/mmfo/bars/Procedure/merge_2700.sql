create or replace procedure Merge_2700 ( p_vidd number, p_rnk number, p_kv number, p_NN number ) is
 -- объединение нескольких 2700 в один МБДК 
 oo      oper%rowtype      ;  mm      MBK_GPK0%rowtype     ; L_nvidd cc_vidd.name%type; nd_ cc_deal.nd%type;  l_cc_id  cc_deal.cc_id%type;
 l_accn  int_accn.acra%type;  l_freq  cc_add.freq%type := 5; l_mm    integer := 1     ; l_dat  date        ;  l_dat_s  date              ;
 l_basey int  ;
 l_acc   number;
-------------
begin bc.go('300465')  ;

   for G in (select a.isp, a.nbs, a.kv,a.rnk,acrn.fprocn ( a.acc, 1, gl.bd) ir,  min(a.daos) sdate, max(a.mdate) wdate,  sum(ostc) S, count(*)   cn
             from accounts a where nbs='2701' and ostc<>0 and nls like ('_______'||p_NN) --and not exists (select 1 from nd_acc where acc=a.acc)
             group  by a.isp, a.nbs, a.kv, acrn.fprocn ( a.acc, 1, gl.bd) , a.rnk    --  having count(*)  > 1    
            ) 
   loop 
      if p_rnk > 0  and g.RNK <> p_RNK then goto NO_ ; end if ;
      If p_kv  > 0  and g.KV  <> p_kv  then goto NO_ ; end if ;

      if p_nn =1 THEN select acc into l_acc from accounts where nls='27010201' and kv=g.kv; l_freq := 180; l_dat :=  to_date('10-03-2018','dd-mm-yyyy'); l_dat_s :=  to_date('10-03-2017','dd-mm-yyyy');
      else            select acc into l_acc from accounts where nls='27019202' and kv=g.kv; l_freq := 180; l_dat :=  to_date('20-03-2018','dd-mm-yyyy'); l_dat_s :=  to_date('20-03-2017','dd-mm-yyyy');
      end if;

      begin 
         select basey into l_basey from int_accn where acc = l_acc;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_basey := NULL;
      end;

      if     l_freq =   5 THEN l_mm := 1;
      elsif  l_freq =   7 THEN l_mm := 3;
      elsif  l_freq = 180 THEN l_mm := 6;
      elsif  l_freq = 360 THEN l_mm := 12;
      end if;

      begin  
         select nd into nd_ from nd_acc where acc = l_acc;
      EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
         nd_ := bars_sqnc.get_nextval('s_cc_deal') ;
      end;

      if p_nn = 1 THEN l_cc_id := 'Б/Н';  -- 'SSB №1 PLC дог. від 04/03/11';
      else             l_cc_id := 'Б/Н';  --'SSB №1 PLC дог. від 15/03/13';
      end if;  

      begin
         select substr(name,1,70) into L_nvidd from ps where nbs = g.nbs; 
      EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
      end;

      begin 
         insert into cc_vidd (VIDD, CUSTTYPE, TIPD, NAME) values (g.nbs, 2, 2, l_nvidd);
      exception when others then
      if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
      end;

      begin 
         insert into cc_deal (nd , vidd , rnk  , user_id, cc_id  , sos, wdate  , sdate  , limit  , kprolog)
                      values (nd_, g.nbs, g.rnk, g.isp  , l_cc_id, 10 , g.wdate, g.sdate, g.S/100, 0      );
      exception when others then
      if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
      end;

      begin 
         insert into cc_add
                (nd  , adds   , s      , kv     , bdate  , wdate     , accs      , sour    , acckred   , mfokred   , freq       , accperc    , mfoperc, 
                 refp, swi_bic, swi_acc, swo_bic, swo_acc, int_amount, alt_partyb, interm_b, int_partya, int_partyb, int_interma, int_intermb)
         values (nd_ , 0      , g.S/100, g.kv   , g.sdate, g.sdate   , null      , 4       , null      , null      , 2          , null       , null   , 
                 null, null   , null   , null   , null   , null      , null      , null    , null      , null      , null       , null       );
      exception when others then
      if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
      end;

      delete from MBK_GPK0 ; -- where fdat < gl.bdate ;
      --insert into MBK_GPK0 ( nd, fdat, sumT, lim2 ) values ( ND_, gl.bdate, 0, g.S );
      oo.ref  := null;      
      oo.nam_a:= Substr( 'Рах.2700*RNK='||g.RNK|| ', вал='||g.KV||', % ст='|| g.IR ,1,38) ;
      select okpo into oo.id_a from customer where rnk = g.rnk;

      for d in (select a.daos,a.kv,a.rnk,acrn.fprocn ( a.acc, 1, gl.bd) ir,  a.ostc, a.nls,a.acc,a.nms,a.mdate wdate
                from accounts a where nbs='2701' and ostc<>0 and nls like ('_______'||p_NN)
                order by a.daos
               )
      loop
         If d.ostc  > 0 then  insert into MBK_GPK0 ( nd, fdat, sumT ) values ( nd_, d.WDATE, d.ostc );  end if;
         If d.nls in ('27010201','27019202') THEN   
            update accounts set mdate = g.wdate where acc = d.acc; 
            update cc_deal  set wdate = g.wdate where nd  = nd_;
            update cc_add   set accs  = d.acc   where nd  = nd_ and adds = 0;
            begin 
               insert into nd_acc ( nd, acc) values (nd_, d.acc);
            exception when others then
            if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
            end;
            begin 
               select acra into l_accn from int_accn where acc = d.acc;
               begin 
                  insert into nd_acc ( nd, acc) values (nd_, l_accn);
               exception when others then
               if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
               end;
            EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
            end;

            begin
               select acc into l_acc from accounts where nls like substr(d.nls,1,3)||'6_'|| substr(d.nls,6,9) and kv = d.kv;
               begin 
                  insert into nd_acc ( nd, acc) values (nd_, l_acc);
               exception when others then
               if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
               end;
            EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
            end;

            begin
               select acc into l_acc from accounts where nls like substr(d.nls,1,3)||'7_'|| substr(d.nls,6,9) and kv = d.kv;
               begin 
                  insert into nd_acc ( nd, acc) values (nd_, l_acc);
               exception when others then
               if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
               end;
            EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
            end;
            begin 
               insert into CUSTBANK ( RNK  , BKI) values ( d.rnk, 1 );
            exception when others then
            if SQLCODE in (-02291,-00001,-06512) then NULL; else  raise; end if;
            end;
            oo.nd   := d.nls; 
            oo.nlsb := d.nls;
            oo.s    := G.s - d.ostc ;  
            oo.nam_b:= Substr(d.nms,1,38) ; 
            l_acc   := d.acc   ;
            logger.info('M_2700 Перенесення залишку коштів за довг.кредитом від ' || g.sdate  || 
                                                           ' р. на рах. ' || oo.nlsb  || 
                                                           ' по клієнту ' || oo.nam_b ||
                                                                ', РНК= ' || g.rnk    ||
                                            ' (реалізація Портфелю угод)') ;
--          oo.nazn := 'Об`єднання в одну угоду МБК '|| d.nls || ' кількох траншів по РНК='||g.RNK; 
--          Перенесення.зал.коштів за довг.кред.від 10.03.2011 р. на рах. 27010201 по клієнту Довгостр.кредит від  SSB №1 PLC дог. в, РНК= 93709201 (реаліз.Портфелю угод)
            oo.nazn := 'Перенесення.зал.коштів за довг.кред.від ' || g.sdate  || 
                                                   ' р. на рах. ' || oo.nlsb  || 
                                                   ' по клієнту ' || oo.nam_b ||
                                                        ', РНК= ' || g.rnk    ||
                                         ' (реаліз.Портфелю угод)';  
         else
            If ( d.ostc > 0 ) then 
               oo.nam_a := Substr(d.nms,1,38) ; 
               If oo.ref is null then gl.ref (oo.REF);
                  gl.in_doc3 (ref_  => oo.REF  , tt_   => '024'   , vob_   => 6       , nd_    => oo.nd  , pdat_ => SYSDATE, vdat_  => gl.bdate,  
                              dk_   => 1       , kv_   => g.kv    , s_     => oo.S    , kv2_   => g.kv   , s2_   => oo.S   , sk_    => null    , 
                              data_ => gl.BDATE, datp_ => gl.bdate, nam_a_ => oo.nam_a, nlsa_  => '2701*', mfoa_ => gl.aMfo, nam_b_ => oo.nam_b, 
                              nlsb_ => oo.nlsb , mfob_ => gl.aMfo , nazn_  => oo.nazn , d_rec_ => null   , id_a_ => oo.id_a, id_b_  => oo.id_a , 
                              id_o_ => null    , sign_ => null    , sos_   => 1       , prty_  => null   , uid_  => null   );
               end if; 

               gl.payv(0, oo.ref, gl.bdate, '024', 1, g.kv, d.nls , d.ostc, g.kv,  oo.nlsb, d.ostc);   
               gl.pay (2, oo.ref, gl.bdate) ; 
            end if;
         end if;
                  
      end loop  ;  -- d

      if l_freq <> 400 THEN
         insert into MBK_GPK0 ( nd , fdat, sumT ) 
                         select ND_, FDAT, 0
                         from  (select  least(add_months(l_dat, l_mm*(c.num-1)),  g.wdate) FDAT  
                                from conductor c where c.num<1000 and add_months(l_dat, l_mm*(c.num-2)) <= g.wdate  and g.wdate > l_dat )    
                                where fdat not in (select fdat from MBK_GPK0);  
      end if;

      mm.npp  := 0 ;

      --mm.dat1 := trunc ( gl.bdate, 'MM') ;
      mm.dat1 := l_dat_s ;
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
                                             g.IR  , -- проц.ставка
                                             x.dat1, -- датв С
                                             x.dat2, -- дата по
                                             l_basey -- базовій год
                                            );

     delete from cc_lim where nd = ND_;
     commit;
     insert into cc_lim (nd, acc, fdat, lim2, sumg, sumo, sumk) select ND_, l_acc, FDAT, lim2, sumT, (sumP+sumT), 0 from MBK_GPK0;
     delete from MBK_GPK0 ;
     --------------------
     <<NO_>> null;

  end loop; -- g
end ;
/

show err;

grant execute on Merge_2700 to RCC_DEAL;
grant execute on Merge_2700 to start1;
grant execute on Merge_2700 to BARS_ACCESS_DEFROLE;

      


