

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OVR_MIGR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OVR_MIGR ***

  CREATE OR REPLACE PROCEDURE BARS.P_OVR_MIGR (p_mode int, p_kf varchar2 )  is    --p_mode = 0   = Выполнить миграцию
-- 15.11.2017 sTA TRANSFER-2017
-- 14.08.2017 Sta  OVR_LIM_dog
-- 24.07.2017 STA +KVA (Вася Х.) Разное

  a26 accounts%rowtype;
  i26 int_accn%rowtype;
  a67 accounts%rowtype;
  a69 accounts%rowtype;
  dd  CC_DEAL%rowtype ;
  a89 accounts%rowtype;
  nTmp_ number;
  dTmp_ date  ;
  a07 accounts%rowtype;
  Datx_ date  ;

  SB_2067  SB_OB22%ROWTYPE;
  SB_2069  SB_OB22%ROWTYPE;
  SB_6020  SB_OB22%ROWTYPE;
  SB_6111  SB_OB22%ROWTYPE;
  -----------------------

  procedure a3600 (DatX_ date ) is       oo oper%rowtype;    dat0_ date  ;
  begin
     oo.tt    := '%%1' ;
     oo.nlsb  := nbs_ob22(sb_6020.R020,sb_6020.OB22);
     oo.nam_b := 'Амортизац.дох. вiд дог.ОВР';

     for k in (select a.nls, a.nms, a.ostc, v.datd2, c.okpo, a.branch, a.ostf, v.ndoc , v.datd, a.kv , a.acc
               from accounts a , acc_over v , customer c
               where c.rnk = a.rnk and a.ostc > 0 and a.ostf = 0 and a.acc =v.acc_3600 and a.ostc = a.ostb and v.datd2 > datX_ and a.kv = 980
              )
     loop  dat0_  := DatX_ ;      k.ostf := k.ostc;
        FOR x in (select TRUNC(add_months(gl.bdate,c.num),'MM')-1 dat31 from conductor c where TRUNC(add_months(gl.bdate,c.num),'MM')-1 < k.datd2
                  union all select k.datd2 from dual     order by 1   )
        loop
           If x.dat31 = k.datd2 then oo.s := k.ostf ;
           else                      oo.s := ROUND(  k.ostf * (x.dat31-Dat0_) / (k.datd2-Dat0_) -0.5 ,0) ;
           end if;
           If oo.s > 0 then
              k.ostf  := k.ostf  - oo.s ;
              oo.vdat := x.dat31 ;
              oo.nazn := Substr('Щомiсячна Aмортизацiя поч.комiсiї по Дог.№ '  ||k.ndoc||' вiд '||to_char(k.datd,'dd.mm.yyyy')||
                                '. Період з '||to_char((Dat0_+1), 'dd.mm.yyyy')||' по ' || to_char(oo.vdat , 'dd.mm.yyyy'), 1, 160 ) ;
              gl.ref (oo.REF);
              oo.nd := Substr( k.ndoc,1,10) ;
              gl.in_doc3 (ref_=>oo.REF,  tt_ =>oo.tt , vob_ => 6    , nd_ =>oo.nd,   pdat_ =>SYSDATE,  vdat_=> oo.vdat,  dk_ => 1,
                           kv_=>k.kv  ,  s_  =>oo.S  , kv2_ => k.kv , s2_ =>oo.S ,   sk_   => null  ,  data_=> oo.vdat, datp_=> gl.bdate,
                        nam_a_=>substr(k.nms,1,38)   , nlsa_=> k.nls,mfoa_=>gl.amfo, nam_b_=>oo.nam_b, nlsb_=>oo.nlsb,  mfob_=> gl.amfo,
                         nazn_=>oo.nazn, d_rec_=>null, id_a_=>k.okpo, id_b_=>gl.aOkpo, id_o_=>null   , sign_=>null, sos_=>1, prty_=>null, uid_=> 5901 );
              gl.payv(0, oo.ref, oo.vdat, oo.tt, 1, k.kv, k.nls, oo.s, k.kv,  oo.nlsb, oo.s);
              gl.pay (2, oo.ref, oo.vdat);
           end if ;
           Dat0_  := x.dat31;
        end loop  ; ---x
     end loop     ; --- k

  end a3600;
  --------------
