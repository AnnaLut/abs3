create or replace procedure m1624 ( p_vidd number, p_rnk number, p_kv number, p_ir number ) is
 -- объединение нескольких 1624 в один МБДК по РНК+ КВ +% ст
 oo oper%rowtype;
 mm MBK_GPK0%rowtype;
 l_basey int  ;
 l_acc  number;
 g_ND  number ;
-------------
/*
1) Остались лишние строки в портфеле, т.е. те с которых перенеслись остатки.
2)  Назначение платежа при «схлопывании сделок» 1624 должно быть таким :
*/

begin bc.go('300465')  ;

  for G in (select a.kv, acrn.fprocn ( a.acc, 1, gl.bd) ir, d.rnk, 
                   min(d.sdate) sdate, max(d.wdate) wdate, min(d.nd) Md, max(d.nd) XD, sum(ostc) S, count(*) 
            from cc_deal d, cc_add x, accounts  a
            where d.vidd = p_vidd and d.nd = x.nd and x.adds =0 and x.accs = a.acc and d.wdate > gl.bdate
            --and a.ostc > 0 
              and nvl(d.sos,0) < 15 
            group  by a.kv, acrn.fprocn ( a.acc, 1, gl.bd) , d.rnk      having count(*)  > 1    
           ) 
  loop 
     if p_rnk > 0  and g.RNK <> p_RNK then goto NO_ ; end if ;
     If p_kv  > 0  and g.KV  <> p_kv  then goto NO_ ; end if ;
     If p_ir  > 0  and g.ir  <> p_ir  then goto NO_ ; end if ;


    select d.ND into g_ND 
    from cc_deal d, cc_add x, accounts  a
    where d.vidd = p_vidd and d.nd = x.nd and x.adds =0 and x.accs = a.acc and d.wdate = g.WDATE 
      and nvl(d.sos,0) < 15   and a.kv = G.KV and acrn.fprocn ( a.acc, 1, gl.bd) = G.IR and d.rnk = G.RNK
      and d.nd >= g.MD and d.nd <= g.XD and rownum = 1 ;



     delete from MBK_GPK0 ; -- where fdat < gl.bdate ;
     insert into MBK_GPK0 ( nd, fdat, sumT, lim2 ) values (g_ND, gl.bdate, 0, g.S );

     if g.kv = 840 and  g.IR = 5.867 then 
        If gl.bdate < to_date('21/08/2017', 'dd/mm/yyyy') then 
           insert into MBK_GPK0(nd,fdat, sumT ) values ( g_ND, to_date('21/08/2017', 'dd/mm/yyyy'), 0);
        end if;
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('20/02/2018', 'dd/mm/yyyy'), 0);
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('20/08/2018', 'dd/mm/yyyy'), 0);
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('20/02/2019', 'dd/mm/yyyy'), 0);
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('20/08/2019', 'dd/mm/yyyy'), 0);
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('20/02/2020', 'dd/mm/yyyy'), 0);
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('20/08/2020', 'dd/mm/yyyy'), 0);
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/02/2021', 'dd/mm/yyyy'), 0);
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('20/08/2021', 'dd/mm/yyyy'), 0);
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('20/02/2022', 'dd/mm/yyyy'), 0);

     elsIf  g.kv = 978 and  g.IR = 4.256 then

        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/12/2017', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/06/2018', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('24/12/2018', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('24/06/2019', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('23/12/2019', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/06/2020', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/12/2020', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/06/2021', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/12/2021', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/06/2022', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/12/2022', 'dd/mm/yyyy'), 0);   
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/06/2023', 'dd/mm/yyyy'), 0);   
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('22/12/2023', 'dd/mm/yyyy'), 0);   
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('24/06/2024', 'dd/mm/yyyy'), 0);   
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('23/12/2024', 'dd/mm/yyyy'), 0);   


     ElsIf g.KV = 978  and g.ir =4.434 then

        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/09/2017', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/03/2018', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/09/2018', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/03/2019', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/09/2019', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/03/2020', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('07/09/2020', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/03/2021', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('06/09/2021', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('07/06/2022', 'dd/mm/yyyy'), 0); 
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/09/2022', 'dd/mm/yyyy'), 0);   
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('06/03/2023', 'dd/mm/yyyy'), 0);   
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/09/2023', 'dd/mm/yyyy'), 0);   
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/03/2024', 'dd/mm/yyyy'), 0);   
        insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, to_date('05/09/2024', 'dd/mm/yyyy'), 0);   

     end if;

     oo.ref  := null;      
     oo.nam_a:= Substr( 'Рах.1624*RNK='||g.RNK|| ', вал='||g.KV||', % ст='|| g.IR ,1,38) ;
     select okpo into oo.id_a from customer where rnk = g.rnk;

     for d in (select  a.acc, a.nls, a.nms, a.ostc, d.nd, d.sdate, d.wdate, d.cc_id, a1.nls nls1, a1.ostc  ostc1, rownum RI, i.acr_dat, i.basey 
               from cc_deal d, cc_add x, accounts  a, int_accn i,  accounts a1 
               where d.vidd = p_vidd and d.nd = x.nd and x.adds =0 and x.accs = a.acc and d.wdate > gl.bdate
                 and d.rnk  = G.rnk and a.kv = G.kv and  acrn.fprocn ( a.acc, 1, gl.bd) = g.IR
                 and i.acc  = a.acc and i.id  = 1 
                 and i.acra = a1.acc and a.kv = a1.kv 
                 and nvl(d.sos,0) < 15 
               order by Decode (d.nd , g_ND,1, d.nd)
               )
     loop
        if d.acr_dat <> gl.bdate - 1  then     raise_application_error(-20203, 'НЕ нарах.%% , угода ' || d.nd || ' по '|| ( gl.bdate - 1 ) || ' включно ' );    end if;

        If d.ND = G_ND then   
           oo.nd   := Substr(d.cc_id,1,10); 
           oo.s    := G.s - d.ostc ; 
           oo.nlsb := d.nls   ; 
           oo.nam_b:= Substr(d.nms,1,38) ; 
           oo.nlsa := d.nls1  ;
           l_basey := d.basey ;
           l_acc   := d.acc   ;
           update cc_deal set sdate = g.sdate, wdate = g.wdate, ndi = g_nd where nd = d.ND;
