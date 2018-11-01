CREATE OR REPLACE PROCEDURE BARS.p_ani34 (
  p_mode int ,  -----------         ------|34 = № 3. Фін.результат за період по похідним фін.інструментам
                                    ------|35 = № 3` Фінансовий результат за період по "коротким" Форекс-угодам   COBUMMFO-4428
  p_dat1 date,  -- Дата З                 |          Розробка нового звіту за операціями ФОРЕКС на умовах СПОТ
  p_dat2 date,  -- Дата ПО                ----------------------------------------------------------------
  p_tag  number --
) is

  l_dat1 date;  -- Дата З                 |
  l_dat2 date;  -- Дата ПО                ----------------------------------------------------------------
  l_tag  number; --
---------------------------------------------------
  Z_KOD   forex_ob22.kod%type  ; Z_tag1  fx_deal.DEAL_TAG%type;  Z_dat   fx_deal.DAT%type  ;  Z_ntik  fx_deal.NTIK%type ;  Z_rnk fx_deal.RNK%type ;
  Z_dat_M fx_deal.DAT_A%type   ; Z_KVA   fx_deal.KVA%type     ;  Z_suma1 fx_deal.SUMA%type ;  Z_suma2 fx_deal.SUMA%type ;  z_ref fx_deal.Ref%type ;
   Z_dat_X fx_deal.DAT_B%type   ; Z_KVb   fx_deal.KVB%type     ;  Z_sumb1 fx_deal.SUMB%type ;  Z_sumb2 fx_deal.SUMB%type ;  --Z_noga  int ;

/*
  28.09.2017 Sta добавлен бал.счет 6214
  05.09.2017 Sta COBUMMFO-4428  p_mode = 35 Розробка нового звіту за операціями ФОРЕКС на умовах СПОТ
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
  -----------------------------------------------
  CURSOR C_34 IS select FOREX.get_forextype(x.dat, max(greatest (x.dat_a,x.dat_b)), max(greatest (x.dat_a, x.dat_b)) ) kod,
                        nvl (x.swap_tag, x.deal_tag)  tag1,  count ( * )  noga,  x.dat, x.ntik,  x.rnk,
                        min (least    (x.dat_a, x.dat_b)) dat_M,  max(greatest(x.dat_a,x.dat_b)) dat_X,
                        min (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.KVA, null) ) KVA,
                        sum (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.suma, 0)   ) suma1,
                        sum (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, 0, x.sumb)   ) suma2,
                        min (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.KVb, null) ) KVb,
                        sum (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.sumb, 0)   ) sumb1,
                        sum (decode ( nvl(x.swap_tag, x.deal_tag), x.deal_tag, 0,x. suma)   ) sumb2
                 from fx_deal x
                 where NVL(l_tag,0)  in  (0, x.swap_tag, x.deal_tag )
                  group by forex.get_forextype3 (x.DEAL_TAG), nvl(x.swap_tag, x.deal_tag), x.dat,  x.ntik, x.rnk
                   --having ( FOREX.get_forextype(x.dat, max(greatest (x.dat_a, x.dat_b)) , max(greatest (x.dat_a, x.dat_b)) ) ='FORWARD'   OR    count ( * ) > 1      )
                   --having  (forex.get_forextype3 (x.DEAL_TAG) in ('D.SWAP_FORWARD','D.SWAP_SPOT','D.SWAP_TOD', 'FORWARD','V.SWAP_FORWARD','V.SWAP_SPOT','V.SWAP_TOD') OR count ( * ) > 1 )
                   having (forex.get_forextype3(x.deal_tag) like '%.SWAP\_%' escape '\' or forex.get_forextype3(x.deal_tag) = 'FORWARD' or count(*) > 1) --COBUMMFO-8184 MDom 2018.10.18
                   and min ( least    (x.dat_a, x.dat_b)) <= l_dat2        and max( greatest (x.dat_a, x.dat_b)) >= l_dat1 */
                  --COBUMMFO-8184 MDom 24.10.2018 переписав попередній запит (підвищена швидкість, особливо за невеликий проміжок часу)
                  select --якщо в типі угоди немає '_' то виводимо повністю, якщо є, обрізаємо до першого символу '_'
                         upper(substr(case instr(t.kod, '_')
                                        when 0 then t.kod
                                        else substr(t.kod, 1, instr(t.kod, '_')-1)
                                      end, 1, 9)) as kod, --т.я. Z_KOD VARCHAR2(15) і більше 9 не потрібно
                         t.tag1,
                         t.dat,
                         t.ntik,
                         t.rnk,
                         min(t.dat_M) dat_M,
                         max(t.dat_X) dat_X,
                         min(t.KVA) KVA,
                         sum(t.suma1) suma1,
                         sum(t.suma2) suma2,
                         min(t.KVb) KVb,
                         sum(t.sumb1) sumb1,
                         sum(t.sumb2) sumb2
                    from (select forex.get_forextype3(x.DEAL_TAG) kod,
                                 nvl(x.swap_tag, x.deal_tag) tag1,
                                 x.dat,
                                 x.ntik,
                                 x.rnk,
                                 least(x.dat_a, x.dat_b) dat_M,
                                 greatest(x.dat_a, x.dat_b) dat_X,
                                 decode(nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.KVA, x.KVB) KVA,
                                 decode(nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.suma, 0) suma1,
                                 decode(nvl(x.swap_tag, x.deal_tag), x.deal_tag, 0, x.sumb) suma2,
                                 decode(nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.KVB, x.KVA) KVb,
                                 decode(nvl(x.swap_tag, x.deal_tag), x.deal_tag, x.sumb, 0) sumb1,
                                 decode(nvl(x.swap_tag, x.deal_tag), x.deal_tag, 0, x.suma) sumb2
                            from fx_deal x
                           where NVL(l_tag, 0) in (0, x.swap_tag, x.deal_tag)
                             and greatest(x.dat_a, x.dat_b) >= l_dat1
                             and least(x.dat_a, x.dat_b) <= l_dat2) t
                   where t.kod like '_.SWAP\_%' escape '\' or t.kod = 'FORWARD'
                   group by upper(substr(case instr(t.kod, '_')
                                        when 0 then t.kod
                                        else substr(t.kod, 1, instr(t.kod, '_')-1)
                                      end, 1, 9)), t.tag1, t.dat, t.ntik, t.rnk;

  -----------------------------------------------
  CURSOR C_35 IS select X.kod, x.deal_tag,  x.dat, x.ntik,  x.rnk,  x.dat_a, x.dat_b, x.KVA,  x.suma, x.kvb, x.sumb, x.ref
                   from (SELECT forex.get_forextype3 (xx.DEAL_TAG) KOD,  XX.* 
                -- forex.get_forextype (dat,dat_a,dat_b) KOD,  XX.*
                       FROM fx_deal XX
                       WHERE nvl(xx.SWAP_TAG,0)=0 AND  NVL(l_tag,0) in (0, XX.deal_tag ) AND XX.SOS >0  and   least (xx.dat_a, xx.dat_b) <= l_dat2  and greatest (xx.dat_a, xx.dat_b) >= l_dat1
                      ) x
                 WHERE KOD IN ('TOD','SPOT') ;
  -----------------------------------------------

  ------------
  FUNCTION fx_pvp ( p_tag1 number,  p_dat1 date, p_dat2 date ) return NUMBER IS    l_S number := 0 ;
      d1a_ date      ;     d2a_ date  ;     d1b_ date  ;     d2b_ date  ;    Sa_ number ;    Sb_ number ;    ka_ int    ;    kb_ int    ;
      kurs_A1 number ; kurs_A2 number ; kurs_B1 number ; kurs_B2 number ;

      FUNCTION R_Kurs ( p_kv number, p_ref number, p_dk number,  p_dat date ) return NUMBER IS
        l_Kurs number := 1 ;     l_k1    number := 100000000;    l_s number; l_sq number;
      begin If p_kv <> gl.baseval then
               begin select div0(o.sq,o.s) , o.s, o.sq  into l_kurs , l_s, l_sq   from opldok o, accounts a
                     where a.kv = p_kv and a.nbs = '3800' and a.acc = o.acc and o.dk = p_dk and o.ref = p_ref and fdat = p_dat ;
               exception when no_data_found then l_kurs := gl.p_icurval( p_kv, l_k1, p_dat)/l_k1 ;
               end;
            end if;
            Return l_kurs;
      end R_Kurs;
  begin  --------------- Гр.13 = A * (N-F) – B* (M-E)
     for x in (select x.* from fx_deal x  where x.swap_tag = p_tag1 and exists (select 1 from opldok o, accounts a where a.nbs ='3800' and a.acc= o.acc and o.ref = x.ref) order by x.deal_tag  )
     loop
        If x.deal_tag  =  p_tag1 then
           ka_  := x.kva;  SA_ := x.suma ; D1a_ := greatest (x.dat_a, p_dat1) ; kurs_A1 := R_Kurs ( ka_, x.ref, 1, d1a_) ;
           kb_  := x.kvb;  Sb_ := x.sumb ; D1b_ := greatest (x.dat_b, p_dat1) ; kurs_B1 := R_Kurs ( kb_, x.ref, 0, d1b_) ;
        else                               D2a_ := least    (x.dat_b, p_dat2) ; kurs_A2 := R_Kurs ( ka_, x.ref, 0, d2a_) ;
                                           d2b_ := least    (x.dat_a, p_dat2) ; kurs_B2 := R_Kurs ( kb_, x.ref, 1, d2b_) ;
           EXIT;
        end if;
     end loop;
     If ka_ <> gl.baseval  then  l_S := l_s + sa_* (kurs_A2 - kurs_A1) ;   end if ;
     If kb_ <> gl.baseval  then  l_S := l_s - sb_* (kurs_B2 - kurs_B1) ;   end if ;
     Return nvl(l_s,0);
  end fx_pvp ;
----#########################################################
begin
  If p_dat1 is null OR p_Mode not in (34,35) then RETURN; end if;
  l_dat1 := NVL(p_dat1, to_date  (pul.Get_Mas_Ini_Val('sFdat1') , 'dd.mm.yyyy') ) ;
  l_dat2 := NVL(p_dat2, to_date  (pul.Get_Mas_Ini_Val('sFdat2') , 'dd.mm.yyyy') ) ;
  l_tag  := NVL(p_tag , to_number(pul.Get_Mas_Ini_Val('SWAP'  )               ) ) ;

  EXECute immediate 'truncate table tmp_ani34 ' ;
  If    p_mode = 34 then OPEN C_34 ;
  elsIf p_mode = 35 then OPEN C_35 ;
  else  RETURN ;
  end if;
  LOOP
      If    p_mode = 34 then
        FETCH C_34 into Z_KOD, Z_tag1, /*Z_noga, */Z_dat, Z_ntik, Z_rnk, Z_dat_M, Z_dat_X, Z_KVA, Z_suma1, Z_suma2, Z_KVb, Z_sumb1, Z_sumb2;
        EXIT WHEN c_34%NOTFOUND;
      ElsIf p_mode = 35 then
        FETCH C_35 into Z_KOD, Z_tag1,             Z_dat, Z_ntik, Z_rnk, Z_dat_M, Z_dat_X, Z_KVA, Z_suma1,          Z_KVb, Z_sumb1, z_Ref  ;
        EXIT WHEN c_35%NOTFOUND;
      else
        RETURN ;
     end if;

     fl_3800 := 0 ;   tmp.G14 := 0 ;    tmp.G15 := 0 ;  tmp.G16 := 0 ;   tmp.G17 := 0 ;   tmp.G18 := 0 ;
     for p in (select decode (o.dk , 0,-1, +1) * o.s S, a.nbs, a.ob22
               from (select ref,acc,dk,s   from opldok   where fdat >= l_dat1 and fdat <= l_dat2 ) o,
                    (select acc, nbs, ob22 from accounts where nbs    in ( '3800', '6204',  '6206', '6208', '6209', '6214' , '6216', '6218' )  ) a
               where o.acc= a.acc
                 and o.ref in (select ref from fx_deal_ref
                               where DEAL_TAG in (select deal_tag from fx_deal where nvl(swap_tag,deal_tag) = Z_tag1)
                               )
               )
     loop

        if    p.nbs  ='3800'  then fl_3800 := 1 ;
        ElsIf p_mode = 34     then
           If    p.nbs='6204' and p.ob22='20' OR p.nbs='6218' and p.ob22='05' OR p.nbs='6218' and p.ob22='07'                                 then tmp.G14 :=tmp.G14+p.S; --14~нереаліз.6218/05+6218/07
           elsIf p.nbs='6204' and p.ob22='19' OR p.nbs='6218' and p.ob22='06' OR p.nbs='6218' and p.ob22='08'                                 then tmp.G15 :=tmp.G15+p.S; --15~реаліз.  6218/06+6218/08
           elsIf p.nbs='6209' and p.ob22='04' OR p.nbs='6206' and p.ob22='01' OR p.nbs='6208' and p.ob22='01' OR p.nbs='6208' and p.ob22='04'
              OR p.nbs='6208' and p.ob22='02' OR p.nbs='6208' and p.ob22='03'                                                                 then tmp.G16 :=tmp.G16+p.S; --16~переоцін 6206/01+6208/01+6208/04+6208/02+6208/03
           elsIf p.nbs='6209' and p.ob22='05' OR p.nbs='6216' and p.ob22='01' OR p.nbs='6218' and p.ob22='01' OR p.nbs='6218' and p.ob22='03' then tmp.G17 :=tmp.G17+p.S; --17~нереаліз.6216/01+6218/01+6218/03
           elsIf p.nbs='6209' and p.ob22='06' OR p.nbs='6216' and p.ob22='02' OR p.nbs='6218' and p.ob22='02' OR p.nbs='6218' and p.ob22='04' then tmp.G18 :=tmp.G18+p.S; --18~реаліз.  6216/02+6218/02+6218/04
           end if;
        ElsIf p_mode = 35     then
--6204	19	реалўзований фўнансовий результат за операцўями FOREX-звичайний, СВОП     (короткў)
--6204	20	нереалўзований фўнансовий результат за операцўями FOREX-звичайний, СВОП (короткў)

           If    p.nbs='6214' and p.ob22='06' OR p.nbs='6204' and p.ob22='20' then tmp.G14 :=tmp.G14+p.S; --14 Нереалізований р-т   6214/06
           elsIf p.nbs='6214' and p.ob22='05' OR p.nbs='6204' and p.ob22='19' then tmp.G15 :=tmp.G15+p.S; --15 Реалізований р-т   6214/05
           end if;
        else RETURN;
        end if;
     end loop ; -- p

     If fl_3800 = 1    then
        If p_mode = 34 then

            --COBUMMFO-8184 MDom 2018.10.26 закоментував та написав нову перевірку нижче (виправлення пункту 4)
            --If z_noga > 1 then tmp.G13 := fx_pvp ( z_tag1,  l_dat1,  l_dat2 ) ; else   tmp.G13 := 0 ; end if;
            if z_kod like '_.SWAP' then
              tmp.G13 := fx_pvp(z_tag1, l_dat1, l_dat2);
            else
              tmp.G13 := 0;
            end if;

            insert into tmp_ani34(B, E, G01, G02, G03, G04, G05, G06, G07, G08, G08a, G08b, G09, G10, G11, G12, G13, G14, G15, G16, G17, G18, G19, G20, G21, G22)
            select l_dat1,
                   l_dat2,
                   --COBUMMFO-8184 MDom 2018.10.25 закоментував та написав новий decode нижче (виправлення пункту 1)
                   --decode(z_noga, 1, 'Форвард', 2, 'Вал.своп', 'Депо-своп') G01,
                   decode(z_kod, 'FORWARD', 'Форвард', 'V.SWAP', 'Вал.своп', 'D.SWAP', 'Депо-своп') G01,
                   z_tag1 G02,
                   z_ntik g03,
                   z_rnk g04,
                   substr(nmk, 1, 70) g05,
                   z_dat g06,
                   --COBUMMFO-8184 MDom 2018.10.25 закоментував та написав новий decode нижче тому що перевірка через z_noga не точна
                   --decode(z_noga, 1, null, z_dat_m) g07,
                   decode(z_kod, 'FORWARD', null, z_dat_m) g07,
                   z_dat_X g08,
                   z_KVA g08a,
                   z_KVb g08b,
                   --COBUMMFO-8184 MDom 2018.10.25 закоментував та написав нові decode нижче (виправлення пунктів 2, 3)
                   --decode(z_noga, 1, null, z_suma1)/100 g09, decode(z_noga, 1, null, z_sumb1)/100 g10,
                   --decode(z_noga, 1, z_suma1, z_suma2)/100 g11, decode(z_noga, 1, z_sumb1, z_sumb2)/100 g12,
                   decode(z_kod, 'FORWARD', null, z_suma1)/100 g09,
                   decode(z_kod, 'FORWARD', null, z_sumb1)/100 g10,
                   decode(z_kod, 'FORWARD', z_suma1, z_suma2)/100 g11,
                   decode(z_kod, 'FORWARD', z_sumb1, z_sumb2)/100 g12,
                   tmp.G13/100,
                   tmp.G14/100,
                   tmp.G15/100,
                   tmp.G16/100,
                   tmp.G17/100,
                   tmp.G18/100,
                   (tmp.G13+tmp.G14+tmp.G16+tmp.G17)/100,
                   (tmp.G15+tmp.G18)/100,
                   (tmp.G13+tmp.G14+tmp.G15+tmp.G16+tmp.G17+tmp.G18)/100,
                  CASE WHEN z_dat_X <= l_dat2 THEN 'Завершена' ELSE 'Відкрита' END g22
              from customer where rnk = Z_rnk ;

        elsIf p_mode = 35 then

           insert into tmp_ani34 (B,E,G01,G02,G03,G04,G05,G06,G07, G08,G08a,G08b, G11,G12,  G14,G15, G19, G22, g13 )
           select l_dat1, l_dat2 , z_kod G01, z_tag1 G02, z_ntik g03, z_rnk g04, substr(nmk,1,70) g05, z_dat g06,
                  z_dat_m g07,
                  z_dat_X g08,
                  z_KVA g08a, z_KVb g08b,
                  z_suma1/100 g11, z_sumb1/100 g12, tmp.G14/100 g14, tmp.G15/100 g15,  (tmp.G14+tmp.G15)/100 g19, CASE WHEN z_dat_X <= l_dat2 THEN 'Завершена' ELSE 'Відкрита' END g22, z_ref g13
           from customer where rnk = Z_rnk ;

        else RETURN;
        end if;
     end if;

  end loop ; -- z

  If    p_mode = 34 then close C_34 ;
  elsIf p_mode = 35 then close C_35 ;
  else  RETURN ;
  end if;


  PUL.Set_Mas_Ini( 'sFdat1', to_char(l_dat1,'dd.mm.yyyy'), 'sар.sFdat1' );
  PUL.Set_Mas_Ini( 'sFdat2', to_char(l_dat2,'dd.mm.yyyy'), 'sар.sFdat2' );
  PUL.Set_Mas_Ini( 'SWAP'  , to_char(l_tag),               'SWAP_TAG'   );
end p_ani34;
------------------------------------------------------------------------------
/