begin


 begin select 0 into OVRN.G_2017 from SB_OB22  where         r020  = '2067'      and ob22  = '01'   and d_close is null ;
       SB_2067.R020 := '2067';   SB_2067.OB22 := '01' ; -- короткостроковў кредити в поточну дўяльнўсть
       SB_2069.R020 := '2069';   SB_2069.OB22 := '04' ; -- простроченў нарахованў доходи за короткостроковими кредитами в поточну дўяльнўсть
       SB_6020.R020 := '6020';   SB_6020.ob22 := '06' ; -- за рахунками клўїнтўв банку за овердрафтом в нацўональнўй валютў (рахунок 2600)
       SB_6111.R020 := '6111';   SB_6111.ob22 := '05' ; -- за супроводження кредитів, наданих юридичним особам та іншим суб`єктам підприємницької діяльності
 EXCEPTION WHEN NO_DATA_FOUND THEN OVRN.G_2017 := 1;
       SB_2067.R020 := '2063';   SB_2067.OB22 := '33' ; -- короткостроковў кредити в поточну дўяльнўсть
       SB_2069.R020 := '2068';   SB_2069.OB22 := '46' ; -- простроченў нарахованў доходи за короткостроковими кредитами в поточну дўяльнўсть
       SB_6020.R020 := '6020';   SB_6020.ob22 := '06' ; -- за рахунками клўїнтўв банку за овердрафтом в нацўональнўй валютў (рахунок 2600)
       SB_6111.R020 := '6511';   SB_6111.ob22 := '05' ; -- за супроводження кредитів, наданих юридичним особам та іншим суб`єктам підприємницької діяльності
 end;


  bars.bc.go (p_kf);
  begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values   (141, 980, 'Комісія за надання Овердрафту (% від ліміту)', 0, 1,   0, 0, p_KF );
  exception when dup_val_on_index then null;
  end;

  begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values   (142, 980, 'Комісія за підключення Овердрафту Холдінгу', 100000, 0,  0, 0, p_kf );
  exception when dup_val_on_index then null;
  end;

  begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values    (143, 980, 'Комісія за підключення послуги NPP', 100000, 0,  0, 0, p_kf);
  exception when dup_val_on_index then null;
  end;

  begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values    (144, 980, 'Комісія за Овердр.Одного Дня (% від макс.деб.зал.)', 0, 0.06,     0, 0, p_kf );
  exception when dup_val_on_index then null;
  end;

  begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values   (145, 980, 'За користування Овердрафтом Холдингу', 10000, 0,  0, 0, p_kf );
  exception when dup_val_on_index then null;
  end;

  begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf) Values    (146, 980, 'За користування послугою NPP', 20000, 0,  0, 0, p_kf );
  exception when dup_val_on_index then null;
  end;
  ----------------------------------------------------------------------------
  for xx in (select * from acc_over where nvl(sos,0) = p_mode and acc = acco and acc_2067 is not null )
  loop
    begin  select   * into a26 from accounts where acc = xx.acc ;
           select   * into i26 from int_accn where acc = xx.acc and id = 0;
           select   * into a67 from accounts where acc = xx.acc_2067;
           select a.* into a69 from accounts a, int_accn i where i.acc = a67.acc and i.id = 0 and i.acra = a.acc ;
    EXCEPTION WHEN NO_DATA_FOUND THEN goto HET_ ;
    end;
    -- мигрируем только с нестекшим сроком, либо с просрочками
    If NOT (xx.DATD2 > gl.bdate OR a26.ostc < 0 or a67.ostc < 0 or a69.ostc < 0 ) then   null;
    Else
       dd         := null;
       dd.ndi     := null  ;
       dd.nd      := bars_sqnc.get_nextval('s_cc_deal', p_kf);
       dd.sos     := CASE WHEN a67.ostc < 0  OR a69.ostc < 0 THEN 13 else 10 end;
       dd.cc_id   := xx.NDOC   ;
       dd.sdate   := xx.DATD   ;
       dd.wdate   := xx.DATD2  ;
       dd.limit   := xx.sd/100 ;
       dd.sdog    := xx.sd/100 ;
       dd.rnk     := a26.rnk   ;
       dd.vidd    := OVRN.vidd ;
       dd.branch  := a26.branch;
       dd.kf      := a26.kf    ;
       dd.user_id := NVL(xx.USERID, a26.isp);
       dd.user_id :=                a26.isp ;
       dd.OBS     := xx.OBS    ;
       dd.FIN23   := xx.FIN23  ;
       dd.OBS23   := xx.OBS23  ;
       dd.KAT23   := xx.KAT23  ;
       dd.K23     := xx.K23    ;
       BARS.CCK_APP.Set_ND_TXT (p_ND => dd.nd , p_TAG => 'CPROD' ,p_TXT => '13');
       INSERT INTO cc_deal  values dd;
       Insert into nd_acc (nd, acc) select dd.nd, n.acc from nd_acc n where nd = xx.ND;
        While 1<2     loop     nTmp_ := trunc(dbms_random.value(1, 999999999));
          begin select 1 into nTmp_ from accounts where nls like '8998_'||nTmp_; EXCEPTION WHEN NO_DATA_FOUND THEN EXIT ; end;
          end loop;
       a89.nls := vkrzn ( substr(gl.aMfo,1,5) ,'89980'||nTmp_ );
       a89.nms :='Мігрований ОВР '|| dd.cc_id;
       op_reg_ex( mod_=>1, p1_=>dd.nd, p2_=>0, p3_=>a26.grp, p4_=>nTmp_, rnk_=>dd.rnk, nls_=>a89.nls, kv_=>a26.kv, nms_=>a89.nms, tip_=>  OVRN.TIP,
                isp_=>a26.isp,   accR_=>a89.acc, nbsnull_ =>null, pap_ => 2,  tobo_ =>a26.branch);
       select * into a89 from accounts where acc = a89.acc;
       update accounts set ostc= a26.ostc, ostb = a26.ostb, ostf = a26.ostf, lim = a26.lim where acc = a89.acc;
       update accounts set accc= a89.acc where acc = a26.acc ;
       insert into int_accn (ACC, ID, METR, BASEM, BASEY,FREQ, stp_DAT, acr_dat )
                  select a89.acc, id, METR, BASEM, BASEY,1   , dd.wdate, acr_dat
                  from int_accn where acc = a26.acc and id in (0,1) ;
       OVRN.SetIR( dd.nd, a89,  0, dd.sdate, 0 ) ; --\ Установить проц ставку на 8998* = 0
       OVRN.SetIR( dd.nd, a89,  1, dd.sdate, 0 ) ; --/
       If nvl(xx.PR_2600A,0) < 1 then xx.PR_2600A  := 5; end if; -- пл.день для процентов
       OVRN.SetW ( a89.acc, 'TERM_LIM' , '09'                 ) ;   --- День міс.перегляду ліміту(КБ=20,ММСБ=10)
       OVRN.SetW ( a89.acc, 'TERM_DAY' , to_char(xx.PR_2600A) ) ;   --- g_TAGD = TERM_DAY -- Термiн(день мiс) для сплати %%
       OVRN.SetW ( a89.acc, 'PCR_CHKO' , '50'                 ) ;   --- g_TAGC = PCR_CHKO -- Розмiр лiмiту (% вiд ЧКО)
       OVRN.SetW ( a26.acc, 'PCR_CHKO' , '50'                 ) ;   --- g_TAGC = PCR_CHKO -- Розмiр лiмiту (% вiд ЧКО)
       OVRN.SetW ( a26.acc, 'TERM_OVR' , to_char(xx.day)      ) ;   --- g_TAG  = TERM_OVR -- Термiн безперервного ОВР, кiл.днiв
       OVRN.SetW ( a26.acc, 'DONOR'    , '0'                  ) ;   --- g_TAGN = DONOR    -- Признак донора
       OVRN.SetW ( a26.acc, 'NEW_KL'   , '0'                  ) ;   --- g_TAGK = NEW_KL   -- Признак <<нов кл>>
       OVRN.SetW ( a26.acc, 'NOT_DS'   , '1'                  ) ;   --- Договірне списання - ВІДСУТНЄ

       insert into OVR_LIM     (nd,acc,fdat, lim, ok ) values (dd.nd, a89.acc, dd.sdate , a26.lim, 1 )  ;
       insert into OVR_LIM     (nd,acc,fdat, lim, ok ) values (dd.nd, a26.acc, dd.sdate , a26.lim, 1 )  ;
       insert into OVR_LIM_dog (nd,acc,fdat, lim     ) values (dd.nd, a89.acc, dd.sdate , a26.lim    )  ;
       insert into OVR_LIM_dog (nd,acc,fdat, lim     ) values (dd.nd, a26.acc, dd.sdate , a26.lim    )  ;

       dd.NDI     := dd.ND     ;
       dd.nd      := xx.nd     ;
       dd.vidd    := OVRN.vid1 ;
       INSERT INTO cc_deal  values dd;
       OVRN.isob  (p_nd => dd.NDI, p_sob => 'Мігровано дог.ОВР ' || dd.nd ||'->'|| dd.NDI);
       OVRN.INT_OLD (a26.acc, gl.bdate-1 ); ---------- Доначислить проц по <вчера>
       -----------------------------------------------------------------
       dTmp_ := trunc(gl.bdate,'MM') ;
       begin insert into  OVR_CHKO  (PR, acc,datM ) values ( 0 ,a26.acc, add_months( dTmp_, -1) ); exception when others then null; end;
       begin insert into  OVR_CHKO  (PR, acc,datM ) values ( 0, a26.acc, add_months( dTmp_, -2) ); exception when others then null; end;
       begin insert into  OVR_CHKO  (PR, acc,datM ) values ( 0, a26.acc, add_months( dTmp_, -3) ); exception when others then null; end;

       -- 05.04.2017 типы счетов
       for k in  (select a.*  from accounts a where  a.tip = 'ODB' and a.acc in (select n.acc from nd_acc n where n.nd = xx.ND) )
       loop
          If    k.NBS like '26_7'                                then    update accounts set tip ='SN ' where acc = k.acc;
          ElsIf k.NBS = sb_2067.R020  AND K.OB22 = sb_2067.OB22  then    update accounts set tip ='SP ' where acc = k.acc;
          ElsIf k.NBS = sb_2069.R020  AND K.OB22 = sb_2069.OB22  then    update accounts set tip ='SPN' where acc = k.acc;
          ElsIf k.NBS like '3739'                                then    update accounts set tip ='SG ' where acc = k.acc;
          ElsIf k.NBS like '9129'                                then    update accounts set tip ='CR9' where acc = k.acc;
          end if;
       end loop;

       -- 05.04.2017 договорные лимиты
       insert into OVR_LIM_dog (nd,acc,fdat, lim) select nd,acc,fdat, lim from OVR_LIM where nd = dd.nd;
    end if ;
    --1)	Не была обнулена таблица Mdate;
    If a26.mdate is not null then
       If a26.ostc >= 0      then Update accounts set mdate = null where acc = a26.acc;   -- Если при миграции на 2600 >= 0 – обнулить Mdate
       elsIf gl.bdate > a26.mdate then  OVRN.ins_TRZ (p_acc1=> a26.acc, p_datVZ=> a26.mdate, p_datSP => null, p_trz=> 1); -- Если Mdate – в прошлом (до 15 дней)  – поместить в серую зону
       end if;
    end if;
    --- 2) В случае если в сделке 1 участник следующие комиссии не взымаются (вне зависимости от установленного размера):
    OVRN.TARIF ( 2, a26.acc, 141, 0); --- 141 – Комісія за надання Овердрафту (% від ліміту)
    OVRN.TARIF ( 2, a26.acc, 142, 0); --- 142 – Комиссия за подключение Овердрафта Холдинга;
    OVRN.TARIF ( 2, a26.acc, 143, 0); --- 143 – Комиссия за подключение услуги NPP;
    OVRN.TARIF ( 2, a26.acc, 144, 0); --- 144 – Комісія за Овердр.Одного Дня (% від макс.деб.зал.)
    OVRN.TARIF ( 2, a26.acc, 145, 0); --- 145 – За пользование Овердрафтом Холдинга;
    OVRN.TARIF ( 2, a26.acc, 146, 0); --- 146 – За пользование услугой NPP;
    update int_accn set basey = i26.basey,  acr_dat = i26.acr_dat  where acc = a89.acc and id in (0,1) ;
    update acc_over set sos = 110 where acc = xx.acc;

    <<HET_>> null;
  end loop ; -- xx

  -- 5).Необходимо сформировать форвардные проводки по счету 3600;
  a3600 (i26.acr_dat) ;

end p_OVR_MIGR ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OVR_MIGR.sql =========*** End **
PROMPT ===================================================================================== 