--         oo.nazn := 'Об`єднання в одну угоду МБК № '|| d.CC_ID || ' кількох траншів по РНК='||g.RNK|| ', вал='||g.KV||',  % ст='|| g.IR  ;         
           oo.nazn := Substr( 'Перенесення залишку коштів за довг.кредитом від 30/12/13р. на рах. '   ||oo.nlsb ||
                              ' по клієнту EIB, РНК='|| g.RNK ||
                              ' (реалізація Портфелю угод)', 1,160);
        else

           update cc_deal set sos = 15 where nd = d.ND;

           If ( d.ostc > 0 OR d.ostc1 > 0 ) then 

              If oo.ref is null then gl.ref (oo.REF);
                 gl.in_doc3 (ref_ => oo.REF , tt_ =>'024', vob_ =>  6  , nd_ => oo.nd, pdat_=>SYSDATE, vdat_=> gl.bdate,  dk_ => 1,
                              kv_ => g.kv   , s_  =>oo.S , kv2_ => g.kv, s2_ => oo.S , sk_  => null  , data_=> gl.BDATE, datp_=>gl.bdate,
                           nam_a_ =>oo.nam_a, nlsa_=>'1624*', mfoa_=>gl.aMfo,
                           nam_b_ =>oo.nam_b, nlsb_=>oo.nlsb, mfob_=>gl.aMfo,
                            nazn_ =>oo.nazn ,d_rec_=>null   , id_a_=>oo.id_a, id_b_=>oo.id_a, id_o_=>null, sign_=>null, sos_=>1, prty_=>null, uid_=>null );
              end if; 

              If d.ostc  > 0 then  gl.payv(0, oo.ref, gl.bdate, '024', 1, g.kv, d.nls , d.ostc , g.kv,  oo.nlsb, d.ostc );   end if;
              If d.ostc1 > 0 then  gl.payv(0, oo.ref, gl.bdate, '024', 1, g.kv, d.nls1, d.ostc1, g.kv,  oo.nlsa, d.ostc1);   end if ;
              gl.pay (2, oo.ref, gl.bdate) ; 
           end if;

           update cc_deal set sos = 15, ndi = g_nd where nd = d.nd ;
   
        end if;

        If d.ostc  > 0 then  
           delete from MBK_GPK0 where fdat = d.WDATE ;
           insert into MBK_GPK0 ( nd, fdat, sumT ) values ( g_ND, d.WDATE, d.ostc );  
        end if;

     end loop  ;  -- d

/*
     insert into MBK_GPK0 ( nd, fdat, sumT ) 
                   select g_ND, FDAT, 0
                    from ( select least(last_day(add_months(gl.bdate,c.num-1)), g.wdate) FDAT  
                          from conductor c where add_months(gl.bdate, c.num-2) <= g.wdate  and g.wdate > gl.bdate     )    
                   where fdat not in (select fdat from MBK_GPK0);  
*/
      mm.npp  := 0 ;
      mm.dat1 := trunc ( gl.bdate, 'MM') ;
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
      update MBK_GPK0 x set sump = calp ( x.lim1,  -- проц.база (тело)
                                          g.IR  , -- проц.ставка
                                          x.dat1, -- датв С
                                          x.dat2, -- дата по
                                          l_basey -- базовій год
                                          );
     delete from cc_lim where nd = g_ND;
     insert into cc_lim (nd, acc, fdat, lim2, sumg, sumo, sumk) select g_ND, l_acc, FDAT, lim2, sumT, (sumP+sumT), 0 from MBK_GPK0;
     delete from MBK_GPK0 ;
     --------------------
     <<NO_>> null;

  end loop; -- g


end ;
/

--exec  m1624 ( p_vidd =>1624 , p_rnk => 0, p_kv =>0 , p_ir => 0  ) ;
--commit;