
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cck_dpk.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCK_DPK IS
  g_header_version CONSTANT VARCHAR2(64) := 'ver.1.0  19/09/2017 ';
/*
 12.06.2015 Сухова. Разделено на две процедура: Возврат ГПК MODI_RET_GPK и сторно док
 28.04.2015 COBUSUPABS-3441:   Есть 2620+2625+SG
 22.01.2014 Сверка план-факт отс
*/

--Блок сбора инф.
  K0_ number    ;  -- 1-Ануитет. 0 - Класс
  K1_ number    ;  -- Сумма для досрочного пог
  K2_ number    ;  -- Платежный день
  K3_ number    ;  -- 1=с сохранением суммы одного платежа, 2=с перерасчетом суммы до последней даты
  ACR_DAT_ date ;

---------------------------------------
-- На перестроенном ГПК выровнять проценты в первом платеже
PROCEDURE PROC1    ( p_ND IN number, p_datn date) ;
------------------------------------

-- перевод ГПК на носую схему - без платежей
PROCEDURE REST_GPK ( p_ND IN number) ;
------------------------------------

-- Попытка предварительно что-то выпoнить, например, разобрать счет гашения  в части просрочек
PROCEDURE PREV ( p_ND IN number, p_acc2620 number ) ;
---------------------------------------
PROCEDURE REF_2620
( p_ND   IN     number, -- реф КД
  p_acc  in out number  -- acc 2620
 ) ;
-- подвязка к КД=p_ND  заданного счета  асс_2620
-- или с авто-подбором счета (если p_acс2620 = 0 или null)
-- и возвратом рез.

-- cck_dpk.sum_SP_ALL (d.nd)         Z1,
-- cck_dpk.sum_SN_all (a8.vid, d.nd) Z2,
-- cck_dpk.sum_SS_next (d.nd)        Z3,
----------------------------------------------------------------------
--DAT_MOD.Определение предыдущей даты модификации ГПК
function DAT_MOD ( p_nd cc_deal.nd%type) return cc_lim_arc.MDAT%type ;
----------------------------------------------------------------------

--Z1.Определение суммы разных просрочек
function sum_SP_all  ( p_nd cc_deal.nd%type) return number;

-------------------------------------------------
--Z2.Определение суммы проц текущих+доначисленн
function sum_SN_all ( p_vid int, p_nd cc_deal.nd%type) return number;

-----------------------------------------
--Z3.Определение суммы след.платежа по телу
function sum_SS_next ( p_nd cc_deal.nd%type) return number;
-----------------------------------------

-- Вычитать пред.сумму 1-го платежа
function prev_SUM1 (p_nd number) return  number;
------------------------------------------------

PROCEDURE PLAN_FAKT (p_nd number)              ;
------------------------------------------------


--Модификация ГПК при доср.погаш

