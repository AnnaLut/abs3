
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mbk2.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MBK2 IS

/*
  23.01.2015 Сухова Добавки к основному пакеджу МБК, который потом Ната Ч. объединит в один
             Забрала сюда процедуру mbk_SP
*/

---- Редактирование параметров
procedure UPD1( p_ND  number ); -- реф дог

------Постороение ГПК ----------------------------------------
procedure GPK (  p_mode  int, --- режим выполнения процедуры:
                              -- 0 - Разбить помесячно пл.календарь
                              -- 1 - Пересчет сумм пл.календаря
                              -- 2 - Сохранение ГПК
                 p_ND    number ); -- реф дог

------ вынос на просрочку тела и %%
procedure  mbk_SP (
n_SP  number,   -- Сума для виноса~HA простроченi~1**7
p_SS  int   ,   -- FLAG = OK = Тiло+Вiдсотки=>~HA простроченi~1**7
n_SPN number,   -- Сума для виноса~HA простроченi~1**9
p_SN  int   ,   --  FLAG = OK =     Вiдсотки=>~HA простроченi~1**9
p_nd  number    -- Реф МБК
) ;


END MBK2;
/
CREATE OR REPLACE PACKAGE BODY BARS.MBK2 IS

/*
  30.01.2015 Сухова Мелочи.
  23.01.2015 Сухова Добавки к основному пакеджу МБК, который потом Ната Ч. объединит в один
             Забрала сюда процедуру mbk_SP
*/
---- Редактирование параметров
procedure UPD1( p_ND  number ) is -- реф дог
begin null;
end UPD1;

----------Постороение ГПК ----------------------------------------
procedure GPK (  p_mode  int, --- режим выполнения процедуры:
                 p_ND    number ) -- реф дог
is

-- Виконати 0 = Стандартну розмітку Гр.Погаш. ?
-- Виконати 1 = Загрузку реального Гр.Погаш. ?
-- Виконати 2 = Рохрахунок %% згідно дат та погашень тіла ?

  d1523 cc_deal%rowtype    ;
  q1523 cc_add%rowtype     ;
  a1523 accounts%rowtype   ;
  i1523 int_accn%rowtype   ;
  l_IR  number   ;
  l_Err varchar2 (50) ;
  l_npp  int     := 0 ;
  l_dat1 date    ;
  l_dat2 date    ;
  l_sumg number  := 0 ;
  l_lim2 number  := 0 ;
  l_ND   number  ;
  ir_    number  ;
  irr0_  number  ;
  l_fdat date    ;
