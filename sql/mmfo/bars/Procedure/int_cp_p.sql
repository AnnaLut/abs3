

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INT_CP_P.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INT_CP_P ***

CREATE OR REPLACE PROCEDURE INT_CP_P
(p_METR int   , --код методики
 p_Acc  int   , -- для передачи в
 p_Id   int   , -- acrn.p_int(nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)
 p_Dat1 date  , --
 p_Dat2 date  , --
 p_Int  OUT NUMBER, -- Interest accrued
 p_Ost  number,
 p_Mode int   )   IS
--  *** ver. 3.06 23/06-17   ***     prv 3.05 26/01-16

-- 23/06-17 Обрахунок кривого купона в останньому періоді начислення (потрібно не враховувати) COBUMMFOTEST-917
-- 26/01-16 Если есть кривой купон, считаем срок для всего полного периода
-- 13/07-15 Для p_mode=0 фіксуємо поточну ціну для майбутніх періодів
--          Ще фільтрація повідомлень залежно від p_mode
--          p_mode=5 - для тестових запусків включення додаткових повідомлень
--  1/07    p_mode=0 - Ігровий режим. Обходимо різні перевірки.
--          При p_mode=1 and p_int=0 - ! вихід через точку ZAP
-- 19/06    Аналіз купону минулого та поточного періоду щодо факту погашення
-- 13/05    Врегулювання нарахованого купону по дату l_dnk-1
--          Додаткові умови різних перевірок та фіксація в журнал
--  6/05-15 Умови контролю при НЕпогашеному купоні
--          Остання версія в НБУ  від 6/05-14
--  6/05-14 Уточнено визначення залишку номіналу в дату факт. Ф-продажу
--          Виявлено ситуацію - в даті Ф-продажу згенеровано проводку з НЕвірним DK.
-- 28/03-14 Включаємо ДС НБУ
-- 19/11-13 контроль на часткове погашення номіналу
-- валютні ЦП
-- 30/09-13 Метод 515 - Australian Floater
-- 13/03-13 Аналіз залишків на 0 в минулій даті l_dat2
-- 14/02-13 Уточнено аналіз залишків (форвард)
--  1/11-12 Значність l_kupon
-- 31/10-12 Уточнення по аналізу STOP_DAT для tip=1
-- 10/10-12 Аналіз  ACR_dat  та p_dat1  на значення '01.01.1900'
--          прописуємо remi=0
-- 27/06-12 Реф-с угоди в записи протоколу
-- 19/06-12 Знак нарахованих %-в по знаку залишку номінала.
-- 18/06-12 Узгодження всіх сум до грн/коп
--          доповнення BR=0  в acr_intN
--  5/06-12 Уточнення щодо коректного вибору купонного періоду.
-- 14/05-12 Особливості купону по ЦП в Австр. доларах.
--  9/11-11 пр-ра LOG (виклик MON_U.to_log)
-- 26/07-11 ведення протоколу через пр-ру MONITOR.TO_LOG
--          З різними рівнями деталізації в MONITOR_USER_LOG (+ SEC_AUDIT по умові)

 ACR_DAT_ int_accn.ACR_DAT%type;
 KOL1_    int ;
 KOL2_    int ;
 REF_     cp_deal.REF%type ;
 D1_    date; D1_P date;
 D2_    date; D2_P date;
 D3_    date;
 De_    cp_kod.DAT_EM%type   ;
 Dp_    cp_kod.DATp%type     ;
 Kup_   cp_dat.kup%type      ;
 Kup1_  number;  Kup0_  number;
 Kup2_  number;

 Ir_      cp_kod.IR%type       ;     l_ir   cp_kod.IR%type;
 ID_      cp_deal.ID%type      ;
 CENA_    cp_kod.cena%type     ;   CENA_F  cp_kod.cena%type     ;
 l_CENA_kup cp_kod.cena%type   ;   l_CENA_kup0 cp_kod.cena_kup0%type;
 l_pr1_kup cp_kod.pr1_kup%type ;
 l_daos accounts.daos%type;
 l_dat1 date; l_dat2 date;
 l_tip  cp_kod.tip%type;
 l_nbs  accounts.nbs%type;
 l_acra int_accn.ACRA%type;
 l_stpdat int_accn.stp_dat%type;
 l_ostr number; l_ostr2 number;  l_ostr_dok number; l_ostr2_dok number;
 l_ostr3 number;
 l_ost number;  l_ostaf number;
 l_ISIN cp_kod.cp_id%type;
 l_nazn varchar2(160);
 l_nd varchar2(10);
 l_paket varchar2(20); l_stavka varchar2(20);
 l_nls  accounts.nls%type;
 l_dn int;
 pnt int :=0; l_fl int; fl_pg int;
 l_accr cp_deal.accr%type;
 l_accr2 cp_deal.accr%type;
 l_accr3 cp_deal.accr3%type; 
 l_sint number;  l_sint_dok number;
 l_kupon number; l_kupon0 number;
 l_kv int;
 l_ky int;  l_npp int;   l_pap int;
 l_metr int;  l_dkp int; l_days int;
 l_apl_dat int_accn.apl_dat%type;
 l_dok date; l_dnk date;  l_dat_cr date;

 l_nom number;
 l_nom_g number;
 l_CENA_start cp_kod.cena_start%type;
 l_IO cp_kod.IO%type; l_IO_k cp_kod.IO%type;
 l_idt cp_type.idt%type; l_tname cp_type.name%type;
 G_TRACE  constant varchar2(20) := 'INT_CP_P: ';
 G_MODULE constant varchar2(20) := 'CPN';
 l_mdl varchar2(20) := 'CPN';
 l_trace  varchar2(1000):= '';
 l_has_awry_period int := 0; -- есть ли "кривой" купон для бумаги - при наличии укороченного 1го или последнего купонного периода
 l_normal          int;
 l_awry_first      int;
 l_awry_last       int;

