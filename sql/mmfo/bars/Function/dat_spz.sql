
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dat_spz.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DAT_SPZ (P_ACC NUMBER, -- Счет
                                    P_dat date  , -- дата на которую отчет
                                    p_zo  int     -- = 1 с учетом корр
                                   )
  RETURN date
  is
/*
04.06.2018  saldoa без оборотов с одной строкой - по старых

 02.06.2018 STA  ИДЕЯ ХАРИНА В. СНИМАТЬ ОБОРОТЫ 024 И ПО ДЕБЕТУ  SALDOA - OPLDOK ( ам не сумма  по OPLDOK)

 04.04.2018 Sta+Lit Учли "обрезанный" OPLDOK + нелевые записи в SALDOA . пример acc= 16124701
 07.02.2018 Sta Обходим обороты с кодом операции 024 и.или типом счета 024
 24.12.2015 Sta CСч иеен одну запись в SALDOA. ostf= 0. dos=kos
 17.12.2015 Sta Сч создан с ост и потом были обороты
 12.11.2015 Sta  Добавлен комментарий - описание алгоритма
 06.11.2015 Sta  Старт-Сумма остатка.
 20.10.2015 Sta  берем доп.рекв только если он меньше saldoa.FDAT
 05.10.2015 Sta Для счетов просрочки, кот изначально открылись в АБС с остатком , например, при миграции. Или по ЦБ
 09.07.2015 Sta = c учетом корр.проводок
 возвращает реальную дату просрочки с учетом частичных погашений, которые гасили "самую старую" просрочку
*/

  KOS_    number;   -- сколько всего погашено  до отчетной даты
  KOZ_    number;   -- плюс корр >  отч даты с датой вал <= отч.даты
  L_DAT01 DATE;   -- отч.дата
  d_DAT   DATE;   -- в дата доп.рекв
  Z_DAT05 DATE;   -- отч.дата с учетом корр
  l_ZO    int;
  DOZ_    number;
  m_Dat   DATE;
  m_Kol   int;
  m_Ost   number; -- минимальное по SALDOA
  g_Dat   Date;  -- пограничная дата. где мы не трогаем оплдок
  D24_    NUMBER;
  dAT_DOP DATE ;
  koss_   number ;
  k24_    number;

begin

/* Высылаю вам описание работы алгоритма.
   Выводы о (НЕ)Соответствии написанному ниже – делайте сами.

  m_Kol = количество движений по счету
  m_Dat = минимальная дата движения по счету
  d_Dat = доп.рекв «Дата виникнення заборгованості по рахунку або по КД»
  KOS   = сколько всего погашено  до отчетной даты

1) Если m_Kol = 1 и деб.остаток :
   • Если  d_Dat = пусто, то m_Dat,
   • иначе d_Dat
   • Выход.
---- Здесь отсекаются просрочки, которые никогда (в истории нашей АБС) не гасились. И дальше можно не смотреть.

2) Иначе, т.е. была какая-то «жизнь» счета
   • Сканируем все дни FDAT, когда были деб.обороты, начиная с самого старого
     При этом - первый день подменяем на d_Dat, если он не пустой,
     это важно для исключения технических оборотов миграции, или «запоздалого» отображения в АБС.

   • Для каждого из них :
     Вычитаем Сумму дебетового оборота  DOS одного дня
     из обшей суммы Кредитовых оборотов KOS
     KOS(итого)  = KOS(итого) – DOS(дня)

   • Тот день = FDAT, где станет KOS(итого) < 0 считается днем просрочки. Выход.
   • Если такого нет, т.е. все деб.обороты покрыты кредитовыми (KOS=0), то просточки нет. Выход.

*/

  L_DAT01 := NVL( P_DAT, GL.BDATE);
  Z_DAT05 := L_DAT01 + 5   ;
  g_Dat   := L_DAT01 - 100 ;

  if  P_ZO = 0 then
    L_ZO := 0;
  else
    L_ZO := 1;
  end if;

 --01/06/2018 -----------------------------------------------------
  IF FOST ( P_ACC, L_DAT01) >=0 THEN
    RETURN NULL ;
  END IF;
  ---------------------------------------------------------

  -- сколько всего погашено-1 по saldoa

  select  min (s.FDAT)
    INTO   m_Dat
    from saldoa S
    where  S.acc = P_ACC ;

  select  min (s.ostf-s.dos+s.kos), count(*) , NVL(sum(kos) ,0)
    INTO   m_Ost, m_Kol , koss_
    from saldoa S
    where  S.acc = P_ACC
      and S.fdat <= L_DAT01
      and ( dos+kos > 0 OR fdat = m_Dat );


 --select  min (s.FDAT), min (s.ostf-s.dos+s.kos), count(*) , NVL(sum(kos) ,0)
 --INTO   m_Dat, m_Ost, m_Kol , koss_
 --from saldoa S  where  S.acc = P_ACC and S.fdat <= L_DAT01  and dos+kos > 0;

--
  -- сколько всего погашено-2    opldok