PROCEDURE DPK
(p_mode IN  int   , -- 0 - справка,
                    -- 1 - модификация
                    -- 2 - только модификация ГПК
 p_ND   IN     number, -- реф КД
 p_acc2620 IN  number, -- счет гашения (2620/2625/SG)
                    --=== Блок сбора инф.
 p_K0   IN OUT number, -- 1-Ануитет. 0 - Класс
 p_K1   IN     number, -- <Сумма для досрочного пог>, по умолч = R2,
 p_K2   IN     number, -- <Платежный день>, по умол = DD от текущего банк.дня
 p_K3   IN     number, -- 1=ДА ,<с сохранением суммы одного платежа?>
                       -- 2=НЕТ (с перерасчетом суммы до последней ненулевой даты)
                       --
                       --==--Инфо-блок <Задолженности>
 p_Z1      OUT number, -- Просрочки z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
 p_Z2      OUT number, -- Норм.проценты и комис z2 =SN+SN`+SK0
 p_Z3      OUT number, -- <Сегодняшний> или БЛИЖАЙШИЙ (будущий, следующий) платеж по телу
 p_Z4      OUT number, --ИТОГО  обязательного платежа = z4 =  z1 + z2 + z3
 p_Z5      OUT number, -- Плановый остаток по телу  z5 = (SS - z3)
                    --
                    --== Инфо-Брок <Рессурс>
 p_R1      OUT number, -- Общий ресурс (ост на SG(2620)
 p_R2      OUT number,  --  Свободный ресурс R2 =  R1 - z4
 p_P1      OUT number  --  Реф.платежа
  ) ;
--------------------------------
PROCEDURE MODI_INFO
(p_mode IN  int   , -- 0 - справка, без блокировок
                    -- 1 - досрочное пог.+модификация ГПК
                    -- 2 - только модификация ГПК
 p_ND   IN  number, -- реф КД
 p_acc2620 IN  number, -- счет гашения (2620/2625/SG)
                    --==--Инфо-блок <Задолженности>
 p_Z1   OUT number, -- Просрочки z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
 p_Z2   OUT number, -- Норм.проценты и комис z2 =SN+SN`+SK0
 p_Z3   OUT number, -- <Сегодняшний> или БЛИЖАЙШИЙ (будущий, следующий) платеж по телу
 p_Z4   OUT number, --ИТОГО  обязательного платежа = z4 =  z1 + z2 + z3
 p_Z5   OUT number, -- Плановый остаток по телу  z5 = (SS - z3)
                    --
                    --== Инфо-Брок <Рессурс>
 p_R1   OUT number, -- Общий ресурс (ост на SG(2620)
 p_R2   OUT number  --  Свободный ресурс R2 =  R1 - z4
  );
--------------------------------------------------
PROCEDURE MODI_pay ( p_ND  IN  number, p_acc2620 IN number );
--------------------------------------------------


PROCEDURE MODI_gpk ( p_ND  IN  number) ; -- реф КД.
---------------------------------------------------
procedure MODI_RET( p_Nd  IN     cc_deal.nd%type,
                    p_REF IN OUT oper.ref%type
                  );

procedure MODI_RET_EX( p_Nd   IN     cc_deal.nd%type,
                       p_REF  IN OUT oper.ref%type ,
                       p_mdat IN date
                   );

procedure RET_GPK ( p_Nd   IN cc_deal.nd%type,
                    p_REF  IN oper.ref%type ,
                    p_mdat IN date
                   );
---------------------------------------------------
END ;
/
CREATE OR REPLACE PACKAGE BODY BARS.CCK_DPK IS
  -------------------------------------------------------------------
  g_body_version CONSTANT VARCHAR2(64) := 'ver.1.0.0  19/09/2017 ';
  ------------------------------------------------------------------
  /*
  19/09/2017 COBUSUPABS-6420
  21.10.2015 Sta Досрочное погаш для ЮЛ по теме ОСББ
  23-09-2015 Sta СТОП-дата =  проценты начисляются. как за последний день периода !!!!
  12.06.2015 Сухова. Разделено на две процедура:
                Возврат ГПК procedure RET_GPK  и сторно док
                procedure RET_GPK (p_Nd  IN cc_deal.nd%type, p_mdat IN date ) is

  29.05.2015 Sta  заявки  2752    +  погасить все просрочки  Z1_ - только для БПК  - верим на слово, что на карточке достаточно денег
  28.05.2015 Sta  COBUSUPABS-3441. Досрочное, код операции новый  =  'W4Y' = W4.Списання с БПК для достр. погашення заборг. (Вместо W4X )
  -------------------------------------
  15/05/2015 LitvinSO http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-3525
     Виправлено: В операції %%1 Нарахування відсотків при донарахуванні відсотків у зв’язку з достроковим погашенням кредитного договору не заповнюються поля Відправник та Отримувач, внаслідок чого некоректно друкується меморіальний ордер.
    В процедурі MODI_pay додано наповнення значень RR2.nam_a, RR2.nam_b для вставки у проводку %%1
  --------------------------------
  29.04.2015 COBUSUPABS-3441:  p_acc2620 IN  number, -- счет гашения (2620/2625/SG)
  1. Доопрацювати функцію «Дострокове погашення тіла кредиту (перебудова ГПК)»:
  додати можливість вибору варіанту проведення дострокового погашення:
  - 2620
  - SG=3739
  - 2625
  для 2625 функція  відмінності:
  > - не повинна аналізувати залишок рахунку 2625 для перевірки можливості здійснення дострокового погашення;

  > - сума дострокового погашення повинна бути у вигляді одного документа (зі складною бух-ой моделлю) з використанням транзитного рахунку 2924, а також мати окремий тип операції з групою контролю «2 Контролер підрозділу».;
  > - Сума дострокового погашення за типом рахунку SS (тіло кредиту) визначається як різниця між сумою для дострокового погашення, що зазначив менеджер у полі «Сума для дострокового погашення» та обов’язковим платежем;
  > - Документи оплачуються по факту проведеної квитовки ПЦ в той самий день;
  > - При не підтвердженні квитовки ПЦ документ та графік погашення сторнуються в той самий день;
  > - Заблокувати кнопку відміни дострокового погашення (як що був створений файл на ПЦ);
  > - На наступний банківський день АБС отримує файл проведень реально виконаних погашень (в т. ч. врахування «червоного» сальдо);

  23.02.2015 Sta http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-3283
             «Дострокове погашення Кредиту ФО з перебудовою ГПК».
             Для деяких випадків (участники АТО)  проставляють  STP_DAT.
             врахування це значення при здійсненні донарахування.
  Пока блокировано спис ание с 2625*
  -------------------------------------

  22.12.2014 Sta Использование 2625 наравне с 2620.
  02.12.2014 Сухова. Перестроение ГПК по требованию (без одновременной досрочки).
                     Пересчет проц для класс ГПК при наличии НЕПЛАНОВОГО платежа накануне
                     Проверены 6 вариантов
  Д3 = Платежная дата в ГПК
  Д1 = Банк-дата
  Д2 = Неплановы платеж

  1.1. Д3 > Д1 > Д2
  1.2. Д3 > Д1 = Д2
  2.1. Д3 = Д1 > Д2
  2.2. Д3 = Д1 > Д2
  3.1. Д1 > Д2 > Д3
  3.2. Д1 = Д2 > Д3

    21.11.2014 Перестроить ГПК без факта досрочного погаш. Но при наличии досроски . сделанной накануне.
    11.06.2014 Восстановление даты завершения после восстановления из архива ГПК ( ош из Винницы )----
    10.04.2014 Sta CCK_DPK.prev_SUM1 - для показывания суммы 1-го платежа.
          надо брать не ближайший прошлый (без тек.дня), ближайший будущий с учетом тек дня.
          Важно для более рдной досрочки в течепнии одного мес

    07.04.2014 Sta + Novikov
       l_txt := '90'; l_basem :=1;  -- 1 -Ануитет, Без канікул, % за попередній день \
       l_txt := '91'; l_basem :=0;  -- 0- Класс, Без канікул, % за попередній місяць / для размежевания со старыми КД
  */

  --cck_dpk.sum_SP_ALL (d.nd)         Z1,
  --cck_dpk.sum_SN_all (a8.vid, d.nd) Z2,
  --cck_dpk.sum_SS_next (d.nd)        Z3,

  ----------------------------------------
  TT_W4 char(3) := 'W4Y'; --  Досрочное, код операции новый    =  'W4Y' = W4.Списання с БПК для достр. погашення заборг. (Вместо W4X )

  II    int_accn%rowtype; -- проц.карточка счета SS /II.basem=1 это АНУИТЕТ. иначе классика
  IR_   number; -- проц.ставка
  acc8_ accounts.accc%type;
  datn_ date; -- дата нач КД
  datk_ date; -- дата конца КД
  lim1_ number; -- старый лимит
  lim2_ number; -- новый лимит
  kol_  int;

  --Инфо-блок <Задолженности>
  z1_  number; --Просрочки z1 =SLN+SLK+SL+SPN+SK9+SP+SN8(В сс_rang =10 это стоит ПОСЛЕ SS)
  z2K_ number; -- собственно            Z2K = комис  SK0
  z2N_ number; -- Норм.проценты         z2N = SN  + SN`
  z2_  number; -- Норм.проценты и комис z2  = Z2N + Z2K

  SS_ number; -- остаток по норм телу
  ZN_ number; -- (SN` расчетные проц до тек дня по счету SS + SP )
  Z3_ number; --<Сегодняшний> или БЛИЖАЙШИЙ (будущий, следующий) платеж по телу
  z4_ number; --ИТОГО  обязательного платежа = z4 =  z1 + z2 + z3
  z5_ number; -- Плановый остаток по телу  z5 = (SS - z3)  = TELO_  number;

  --Инфо-Брок <Рессурс>
  R1_ number; -- Общий ресурс (ост на SG(2620/2625) R1
  R2_ number; -- Свободный ресурс R2 =  R1 - z4
  RR1 oper%rowtype;
  --------------
  nls_8006 accounts.nls%type;
  nls_6397 accounts.nls%type;

  ---------------------------------------
  -- На перестроенном ГПК выровнять проценты в первом платеже
  PROCEDURE PROC1(p_ND IN number, p_datn date) is
    l_acc     number;
    l_acra    number;
    l_accc    number;
    l_sump    number := 0;
    l_ost_SN  number;
    l_ost_SS  number;
    l_adat    date;
    l_dat31   date;
    l_fdat2   date;
    l_int     number := 0;
    l_daos    date;
    l_STP_DAT date;
  begin
    begin
      --ссудный счет и его проц.карточка.
      select i.acc,
             i.acra,
             a.accc,
             greatest(nvl(i.acr_dat, a.daos - 1), a.daos - 1),
             a.daos,
             a.ostc,
             nvl(i.STP_DAT, a.mdate - 1)
        into l_acc, l_acra, l_accc, l_adat, l_daos, l_ost_SS, l_STP_DAT
        from accounts a, nd_acc n, int_accn i
       where n.nd = p_nd
         and n.acc = a.acc
         and a.tip = 'SS '
         and a.ostc < 0
         and a.ostb = a.ostc
         and i.acc = a.acc
         and i.id = 0
         and i.acra is not null;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' Не знайдено рах.SS для КД реф=' || p_nd ||
                                ', або його проц.картка',
                                TRUE);
    end;

    begin
      select sumo - sumg - nvl(sumk, 0)
        into l_sump
        from cc_lim
       where nd = p_nd
         and fdat = p_datn;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                'В новому ГПК Не знайдено найближчу пл.дату для КД реф=' || p_nd,
                                TRUE);
    end;

    If cck_dpk.K0_ = 1 then
      ---------------------------------- 1-Ануитет

      If l_adat < Least((p_datn - 1), l_STP_DAT) then
        CCK.INT_METR_A(l_Accc,
                       l_Acc,
                       0,
                       l_adat,
                       Least((p_datn - 1), l_STP_DAT),
                       l_Int,
                       Null,
                       0);
      end if; -- начисление по ануитету

      l_ost_SN := fost(l_acra, gl.bdate) + l_int;
      update cc_lim
         set sumo = sumo - l_sump + (-l_ost_SN)
       where nd = p_nd
         and fdat = p_datn;
    else
      -- 0-Класс
      -- первая пл дата в ГПК
      l_dat31 := trunc(gl.bdate, 'MM') - 1;

      If l_daos > l_dat31 then
        acrn.p_int(l_Acc,
                   0,
                   gl.bdate,
                   Least(add_months(l_dat31, 1), l_STP_DAT),
                   l_Int,
                   Null,
                   0); -- начисление банковское
        l_ost_SN := fost(l_acra, gl.bdate) + round(l_int, 0);
        update cc_lim
           set sumo = sumo - l_sump + (-l_ost_SN)
         where nd = p_nd
           and fdat = p_datn; --добавить ост нач % 31Б который был числа
        RETURN;
      end if;

      l_ost_SN := fost(l_acra, l_dat31);
      update cc_lim
         set sumo = sumo - l_sump + (-l_ost_SN)
       where nd = p_nd
         and fdat = p_datn; --добавить ост нач % 31Б который был числа

      -- вторая пл дата в ГПК
      acrn.p_int(l_Acc,
                 0,
                 (l_dat31 + 1),
                 least(add_months(l_dat31, 1), l_STP_DAT),
                 l_Int,
                 Null,
                 0); -- начисление банковское
      l_int := round(l_int, 0);
      select nvl(min(fdat), p_datn)
        into l_fdat2
        from cc_lim
       where nd = p_nd
         and fdat > p_datn;
      select sumo - sumg - nvl(sumk, 0)
        into l_sump
        from cc_lim
       where nd = p_nd
         and fdat = l_fdat2;
      update cc_lim
         set sumo = sumo - l_sump + (-l_int)
       where nd = p_nd
         and fdat = l_fdat2;

    end if;

  end PROC1;
  ------------------------------------

  -- перевод ГПК на носвую схему - без платежей
  PROCEDURE REST_GPK(p_ND IN number) is
    -- Первая пл.дата ишется начиная с текущей - так в ОБ. Согласовано с Долинченко
    s_dd  char(2);
    nTmp_ int;
  begin

    --CCK_DPK.PREV ( p_nd)   ; -- вызываем из приложения
    --cck_dpk.K1_ :=  0      ;  -- Сумма для досрочного пог
    --cck_dpk.K3_ :=  1      ;  -- с сохранением суммы одного платежа
    -----------------------------
    begin
      select a8.acc,
             least(-a8.ostx, -a8.ostc),
             a8.mdate,
             DECODE(a8.vid, 4, 1, 0)
        into acc8_, lim2_, datk_, cck_dpk.K0_
        from accounts a8, nd_acc n8
       where n8.nd = p_nd
         and n8.acc = a8.acc
         and a8.tip = 'LIM'
         and a8.ostc = a8.ostb
         and a8.ostb < 0
         and a8.mdate > gl.bdate;

      If Lim2_ = 0 then
        raise_application_error(- (20203),
                                ' Не визначено сумму для ГПК КД реф=' || p_nd,
                                TRUE);
      end if;

      select *
        into II
        from int_accn
       where acc = acc8_
         and id = 0;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' Не знайдено рах.8999 для КД реф=' || p_nd ||
                                ', або його проц.картка',
                                TRUE);
    end;

    select count(*), min(fdat)
      into nTmp_, datn_
      from cc_lim
     where nd = p_nd
       and fdat < gl.bdate;

    If nTmp_ > 1 then
      -- Перестроение ГПК после первой плат даты даты

      select min(fdat)
        into datn_
        from cc_lim
       where nd = p_nd
         and fdat >= gl.bdate;

      if datn_ is null then
        raise_application_error(- (20203),
                                'В попередньому ГПК Не знайдено найближчу пл.дату для КД реф=' || p_nd,
                                TRUE);
      end if;

      -- 11.06.2014 в старом ГПК был сдвиг даты вперед с переходом в новый месяц в связи с выходными, но это при перестороении ГПК приводило к потере первого месяца ( ош из Винницы )----
      If to_number(to_char(datn_, 'dd')) <> ii.s then
        datn_ := CCK.F_DAT(to_char(ii.s), trunc(gl.bdate, 'MM'));
      end if;

    end if;

    cck_dpk.modi_gpk(p_nd);
    select min(fdat)
      into datn_
      from cc_lim
     where nd = p_nd
       and fdat >= gl.bdate;

  end REST_GPK;
  ------------------------------------
  -- Попытка предварительно что-то выпoнить, например, разобрать счет гашения  в части просрочек
  PROCEDURE PREV(p_ND IN number, p_acc2620 number) is

    -- необходимые предварительные работы при попытке досрочного погашения
    oo       oper%rowtype;
    l_rnk    number; --dd cc_deal%rowtype ;
    nls_2924 varchar2(15);
    S_       number := 0;
  begin
    begin
      select d.rnk, c.okpo
        into l_rnk, oo.id_a
        from cc_deal d, customer c
       where d.nd = p_nd
         and d.rnk = c.rnk;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN;
    end;
    -- 1) разбор счета гашения - вдруг былa досрочка по всем КД клиента
    -- цикл по счетам ресурса для погашения пока только 1 счет
    for g in (select *
                from accounts
               where acc = p_acc2620
                 and (ostc > 0 and ostc = ostb OR nbs = '2625')) loop
      oo.tt  := 'ASG';
      oo.vob := 6;
      oo.ref := null;
      -- цикл по счетам просроченного долга всех КД данного клиента
      for p in (select a.*
                  from accounts a, nd_acc n, cc_deal d
                 where d.rnk = l_rnk
                   and d.sos >= 10
                   and d.sos < 14
                   and n.nd = d.nd
                   and n.acc = a.acc
                   and a.kv = g.kv
                   and a.tip in ('SPN', 'SP ', 'SK9', 'SN8')
                   and a.ostc < 0
                   and a.ostc = a.ostb) loop
        if g.ostc <= 0 then
          EXIT;
        end if;
        ----------------------------------------------------------------------------------- в валюте тек счета 262*
        If g.KV = p.KV then
          oo.s  := least(g.ostc, -p.ostc);
          oo.s2 := gl.p_icurval(g.kv, oo.s, gl.bdate); -- задолженность в валюте счета гашения
        else
          oo.s  := least(g.ostc, gl.p_Ncurval(g.KV, -p.ostc, gl.bdate));
          oo.s2 := -p.ostc; -- пеня. она может начисляться в грн
        end if;
        --------------------------------
        g.ostc := g.ostc - oo.s;
        If oo.ref is null then
          GL.REF(oo.ref);
          oo.NAZN := 'Списання просроченої заборгованостi згiдно кред/угоди';
          if g.nbs in ('2600', '2620', '2625') then
            oo.NAZN := 'Договiрне ' || oo.nazn;
          end if;
          if g.nbs = '2625' then
            oo.tt    := cck_dpk.TT_W4;
            nls_2924 := bpk_get_transit('20', p.nls, g.nls, g.kv);
          else
            oo.tt    := 'ASG';
            nls_2924 := g.nls;
          end if;
          gl.in_doc3(ref_   => oo.REF,
                     tt_    => oo.tt,
                     vob_   => oo.vob,
                     nd_    => to_char(p_ND),
                     pdat_  => SYSDATE,
                     vdat_  => gl.BDATE,
                     dk_    => 1,
                     kv_    => g.kv,
                     s_     => oo.s,
                     kv2_   => g.kv,
                     s2_    => oo.s,
                     sk_    => null,
                     data_  => gl.BDATE,
                     datp_  => gl.bdate,
                     nam_a_ => substr(g.nms, 1, 38),
                     nlsa_  => g.nls,
                     mfoa_  => gl.aMfo,
                     nam_b_ => substr(p.nms, 1, 38),
                     nlsb_  => p.nls,
                     mfob_  => gl.aMfo,
                     nazn_  => oo.nazn,
                     d_rec_ => null,
                     id_a_  => oo.id_a,
                     id_b_  => gl.aOkpo,
                     id_o_  => null,
                     sign_  => null,
                     sos_   => 1,
                     prty_  => null,
                     uid_   => null);
        end if;
        S_ := S_ - p.ostc;
        If p.tip = 'SN8' then
          -- БЕЗАКЦЕПТНОЕ СПИСАНИЕ ПЕНИ -- счет для дох 6397 по пене эмит КД
          --сворачивание пени 8006 - 8008
          If g.kv <> p.kv then
            gl.payv(0,
                    oo.REF,
                    gl.bDATE,
                    oo.tt,
                    1,
                    p.kv,
                    CCK_DPK.NLS_8006,
                    oo.s2,
                    p.kv,
                    p.nls,
                    oo.s2);
          else
            gl.payv(0,
                    oo.REF,
                    gl.bDATE,
                    oo.tt,
                    1,
                    p.kv,
                    CCK_DPK.NLS_8006,
                    oo.s,
                    p.kv,
                    p.nls,
                    oo.s);
          end if;
          gl.payv(0,
                  oo.REF,
                  gl.bDATE,
                  oo.TT,
                  1,
                  g.kv,
                  nls_2924,
                  oo.s,
                  gl.baseval,
                  CCK_DPK.NLS_6397,
                  oo.s2); ----\  -- частная проводка
        else
          gl.PAYv(0,
                  oo.REF,
                  gl.bDATE,
                  oo.tt,
                  1,
                  g.kv,
                  nls_2924,
                  oo.s,
                  g.kv,
                  p.nls,
                  oo.s); ----/
        end if;
      end loop; --- P
      if oo.ref is not null then
        Update oper set s = S_, s2 = S_ where ref = oo.REF;
        If oo.tt <> cck_dpk.TT_W4 then
          gl.pay(2, oo.REF, gl.bDATE);
        Else
          gl.payv(0,
                  oo.REF,
                  gl.bDATE,
                  oo.TT,
                  0,
                  g.kv,
                  nls_2924,
                  S_,
                  g.kv,
                  g.nls,
                  S_); ------ итоговая проводка
        end if;
      end if;

    end loop; -- G

    -- 2) доначислить проц по вчера
    null;
  end PREV;

  ---------------------------------------
  PROCEDURE REF_2620(p_ND  IN number, -- реф КД
                     p_acc in out number -- acc 262*
                     ) is
    -- подвязка к КД=p_ND  заданного счета  асс_2620
    -- или с авто-подбором счета (если p_acс2620 = 0 или null)
    -- и возвратом рез.
    l_acc number;
    nTmp_ int;

  begin
    l_acc := nvl(p_acc, 0);
    begin
      If l_acc > 0 then
        select 1
          into nTmp_
          from nd_acc
         where nd = p_nd
           and acc = l_acc;
        return;
      else
        SELECT a2.ACC
          into l_acc
          FROM accounts a2, nd_acc n8, accounts a8
         WHERE a2.rnk = a8.rnk
           and a2.kv = a8.kv
           and a2.dazs IS NULL
           AND a2.nbs in ('2620', '2625')
           AND n8.nd = p_nd
           and n8.acc = a8.acc
           AND a8.dazs IS NULL
           AND a8.tip = 'LIM'
           and rownum = 1;
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;

    If l_acc > 0 then
      insert into nd_acc (nd, acc) values (p_nd, l_acc);
      INSERT INTO cc_sob
        (ND, FDAT, ISP, TXT, otm)
        select p_nd,
               gl.bDATE,
               gl.aUID,
               'Пов`язати КД з рах.' || a2.nls || '/' || a2.kv,
               6
          from accounts a2
         where acc = l_acc;
      p_acc := l_acc;
    end if;

  end REF_2620;

  ---------------------------
  --DAT_MOD.Определение предыдущей даты модификации ГПК
  function DAT_MOD(p_nd cc_deal.nd%type) return cc_lim_arc.MDAT%type is
    l_mdat cc_lim_arc.MDAT%type;
  begin
    select max(mdat)
      into l_mdat
      from cc_lim_arc
     where nd = p_ND
       and TYPM is not null;
    return l_mdat;
  end DAT_MOD;
  ------------------------------------------------------

  --Z1.Определение суммы разных просрочек
  function sum_SP_ALL(p_nd cc_deal.nd%type) return number IS
    -- Z1_- Просрочки z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
  begin
    select -NVL(sum(a.ostb), 0)
      into cck_dpk.Z1_
      from accounts a, nd_acc n
     where n.nd = p_ND
       and n.acc = a.acc
       and a.tip in ('SP ', 'SL ', 'SPN', 'SK9', 'SLN', 'SLK', 'SN8');
    -- положительное число
    Return(cck_dpk.Z1_);
  end sum_SP_ALL;

  -------------------------------------------------
  --Z2.Определение суммы проц текущих+доначисленн ( для АНУит и для Класс)
  function sum_SN_all(p_vid int, p_nd cc_deal.nd%type) return number is
    ko_ number := 1000000;
  begin

    begin
      -- Z2k_-  Норм.комиссия положит число
      select -nvl(sum(a.ostb), 0)
        into Z2K_
        from accounts a, nd_acc n
       where n.ACC = a.acc
         and n.nd = p_nd
         and a.tip = 'SK0';
      select i.*
        into II
        from int_accn i, nd_acc n, accounts ss
       where n.nd = p_ND
         and N.acc = ss.acc
         and ss.tip = 'SS '
         and i.id = 0
         and i.acc = ss.ACC
         and ss.ostb < 0;
      ii.STP_DAT := least(NVL(ii.STP_DAT, gl.bdate - 1), gl.bdate - 1);
      CCK_DPK.ACR_DAT_ := ii.acr_dat;
      -- Z2n_-  Норм.проценты   положит число
      select -ostb into Z2N_ from accounts where ACC = II.acra;
      Z2_ := Z2N_ + Z2K_;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        Z2N_ := 0;
        Z2_  := z2k_;
        return Z2_;
    end;

    -- Прогноз %
    If II.acr_dat >= ii.STP_DAT then
      RETURN Z2_;
    end if; -- он уже не требуется
    IR_ := acrn.fprocn(II.acc, 0, gl.bdate);
    If IR_ <= 0 then
      RETURN Z2_;
    end if;

    --ZN_ -- SN` положит число,= расчетные проц до тек дня доначисленн
    ZN_ := 0;

    If ii.STP_DAT > II.acr_dat then
      If p_vid = 4 then
        -- для ануитета
        begin
          select (lb.sumo - lb.sumg) * (ii.STP_DAT - II.acr_dat) /
                 (lb.fdat - lp.fdat)
            into Zn_
            from cc_lim lb,
                 (select max(fdat) fdat
                    from cc_lim
                   where nd = p_ND
                     and fdat <= ii.STP_DAT) lp
           where lb.nd = p_ND
             and lb.fdat > lp.fdat
             and lb.fdat = (select min(fdat)
                              from cc_lim
                             where nd = p_ND
                               and fdat > ii.STP_DAT);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            ZN_ := 0;
        end;
      else
        select NVL(sum(calp(-fost(ii.acc, z.fdat) * ko_,
                            IR_,
                            z.fdat,
                            z.fdat,
                            ii.basey)),
                   0) / ko_
          into ZN_
          from (select (ii.acr_dat) + c.num fDAT
                  from conductor c
                 where ii.acr_dat + c.num <= ii.STP_DAT) z;
      end if;
      zn_ := round(zn_, 0);
    end if;

    -- прогноз-проц на просроч тело
    declare
      jj   int_accn%rowtype;
      znp_ number;
    begin
      select j.*
        into jj
        from int_accn j, nd_acc n, accounts sp
       where n.nd = p_ND
         and N.acc = sp.acc
         and sp.tip = 'SP '
         and j.id = 0
         and j.acc = sp.ACC
         and sp.dazs is null;

      select NVL(sum(calp(-fost(jj.acc, z.fdat) * ko_,
                          IR_,
                          z.fdat,
                          z.fdat,
                          jj.basey)),
                 0) / ko_
        into ZNP_
        from (select (jj.acr_dat) + c.num fDAT
                from conductor c
               where jj.acr_dat + c.num <= ii.STP_DAT) z;
      zn_ := zn_ + round(znp_, 0);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;

    -- полож число
    Z2N_ := Z2N_ + ZN_;
    Z2_  := Z2N_ + Z2K_;
    Return Z2_;

  end sum_SN_all;
  -------------------------------------------------
  --Z3.Определение суммы след.платежа по телу
  function sum_SS_next(p_nd cc_deal.nd%type) return number IS
  begin
    begin
      select lb.sumg
        into Z3_
        from cc_lim lb,
             (select max(fdat) fdat
                from cc_lim
               where nd = p_ND
                 and fdat < gl.BDate) lp
       where lb.nd = p_ND
         and lb.fdat = (select min(fdat)
                          from cc_lim
                         where nd = p_ND
                           and fdat >= gl.BDate)
         and lb.fdat > lp.fdat;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        Z3_ := 0;
    end;
    -- полож число
    Return(Z3_);

  end sum_SS_next;

  -----------------------------------------

  /*  Вычитать .сумму 1-го платежа - используется для показывания суммы 1-го платежа.
       надо брать не ближайший прошлый (без тек.дня)-как было ранее,
       а ближайший будущий с учетом тек дня.
       !!! Важно для более одной досрочки в течепнии одного мес
  */

  function prev_SUM1(p_nd number) return number IS
    CL   cc_lim%rowtype;
    so1_ number;
    vid_ number;
  begin

    select a.vid
      into vid_
      from accounts a, nd_acc n
     where n.nd = p_nd
       and n.acc = a.acc
       and a.tip = 'LIM';

    If vid_ = 4 then
      CCK_DPK.k0_ := 1;
    else
      CCK_DPK.k0_ := 0;
    end if;

    begin
      select *
        into CL
        from cc_lim
       where nd = p_ND
         and fdat = (select min(fdat)
                       from cc_lim
                      where nd = p_nd
                        and fdat >= gl.bdate);
      If so1_ <= 0 then
        select *
          into CL
          from cc_lim
         where nd = p_ND
           and fdat = (select max(fdat)
                         from cc_lim
                        where nd = p_nd
                          and fdat < gl.bdate);
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;

    if CCK_DPK.K0_ = 1 then
      so1_ := CL.sumo;
    else
      so1_ := CL.sumg;
    end if;

    RETURN NVL(so1_, 0);

  end prev_SUM1;
  -------------------------------------
  PROCEDURE PLAN_FAKT(p_nd number) is
    aa accounts%rowtype;
  begin

    begin
      select a.*
        into aa
        from nd_acc n, cc_deal d, accounts a
       where d.nd = p_nd
         and a.acc = n.acc
         and n.nd = d.nd
         and d.rnk = a.rnk
         and a.dazs is null
         and rownum = 1
         and a.ostc <> a.ostb
         and a.nbs <> '2625';
      raise_application_error(- (20203),
                              'рах.' || aa.nls ||
                              ' Залишок план НЕ = факт ');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;

  end plan_fakt;
  -----

  PROCEDURE DPK(p_mode IN int, -- 0 - справка,
                -- 1 - досрочное пог.+модификация ГПК (121)
                -- 2 -         только модификация ГПК (122)
                p_ND      IN number, -- реф КД
                p_acc2620 IN number, -- счет гашения (2620/2625/SG)
                --=== Блок сбора инф.
                p_K0 IN OUT number, -- 1-Ануитет. 0 - Класс
                p_K1 IN number, -- <Сумма для досрочного пог>, по умолч = R2,
                p_K2 IN number, -- <Платежный день>, по умол = DD от текущего банк.дня
                p_K3 IN number, -- 1=ДА ,<с сохранением суммы одного платежа?>
                -- 2=НЕТ (с перерасчетом суммы до последней ненулевой даты)
                --
                --==--Инфо-блок <Задолженности>
                p_Z1 OUT number, -- Просрочки z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                p_Z2 OUT number, -- Норм.проценты и комис z2 =SN+SN`+SK0
                p_Z3 OUT number, -- <Сегодняшний> или БЛИЖАЙШИЙ (будущий, следующий) платеж по телу
                p_Z4 OUT number, --ИТОГО  обязательного платежа = z4 =  z1 + z2 + z3
                p_Z5 OUT number, -- Плановый остаток по телу  z5 = (SS - z3)
                --
                --== Инфо-Брок <Рессурс>
                p_R1 OUT number, -- Общий ресурс (ост на SG(262*)
                p_R2 OUT number, --  Свободный ресурс R2 =  R1 - z4
                p_P1 OUT number --  Реф.платежа
                ) is
    ------------------------
  begin

    /*
    declare p_mode int := 1; p_ND  number := 7688;  p_K0  number := 0; p_K1  number := 1000000; p_K2  number := 24; p_K3  number := 0;
     p_Z1  number; p_Z2  number;  p_Z3  number;  p_Z4  number; p_Z5  number;  p_R1  number;  p_R2  number;  p_P1  number ;
    begin tuda;  CCK_dpk.dpk ( p_mode, p_ND, p_K0, p_K1, p_K2, p_K3, p_Z1,  p_Z2,  p_Z3,  p_Z4,  p_Z5,  p_R1,  p_R2, p_P1) ;
    logger.info ( 'DPK*' || p_Z1 ||','||  p_Z2 ||','||  p_Z3 ||','||  p_Z4 ||','||  p_Z5 ||','|| p_R1 ||','||  p_R2  ||','||  p_P1);
    end;
    */

    p_P1        := null;
    CCK_DPK.k2_ := nvl(p_K2, to_number(to_char(gl.bdate, 'DD')));
    CCK_DPK.k3_ := nvl(p_K3, 1);
    CCK_DPK.MODI_INFO(p_mode,
                      p_ND,
                      p_acc2620,
                      p_Z1,
                      p_Z2,
                      p_Z3,
                      p_Z4,
                      p_Z5,
                      p_R1,
                      p_R2);
    p_K0 := CCK_DPK.K0_;
    ---------------------------------
    If p_mode = 0 then
      -- только справка.
      null;
      Return;
    end if;

    cck_dpk.PLAN_FAKT(p_nd); -- проверка на совпадение флановых и фактич остатков

    If p_mode = 1 then
      -- досрочное погашение + изменение ГПК.

      If nvl(p_k1, 0) <= 1 then
        bars_error.raise_nerror(p_errmod  => 'CCK',
                                p_errname => 'SUM_POG',
                                p_param1  => to_char(p_nd),
                                p_param2  => to_char(p_K1 / 100));
      end if;
      CCK_DPK.K1_ := p_k1 + Z3_;
      lim2_       := Z5_ - p_K1;

      CCK_DPK.MODI_pay(p_ND, p_acc2620);

      If Z5_ > 0 then
        CCK_DPK.MODI_gpk(p_ND);
        p_P1 := RR1.ref;
      end if;

    ElsIf p_mode = 2 then
      -- только изменение ГПК, без досрочного погашения.
      CCK_DPK.k1_ := 0; -- Сумма для досрочного пог
      cck_dpk.REST_GPK(p_ND => p_nd);
    end if;

    Return;

  end DPK;
  -----------------
  PROCEDURE MODI_INFO(p_mode IN int, -- 0 - справка, без блокировок
                      -- 1 - досрочное пог.+модификация ГПК
                      -- 2 - только модификация ГПК
                      p_ND      IN number, -- реф КД
                      p_acc2620 IN number, -- счет гашения (2620/2625/SG)
                      --==--Инфо-блок <Задолженности>
                      p_Z1 OUT number, -- Просрочки z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                      p_Z2 OUT number, -- Норм.проценты и комис z2 =SN+SN`+SK0
                      p_Z3 OUT number, -- <Сегодняшний> или БЛИЖАЙШИЙ (будущий, следующий) платеж по телу
                      p_Z4 OUT number, --ИТОГО  обязательного платежа = z4 =  z1 + z2 + z3
                      p_Z5 OUT number, -- Плановый остаток по телу  z5 = (SS - z3)
                      --
                      --== Инфо-Брок <Рессурс>
                      p_R1 OUT number, -- Общий ресурс (ост на SG(262*)
                      p_R2 OUT number --  Свободный ресурс R2 =  R1 - z4
                      ) IS

    mdat_    date;
    vid_     int;
    ostb_    number;
    ostc_    number;
    nbs_2620 accounts.nbs%type;
    nls_2620 accounts.nls%type;
    nls_8999 accounts.nls%type;
    nls_2203 accounts.nls%type;

  BEGIN
    --------------------------------------
    -- защита от двойного досроч погаш в течение дня.
    /*
    Для возможности совместного использования таблицы cck_arc_cc_lim модулями REZ+CCK необходимо добавить признак что сохраненный архивный ГПК на дату (mdate)  был изменен модулем CCK (ф. Досрочного погашения).
    Фантазии :Например TYPM (тип модуля) можно даже сделать его  составными со значениями типа : “CCKD” – кредитный досрочка.
    Он нужен для:
    - определения досрочных погашений от технических записей (где то в отчетности)
    - от повторного создания досрочного погашения в текущий БД.
    - При откате досрочного погашения.

    2.В функции досрочного погашения учесть что в  cck_arc_cc_lim  когут быть значения больше банковской даты.
    */

    select max(mdat)
      into mdat_
      from cc_lim_arc
     where nd = p_ND
       and TYPM = 'CCKD';
    If mdat_ >= gl.bdate and p_MODE > 0 then
      raise_application_error(- (20203),
                              ' КД ' || p_nd || ' ГПК уже є в архіві за ' ||
                              to_char(gl.bdate, 'dd.mm.yyyy'));
    end if;
    --------------------------------------
    -- Общая инф
    begin
      -- R1. Общий ресурс (ост на 2620/2625/SG)
      select a.nbs, a.ostb, a.ostb, a.ostc, a.nls
        into nbs_2620, R1_, ostb_, ostc_, nls_2620
        from accounts a, nd_acc n
       where n.nd = p_ND
         and n.acc = a.acc
         and a.acc = p_acc2620;
      If nbs_2620 <> '2625' and p_MODE = 1 and ostb_ <> ostc_ then
        raise_application_error(- (20203),
                                ' КД ' || p_nd || ' рах.' || nls_2620 ||
                                ': План.зал НЕ = Факт.зал');
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' КД ' || p_nd ||
                                ' Не знайдено рах для списання ACC=' ||
                                p_acc2620);
    end;

    begin
      --несовпадение плановых и факт ост 8999*
      select a.acc, a.vid, a.ostb, a.ostc, a.nls
        into acc8_, vid_, ostb_, ostc_, nls_8999
        from accounts a, nd_acc n
       where n.nd = p_nd
         and n.acc = a.acc
         and a.tip = 'LIM'
         and a.ostb < 0;
      if ostb_ <> ostc_ and p_MODE in (1, 2) and nbs_2620 <> '2625' then
        raise_application_error(- (20203),
                                ' КД ' || p_nd || ' рах.' || nls_8999 ||
                                ': План.зал НЕ = Факт.зал');
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' КД ' || p_nd || ' Не знайдено рах 8999*');
    end;

    begin
      -- SS. остаток по норм телу
      select -a.ostb, a.nls, a.ostb, a.ostc
        into SS_, nls_2203, ostb_, ostc_
        from accounts a, nd_acc n
       where n.nd = p_ND
         and n.acc = a.acc
         and a.tip = 'SS '
         and a.ostb < 0;
      if ostb_ <> ostc_ and p_MODE = 1 then
        raise_application_error(- (20203),
                                ' КД ' || p_nd || ' рах.' || nls_2203 ||
                                ': План.зал НЕ = Факт.зал');
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' КД ' || p_nd || ' Не знайдено рах.SS*');
    end;
    select min(fdat), max(fdat)
      into datn_, datk_
      from cc_lim
     where nd = p_nd;
    ----------------------------

    -- переопределение признака ануитета по-новому
    If vid_ = 4 then
      CCK_DPK.k0_ := 1;
      II.BASEM    := 1;
      II.BASEY    := 2;
    else
      CCK_DPK.k0_ := 0;
    end if;
    ---------------------------------
    -- ИТОГО  обязательного платежа = z4 =  z1 + z2 + z3
    -- (Z1_Просрочки) + (Z2_Проценты_и_донач_проц_и_комис) + (Z3_ближ.Платеж)
    cck_dpk.Z1_ := cck_dpk.sum_SP_ALL(p_nd);
    cck_dpk.Z2_ := cck_dpk.sum_SN_all(vid_, p_nd);
    cck_dpk.Z3_ := cck_dpk.sum_SS_next(p_nd);
    cck_dpk.Z4_ := cck_dpk.Z1_ + cck_dpk.Z2_ + cck_dpk.Z3_;

    cck_dpk.Z5_ := cck_dpk.SS_ - cck_dpk.Z3_; -- Плановый остаток по телу  z5 = (SS - z3)
    cck_dpk.R2_ := cck_dpk.R1_ - cck_dpk.Z4_; -- Свободный ресурс R2 =  R1 - z4
    ----------------------------------
    If cck_dpk.Z1_ < 0 and p_mode in (1) then
      -- КД реф=%s есть просрочен.задолжен.
      bars_error.raise_nerror(p_errmod  => 'CCK',
                              p_errname => 'YES_SP',
                              p_param1  => to_char(p_nd),
                              p_param2  => to_char(-cck_dpk.Z1_ / 100));
    end if;
    ----------------------------------

    If cck_dpk.R2_ <= 0 and p_mode in (1) and nbs_2620 <> '2625' then
      --КД реф=%s свободный остаток
      bars_error.raise_nerror(p_errmod  => 'CCK',
                              p_errname => 'FREE_SG',
                              p_param1  => to_char(p_nd),
                              p_param2  => 'Вiльний зал.=' ||
                                           to_char(cck_dpk.R2_ / 100));
    end if;
    ----------------------------
    p_Z1 := cck_dpk.Z1_;
    p_Z2 := cck_dpk.Z2_;
    p_Z3 := cck_dpk.Z3_;
    p_Z4 := cck_dpk.Z4_;
    p_Z5 := cck_dpk.Z5_;
    p_R1 := cck_dpk.R1_;
    p_R2 := cck_dpk.R2_;

  END MODI_INFO;
  ----------------------------------------
  PROCEDURE MODI_pay(p_ND IN number, p_acc2620 IN number) is
    RR2      oper%rowtype;
    dd       cc_deal%rowtype;
    ostc_    number;
    ostb_    number;
    l_tt     tts.tt%type; -- код операции для доср.погаш. Настроить операцию!
    nls_2924 accounts.nls%type;
  begin
    begin
      select d.cc_id,
             d.sdate,
             c.okpo,
             SG.nls,
             substr(SG.nms, 1, 38),
             sg.kv,
             SS.nls,
             substr(SS.nms, 1, 38),
             ss.ostc,
             ss.ostb,
             substr('Дострокове погаш КД № ' || d.cc_id || ' вiд ' ||
                    to_char(d.sdate, 'dd.mm.yyyy') || '. ( Зі збереженням ' ||
                    Decode(CCK_DPK.k3_,
                           1,
                           'суми 1-го платежу',
                           'кiнцевого термiну') || ' )',
                    1,
                    160)
        into dd.cc_id,
             dd.sdate,
             RR1.id_a,
             RR1.nlsa,
             RR1.nam_a,
             RR1.kv,
             RR1.nlsb,
             RR1.nam_b,
             ostc_,
             ostb_,
             RR1.nazn
        from accounts SG,
             nd_acc   NSG,
             accounts SS,
             nd_acc   NSS,
             customer c,
             cc_deal  d
       where d.nd = p_ND
         and d.rnk = c.rnk
         and NSG.nd = d.ND
         and NSG.acc = SG.acc
         and SG.acc = p_acc2620
         and SG.dazs is null
         and NSS.nd = d.ND
         and NSS.acc = SS.acc
         and SS.tip = 'SS '
         and SS.dazs is null;

      if ostc_ <> ostb_ then
        bars_error.raise_nerror(p_errmod  => 'CCK',
                                p_errname => 'PLAN#FAKT',
                                p_param1  => to_char(p_nd),
                                p_param2  => RR1.nlsb);
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                'НЕ знайдено рах. p_acc2620=' || p_acc2620 ||
                                ' або SS по КД =' || p_ND);
    end;

    --- для доначис и пог %
    begin
      select SN.nls,
             SD.nls,
             substr(SN.nms, 1, 38),
             substr(SD.nms, 1, 38),
             SN.KV,
             SD.KV,
             -SN.ostb
        into RR2.nlsa,
             RR2.nlsb,
             RR2.nam_a,
             RR2.nam_b,
             RR2.kv,
             RR2.kv2,
             RR2.s
        from accounts SN, accounts SD
       where SN.acc = II.acra
         and SD.acc = II.acrb
         and SN.dazs is null
         and SD.dazs is null;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                'НЕ знайдено рах. з проц.картки по К ');
    end;

    If II.acr_dat < NVL(II.stp_dat, (gl.bdate - 1)) and ZN_ > 0 then

      -- доначислить %  ZN
      gl.ref(RR2.REF);
      gl.in_doc3(ref_   => RR2.REF,
                 tt_    => '%%1',
                 vob_   => 6,
                 nd_    => substr(to_char(RR2.REF), -10),
                 pdat_  => SYSDATE,
                 vdat_  => gl.BDATE,
                 dk_    => 1,
                 kv_    => RR2.kv,
                 s_     => ZN_,
                 kv2_   => RR2.kv,
                 s2_    => ZN_,
                 sk_    => null,
                 data_  => gl.BDATE,
                 datp_  => gl.bdate,
                 nam_a_ => RR2.nam_a,
                 nlsa_  => RR2.nlsa,
                 mfoa_  => gl.aMfo,
                 nam_b_ => RR2.nam_b,
                 nlsb_  => RR2.nlsb,
                 mfob_  => gl.aMfo,
                 nazn_  => Substr('Донарахування вiдсоткiв з ' ||
                                  to_char(II.acr_dat + 1, 'dd.mm.yyyy') ||
                                  ' по ' ||
                                  to_char(ii.STP_dat, 'dd.mm.yyyy') ||
                                  ' в зв`язку з достроковим погаш КД № ' ||
                                  dd.cc_id || ' вiд ' ||
                                  to_char(dd.sdate, 'dd.mm.yyyy'),
                                  1,
                                  160),
                 d_rec_ => null,
                 id_a_  => RR1.id_a,
                 id_b_  => gl.aOkpo,
                 id_o_  => null,
                 sign_  => null,
                 sos_   => 1,
                 prty_  => null,
                 uid_   => null);

      gl.payv(0,
              RR2.REF,
              gl.bDATE,
              '%%1',
              1,
              RR2.kv,
              RR2.nlsa,
              ZN_,
              RR2.kv2,
              RR2.nlsb,
              ZN_);

      -- проставить дату, по кот % уже начислены
      update int_accn
         set acr_dat = NVL(II.stp_dat, (gl.bdate - 1))
       where id = 0
         and acc in (select a.acc
                       from nd_acc n, accounts a
                      where n.nd = p_nd
                        and n.acc = a.acc
                        and tip in ('SS ', 'SP '));
      gl.pay(2, RR2.REF, gl.bDATE);
    end if;
    -----------------------------------------------
    --- снять сумму досрочки по телу CCK_DPK.K1_
    --  +  погасить все %%                   Z2N_
    --  +  погасить все комис                Z2K_,
    --  +  погасить все просрочки            Z1_ - только для БПК  - верим на слово, что на карточке достаточно денег

    If RR1.nlsa like '2625%' then
      l_tt  := cck_dpk.TT_W4;
      rr1.s := CCK_DPK.K1_ + cck_dpk.Z2N_ + cck_dpk.Z2K_ + cck_dpk.Z1_; -- 29.05.2015
    else
      l_tt  := 'ASD';
      rr1.s := CCK_DPK.K1_ + cck_dpk.Z2N_ + cck_dpk.Z2K_;
    end if;
    /*
    logger.info('AAAA ' || RR1.nlsa  ||' ' || l_tt ||
       ' K1_=' || CCK_DPK.K1_  ||
    ' + Z2N_=' || cck_dpk.Z2N_ ||
    ' + Z2K_=' || cck_dpk.Z2K_ ||
    ' + Z1_='  || cck_dpk.Z1_  ||
    '= rr1.S=' || rr1.S );
    */

    If rr1.S <= 0 then
      Return;
    end if;

    gl.ref(RR1.REF);
    gl.in_doc3(ref_   => RR1.REF,
               tt_    => l_tt,
               vob_   => 1,
               nd_    => substr(dd.cc_id, 1, 10),
               pdat_  => SYSDATE,
               vdat_  => gl.BDATE,
               dk_    => 1,
               kv_    => RR1.kv,
               s_     => rr1.s,
               kv2_   => RR1.kv,
               s2_    => rr1.s,
               sk_    => null,
               data_  => gl.BDATE,
               datp_  => gl.bdate,
               nam_a_ => RR1.nam_a,
               nlsa_  => RR1.nlsa,
               mfoa_  => gl.aMfo,
               nam_b_ => RR1.nam_b,
               nlsb_  => RR1.nlsb,
               mfob_  => gl.aMfo,
               nazn_  => RR1.nazn,
               d_rec_ => null,
               id_a_  => RR1.id_a,
               id_b_  => RR1.id_a,
               id_o_  => null,
               sign_  => null,
               sos_   => 1,
               prty_  => null,
               uid_   => null);
    insert into operw
      (REF, TAG, VALUE)
    values
      (RR1.REF, 'ND   ', to_char(p_ND)); -- Дата дострокового погашення DD.MM.YYYY
    insert into operw
      (REF, TAG, VALUE)
    values
      (RR1.REF, 'MDATE', to_char(gl.bdate, 'dd.mm.yyyy')); -- Реф KД

    If l_tt = cck_dpk.TT_W4 then
      nls_2924 := bpk_get_transit('20', RR1.nlsb, RR1.nlsa, RR1.kv);
      gl.payv(0,
              RR1.REF,
              gl.BDATE,
              l_tt,
              1,
              RR1.kv,
              RR1.nlsa,
              rr1.s,
              RR1.kv,
              nls_2924,
              rr1.s); ---------- итоговая проводка

      iF cck_dpk.Z1_ > 0 THEN
        -- 29.05.2015 ПРОСРОЧКИ в том же реф =  -NVL(sum(a.ostb),0) into cck_dpk.Z1_  -- положительное число

        for x in (select a.*
                    from accounts a, nd_acc n
                   where n.nd = p_ND
                     and n.acc = a.acc
                     and ostb < 0
                     and a.kv = RR1.kv
                     and (a.tip in
                         ('SP ', 'SL ', 'SPN', 'SK9', 'SLN', 'SLK') OR
                         a.tip in ('SN8') and RR1.kv = gl.baseval)) loop
          if x.TIP = 'SPN' then
            rr1.d_rec := 'Погашення просрочених вiдсоткiв';
          elsIF x.TIP = 'SK9' then
            rr1.d_rec := 'Погашення просроченої комiсiї';
          elsIF x.TIP = 'SP ' then
            rr1.d_rec := 'Погашення просроченого осн.боргу';
          elsIF x.TIP = 'SL ' then
            rr1.d_rec := 'Погашення сумнiвного осн.боргу';
          elsIF x.TIP = 'SLN' then
            rr1.d_rec := 'Погашення сумнiвного проц.боргу';
          elsIF x.TIP = 'SLK' then
            rr1.d_rec := 'Погашення сумнiвного комiс.боргу';
          elsIF x.TIP = 'SN8' then
            rr1.d_rec := 'Погашення пенi';
            gl.payv(0,
                    RR1.REF,
                    GL.BDATE,
                    'ASG',
                    1,
                    x.kv,
                    cck_dpk.NLS_8006,
                    -x.ostb,
                    x.kv,
                    x.nls,
                    -x.ostb); -- сворачиваем пеню
            x.nls := cck_dpk.NLS_6397;
          end if;

          gl.payv(0,
                  RR1.REF,
                  gl.BDATE,
                  l_tt,
                  1,
                  RR1.kv,
                  nls_2924,
                  -x.ostb,
                  RR1.kv,
                  x.nls,
                  -x.ostb);
          update opldok
             set txt = rr1.d_rec
           where ref = RR1.REF
             and stmt = gl.aStmt;

        end loop;
      end if;
    Else
      nls_2924 := RR1.nlsa;
    End if;

    If CCK_DPK.K1_ > 0 then
      ---- частная проводка по 2203
      gl.payv(0,
              RR1.REF,
              gl.BDATE,
              l_tt,
              1,
              RR1.kv,
              nls_2924,
              CCK_DPK.K1_,
              RR1.kv,
              RR1.nlsb,
              CCK_DPK.K1_);
      update opldok
         set txt = 'K1. Сума для дострокового погашення'
       where ref = RR1.REF
         and stmt = gl.aStmt;
    end if;

    If CCK_DPK.Z2N_ > 0 then
      ---- частная проводка по 2208
      gl.payv(0,
              RR1.REF,
              gl.BDATE,
              l_tt,
              1,
              RR1.kv,
              nls_2924,
              CCK_DPK.Z2N_,
              RR1.kv,
              RR2.nlsa,
              CCK_DPK.Z2N_);
      update opldok
         set txt = 'Z2N_. погасить все %%'
       where ref = RR1.REF
         and stmt = gl.aStmt;
    end if;

    If CCK_DPK.Z2K_ > 0 then
      ---- частная проводка по 3578
      begin
        select Sk.nls, Sk.KV, -Sk.ostb
          into RR2.nlsa, RR2.kv, RR2.s
          from accounts Sk, nd_acc n
         where Sk.acc = n.acc
           and sk.tip = 'SK0'
           and sk.ostb < 0
           and n.nd = p_ND
           and sk.kv = rr1.kv
           and rownum = 1;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          null;
          raise_application_error(- (20203),
                                  'НЕ знайдено рах. з tip = SK0');
      end;
      gl.payv(0,
              RR1.REF,
              gl.BDATE,
              l_tt,
              1,
              RR1.kv,
              RR1.nlsa,
              CCK_DPK.Z2K_,
              RR1.kv,
              RR2.nlsa,
              CCK_DPK.Z2K_);
      update opldok
         set txt = 'Z2K_ погасить все комис'
       where ref = RR1.REF
         and stmt = gl.aStmt;
    End if;

  end MODI_pay;
  --------------

  PROCEDURE MODI_gpk(p_ND IN number) is
    -- реф КД.
    sum1_    number;
    l_gpk    number;
    l_txt    char(2);
    l_basem  int;
    Datk_new date;
  begin

    If CCK_DPK.K0_ = 1 then
      l_gpk   := 4;
      l_txt   := '90';
      l_basem := 1; -- 1 -Ануитет, Без канікул, % за попередній день
    else
      l_gpk   := 2;
      l_txt   := '91';
      l_basem := 0; -- 0- Класс, Без канікул, % за попередній місяць
    end if;

    IR_ := acrn.fprocn(II.acc, 0, gl.bdate);

    If CCK_DPK.k1_ > 0 then
      -- есть сумма досрочного погашения сегодня => первая запись gl.bdate = начало нового ГПК
      datn_ := greatest(datn_, gl.bdate);
    else
      --11.06.2014 Винница
      select nvl(max(fdat), gl.bdate)
        into datn_
        from cc_lim
       where nd = p_nd
         and fdat <= gl.bdate;
    end if;

    ----- сумма 1-го пл
    sum1_ := cck.f_pl1(p_nd   => p_nd,
                       p_lim2 => lim2_, -- новый лимит
                       p_gpk  => l_gpk, -- 4-Ануитет. 2 - Класс ( -- 1-Ануитет. 0 - Класс   )
                       p_dd   => CCK_DPK.K2_, -- <Платежный день>, по умол = DD от текущего банк.дня
                       p_datn => datn_, -- дата нач КД
                       p_datk => datk_, -- дата конца КД
                       p_ir   => ir_, -- проц.ставка
                       p_ssr  => CCK_DPK.k3_ -- признак =0= "с сохранением срока"
                       );

    -- перенести все в архив
    delete from CC_LIM_ARC
     where nd = p_nd
       and mdat = gl.bdate;

    insert into CC_LIM_ARC
      (ND,
       MDAT,
       FDAT,
       LIM2,
       ACC,
       NOT_9129,
       SUMG,
       SUMO,
       OTM,
       SUMK,
       NOT_SN,
       TYPM)
      select ND,
             gl.bdate,
             FDAT,
             LIM2,
             ACC,
             NOT_9129,
             SUMG,
             SUMO,
             OTM,
             SUMK,
             NOT_SN,
             'CCKD'
        from cc_lim
       where nd = p_ND;

    If CCK_DPK.k1_ > 0 then
      -- есть сумма досрочного погашения сегодня => первая запись gl.bdate = начало нового ГПК
      update cc_lim
         set sumg = sumg + CCK_DPK.k1_,
             sumo = sumo + CCK_DPK.k1_,
             lim2 = lim2_
       where nd = p_nd
         and fdat = gl.bdate;
      if SQL%rowcount = 0 then
        insert into CC_LIM
          (ND, FDAT, LIM2, ACC, SUMG, SUMO, OTM, SUMK)
        values
          (p_nd,
           gl.bdate,
           lim2_,
           acc8_,
           CCK_DPK.k1_,
           CCK_DPK.k1_ + z2N_,
           1,
           0);
      end if;
    end if;

    delete from cc_lim
     where nd = p_nd
       and fdat > gl.bdate;

    --построим новую часть во врем табл
    cck.UNI_GPK_FL(p_lim2  => lim2_, -- новый лимит
                   p_gpk   => l_gpk, -- 4-Ануитет. 2 - Класс ( -- 1-Ануитет. 0 - Класс   )
                   p_dd    => CCK_DPK.K2_, -- <Платежный день>, по умол = DD от текущего банк.дня
                   p_datn  => datn_, -- дата нач КД
                   p_datk  => datk_, -- дата конца КД
                   p_ir    => ir_, -- проц.ставка
                   p_pl1   => sum1_, -- сумма 1 пл
                   p_ssr   => CCK_DPK.k3_, -- признак =0= "с сохранением срока"
                   p_ss    => ss_, -- остаток по норм телу
                   p_acrd  => II.acr_dat + 1, -- с какой даты начислять % acr_dat+1
                   p_basey => II.BASEY -- база для нач %%;
                   );
    commit;

    insert into cc_lim
      (ND, FDAT, LIM2, ACC, SUMG, SUMO, SUMK)
      select p_nd, fdat, lim2, acc8_, sumg, sumo, nvl(sumk, 0)
        from tmp_gpk
       where fdat > gl.bdate;

    -- 11.06.2014 + 21.11.2014 + 02.12.2014 пересчет проц в первый пл.период
    If CCK_DPK.k1_ = 0 and datn_ <= gl.bdate then

      declare
        dTmpG_ date;
        dTmp1_ date; -- 01.10.2014 (21.10.2014) \
        dTmp2_ date; -- 31.10.2014              / прошлый мес
        dTmp3_ date; -- 01.11.2014 \
        dTmp4_ date; -- 04.11.2014 / тек.мес часть - 1
        dTmp5_ date; -- 05 11.2014 \
        dTmp6_ date; -- 30.11.2014 / тек.мес часть -2

        gg  cc_lim%rowtype;
        si_ number;
        s1_ number;
        s2_ number;
      begin

        If l_gpk = 2 then
          -- 4-Ануитет. 2 - Класс ( -- 1-Ануитет. 0 - Класс   )

          -- Для 1-й пл даты -- строго по остаткам, т.к. период начисления - строго в прошлом
          dTmp1_ := trunc(add_months(gl.bdate, -1), 'MM'); -- 01 число прош мес
          dTmp2_ := trunc(gl.bdate, 'MM') - 1; -- 31 число прош.мес
          acrn.p_int(acc8_, 0, dTmp1_, dTmp2_, si_, NULL, 0);
          si_ := -Round(si_, 0);
          select min(fdat)
            into dTmpG_
            from cc_lim
           where nd = p_nd
             and fdat > dTmp2_;
          update cc_lim
             set sumo = sumg + si_
           where nd = p_nd
             and fdat = dTmpG_;

          -- Для 2-й пл даты
          ------------------ Часть 1 -- строго по остаткам
          dTmp3_ := dTmp2_ + 1; -- 01 число тек.мес
          select min(fdat) - 1
            into dTmp4_
            from cc_lim
           where nd = p_nd
             and fdat > dTmp3_; -- пл.дата-1  тек.мес
          acrn.p_int(acc8_, 0, dTmp3_, dTmp4_, si_, NULL, 0);
          s1_ := -Round(si_, 0);

          ------------------ Часть 2 -- разные
          dTmp5_ := dTmp4_ + 1; -- тек.мес пл.дата
          dTmp6_ := add_months(dTmp2_, 1); -- 31 число тек мес
          select min(fdat)
            into dTmpG_
            from cc_lim
           where nd = p_nd
             and fdat > dTmp6_;
          If dTmp5_ > gl.bdate then
            ---2.2.1 - по лимиту, Если пл.дата текущего месяца еще в будущеи, т.е сег.02.11.2014, а пл.дата 05.11.2014,  от лимита 05.11.2014
            select lim2
              into gg.LIM2
              from cc_lim
             where nd = p_nd
               and fdat = dTmp5_;
            s2_ := calp_AR(gg.LIM2, ir_, dTmp5_, dTmp6_, ii.basey);
          Else
            ---2.2.2 - по остаткам. Если пл.дата текущего месяца уже сегодня или в прошлом, т.е. сег.28.11.2014 или 05.11.2014, А пл.дата 05.11.2014
            acrn.p_int(acc8_, 0, dTmp5_, dTmp6_, s2_, NULL, 0);
            s2_ := -Round(s2_, 0);
          end if;
          si_ := s1_ + s2_;
          update cc_lim
             set sumo = sumg + si_
           where nd = p_nd
             and fdat = dTmpG_;
        Else
          /* А.Для Ануитета - проц по пред день  - (  это проверялось и справлялось 11.06.2014)
               пересчет процентов надо делать для 1-й будущей даты,
               И он равен расчетной сумме проц + досчитанной .
               Но это надо бы проверить еще раз. Сделайте, пож.
          */

          dTmp1_ := datn_; -- пред пл.дата
          dTmp2_ := add_months(datn_, 1); -- след пл.дата
          si_    := calp_AR(lim2_, ir_, datn_, dTmp2_ - 1, ii.basey); -- расч проц для след пл.даты
          update cc_lim
             set sumo = sumo + si_
           where nd = p_nd
             and fdat = dTmp2_
             and sumg = sumo - nvl(sumk, 0);
        End if;
      end;
    end if;

    -- 28.03.2014 Sta Модификация с уменьшением срока
    select max(fdat) into Datk_new from tmp_gpk;
    if Datk_new < Datk_ then
      update cc_deal set wdate = Datk_new where nd = p_ND;
      for k in (select a.acc
                  from nd_acc n, accounts a
                 where n.nd = p_nd
                   and n.acc = a.acc
                   and a.tip in ('SS ',
                                 'SN ',
                                 'SL ',
                                 'SDI',
                                 'SK0',
                                 'S9N',
                                 'SN8',
                                 'SG ',
                                 'LIM',
                                 'CR9',
                                 'SP ',
                                 'SPN',
                                 'SLN',
                                 'SPI',
                                 'SK9',
                                 'S9K',
                                 'SNO')) loop
        update accounts set mdate = Datk_new where acc = k.acc;
      end loop;
    end if;

    cck_app.set_nd_txt(P_ND, 'FLAGS', l_txt);
    --cck_app.set_nd_txt(P_ND, 'CCRNG', '10');

    /*
    rang|name
    ----|-----------------------------------------------|CUSTTYPE| BLK
    0    Без авто-розбору
    1    Стандартний
    2    Тільки основний борг (Чорнобильці) 3
    5    По платiжним дням (на рах. SG) основного боргу 3      2
    10   По платiжним дням з 262* або рах. погашення SG 3      14
    11   Доходи, основна заборгованість               3      14
    */

    update int_accn i
       set i.basem = l_basem, i.basey = decode(l_basem, 1, 2, i.basey)
     where id = 0
       and acc in (select a.acc
                     from nd_acc n, accounts a
                    where n.nd = p_nd
                      and n.acc = a.acc
                      and a.tip in ('LIM', 'SS '));

    LOGGER.financial('Модиф.ГПК реф.' || p_ND || ' при доср.погаш тела=' ||
                     CCK_DPK.k1_);

  end modi_gpk;

  ---------------------
  procedure MODI_RET(p_Nd IN cc_deal.nd%type, p_REF IN OUT oper.ref%type) is
  begin
    CCK_DPK.MODI_RET_EX(p_Nd => p_ND, p_REF => p_REF, p_mdat => gl.bdate);
  end MODI_RET;
  ---------------------
  procedure MODI_RET_EX(p_Nd   IN cc_deal.nd%type,
                        p_REF  IN OUT oper.ref%type,
                        p_mdat IN date) is
    l_p1 number;
    l_p2 number;
  begin
    CCK_DPK.RET_GPK(p_ND, p_ref, p_mdat); -- откат ГПК
    If p_ref is not null and p_ref <> 0 then
      p_back_dok(p_ref, 5, null, l_p1, l_p2);
      p_REF := null;
    end if; -- откат проводок
  end MODI_RET_EX;
  -------------------
  procedure RET_GPK(p_Nd   IN cc_deal.nd%type,
                    p_REF  IN oper.ref%type,
                    p_mdat IN date) is
    l_mdat cc_lim_arc.mdat%type;
    B_mdat date := NVL(p_mdat, gl.bdate);
    l_nd   number := p_ND;
  begin

    If l_nd is null and p_ref is not null then
      begin
        select n.nd
          into l_nd
          from nd_acc n, accounts a, oper o
         where n.acc = a.acc
           and a.kv = o.kv2
           and a.nls = o.nlsb
           and o.ref = p_ref;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          null;
      end;
    end if;
    if l_nd is null then
      return;
    end if;
    ------------------------------------

    select max(mdat)
      into l_mdat
      from cc_lim_arc
     where nd = L_ND
       and TYPM = 'CCKD';

    If l_mdat = B_mdat then
      delete from cc_lim where nd = L_nd;
      insert into CC_LIM
        (ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, SUMK, NOT_SN)
        select ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, SUMK, NOT_SN
          from cc_lim_arc
         where nd = L_nd
           and mdat = l_mdat;

      -- 11.06.2014 Винница ----
      declare
        dat_end date;
        dd      cc_deal%rowtype;
      begin
        select max(fdat) into dat_end from cc_lim where nd = L_nd;
        select * into dd from cc_deal where nd = L_nd;
        if dd.wdate <> dat_end then
          update cc_deal set wdate = dat_end where nd = L_nd;
          for k in (select acc
                      from accounts
                     where rnk = dd.rnk
                       and dazs is null
                       and mdate != dat_end
                       and acc in (select acc from nd_acc where nd = L_nd)) loop
            update accounts set mdate = dat_end where acc = k.acc;
          end loop;
        end if;
      end;

      --   При откате досрочного погашения 01 числа записи  из cck_arc_cc_lim  не удалять,
      --   а только убирать признак досрочного погашения.
      If to_number(to_char(l_mdat, 'DD')) = 1 then
        update cc_lim_arc
           set typm = null
         where nd = L_nd
           and mdat = l_mdat;
      else
        delete from cc_lim_arc
         where nd = L_nd
           and mdat = l_mdat;
      end if;

      -- else ----Нет в архиве за B_mdat
      ---  bars_error.raise_nerror(p_errmod=>'CCK',p_errname=>'Нет в архиве за '||to_char(B_mdat,'dd.mm.yyyy'), p_param1=> to_char(L_nd), p_param2=> to_char(B_mdat,'dd.mm.yyyy'));

    end if;

  end RET_GPK;

