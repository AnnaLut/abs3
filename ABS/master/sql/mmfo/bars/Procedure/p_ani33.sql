

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ANI33.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ANI33 ***

  CREATE OR REPLACE PROCEDURE BARS.P_ANI33 (p_mode int, -- 33 = Друк звiту
                                    p_dat1 date, -- Дата З
                                    p_dat2 date, -- Дата ПО
                                    p_kv   int -- Код вал або 0=всі
                                    ) is
  /*
    18.05.2015 Виключення угод, що не пройшли через 3800
    28-04-2015 Накрпичення з трасою. з виключенням битої угоди  swap_tag = 95103

    09.04.2015 без анализа проц.ставок на НЕ = 0 ,
               а с анализом на количество записей в пл.календате ( д.б. БОЛЕЕ 2-х)
                     and exists       (select  count(*)     from fx_deal xx where xx.swap_tag = x.swap_tag having count(*) >2 )
  ------------------ and nvl(acrn.fproc(ACC9a,DAT),0) + NVL(acrn.fproc(ACC9B,DAT),0) > 0  -------------------

    17.03.2015 Визначення ДЕПО_СВОП_ОВЕРНАЙТ через DAT_NEXT_U
    10.02.2015 + Депо-своп
    Юрченко Олена Андріївна <YurchenkoOA@oschadbank.ua>  Пн 19/05/2014 11:15
    09.02.2015 Добавлены ДЕПО-СВОП
    --------Новый отчет "Динаміка основних показників ліквідності"
    01.11.2015 Добавлены 4 колонки COBUSUPABS-3805
       - Залучено FX SWAP только c гривной!!!!
       - Розміщено FX SWAP только с гривной
       - Каса 1001-1004
       - Каса 1001-1017

  */
  dMax1_ date;
  dMax2_ date;
  dMax_  date;
  dMin_  date;
  di_    number;
  ndat_  number;
  l_kv   number := nvl(p_kv, 0);
  l_Dat1 date;

  -----------------------------------------------------------------------------------------
  procedure SAL_DSW(P_dat DATE) IS
    Dat1_  date;
    Dat2_  date;
    kod_   varchar2(15);
    sTmp1_ varchar2(15);
    sTmp2_ varchar2(25);

    procedure sal1(k_S IN OUT number,
                   k_I IN OUT number,
                   f_S IN number,
                   f_I IN number) is
      nTmp_ number := k_S + f_S;
    begin
      k_I := div0(k_S * k_I + f_S * f_I, nTmp_);
      k_S := nTmp_;
    end sal1;
    procedure summary(k_S IN OUT number,
                      f_S IN number) is
      nTmp_ number := k_S + f_S;
    begin
      k_S := nTmp_;
    end summary;
    ---------------------------------------------------------------------
  BEGIN
    Dat1_ := NVL(p_dat, gl.bdate);

    --Ищем макс пред день
    select max(fdat) into Dat2_ from SALDO_DSW where fdat < Dat1_;
    sTmp2_ := '/ Пред.день=' || to_char(Dat2_, 'yyyy-mm-dd');

    FOR k in (select * from SALDO_DSW where fdat = Dat2_) loop
      sTmp1_ := to_char(Dat1_, 'yyyy-mm-dd') || '*' || k.kv;

      insert into TMP_OPERW
        (DVAL, ord, VALUE)
      values
        (sTmp1_,
         0,
         ' Вход.ост: Роз ов=' || k.SHORT_S1 || ' Роз ст=' || k.LONG_S1 ||
         ' Зал ов=' || k.SHORT_S2 || ' Зал ст=' || k.LONG_S2 || sTmp2_);

      for f in (select x.swap_tag,
                       x.deal_tag,
                       x.dat,
                       x.dat_a,
                       x.kva,
                       x.kvb,
                       x.suma / 100 SA,
                       x.sumB / 100 SB,
                       nvl(acrn.fproc(ACC9a, DAT), 0) ira,
                       nvl(acrn.fproc(ACC9B, DAT), 0) irb
                  from fx_deal x
                       --where exists ( select 1 from opldok p, vp_list v where p.ref = x.ref and p.acc = v.acc3800 )
                      ,
                       oper o
                 where x.ref = o.ref
                   and o.sos > 0
                   and swap_tag <> 95103 --   з виключенням битої угоди  swap_tag = 95103
                   and k.KV in (x.kva, x.kvb)
                   and x.swap_tag > 0
                   and x.deal_tag =
                       (select min(deal_tag)
                          from fx_deal xx
                         where xx.swap_tag = x.swap_tag
                           and xx.swap_tag <> xx.deal_tag)
                   and exists
                 (select count(*)
                          from fx_deal xx
                         where xx.swap_tag = x.swap_tag having count(*) > 2)
                   and exists (select 1
                          from opldok p, accounts ac
                         where p.acc = ac.acc
                           and ac.nls like '9%'
                           and p.ref = x.ref)
                      --and swap_tag <> 95103  --   з виключенням битої угоди  swap_tag = 95103
                   and ((x.dat >= Dat2_ and x.dat <= Dat1_) ---- PLUS  Начало сделки
                       OR (x.dat_a >= Dat2_ and x.dat_a <= Dat1_) ---- MINUS Возрвр сделки
                       )
                 order by x.swap_tag) loop
        -- F
        If DAT_NEXT_U(f.dat, 1) = f.dat_a THEN
          kod_ := 'TO'; -- Овернайт
        ELSE
          kod_ := 'XX'; -- строковы
        end if;

        If f.dat > Dat2_ and f.dat <= Dat1_ then
          ------------------------------------------------------------------- PLUS Начало
          If f.kvb = k.KV then

            If kod_ = 'TO' then

              sal1(k_S => k.SHORT_S2,
                   k_I => k.SHORT_I2,
                   f_S => +f.Sb,
                   f_I => f.IRb); --21 Залучено овернайт
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 21,
                 'Зал ов swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || f.SB);

            elSe

              sal1(k_S => k.LONG_S2,
                   k_I => k.LONG_I2,
                   f_S => +f.Sb,
                   f_I => f.IRb); --22 Залучено строкові
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 22,
                 'Зал ст swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || f.SB);

            End If;

          else
            If kod_ = 'TO' then

              sal1(k_S => k.SHORT_S1,
                   k_I => k.SHORT_I1,
                   f_S => +f.Sa,
                   f_I => f.IRa); -- 24 Розмiщено овернайт
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 24,
                 'Роз ов swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kva=' || f.kva || ', sa=' || f.SA);

            elSe

              sal1(k_S => k.LONG_S1,
                   k_I => k.LONG_I1,
                   f_S => +f.Sa,
                   f_I => f.IRa); -- 25 Розмiщено строкові
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 25,
                 'Роз ст swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kva=' || f.kva || ', sa=' || f.SA);

            End If;
          end if;
        end if;

        If f.dat_a > Dat2_ and f.dat_a <= Dat1_ then
          --------------------------------------------------------------------- MINUS  Возрвр
          If f.kvb = k.KV then
            If kod_ = 'TO' then

              sal1(k_S => k.SHORT_S2,
                   k_I => k.SHORT_I2,
                   f_S => -f.Sb,
                   f_I => f.IRb); --21 Повернено Залучень овернайт
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 -21,
                 'Пов зал ов swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || (-f.SB));

            elSe
              sal1(k_S => k.LONG_S2,
                   k_I => k.LONG_I2,
                   f_S => -f.Sb,
                   f_I => f.IRb); --22 Повернено Залучень строкові
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 -22,
                 'Пов зал ст swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || (-f.SB));

            End If;

          else

            If kod_ = 'TO' then

              sal1(k_S => k.SHORT_S1,
                   k_I => k.SHORT_I1,
                   f_S => -f.Sa,
                   f_I => f.IRa); --24 Повернено Розмiщень овернайт
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 -24,
                 'Пов роз ов swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kva=' || f.kva || ', sa=' || (-f.SA));

            elSe
              sal1(k_S => k.LONG_S1,
                   k_I => k.LONG_I1,
                   f_S => -f.SA,
                   f_I => f.IRA); --25 Повернено Розмiщень строкові
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 -25,
                 'Пов роз ст swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kva=' || f.kva || ', sa=' || (-f.SA));

            End If;
          end if;
        end if;

      end loop; -- F
      for f in (select x.swap_tag,
                       x.deal_tag,
                       x.dat,
                       x.dat_a,
                       x.kva,
                       x.kvb,
                       x.suma / 100 SA,
                       x.sumB / 100 SB,
                       nvl(acrn.fproc(ACC9a, DAT), 0) ira,
                       nvl(acrn.fproc(ACC9B, DAT), 0) irb
                  from fx_deal x,
                       oper o
                 where x.ref = o.ref
                   and o.sos > 0
                   and k.KV in (x.kva, x.kvb)
                   and (x.kva=980 or x.kvb=980)
                   and x.swap_tag > 0
                   and x.deal_tag =
                       (select min(deal_tag)
                          from fx_deal xx
                         where xx.swap_tag = x.swap_tag
                           and xx.swap_tag <> xx.deal_tag)
                   and exists
                 (select count(xx.deal_tag)
                          from fx_deal xx
                         where xx.swap_tag = x.swap_tag having count(xx.deal_tag) = 2)
                   and exists (select 1
                                 from opldok p, accounts ac
                                where p.acc = ac.acc
                                  and ac.nls like '9%'
                                  and p.ref = x.ref)
                   and ((x.dat >= Dat2_ and x.dat <= Dat1_ )---- PLUS  Начало сделки
                       OR (x.dat_a >= Dat2_ and x.dat_a <= Dat1_) ---- MINUS Возрвр сделки
                       )
                 order by x.swap_tag) loop
        -- F
        If DAT_NEXT_U(f.dat, 1) = f.dat_a THEN
          kod_ := 'TO'; -- Овернайт
        ELSE
          kod_ := 'XX'; -- строковы
        end if;

        If f.dat > Dat2_ and f.dat <= Dat1_ then
          ------------------------------------------------------------------- PLUS Начало
          If f.kvb = k.KV then

            If kod_ = 'TO' then

              summary(k_S => k.SHORT_S2_UAH,
                      f_S => f.Sb); --26 Залучено овернайт
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 26,
                 'Зал UAH over swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || f.SB|| ', Dat2_' || Dat2_|| ', Dat1_' || Dat1_);

            elSe
              summary(k_S => k.LONG_S2_UAH,
                      f_S => f.Sb); --27 Залучено строкові
               insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 27,
                 'Зал UAH ст swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || f.SB|| ', Dat2_' || Dat2_|| ', Dat1_' || Dat1_);
            End If;
          else
            If kod_ = 'TO' then

              summary(k_S => k.SHORT_S1_UAH,
                     f_S => f.Sa); -- 28 Розмiщено овернайт
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 28,
                 'Роз UAH over swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kva=' || f.kva || ', sa=' || f.SA|| ', Dat2_' || Dat2_|| ', Dat1_' || Dat1_);
            elSe

              summary(k_S => k.LONG_S1_UAH,
                      f_S => f.Sa); -- 29 Розмiщено строкові
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 29,
                 'Роз UAH ст swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kva=' || f.kva || ', sa=' || f.SA|| ', Dat2_' || Dat2_|| ', Dat1_' || Dat1_);
            End If;
          end if;
        end if;

        If f.dat_a > Dat2_ and f.dat_a <= Dat1_ then
          --------------------------------------------------------------------- MINUS  Возрвр
          If f.kvb = k.KV then
            If kod_ = 'TO' then

              summary(k_S => k.SHORT_S2_UAH,
                      f_S => -f.Sb); --26 Повернено Залучень овернайт
             insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 -26,
                 'Пов зал UAH over swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || (-f.SB)|| ', Dat2_' || Dat2_|| ', Dat1_' || Dat1_);
            elSe
              summary(k_S => k.LONG_S2_UAH,
                      f_S => -f.Sb); ---27 Повернено Залучень строкові
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 -27,
                 'Пов зал UAH ст swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || (-f.SB)|| ', Dat2_' || Dat2_|| ', Dat1_' || Dat1_);
            End If;

          else

            If kod_ = 'TO' then

              summary(k_S => k.SHORT_S1_UAH,
                      f_S => -f.Sa); --28 Повернено Розмiщень овернайт
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 -28,
                 'Пов UAH розм over swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || (-f.SB)|| ', Dat2_' || Dat2_|| ', Dat1_' || Dat1_);
            elSe
              summary(k_S => k.LONG_S1_UAH,
                      f_S => -f.SA); --29 Повернено Розмiщень строкові
              insert into TMP_OPERW
                (DVAL, ord, VALUE)
              values
                (sTmp1_,
                 -29,
                 'Пов UAH розм ст swap_tag=' || f.swap_tag || ', deal_tag=' ||
                 f.deal_tag || ', dat=' || f.dat || ', dat_a=' || f.dat_a ||
                 ', kvb=' || f.kvb || ', sb=' || (-f.SB)|| ', Dat2_' || Dat2_|| ', Dat1_' || Dat1_);
            End If;
          end if;
        end if;

      end loop; -- F
      insert into SALDO_DSW
        (FDAT,
         RNK,
         KV,
         SHORT_S1,
         SHORT_I1,
         LONG_S1,
         LONG_I1,
         SHORT_S2,
         SHORT_I2,
         LONG_S2,
         LONG_I2,
         SHORT_S1_UAH,
         LONG_S1_UAH,
         SHORT_S2_UAH,
         LONG_S2_UAH
         )
      values
        (Dat1_,
         0,
         k.kv,
         k.SHORT_S1,
         k.SHORT_I1,
         k.LONG_S1,
         k.LONG_I1,
         k.SHORT_S2,
         k.SHORT_I2,
         k.LONG_S2,
         k.LONG_I2,
         nvl(k.SHORT_S1_UAH,0),
         nvl(k.LONG_S1_UAH,0),
         nvl(k.SHORT_S2_UAH,0),
         nvl(k.LONG_S2_UAH,0));
      insert into TMP_OPERW
        (DVAL, ord, VALUE)
      values
        (sTmp1_,
         30,
         ' Исход.ост:' || ' Роз ов=' || k.SHORT_S1 || ' Роз ст=' ||
         k.LONG_S1 || ' Зал ов=' || k.SHORT_S2 || ' Зал ст=' || k.LONG_S2);

    end loop; -- K
    RETURN;
  END SAL_DSW;
  ----------------

