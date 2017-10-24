CREATE OR REPLACE PROCEDURE BARS.p_ani34 (
  p_mode int ,  -----------         ------|34 = № 3. Фін.результат за період по похідним фін.інструментам
  p_dat1 date,  -- Дата З                 |
  p_dat2 date,  -- Дата ПО                ----------------------------------------------------------------
  p_tag  number --
) is

  l_dat1 date;  -- Дата З                 |
  l_dat2 date;  -- Дата ПО                ----------------------------------------------------------------
  l_tag  number; --

/*
  04.08.2017 Sta В ввиду изменения плана счетов согласно Постановления НБУ №39 необходимо дополнить логику формирования отчета №3 фин.рез…., 
      
№ графы	Зараз є так       	Добавити таке
14	6204/20~нереаліз. р-т 	6218/05 + 6218/07
15	6204/19~реаліз.	        6218/06 + 6218/08
16	6209/04~переоцінка	6206/01 + 6208/01 + 6208/04 + 6208/02 + 6208/03
17	6209/05~нереаліз.	6216/01 + 6218/01 + 6218/03 + 
18	6209/06~реаліз.	        6216/02 + 6218/02 + 6218/04


  23-09-2015 Sta Вычисление для гр.13 - расчетная сумма переоценки вал.поз
                 По результату всяческих  БЄКОВ операций  (я не анализирую: кто, когда и зачем это делал)
                 1) Беру алгоритм Рыбалка Лены – по условиям сделки
                 2) Но применяю его лишь к тем записям, которые реально прошли по вал.поз.

  17.08.2015 Sta Ноги в разных отч.периодах. См. ниже комментарий
  04.08.2015 Sta В fx_pvp берем не оф. курс, а расчетный

Рибалка Олена Василівна <RybalkaOV@oschadbank.ua>
По присланной выборке я посчитала нужные курсы путем деления
Сумма_эквивалент  /Сумма_номинал для проводок,
где идет корреспонденция с 38003001025 или 38004001024, они в приложенном файле.
Расчетные курсы получились на мой взгляд корректные, они соответствуют тем, что я подобрала вручную из базы НБУ,
что бы выйти на суммы проводок и на результат Игнатенко по этим 4-м сделкам.

  30/06/2015 Sta перешла со вюшки V_ani34 на процедуру. т.к. оч долглработала
*/

  tmp tmp_ani34%rowtype;  fl_3800 int;
/*
  FUNCTION fx_pvp_old ( p_tag1 number,  p_dat1 date, p_dat2 date ) return NUMBER IS
    l_S number  := 0   ; d1a_ date ; d2a_ date ; d1b_ date ; d2b_ date ;  Sa_ number ;  Sb_ number ; ka_ int; kb_ int;
  begin  --------------- Гр.13 = A * (N-F) – B* (M-E)
    for x in (select * from fx_deal where swap_tag = p_tag1 order by deal_tag )
    loop  If x.deal_tag =  p_tag1 then ka_  := x.kva ; SA_  := x.suma ; D1a_ := x.dat_a ;
                                       kb_  := x.kvb ; Sb_  := x.sumb ; d1b_ := x.dat_b ;
          else                                                          D2a_ := least ( x.dat_b, p_dat2) ;
                                                                        d2b_ := least ( x.dat_a, p_dat2) ;
          end if;
    end loop;
    If ka_ <> gl.baseval  then     l_S := l_s + ( gl.p_icurval(ka_, sa_, D2a_)  - gl.p_icurval(ka_, sa_, D1a_)  ) ;   end if;
    If kb_ <> gl.baseval  then     l_S := l_s - ( gl.p_icurval(kb_, sb_, D2b_)  - gl.p_icurval(kb_, sb_, D1b_)  ) ;   end if;
    Return nvl(l_s,0);
  end fx_pvp_old ;
*/
  ------------
  FUNCTION fx_pvp ( p_tag1 number,  p_dat1 date, p_dat2 date ) return NUMBER IS
    l_S number := 0 ;
    d1a_ date  ;
    d2a_ date  ;
    d1b_ date  ;
    d2b_ date  ;
    Sa_ number ;
    Sb_ number ;
    ka_ int    ;
    kb_ int    ;
    ------------
    kurs_A1 number ;
    kurs_A2 number ;
    kurs_B1 number ;
    kurs_B2 number ;

    FUNCTION R_Kurs ( p_kv number, p_ref number, p_dk number,  p_dat date ) return NUMBER IS
      l_Kurs number := 1 ;     l_k1    number := 100000000;    l_s number; l_sq number;
    begin
      If p_kv <> gl.baseval then
         begin select div0(o.sq,o.s) , o.s, o.sq  into l_kurs , l_s, l_sq   from opldok o, accounts a
               where a.kv = p_kv and a.nbs = '3800' and a.acc = o.acc and o.dk = p_dk and o.ref = p_ref and fdat = p_dat ;
         exception when no_data_found then l_kurs := gl.p_icurval( p_kv, l_k1, p_dat)/l_k1 ;
         end;
      end if;
      Return l_kurs;
    end R_Kurs;
  begin  --------------- Гр.13 = A * (N-F) – B* (M-E)
    for x in (select x.* from fx_deal x
              where x.swap_tag = p_tag1
                and exists (select 1 from opldok o, accounts a where a.nbs ='3800' and a.acc= o.acc and o.ref = x.ref)
              order by x.deal_tag
              )
    loop
       If x.deal_tag  =  p_tag1 then
            ka_  := x.kva;  SA_ := x.suma ; D1a_ := greatest (x.dat_a, p_dat1) ; kurs_A1 := R_Kurs ( ka_, x.ref, 1, d1a_) ;
            kb_  := x.kvb;  Sb_ := x.sumb ; D1b_ := greatest (x.dat_b, p_dat1) ; kurs_B1 := R_Kurs ( kb_, x.ref, 0, d1b_) ;