--  select  Sum(CASE WHEN o.dk = 1 and o.sos = 5 and o.tt<>'024' THEN o.S ELSE 0 END) INTO KOS_  from saldoa S, opldok o  where  S.acc = P_ACC and S.fdat <= L_DAT01  and s.acc = o.acc and s.fdat = o.fdat ;
---  select  Sum(CASE WHEN o.dk = 1 and o.sos = 5 and o.tt <> '024' THEN 0 ELSE O.S  END) INTO K24_
--  from saldoa S, opldok o  where  S.acc = P_ACC and S.fdat <= L_DAT01  and s.acc = o.acc and s.fdat = o.fdat ;

  select  Nvl(Sum(O.S),0)
    INTO K24_
    from saldoa S,
         opldok o
    where S.acc = P_ACC
      and S.fdat <= L_DAT01
      and s.acc = o.acc
      and s.fdat = o.fdat
      and o.tt in ('024', 'IF0', 'IF1', 'IF2', 'IF3', 'IF4', 'IF5', 'IF6');

  KOS_:= KOSS_ - NVL(K24_,0)  ; ---nvl ( KOS_, 0 ) ;

  begin
    select to_date(value, 'dd-mm-yyyy')
      into d_Dat
      from accountsw
      where acc = p_acc
        and tag = 'DATVZ' ; -- Дата виникнення заборгованості по рахунку

        dAT_DOP := d_dAT ;
  exception
    when no_data_found then
      null;
  end ;

  If d_DAT is null then  -- Дата виникнення заборгованості по дог ( через рахунок )
     begin
       select  to_date( t.txt , 'dd-mm-yyyy')
         into d_Dat
         from nd_txt t,
              nd_acc n
         where n.acc = p_acc
           and n.nd = t.nd
           and t.tag = 'DATSP' ;  ----Дата виникнення прострочення за основним боргом
     exception
       when no_data_found then
         null;
     end ;

  end if ;
  d_Dat := NVL( d_Dat, m_Dat);

  If m_Kol = 1 and m_Ost < 0 then
    return NVL(d_Dat, m_Dat) ;
  end if; -- миграц. НЕ оборотные ост
  ------------------------------------------------------------------------

  IF L_ZO = 1 THEN   -- Добавка Погашения корр/обротами
     select NVL(sum(o.s),0)
     INTO KOZ_
     from  opldok o,
         (SELECT FDAT FROM SALDOA WHERE ACC = P_ACC AND KOS > 0 AND ( fdat >= L_DAT01 AND fdat <= Z_DAT05)   ) S
     where o.tt <> '024'
       and O.acc = P_acc
       AND O.FDAT = S.FDAT
       AND o.sos = 5
       and o.dk = 1
       AND EXISTS  (SELECT 1 FROM OPER P WHERE P.REF = O.ref  and P.vob = 96 and P.vdat <= L_DAT01) ;

     KOS_ := KOS_ + KOZ_ ;
  END IF;

  --ловим непогашенн?й интервал по SALDOA
  For k in (select d_DAT FDAT, dos-ostf  DOS,
                   nvl((SELECT SUM(S)  FROM OPLDOK WHERE ACC = X.ACC AND FDAT = X.fdat AND DK = 0 AND TT in ('024', 'IF0', 'IF1', 'IF2', 'IF3', 'IF4', 'IF5', 'IF6') ),0)  D24
              from saldoa x
              where acc = p_acc
                and fdat = m_Dat
            union all
            select  fdat, dos,
                    nvl((SELECT SUM(S)  FROM OPLDOK WHERE ACC = X.ACC AND FDAT = X.fdat AND DK = 0 AND TT in ('024', 'IF0', 'IF1', 'IF2', 'IF3', 'IF4', 'IF5', 'IF6')),0)  D24
              from saldoa X
              where acc = P_ACC
                and dos > 0
                and fdat > m_Dat
                and fdat <= l_DAT01
            order by 1)
  loop
    k.DOS := k.DOS -K.D24;   --- 01/06/2018
    KOS_  := KOS_ - k.DOS;
    If KOS_ < 0 then
      iF dAT_DOP IS NOT NULL THEN
        K.fdat := gREATEST (K.FDAT, DAT_DOP) ;
      END IF; -- 01/06/2018

      return k.FDAT ;
    end if ; ------- просрочка есть даже БЕЗ корр, дальше и смотреть нечего !!!!
  end loop;                   -------------------------------------------

  If l_ZO = 1 then  --- Вынос на просрочку корр/обротами - РАБОТАЕМ ПО OPLDOK !!!!!!
    select NVL( sum(o.s),0)
       INTO DOZ_
       from  opldok o,
          (SELECT FDAT FROM SALDOA WHERE ACC = P_ACC AND DOS > 0 AND ( fdat >= L_DAT01 AND fdat <= Z_DAT05)   ) S
       where o.tt not in ('024', 'IF0', 'IF1', 'IF2', 'IF3', 'IF4', 'IF5', 'IF6')
         and O.acc = P_acc
         AND O.FDAT = S.FDAT
         AND o.sos = 5
         and o.dk = 0
         AND EXISTS  (SELECT 1 FROM OPER P WHERE P.REF = O.ref  and P.vob = 96 and P.vdat <= L_DAT01) ;

    KOS_ := KOS_ - DOZ_ ;
    If KOS_ < 0 then
      RETURN l_DAT01 ;
    end if ; ------- просрочка есть, возникла корр !
  end if;                     -------------------------------------------

  RETURN to_date(null);  -- просрочки нет

end DAT_SPZ;
/
 show err;
 
PROMPT *** Create  grants  DAT_SPZ ***
grant EXECUTE                                                                on DAT_SPZ         to BARSUPL;
grant EXECUTE                                                                on DAT_SPZ         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DAT_SPZ         to START1;
grant EXECUTE                                                                on DAT_SPZ         to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dat_spz.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 