begin
  EXECute immediate 'truncate table TMP_OPERW ';
  -----------------------------------
  l_Dat1 := NVL(p_dat1, trunc(gl.bdate, 'MM')); -- 01.MM.YYYY

  select MAX(FDAT), min(fdat) into dMax1_, dMin_ FROM SALDO_DSW;
  select MAX(FDAT) into dMax2_ FROM SALDO_DSW where fdat < dMax1_;

  If dMax1_ > dMin_ then
    Delete FROM SALDO_DSW where fdat = dMax1_;
  End If;
  If dMax2_ > dMin_ then
    Delete FROM SALDO_DSW where fdat = dMax2_;
  End If;

  select MAX(FDAT) into dMax_ FROM SALDO_DSW;

  -- принудительное накопление ост
  FOR K IN (SELECT *
              FROM FDAT f
             where fdat > dMax_
               and fdat <= gl.bdate
             order by fdat) loop
    SAL_DSW(k.fdat);
  end loop;
  --------------------------------

  -- счета. кот нас интересуют по МБК
  --  EXECute immediate 'truncate table TMP_SAL_ACC ' ;
  delete from TMP_SAL_ACC;

  insert into TMP_SAL_ACC
    (ACC, NBS)
    select acc, substr(nls, 1, 4)
      from accounts a
     where a.nls not in (select nlsa from cp_accc where nlsa is not null)
       and substr(a.nls, 1, 4) in (select nbs from ani331)
       and (a.dazs is null or a.dazs >= l_dat1)
       and l_kv in (0, a.kv);

  ----даты dMax_, кот нас интересуют ( и МБК, и ДЕПО-СВОПЫ)
  --  EXECute immediate 'truncate table CCK_AN_TMP ' ;
  delete from CCK_AN_TMP;

  for d in (select (rownum - 1) n from accounts) loop
    dMax_ := l_dat1 + d.N;
    If dMax_ > p_dat2 OR dMax_ >= nvl(gl.bdate, trunc(sysdate)) then
      PUL.Set_Mas_Ini('KOL', to_char(d.n), 'KOL');
      RETURN;
    end if;
    ndat_ := to_number(to_char(dMax_, 'YYYYMMDD'));

    If l_KV = 0 then
      -- в экв все валюты
      null;

      insert into CCK_AN_TMP
        (SROK, KV, PR, N1, N2)
        select ndat_,
               l_kv,
               x.id,
               sum(y.ost),
               round(sum(y.osts) / sum(y.ost), 2) -------------------- МБК по dMax_
          from ani331 x,
               (select nbs,
                       fostQ(acc, dMax_) ost,
                       fostQ(acc, dMax_) * get_int_rate(acc, dMax_) osts
                  from TMP_SAL_ACC
                 where fost(acc, dMax_) <> 0) y
        -- from ani331 x, (select nbs, fostQ(acc,dMax_) ost, fostQ(acc,dMax_)*acrn.fproc(acc,dMax_) osts from TMP_SAL_ACC where fost(acc,dMax_)<>0) y
        --from ani331 x, (select substr(nls,1,4) nbs, fostQ(acc,dMax_) ost, fostQ(acc,dMax_)*acrn.fproc(acc,dMax_) osts from TMP_SAL_ACC where fost(acc,dMax_)<>0) y
         where x.nbs = y.nbs
         group by x.id
        having sum(y.ost) <> 0
        union all
        select ndat_, l_kv, id, gl.p_icurval(kv, s, fdat), i
          from VALDO_DSW
         where fdat = (select max(fdat) from saldo_dsw where fdat <= dMax_)
        union all
        select ndat_,l_kv,30,
               gl.p_icurval(a.kv,sum (case
                                       when a.nbs in ('1001','1002','1003','1004') then -fost(a.acc,dMax_)
                                       else 0
                                     end),dMax_) as cash_rest_1001_1004,
                    0
          from accounts a
         where a.nbs like '10%'
           and (a.dazs is null or a.dazs <=dMax_)
           group by a.kv
        union all
        select ndat_,l_kv,31,
               gl.p_icurval(a.kv,sum(-fost(a.acc,dMax_)),dMax_) as cash_rest_1001_1017,
               0
          from accounts a
         where a.nbs like '10%'
           and (a.dazs is null or a.dazs <=dMax_)
           group by a.kv ;
    else
      insert into CCK_AN_TMP
        (SROK, KV, PR, N1, N2)
        select ndat_,
               l_kv,
               x.id,
               sum(y.ost),
               round(sum(y.osts) / sum(y.ost), 2) -------------------- МБК по dMax_
          from ani331 x,
               (select nbs,
                       fost(acc, dMax_) ost,
                       fost(acc, dMax_) * get_int_rate(acc, dMax_) osts
                  from TMP_SAL_ACC
                 where fost(acc, dMax_) <> 0) y
        -- from ani331 x, (select  nbs, fost (acc,dMax_) ost, fost (acc,dMax_)*acrn.fproc(acc,dMax_) osts from TMP_SAL_ACC where fost(acc,dMax_)<>0) y
        -- from ani331 x, (select substr(nls,1,4) nbs, fost (acc,dMax_) ost, fost (acc,dMax_)*acrn.fproc(acc,dMax_) osts from TMP_SAL_ACC where fost(acc,dMax_)<>0) y
         where x.nbs = y.nbs
         group by x.id
        having sum(y.ost) <> 0
        union all
        select ndat_, l_kv, id, s, i
          from VALDO_DSW
         where fdat = (select max(fdat) from saldo_dsw where fdat <= dMax_)
           and kv = l_kv --------- DEPO-SWAP по dMax_
        union all
        select ndat_,l_kv,30,
               sum (case
                       when a.nbs in ('1001','1002','1003','1004') then -fost(a.acc,dMax_)
                       else 0
                    end) as cash_rest_1001_1004,
               0
          from accounts a
         where a.nbs like '10%'
           and a.kv=l_kv
           and (a.dazs is null or a.dazs <=dMax_)
        union all
        select ndat_,l_kv,31,
               sum(-fost(a.acc,dMax_)) as cash_rest_1001_1017,
               0
          from accounts a
         where a.nbs like '10%'
           and a.kv=l_kv
           and (a.dazs is null or a.dazs <=dMax_);
    end if;
  end loop; -- D

end p_ani33;
/
show err;

PROMPT *** Create  grants  P_ANI33 ***
grant EXECUTE                                                                on P_ANI33         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ANI33         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ANI33.sql =========*** End *** =
PROMPT ===================================================================================== 