begin
 l_trace := G_TRACE;
 bars_audit.info(G_TRACE||' '||p_dat1||' '||p_dat2);--закоментити
 If p_Dat2 < p_Dat1 then /* явная глупость */
    bars_audit.trace(G_TRACE||'ACC='||p_acc||' '||p_dat1||' '||p_dat2);
    RETURN;
 end if;

 l_dat1:=p_dat1;  l_dat2:=p_dat2;  p_int:=0;

 --If p_Mode = 1 then  /* не игровой режим, проверка на дату перед начисления */
    begin
    select -- nvl(i.ACR_DAT, a.daos-1),
    decode(i.acr_dat,null,a.daos-1,to_date('01.01.1900','dd.mm.yyyy'),a.daos-1,i.acr_dat),
    a.daos, a.nls,
    substr(a.nls,1,4), i.acra, i.stp_dat,
    a.ostc, a.ostb+a.ostf, a.pap, i.io, i.apl_dat
    into ACR_DAT_, l_daos, l_nls, l_nbs, l_acra, l_stpdat,
         l_ost, l_ostaf, l_pap, l_io, l_apl_dat
    from int_accn i, accounts a
         where a.acc = i.acc and i.acc = p_Acc  and i.acc != i.acra
             and i.id=p_Id;

  bars_audit.trace(G_TRACE||'NLS='||l_nls||' '||l_dat1||' '||l_dat2||' stpdat='||l_stpdat);

 if p_dat1 = to_date('02.01.1900','dd.mm.yyyy') then
    l_dat1:=l_daos;
  end if;

 if p_mode=5 then  bars_audit.trace(G_TRACE||'NLS='||l_nls||' '||l_dat1||' '||l_dat2||' acr_dat='||acr_dat_); end if;

--    LOG('NLS='||l_nls||' факт OSTC='||l_ost||' ostaf='||l_ostaf);
       If l_Dat1 <=  ACR_DAT_ then  RETURN;   end if;

       if l_ostaf = 0 and l_ost = 0 and ABS(Fost(p_Acc,l_Dat2)) = 0 then
           bars_audit.trace(G_TRACE||'NLS='||l_nls||' зал-к факт='||l_ost||' форвард='||l_ostaf);
          goto ZAP;
       end if;
       if l_ost = 0 then l_ost:= Fost(p_Acc,l_Dat2); end if;
    EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_audit.trace(G_TRACE||'! такого НЕ може бути acc='||p_acc||' '||p_id);
    RETURN ;
    end;