begin

  If nvl(p_ND,0) = 0 then  l_ND :=        to_number(pul.Get_Mas_Ini_Val( 'MBK_GPK0'                                 ) );
  else                     l_ND := p_ND;            PUL.Set_Mas_Ini    ( 'MBK_GPK0', to_char(l_ND), 'Реф. дог МБДК' ) ;
  end if;

  If p_mode = 99 then  delete from MBK_GPK0 where nd <> l_nd ; RETURN; End if;
  -----------------------------------------------------------------------------
  l_Err :=  ': МБК-угоду ' || l_ND || ' не знайдено !' ;


  begin select * into  d1523 from cc_deal  where nd = L_ND and vidd >1200 and vidd < 1700 and sos <15 ;
      --  d1523.limit := d1523.limit * 100;
  exception when no_data_found then raise_application_error(-20000, 'CC_DEAL' || l_Err );
  end;
  -- 1523    1    Розміщення 1523 - Кредити  короткострокові
  -- 1623    2    Залучення 1623 - Кредити  короткострокові
  select tipd - 1 into i1523.ID from cc_vidd where vidd = d1523.vidd ;
  ------------------
  begin select * into q1523 from cc_add   where nd = L_ND and adds = 0 ;            exception when no_data_found then raise_application_error(-20000,'CC_ADD'||l_Err ); end;
  begin select * into a1523 from accounts where acc = q1523.accS and dazs is null ; exception when no_data_found then raise_application_error(-20000,'Accounts'||l_Err ); end;
  begin select * into i1523 from int_accn where acc = a1523.acc  and id = i1523.ID; exception when no_data_found then raise_application_error(-20000,'INT_ACCN'||l_Err ); end;
  l_IR := acrn.fprocn (a1523.acc, i1523.ID, d1523.sdate) ;

  delete from MBK_GPK0 where nd <> l_nd ;

  if p_mode = 0 then ----------------------------------------------------- 0 - Разбить помесячно пл.календарь - стандарт
     delete from MBK_GPK0 ;

     insert into MBK_GPK0 ( nd, NPP, dat1, dat2, fdat, sumP, sumT, OSTC )
                   select l_ND, x.npp*5, dat1, dat2, FDAT, calp( d1523.limit*100, l_IR, x.dat1, x.dat2,  i1523.basey)/100,
                          decode ( FDAT,d1523.wdate, d1523.limit, 0 ) ,
                          fost (a1523.acc, x.FDAT)/100
                   from ( select greatest(trunc(add_months(d1523.sdate, c.num-1) ,'MM'), d1523.sdate) dat1, -- дата С  какой нач.%%
                                 least(last_day(add_months(d1523.sdate, c.num-1)), d1523.wdate-1    ) dat2, -- дата По какую нач.%%
                                 least(last_day(add_months(d1523.sdate, c.num-1)), d1523.wdate      ) FDAT, -- платежная дата
                                 c.num npp
                          from conductor c where add_months(d1523.sdate, c.num-2) <= d1523.wdate  and d1523.wdate > d1523.sdate
                          union all
                          select  d1523.sdate, d1523.sdate, d1523.sdate, 1 from dual where d1523.wdate = d1523.sdate
                          ) x
                   where dat1 <= dat2 and dat2 <= FDAT ;

     update MBK_GPK0 set lim1 = d1523.limit, lim2 = d1523.limit - sumt ;

  elsif p_mode = 1 then   -- 1 - Загрузить из ГПК
     --MBK2.GPK (1, to_number(pul.Get_Mas_Ini_Val('MBK_GPK0')) )
     delete from MBK_GPK0 ;
     l_dat1 := d1523.sdate ;
     for k in (select * from cc_lim where nd = L_ND order by fdat)
     loop l_npp := l_npp + 10; l_dat2 := k.fdat - 1 ; l_sumg := l_sumg + k.sumg ;
        insert into MBK_GPK0( npp,   dat1,  dat2,  fdat, sumP,                      sumT,       lim2,       nd ) values
                           (l_npp, l_dat1,l_dat2,k.fdat, (k.sumo/100-k.sumg/100), k.sumg/100, k.lim2/100, l_ND );
        l_dat1 := l_dat2 + 1  ;
     end loop;

     update MBK_GPK0 x set x.lim1 = x.lim2 + x.sumt, x.nd = l_ND , x.ostc = fost (a1523.acc, x.FDAT) /100 ;

  elsif p_mode = 2 then   -- 2 - Пересчет сумм пл.календаря
  ----MBK2.GPK (2, to_number(pul.Get_Mas_Ini_Val('MBK_GPK0')) )
     --балансировка
     select max(fdat) into l_fdat  from MBK_GPK0 ;
     update MBK_GPK0 x set x.sumt = d1523.limit - (select nvl( sum (sumt),0) from MBK_GPK0 where fdat < l_fdat ) where fdat = l_fdat;

     -- пересчет лимита
     update MBK_GPK0 x set x.lim1 = (select nvl(sum(y.sumT),0) from MBK_GPK0 y where y.npp >=  x.npp );
     update MBK_GPK0 x set x.lim2 = x.lim1 - x.sumt , x.ostc = fost (a1523.acc, x.FDAT) /100;
     -- пересчет процентов
     update MBK_GPK0 x set sump = calp ( ( x.lim1)*100,  -- проц.база (тело)
                                           l_IR  , -- проц.ставка
                                           x.dat1, -- датв С
                                           x.dat2, -- дата по
                                           i1523.basey -- базовій год
                                          )/100 ;
     IR_ := acrn.fproc(a1523.acc,gl.bdate);

     delete from TMP_IRR;
     insert into tmp_irr (n,s)
     select 1, -sumt*100 from  MBK_GPK0
     where nd=l_nd and fdat in (select max(fdat) from MBK_GPK0 where nd=l_nd);
     insert into tmp_irr (n,s)
     select dat2-d1523.sdate+2,(sump+sumt)*100 from MBK_GPK0 where nd=l_nd;

     begin
        irr0_ := round(XIRR(ir_) * 100,7);
     exception when others then irr0_ := 0;
     end;

     update cc_deal set ir = irr0_ where nd = l_nd ;

  elsif p_mode = 3 then  --   3 - Сохранение ГПК
     --MBK2.GPK (3, to_number(pul.Get_Mas_Ini_Val('MBK_GPK0')) )

     delete from cc_lim where nd = L_ND;
     insert into cc_lim (nd, acc,       fdat, lim2,     sumg,      sumo,          sumk)
                select L_ND, a1523.acc, FDAT, lim2*100, sumT*100, (sumP+sumT)*100, 0
     from MBK_GPK0;
     delete from MBK_GPK0 ;
  end if;