---Аномимный блок --------------
begin
  CCK_DPK.TT_W4 := 'W4Y'; --  Досрочное, код операции новый  =  'W4Y' = W4.Списання с БПК для достр. погашення заборг. (Вместо W4X )

  begin
    select nls
      into CCK_DPK.nls_8006
      from accounts
     where tip = 'SD8'
       and nvl(nbs, '8006') = '8006'
       and dazs is null
       and kv = gl.baseval
       and rownum = 1;
  EXCEPTION
    WHEN OTHERS THEN
      raise_application_error(- (20203),
                              ' Не знайдено контр рах. по пенi 8006*SD8');
  end;

  begin
    select a.nls
      into CCK_DPK.NLS_6397
      from accounts a, TOBO_PARAMS t
     where t.tag = 'CC_6397'
       and a.kv = gl.baseval
       and t.val = a.nls
       and a.dazs is null
       and t.tobo = sys_context('bars_context', 'user_branch');
  EXCEPTION
    WHEN OTHERS THEN
      raise_application_error(- (20203),
                              'Не знайдено рах.6397 дох.по пенi для ' ||
                              sys_context('bars_context', 'user_branch') || '.
        Заповніть довідник  "Параметри підрозділів банку"(TOBO_PARAMS) Таг ="CC_6397"
 ');
  end;

end CCK_DPK;
/
 show err;
 
PROMPT *** Create  grants  CCK_DPK ***
grant EXECUTE                                                                on CCK_DPK         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_DPK         to START1;

 
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/cck_dpk.sql =========*** End *** ===
PROMPT ===================================================================================== 
 