--logger.info ('GPK-A1*'||ka_ ||'*'|| SA_ ||'*'|| D1a_||'*'|| kurs_A1 );
--logger.info ('GPK-B1*'||kb_ ||'*'|| Sb_ ||'*'|| D1b_||'*'|| kurs_b1 );

       else                                 D2a_ := least    (x.dat_b, p_dat2) ; kurs_A2 := R_Kurs ( ka_, x.ref, 0, d2a_) ;
                                            d2b_ := least    (x.dat_a, p_dat2) ; kurs_B2 := R_Kurs ( kb_, x.ref, 1, d2b_) ;
--logger.info ('GPK-A2*'|| D2a_||'*'|| kurs_A2 );
--logger.info ('GPK-B2*'|| D2b_||'*'|| kurs_b2 );

          EXIT;
       end if;
    end loop;
    If ka_ <> gl.baseval  then  l_S := l_s + sa_* (kurs_A2 - kurs_A1) ;   end if ;
    If kb_ <> gl.baseval  then  l_S := l_s - sb_* (kurs_B2 - kurs_B1) ;   end if ;

    Return nvl(l_s,0);
  end fx_pvp ;
----#########################################################
begin
  If p_dat1 is null then RETURN; end if;

  l_dat1 := NVL(p_dat1, to_date  (pul.Get_Mas_Ini_Val('sFdat1') , 'dd.mm.yyyy') ) ;
  l_dat2 := NVL(p_dat2, to_date  (pul.Get_Mas_Ini_Val('sFdat2') , 'dd.mm.yyyy') ) ;
  l_tag  := NVL(p_tag , to_number(pul.Get_Mas_Ini_Val('SWAP'  )               ) ) ;

  EXECute immediate 'truncate table tmp_ani34 ' ;
  for Z in (select FOREX.get_forextype(x.dat, max(greatest (x.dat_a,x.dat_b)), max(greatest (x.dat_a, x.dat_b)) ) kod,
                   nvl(x.swap_tag, x.deal_tag)  tag1,  count ( * )  noga,  x.dat, x.ntik,  x.rnk,
                   min(least    (x.dat_a, x.dat_b)) dat_M,  max(greatest(x.dat_a,x.dat_b)) dat_X,
                   min (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.KVA, null) ) KVA,
                   sum (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.suma, 0)   ) suma1,
                   sum (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, 0, x.sumb)   ) suma2,
                   min (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.KVb, null) ) KVb,
                   sum (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.sumb, 0)   ) sumb1,
                   sum (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, 0,x. suma)   ) sumb2
            from fx_deal x
            where NVL(l_tag,0)  in  (0, x.swap_tag, x.deal_tag )
            group by nvl(x.swap_tag, x.deal_tag), x.dat,  x.ntik, x.rnk
            having ( FOREX.get_forextype(x.dat, max(greatest (x.dat_a, x.dat_b)) , max(greatest (x.dat_a, x.dat_b)) ) ='FORWARD'
                    or
                    count ( * ) > 1
                    )
               and min( least    (x.dat_a, x.dat_b)) <= l_dat2
               and max( greatest (x.dat_a, x.dat_b)) >= l_dat1
           )
  loop
     fl_3800 := 0 ;   tmp.G14 := 0 ;    tmp.G15 := 0 ;  tmp.G16 := 0 ;   tmp.G17 := 0 ;   tmp.G18 := 0 ;
     for p in (select decode (o.dk , 0,-1, +1) * o.s S, a.nbs, a.ob22
               from (select ref,acc,dk,s   from opldok   where fdat >= l_dat1 and fdat <= l_dat2 ) o,
                    (select acc, nbs, ob22 from accounts where nbs    in ( '3800', '6204', '6209', '6206', '6208', '6216', '6218' )  ) a
               where o.acc= a.acc
                 and o.ref in (select ref from fx_deal_ref
                               where DEAL_TAG in (select deal_tag from fx_deal where nvl(swap_tag,deal_tag) = Z.tag1)
                               )
               )
     loop
        if     p.nbs = '3800'                    then fl_3800 := 1 ;

        elsIf  p.nbs = '6204' and p.ob22 = '20' 
           OR  p.nbs = '6218' and p.ob22 = '05'  
           OR  p.nbs = '6218' and p.ob22 = '07'  then tmp.G14 := tmp.G14 + p.S ; -- 14	6204/20~нереаліз. р-т 	6218/05 + 6218/07

        elsIf  p.nbs = '6204' and p.ob22 = '19' 
           OR  p.nbs = '6218' and p.ob22 = '06'             
           OR  p.nbs = '6218' and p.ob22 = '08'  then tmp.G15 := tmp.G15 + p.S ; -- 15	6204/19~реаліз.	        6218/06 + 6218/08

        elsIf  p.nbs = '6209' and p.ob22 = '04' 
           OR  p.nbs = '6206' and p.ob22 = '01'             
           OR  p.nbs = '6208' and p.ob22 = '01'             
           OR  p.nbs = '6208' and p.ob22 = '04' 
           OR  p.nbs = '6208' and p.ob22 = '02'                         
           OR  p.nbs = '6208' and p.ob22 = '03'  then tmp.G16 := tmp.G16 + p.S ; -- 16	6209/04~переоцінка	6206/01 + 6208/01 + 6208/04 + 6208/02 + 6208/03

        elsIf  p.nbs = '6209' and p.ob22 = '05' 
           OR  p.nbs = '6216' and p.ob22 = '01'                         
           OR  p.nbs = '6218' and p.ob22 = '01'                         
           OR  p.nbs = '6218' and p.ob22 = '03'  then tmp.G17 := tmp.G17 + p.S ; -- 17	6209/05~нереаліз.	6216/01 + 6218/01 + 6218/03 

        elsIf  p.nbs = '6209' and p.ob22 = '06' 
           OR  p.nbs = '6216' and p.ob22 = '02'                         
           OR  p.nbs = '6218' and p.ob22 = '02'                         
           OR  p.nbs = '6218' and p.ob22 = '04'  then tmp.G18 := tmp.G18 + p.S ; -- 18	6209/06~реаліз.	        6216/02 + 6218/02 + 6218/04

        end if;

     end loop ; -- p

     If fl_3800 = 1  then

        If z.noga > 1 then tmp.G13 := fx_pvp ( z.tag1,  l_dat1,  l_dat2 ) ; else   tmp.G13 := 0 ; end if;

        insert into tmp_ani34 (B,E,G01,G02,G03,G04,G05,G06 ,G07 ,G08 ,G08a,G08b,G09,G10,
               G11,G12,
               G13,G14,G15,G16,G17,G18,G19,G20,G21,G22)
        select l_dat1, l_dat2, decode(z.noga,1,'Форвард', 2,'Вал.своп','Депо-своп') G01, z.tag1 G02, z.ntik g03, z.rnk g04, substr(nmk,1,70) g05,
               z.dat g06,      decode(z.noga,1,null,z.dat_m) g07, z.dat_X g08, z.KVA g08a, z.KVb g08b,
               decode(z.noga,1,null   ,z.suma1)/100 g09,     decode(z.noga,1,null   ,z.sumb1)/100 g10,
               decode(z.noga,1,z.suma1,z.suma2)/100 g11,     decode(z.noga,1,z.sumb1,z.sumb2)/100 g12,
               tmp.G13/100, tmp.G14/100, tmp.G15/100, tmp.G16/100, tmp.G17/100, tmp.G18/100,
              (tmp.G13+tmp.G14+tmp.G16+tmp.G17) /100, (tmp.G15+tmp.G18)   /100,
              (tmp.G13+tmp.G14+tmp.G15+tmp.G16+tmp.G17+tmp.G18)/100,
               CASE WHEN z.dat_X <= l_dat2 THEN 'Завершена' ELSE 'Відкрита' END g22
        from customer where rnk = Z.rnk ;
     end if;
  end loop ; -- z
  PUL.Set_Mas_Ini( 'sFdat1', to_char(l_dat1,'dd.mm.yyyy'), 'sар.sFdat1' );
  PUL.Set_Mas_Ini( 'sFdat2', to_char(l_dat2,'dd.mm.yyyy'), 'sар.sFdat2' );
  PUL.Set_Mas_Ini( 'SWAP'  , to_char(l_tag),               'SWAP_TAG'   );
end p_ani34;
------------------------------------------------------------------------------
/