end GPK ;

---------- вынос на просрочку тела и %%
procedure  mbk_SP (
n_SP  number,   -- Сума для виноса~HA простроченi~1**7
p_SS  int   ,   -- FLAG = OK = Тiло+Вiдсотки=>~HA простроченi~1**7
n_SPN number,   -- Сума для виноса~HA простроченi~1**9
p_SN  int   ,   --  FLAG = OK =     Вiдсотки=>~HA простроченi~1**9
p_nd  number    -- Реф МБК
) is

/*
  процедура вsноса на просрочку МБК  - тело и проценты по остатку на счете
  =================================
  20.01.2015 Не заменяю ACCS на просрочку по телу
  15.12.2014 Переделина дважды на 100
  09.12.2014 Частичный вынос на просрочку
  04.12.2014 Добавила реф по просрочке к дог
-- 24.11.2014  Вынос по одному дог.
*/
  ---------------------------------------------------------
  aa    cc_add%rowtype   ; a1523 accounts%rowtype ; a1528 accounts%rowtype ; a1527 accounts%rowtype; a1529 accounts%rowtype;
  ii    int_accn%rowtype ; rr    int_ratn%rowtype ; l_id  int_accn.id%type ;
  dd    cc_deal%rowtype  ;
  sErr_ varchar2  (35)   ; sTmp_ varchar2 (100)   ; nTmp_ number           ; oo oper %rowtype;

  procedure opl1 ( oo IN OUT oper%rowtype ) is
  begin
    If oo.ref is null then    gl.ref (oo.ref );
       gl.in_doc3 (ref_ => oo.ref  , tt_  =>oo.tt  , vob_ => 6      , nd_   => oo.nd   , pdat_=> SYSDATE, vdat_=>gl.bdate ,  dk_  => oo.dk   ,
                   kv_  => oo.kv   ,  s_  => oo.s  , kv2_ => oo.kv  , s2_   => oo.s    , sk_  =>null    , data_=> gl.bdate, datp_ => gl.bdate,
                   nam_a_=>oo.nam_a, nlsa_=>oo.nlsa, mfoa_=> gl.aMfo, nam_b_=> oo.nam_b, nlsb_=> oo.nlsb, mfob_=> gl.aMfo , nazn_ => oo.nazn ,
                   d_rec_=> null   , id_a_=> null  , id_b_=> null   , id_o_ => null,  sign_=> null, sos_=> 0, prty_=> null, uid_  => null )  ;

    end if;
    gl.payv( 0, oo.ref, gl.bdate, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv, oo.nlsb, oo.s );
  end;