-- end if;

 If p_Metr not in (8,23,515)  then   -- 14/06-11 or p_id <>0 then  /* случайный залет */
    bars_audit.trace(G_TRACE||'! випадковий вхід acc='||p_acc||' metr='||p_metr);
    acrn.p_int(p_Acc, p_id, l_Dat1, l_Dat2, p_Int, p_Ost, p_Mode) ;
    p_int:=round(p_int,0);  -- 10/07-15
    RETURN;
 end if;
 ----------------------------------

 begin
    pnt:=1;
    select d.id , k.cena , k.dat_em, k.datp, k.ir , d.ref,
    nvl(k.PR1_KUP, decode (k.kv,gl.baseval, 2, 1)), k.tip, k.cp_id,
           d.accr, d.accr2, k.idt, k.kv, k.ky, cena_kup, cena_kup0,
           k.metr, cena_start, nvl(k.io,l_io),
           nvl(k.dok,k.dat_em), nvl(k.dnk,k.datp), d.accr3
    into   ID_, cena_, De_, Dp_, IR_, REF_, l_pr1_kup, l_tip, l_ISIN,
           l_accr, l_accr2, l_idt, l_kv, l_ky, l_cena_kup, l_cena_kup0,
           l_metr, l_cena_start, l_io_k, l_dok, l_dnk, l_accr3
    from  cp_deal d, cp_kod k
    where d.acc = p_Acc and k.id=d.ID;     CENA_F:=CENA_;

    if l_metr=515 then null;   -- тимчасово
    else
    l_metr:=p_metr;
    end if;
    bars_audit.trace(G_TRACE||'! метод нарахування acc='||p_acc||' metr='||l_metr);

    if l_dat1 >= l_dnk  and p_mode=1 then
        bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' NLS='||l_nls||' НЕ актуальний куп. період '||l_dnk);
       goto ZAP;
    end if;

    if l_tip=1 then
    begin
      l_fl :=0 ;
      select 1 into l_fl from dual
      where exists (select 1 from cp_dat where id = ID_);
    exception when NO_DATA_FOUND then
      bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' Не внесена iсторiя купонiв ');
      goto ZAP;
     --return;
    end;
    else     -- l_tip=2
    null; l_fl:=0;
    if nvl(l_cena_kup0,0)=0 then
      bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' НЕ вказано купон ');
      goto ZAP;
    end if;   kup_:=l_cena_kup0*100;
    end if;

    pnt := 2 ;
   if l_tip=1 then
               --log ('ISIN='||l_ISIN||' '||DE_||' '||DP_||' pr1_kup='||l_pr1_kup);
    select nvl(max(dok),De_) into D1_ from cp_dat where id=ID_ and dok<= l_dat1;
               --log('ISIN='||l_ISIN||' 2a D1='||D1_);
    select nvl(min(dok),Dp_) into D2_ from cp_dat where id=ID_ and dok>  l_dat1;
               --log('ISIN='||l_ISIN||' 2b D2='||D2_);
    select nvl(max(dok),De_) into D3_ from cp_dat where id=ID_ and dok<= p_dat2;
               --log('ISIN='||l_ISIN||' 2c D3='||D3_);
   D1_P:=D1_; D2_P:=D2_; l_days:=D2_P - D1_P;
   l_dok:=D1_;  l_dnk:=D2_;    -- -1;

    If D1_ <> D3_ then
        bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' ref='||REF_||' !НЕ нараховано.'||' Змiна куп.перiоду в перiодi нарахування');
       goto ZAP;
    else
    NULL;
    select decode(nvl(min(npp),0),0,1,min(npp))
    into l_npp
    from cp_dat
    where id=ID_ and l_dat1 < dok;
    end if;
    else     -- ДС
    null;

    D1_:=DE_;
    if l_dat1 >= DE_ and l_dat1<DP_ then D1_:=DE_; end if;
    D2_:=DP_;  --D3_:=DP_;
    if l_dat2 > nvl(l_stpdat,DP_) then l_dat2:=nvl(l_stpdat,DP_); end if;

    end if;

 EXCEPTION WHEN NO_DATA_FOUND THEN
            bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' !НЕ нараховано. pnt='||pnt);
           goto ZAP;
           when others then
              bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' !НЕ нараховано. 2d');
             goto ZAP;
             -- RETURN ;
 end;
 /*проверка на кривой купон*/
 cp.awry_period(p_id          => ID_,                 -- IN код ценной бумаги
                p_npp         => l_npp,               -- OUT текущий купонный период
                p_normal      => l_normal,            -- OUT количество дней в нормальном купонном периоде (втором)
                p_awry        => l_has_awry_period,   -- OUT признак наличия укороченного купонного периода 1/0
                p_awry_first  => l_awry_first,        -- OUT количество дней в первом купонном периоде
                p_awry_last   => l_awry_last);        -- OUT количество дней в последнем купонном периоде

 if l_has_awry_period = 0 or nvl(l_normal,0) = 0
 then l_normal := D2_ - D1_;
 end if;

 pnt:=3;
  bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' pnt='||pnt);

     --кол-во  штук ЦБ на первую дату периода начисления.
 if p_mode=1 then CENA_F:=f_cena_cp(id_,l_dat1,0); end if;
 KOL1_  := ABS(Fost(p_Acc, l_Dat1))/ 100/CENA_F;
     --кол-во  штук ЦБ на вторую  дату периода начисления.
 if p_mode=1 then CENA_F:=f_cena_cp(id_,l_dat2,0); end if;
 KOL2_  := ABS(Fost(p_Acc, l_Dat2))/ 100/CENA_F;
 if p_mode=5 then  bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' pnt='||pnt||' ref='||REF_||' ЦП штук='||kol1_); end if;
 bars_audit.trace(G_TRACE||'5) ISIN='||l_ISIN||' pnt='||pnt||' ref='||REF_||' ЦП штук='||kol1_);
 pnt:=4;
 If nvl(KOL1_,1) <> nvl(KOL2_,2) or KOL1_=0 or KOL2_=0 then
    if p_mode in (1,5) then
     bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' !НЕ нараховано.'||
              ' Змiна кiлькостi ЦП в пакетi в перiодi нарахування');
    end if;
    -- return;
    goto ZAP;
 end if;
 --LOG('ISIN='||l_ISIN||' pnt='||pnt||' ref='||REF_||):

    begin
       select nvl(ostc,0)  into l_ostr
       from accounts
       where acc=l_acra and ostc=ostb;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       if p_mode = 1 then
        bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' ref='||REF_||' .Незавізовані док-ти по рах-ку купону ');
       goto ZAP;
       end if;
    end;

    begin
    select nvl(max(fdat),l_dok-1) into l_dat_cr from opldok  where acc=l_acra and dk=1;
    end;

    l_ostr_dok:=FOST(l_accr,l_dok);

    bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' реф.угоди '||REF_||to_char(l_ostr_dok)||' .fost R');
    bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' реф.угоди '||REF_||' dok='||l_dok||' .fost R '||l_ostr_dok||' l_dat_cr='||l_dat_cr);

    l_ostr2:=0;
    if l_accr2 is not NULL then
       begin
         select nvl(ostc,0)  into l_ostr2
         from accounts
         where acc=l_accr2 and ostc=decode(p_mode,1,ostb,ostc);
       EXCEPTION WHEN NO_DATA_FOUND THEN
         bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' реф.угоди '||REF_||
             '.Незавізовані док-ти по рах-ку купону R2');
         l_ostr2:=0;
         -- goto ZAP;
       end;
    end if;
    bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' реф.угоди '||REF_||' .fost R2');
    l_ostr2_dok:=0;
    if l_accr2 is not NULL then
    l_ostr2_dok:=FOST(l_accr2,l_dok);
    bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' реф.угоди '||REF_||' dok='||l_dok||' OSTR2 ... '||l_ostr2_dok||' '||l_ostr2_dok);
    end if;

    pnt:=5;
    if l_tip=1 then
    begin
       select nvl(kup,0)*100 into kup_      --  коп/cnt
       from cp_dat
       where id=ID_
             and npp= decode(D1_,DE_,1,(select npp+1 from cp_dat where id=ID_ and dok=D1_))
                                                    ;
       bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' kup='||kup_/100||' ');
    exception when NO_DATA_FOUND then kup_:=0;
        bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' 6 D1='||D1_||' D2='||D2_||' '||kup_);
    end;

    begin
       select nvl(kup,0)*100 into kup0_      --  коп/cnt
       from cp_dat
       where id=ID_
             and npp= decode(D1_,DE_,1,(select npp from cp_dat where id=ID_ and dok=D1_))
                                                    ;
       bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' kup='||kup0_/100||' ');
    exception when NO_DATA_FOUND then kup0_:=0;
        bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' 6.0 D1='||D1_||' D2='||D2_||' '||kup0_);
    end;
 end if;

    if kup_ =0 and l_kv=980 then
        bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||'! Купон=0 '||' dat1='||l_dat1||' dat2='||l_dat2);
       goto ZAP;
    end if;

    l_kupon:=KUP_ * KOL1_;   -- коп/cnt
    l_kupon0:=KUP0_ * KOL1_;   -- коп/cnt

    bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' Купон(...)= '||l_kupon/100||' dat1='||l_dat1||' dat2='||l_dat2);

    if l_tip=2 then
       if l_io=1 then D1_ := D1_ + 1; end if;
       if l_dat1 = l_daos and l_io=1 then  l_dat1:=l_dat1+1; end if;
    end if;

    l_dkp:=D2_ - D1_;   -- днів в куп. періоді

    if l_kv =980 then

       bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||'/'||id_||' ref='||REF_||' D1='||D1_||' D2='||D2_||' '||kup_);
       bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' l_dat1='||l_dat1||' p_dat2='||p_dat2);

    -- обрахувати l_kupon := ?  для ОВДП та для ДС НБУ
       if l_pr1_kup = 2 then
           Kup1_ := Round( KUP_ * (  (p_Dat2  ) - (D1_-1) ) / least(l_dkp, l_normal) , 0);
           Kup2_ := Round( KUP_ * (  (l_Dat1-1) - (D1_-1) ) / least(l_dkp, l_normal) , 0);
           p_Int := KOL1_ * (Kup2_ - kup1_);
        else
           Kup1_ := KUP_ * (  (p_Dat2  ) - (D1_-1) ) / least(l_dkp, l_normal);
           Kup2_ := KUP_ * (  (l_Dat1-1) - (D1_-1) ) / least(l_dkp, l_normal);
           p_Int := Round(KOL1_ * (Kup2_ - kup1_) , 0);      -- коп
       end if;

        bars_audit.trace('INT_CP_P:l_normal = ' || l_normal ||', l_dkp='|| to_char(l_dkp) ||', least(l_dkp, l_lormal) = '|| to_char(least(l_dkp, l_normal)) ||', Kup1_='||Kup1_|| ', Kup2_='||Kup2_|| ', KOL1_='||KOL1_);
    elsIf l_kv = 36 and l_metr=515 then
       l_ir := ir_;
       l_nom :=  cena_ * kol1_;
       IR_ := IR_/100;
       l_kupon := round((IR_/365) * l_dkp * 100,3);  -- купон за куп. період
         --   l_kupon := l_kupon * (l_nom/100);
       l_kupon := l_kupon * l_nom;   -- * 100;   -- !! цнт
       bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' повний Купон(036)= '||l_kupon/(100)
                  ||' DOK='||D1_||' DNK='||D2_);

       Kup1_ := (IR_/365) * (  (l_Dat2  ) - (D1_-1) );
       Kup2_ := (IR_/365) * (  (l_dat1-1) - (D1_-1) );
       kup1_ := round(kup1_*100,3);
       kup2_ := round(kup2_*100,3);
       p_int := kup1_*(l_nom/100) - kup2_*(l_nom/100);

       p_int:=p_int*100*(-1);   -- цнт  !  act (<0) множ. на -1  19/06-12
       ir_ := l_ir;

    elsIf l_kv = 36 and l_metr in (8,23) then
       l_ir := ir_;
       l_nom :=  cena_ * kol1_;
       bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' cena='||cena_||' kol='||kol1_);
        -- обрахувати l_kupon := ?  для 036
       IR_ := IR_/100;
       l_kupon := round((IR_/l_ky) * 100,3);
        --   l_kupon := l_kupon * (l_nom/100);
       l_kupon := l_kupon * l_nom;   -- * 100;   -- !! коп/cnt
       bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' Купон(036)= '||l_kupon/(100)
                  ||' DOK='||D1_||' DNK='||D2_);


       Kup1_ := (IR_/l_ky) * (  (l_Dat2  ) - (D1_-1) ) / l_normal;
       Kup2_ := (IR_/l_ky) * (  (l_dat1-1) - (D1_-1) ) / l_normal;
       kup1_ := round(kup1_*100,3);
       kup2_ := round(kup2_*100,3);
       p_int := kup1_*(l_nom/100) - kup2_*(l_nom/100);

       p_int:=p_int*100*(-1);   -- коп  !  act (<0) множ. на -1  19/06-12
       ir_ := l_ir;
    else
       if l_pr1_kup = 2 then
           Kup1_ := Round( KUP_ * (  (p_Dat2  ) - (D1_-1) ) / l_normal , 0);
           Kup2_ := Round( KUP_ * (  (l_Dat1-1) - (D1_-1) ) / l_normal , 0);
           p_Int := KOL1_ * (Kup2_ - kup1_);
        else
           Kup1_ := KUP_ * (  (p_Dat2  ) - (D1_-1) ) / l_normal;
           Kup2_ := KUP_ * (  (l_Dat1-1) - (D1_-1) ) / l_normal;
           p_Int := Round(KOL1_ * (Kup2_ - kup1_) , 0);      -- коп
       end if;
    end if;
    bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' int='||p_int/100||' днів='||l_dn);
    if p_int = 0 then
       bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' int='||p_int/100||' днів='||l_dn);
       goto ZAP;
    end if;

     l_dn:= l_dat2 - l_dat1 + 1;
     bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' int='||p_int/100||' днів='||l_dn||' tip='||l_tip);

    if l_tip=2 then
       p_int:=p_int*(-1);
       if l_stpdat is NULL and l_io=1 then l_stpdat := DP_ - 1; end if;
    else
       l_stpdat := D2_ - 1;
    end if;
    bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' tip='||l_tip||' stpdat='||l_stpdat);

    l_sint:= abs(l_ostr) + abs(l_ostr2);   -- ?? а якщо R2 - від'ємний купон
    l_sint_dok:=0;
    l_sint_dok:= l_ostr_dok + l_ostr2_dok;
    l_sint_dok:=abs(l_sint_dok);

    fl_pg:=1;

    if abs(l_sint) >= l_kupon0 and (l_dat_cr < l_dok or l_dat_cr is null) then null;
       fl_pg:=0;  -- ! не погашений купон  минулого періоду
       if p_mode in (1) then
           bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' sint='||l_sint||' >= '||l_kupon0||' fl_pg='||fl_pg);
       end if;
    end if;

    if p_mode=0 then fl_pg:=0; end if;

    if l_sint > l_kupon and fl_pg=1 then
       p_int:=0;
        bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' sint='||l_sint/100||' > '||l_kupon/100||
           ' Загальна сума раніше нарахованих %-в перевищує суму купона в періоді');
    goto ZAP;
    --return;
    end if;

       -- вирівнюємо нарахування за останній період
     if (p_dat2 = l_stpdat or l_dat2 = l_dnk - 1) and fl_pg=1 then

        if l_sint > l_kupon then
            bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' '||l_sint||' > '||l_kupon||
            ' Загальна сума %-в по R+R2 перевищує суму купона в періоді');
           p_int:=0;
           goto ZAP;
        end if;

        if l_sint + abs(p_int) != l_kupon then
            bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' розр. int='||p_int/100||' 6a ');
           p_int:= l_kupon - l_sint;
           if l_tip=1 then  p_int:= p_int * (-1); end if;   -- може відрізнятись кольором

            bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' int='||p_int/100||' 6a stpdat='||l_stpdat||
                                ' врегулювання в куп. періоді');
        end if;
     end if;

     if abs(p_int) + l_sint > l_kupon and fl_pg=1 then
        bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' int='||abs(p_int/100)||' + '||l_sint/100||
            ' Загальна сума %-в перевищує суму купона в періоді');
        --return;
        p_int:=0;
        goto ZAP;
     end if;

    If p_Mode = 0 then RETURN; end if;
 ----------------------------------


    begin
    -- ryn, vidd, pf
    select nd into l_nd from cp_v where ref=REF_;
    EXCEPTION WHEN NO_DATA_FOUND THEN l_nd:='';
    end;

    if l_tip=2 then l_tname:='ДС';
    elsif l_kv=036 then l_tname:='ЦП';
    else l_tname:='ОВДП';
    end if;

    l_paket:='';
      if abs(kol1_) >0 then l_paket:=' пакет '||abs(kol1_)||' шт.'; end if;

      if KUP_ is not NULL then l_stavka:='Купон='||KUP_/100;
      else l_stavka:='Ставка='||IR_||'%';
      end if;

    IF l_tip=2 THEN
       l_nazn := 'Нарах.% по '||trim(l_tname)||' '||trim(l_ISIN)
              ||' уг.'||l_nd
              ||l_paket
              ||l_stavka
              ||' за період '
              ||to_char(l_dat1,'dd.mm.yyyy')||' - '||to_char(l_dat2,'dd.mm.yyyy')
                ;
    ELSE
    --     l_nazn:='';   -- поки що для ОВДП
       l_nazn := 'нарах.%(купон) по рах. '||l_nls||' '||trim(l_tname)||' '||trim(l_ISIN)
              ||' уг.'||l_nd||l_paket||l_stavka||' за період '
              ||to_char(l_dat1,'dd.mm.yyyy')||' - '||to_char(l_dat2,'dd.mm.yyyy');
    END IF;
    l_nazn:=null;   --  Лариса   25/05-12

    --COBUMMFOTEST-917 Якщо йде начислення по кривому купону в останньому періоді то виключити з нього суму R3
    if l_has_awry_period = 1 /*Кривий купон*/ and l_kv = 980 /*ОВДП та може ще щось*/ and D2_ = p_Dat2 + 1/*за останній період*/ then
       begin
         select nvl(abs(ostc),0)  into l_ostr3
         from accounts
         where acc=l_accr3 and ostc=decode(p_mode,1,ostb,ostc);
       EXCEPTION WHEN NO_DATA_FOUND THEN
         bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' '||ID_||' реф.угоди '||REF_||'.Незавізовані док-ти по рах-ку купону R3');
         l_ostr3:=0;
       end;
       p_Int := p_Int + l_ostr3; --P_int тут очікується таке що з мінусом, тому посуті робиться віднімання R3
    end if;  

    <<ZAP>> NULL;
    if p_mode=0 then return; end if;
    pnt:=7;
    DELETE FROM acr_intN WHERE acc= p_Acc AND id= p_id;
    if p_int != 0 then
        INSERT INTO acr_intN (acc,  id  ,   fdat,   tdat, acrd , ir , br, osts, nazn,remi)
        VALUES               (p_acc,p_id, l_Dat1, p_Dat2, p_Int, ir_, 0, l_ost, l_nazn,0);
        pnt:=8;
    end if;
    bars_audit.trace(G_TRACE||'ISIN='||l_ISIN||' ref='||REF_||' pnt='||pnt||' int='||p_int/100);
end;
/
show err;

PROMPT *** Create  grants  INT_CP_P ***
grant EXECUTE                                                                on INT_CP_P        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on INT_CP_P        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INT_CP_P.sql =========*** End *** 
PROMPT ===================================================================================== 