begin

  If NOT ( p_SS = 0 and p_SN = 1  and ( n_SPN<>0            )  OR

           p_SS = 1 and p_SN = 0  and (             n_SP<>0 )  OR
           p_SS = 1 and p_SN = 1  and ( n_SPN<>0 or n_SP<>0 )
         ) then   RETURN;
  end if;

  begin select * into dd from  cc_deal where nd = p_ND and vidd > 1000 and vidd < 2000 and sos <15;
  exception when no_data_found then raise_application_error(-(20203), 'Не знайдено угоду МБК. nd=' ||p_ND ) ;
  end;

  begin
     -- найти все по существующему МБК
     sErr_ := 'cc_add.nd = '    || dd.nd    ; select * into aa        from cc_add   where nd  = dd.nd and adds =0;
     sErr_ := 'accounts.acc='   || aa.accs  ; select * into a1523     from accounts where acc = aa.accs ;
     sErr_ := 'cc_vidd='        || dd.vidd  ; select tipd-1 into l_id from cc_vidd  where vidd= dd.vidd ;
     sErr_ := 'int_accn.acc/0=' || a1523.acc; select * into ii    from int_accn where acc = a1523.acc and id = l_id ;
     sErr_ := 'accounts.accN =' || ii.acra  ; select * into a1528 from accounts where acc = ii.acra ;
   EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-(20203),'Не знайдено ' || sErr_);
   end;

  -- Пометить МБК, как имеющий какую-либо просрочку
  update cc_deal set sos=13 where nd = DD.nd ;
  ----------------------------------------------
  a1527.nbs :=  substr(a1523.nbs ,1,3) || '7';
  If l_id = 0 then -- Размещения   -- Найти свободную пару счетов по просрочке тела и процентов
     a1529.nbs :=  substr(a1523.nbs ,1,3) || '9';
     begin
       SELECT a.acc   , n.acc   into a1527.acc , a1529.acc FROM accounts a, int_accn i, accounts n
       WHERE a.nbs  = a1527.nbs AND a.kv   = a1523.kv  AND a.rnk  = a1523.rnk AND a.acc  = i.acc AND i.acra = n.acc
         AND a.ostc = 0         AND a.ostb = 0         AND a.ostf = 0         AND n.ostc = 0     AND n.ostb = 0
         AND n.ostf = 0         AND (a.mdate<bankdate_g OR a.mdate IS NULL)   AND a.dazs is null
                                AND (n.mdate<bankdate_g OR n.mdate IS NULL)   AND n.dazs is null
                                AND (a.dapp is null or a.dapp < bankdate-10)  and rownum = 1;
     EXCEPTION WHEN NO_DATA_FOUND THEN -- автоматом открыть, если не нашли. Сначала смоделировать номерасчетов
       sTmp_     := Substr(MBK.F_NLS_MB( a1527.nbs, a1523.RNK, Null, a1523.kv, 'MBK'), 1, 30) ;
       -- открытие основного счета
       a1527.nls := Vkrzn( substr(gl.aMfo, 1,5), trim( substr(sTmp_,01,15) ) );
       Op_Reg_ex(1,dd.ND,0,a1523.Grp,nTmp_,dd.RNK, a1527.NLS, a1523.Kv, a1523.NMS,'SP ', a1523.isp, a1527.ACC,'1',null,null,null);  -- KB  pos=1

       -- открытие счета нач.%%
       a1529.nls := Vkrzn( substr(gl.aMfo, 1,5), trim( substr(sTmp_,16,15) ) );
       Op_Reg_ex(1,dd.ND,0,a1528.Grp,nTmp_,dd.RNK, a1529.NLS, a1528.kv, a1528.NMS,'SPN', a1528.isp, a1529.acc,'1',null,null,null);  -- KB  pos=1

     end;
  Else    -- Привлечения  -- Найти свободный счетов по просрочке тела (проценты - тот же счет !)
     begin
       SELECT a.acc          into a1527.acc                FROM accounts a
       WHERE a.nbs  = a1527.nbs AND a.kv   = a1523.kv  AND a.rnk  = a1523.rnk
         AND a.ostc = 0         AND a.ostb = 0         AND a.ostf = 0         AND (a.mdate<bankdate_g OR a.mdate IS NULL)
         AND a.dazs is null     AND (a.dapp is null or a.dapp < bankdate-10)  and rownum = 1;
     EXCEPTION WHEN NO_DATA_FOUND THEN  -- автоматом открыть, если не нашли. Сначала смоделировать номерасчетов
       sTmp_     := Substr(MBK.F_NLS_MB( a1527.nbs, a1523.RNK, Null, a1523.kv, 'MBK'), 1, 30) ;
       -- открытие основного счета
       a1527.nls := Vkrzn( substr(gl.aMfo, 1,5), trim( substr(sTmp_,01,15) ) );
       Op_Reg_ex(1,dd.ND,0,a1523.Grp,nTmp_,dd.RNK, a1527.NLS, a1523.Kv, a1523.NMS,'SP ', a1523.isp, a1527.ACC,'1',null,null,null);  -- KB  pos=1
     end;
     a1529.acc := ii.acra;
  end if;

  If l_id = 0 then
     update accounts set mdate = a1528.mdate where acc = a1529.acc   ;
     begin  insert into nd_acc (nd,acc)   values ( dd.nd, a1529.acc) ; -- ORA-00001: unique constraint (BARS.PK_NDACC) violated
     exception when others then  if SQLCODE = -00001 then null;   else raise; end if;
     end ;
  else
     a1529.acc := a1528.acc ;
  end if ;
  ---------------------------------------------------
  oo.tt := 'ASP'  ;
  oo.nd  := substr(dd.cc_id,1,10) ;

  select * into a1527 from accounts where  acc = a1527.acc;
  select * into a1529 from accounts where  acc = a1529.acc;

  If p_SS = 1  then  -- вынос на просрочку ТЕЛА
     -- Привязать новый счет просроченного тела и процентов к МБК
--   update cc_add  set accs   = a1527.acc   where nd = dd.nd and adds =0 ;
     update accounts set mdate = a1523.mdate where acc = a1527.acc   ;
     begin  insert into nd_acc (nd,acc)   values ( dd.nd, a1527.acc) ; -- ORA-00001: unique constraint (BARS.PK_NDACC) violated
     exception when others then  if SQLCODE = -00001 then null;   else raise; end if;
     end;
     -- Заполнить (если нет) его проц.карточку
     insert into  int_accn (ACC, ID, METR, BASEM, BASEY, FREQ, ACR_DAT, TT,      ACRA, ACRB, IO )
               select a1527.acc, id, METR, BASEM, BASEY, FREQ, ACR_DAT, TT, a1529.acc, acrb, id     from int_accn
               where acc=ii.acc and id = l_id and not exists (select 1 from int_accn where acc=a1527.acc and id = l_id );
     -- установить % ставку
     delete from int_ratn where acc = a1527.acc and id = l_id and bdat >= gl.bdate;
     insert into int_ratn (ACC, ID,  BDAT, IR, BR, OP )
             select  a1527.acc, id, gl.bd, ir, br, op   from int_ratn  where acc=a1523.acc and id = l_id
                and BDAT=(select max(BDAT) from int_ratn where acc=a1523.acc and id= l_id and bdat < gl.bd);
     If a1523.ostb <> 0 then
        oo.nazn  := substr( 'Винесено на простроченi угоду МБК № ' || dd.cc_id || ' вiд ' || to_char(dd.sdate,'dd.mm.yyyy'),1,160);
        oo.s     := LEAST ( ABS(a1523.ostb), ABS(n_SP)*100 ) ;

        If l_id = 0  then oo.dk := 1 ;
        else              oo.dk := 0 ;
        end if;

        oo.nam_a := substr( a1527.nms,1, 38); oo.nam_b := substr( a1523.nms ,1, 38);
        oo.kv    := a1523.kv ;
        oo.nlsa  := a1527.nls;
        oo.nlsb  := a1523.nls;
        opl1 (oo);

     end if;
  end if;

  If a1528.ostb < 0 and l_id = 0  then
     oo.nazn  := substr( 'Винесено на простроченi вiдсотки зг.угоди МБК № ' || dd.cc_id || ' вiд ' || to_char(dd.sdate,'dd.mm.yyyy'),1,160);
     oo.s     := LEAST ( ABS(a1528.ostb), ABS(n_SPN)*100 ) ;
     oo.dk    := 1 ;
     oo.nam_a := substr( a1529.nms,1, 38); oo.nam_b := substr( a1528.nms ,1, 38);
     oo.kv    := a1528.kv ;
     oo.nlsa  := a1529.nls;
     oo.nlsb  := a1528.nls;
     opl1 (oo);
  End If;

  If oo.ref is not null then
     insert into MBD_K_R ( nd, ref) values (p_nd,  oo.ref );
 --  gl.pay ( 2, oo.ref, gl.bdate);
  end if;

end MBK_SP;

END MBK2;
/
 show err;
 
PROMPT *** Create  grants  MBK2 ***
grant EXECUTE                                                                on MBK2            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MBK2            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mbk2.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 