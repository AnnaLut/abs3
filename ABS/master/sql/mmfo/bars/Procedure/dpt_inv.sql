

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_INV.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_INV ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_INV 
 (mode_   int ,
  p_DAT   date,
  BRANCH_ varchar2
  ) IS

l_cont varchar2(100);  -- для тестирования контекст
l_kk   integer;
/*
11.09.2015 nvv mode_=1    З переходом на draps не враховувалась інформація про рахунки з залишком 0
               mode_=100  З переходом на draps не враховувалась інформація про рахунки з залишком 0

18.01.2011 qwa Перешла на другую врем таблицу (Луцк и Черновцы не работало)
               +соотв катзапросы+скрипт на создание таблицы tmp_dpt_inv

10.12.2010 qwa Инвентаризационные ведомости. Была ошибка - если счет открывался в последний
               день месяца и не было начисления %% - не было данных в накопительных таблицах
               по счетам начисленных %% и соотв. такие депозиты  не отбирались.

02.04.2010 Qwa
 Параметр 102  -  сальдовка  на отч.мес, с корр 096
                 оставляю как резерв, блок отлажен и работает,
                 но в запросе \BRS\SBM\REP\31\7
                 заменила на процедуру P_SAL_SNP
                 - на сальдовку за период
04.02.2010 Qwa
  1. Для параметров 100,101 (месячные с корректирующими)
                 установила обновления от 02.02.2010
  2. Новый параметр 102 для месячной сальдовки по типу 11
     причем 2620,2628,2630,2635,2638  выводим только итоги

02.02.2010 Qwa
  1. Страховочную синхронизацию оставила только для МФО, так как если
  для 2 и 3 уровня все одновременно запускают страховочную синхронизацию
  - все висит
  2. из накопительных таблиц вычитываю сразу нужную дату

28.01.2010 Qwa

   1. Сделала обработку по dpt_deposit_clos - для включения тех, которые закрылись после даты отчета
   2. Условный код продукта  2620_07 - название "приватн? нотар?уси"
      Условный код продукта  99998   - название "?нш? по ОБ22"
                             99999   -          "нерухом? АСВО"
   3. Привела номер дела к символьному типу (необходимо add cck_an_tmp.nlsalt)
   Признаки  по выборкам
   =======================================================
   1 - АСВО депозитный портфель
   2 - АБС  депозитный портфель
   1 - АСВО "_нш_ котлов_", в тч нотариусы (не входят в портфель)
   1 - "АСВО нерухом_" (не входят в портфель)

26.01.2010 Qwa +Sta

mode_ = 0   -  детально      на дату, без корр
mode_ = 1   -  консолiдовано на дату, без корр
mode_ = 100 -  детально      на зв.м?с, з корр
mode_ = 101 -  консолiдовано на зв.м?с, з корр
Ознаки  по виборках
=======================================================
1 - АСВО депозитний портфель
2 - АБС  депозитний портфель
1 - АСВО - _нш_ котлов_, в тч нотар_уси (не входять в портфель)
1 - АСВО нерухом_ (не входять в портфель)
*/

   DAT_  date := p_DAT;

begin

  EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_DPT_INV';
--  bars_audit.info ('dpt_inv === '||' mode_ = '||mode_||' p_dat = '||p_dat||' BRANCH_ = '||BRANCH_);
  l_cont:=sys_context('bars_context','user_branch');
  begin

  if mode_ >= 100 then
     DAT_  := to_date  ('01.'||to_char(p_DAT,'mm.yyyy'),'dd.mm.yyyy');
  end if;
  /*if length(BRANCH_)=8 and mode_ >= 100 then
     -- страховочная синхронизация месячная
       bars_accm_sync.sync_AGG('MONBAL', Dat_);
  elsif length(BRANCH_)=8 and mode_ < 100 then
       -- страховочная синхронизация дневная
       bars_accm_sync.sync_snap('BALANCE', Dat_);
  end if;*/
  commit;


  EXCEPTION WHEN NO_DATA_FOUND THEN return;
  end;

If mode_ = 0 then  /* детально на дату, без корр*/
 insert into TMP_DPT_INV
        (branch,    nbs,   kv,  ob22,
         vidd,      nmk,
         nls,       ost,   ostq,
         nlsn,      nost,  nostq,
         nlsalt,    prizn )
  select a.branch,  a.nbs, a.kv, s.ob22,
         d.vidd vidd, substr(c.nmk,1,35),
         a.nls,     m.ost,  m.ostq,
         b.nls, decode(a.nls,b.nls,0,n.ost), decode(a.nls,b.nls,0,n.ostq),
         nvl(a.nlsalt,to_char(d.deposit_id)),                  --
         decode(a.nlsalt,null,2,1)                               -- разделение на АСВО=1, АБС=2
  from accounts a,
       (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) m,
       (select a.acc,a.vidd,a.deposit_id,a.idupd
               from dpt_deposit_clos a,
                   (select distinct acc,  deposit_id,
                            max(idupd)  over (partition by acc, deposit_id) idupd
                    from dpt_deposit_clos   ) b
              where a.acc=b.acc and a.deposit_id=a.deposit_id and a.idupd=b.idupd
        ) d,
       (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) n,
       customer c, int_accn i, accounts b, specparam_int s
  where d.acc=a.acc
    and a.acc=m.acc and   a.nbs not like '8%'  and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and i.acc=a.acc
    and i.id =1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and n.acc(+)=b.acc
    and a.acc=s.acc(+)
union all
  select a.branch, a.nbs,a.kv,s.ob22,
         decode(a.nbs,'2620',decode(s.ob22,'07',262007,99998),99998) vidd,             -- _нш_ котлов_ по ОБ22 (коректн_)
         substr(c.nmk,1,35),                                                     -- в т.ч. 262007 приватн_ нотар_уси
         a.nls, m.ost,m.ostq,
         b.nls, decode(a.nls,b.nls,0,n.ost), decode(a.nls,b.nls,0,n.ostq),
         a.nlsalt, 1
  from accounts a,
       (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) m,
       customer c, int_accn i,   accounts b, specparam_int s,
       (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) n
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and a.acc=m.acc and   a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and i.acc=a.acc
    and i.id =1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and n.acc(+)=b.acc
    and a.acc=s.acc(+)
union all
  select a.branch, a.nbs,a.kv,s.ob22,
         decode(a.nbs,'2620',decode(s.ob22,'07',262007,99999),99999) vidd,
         substr(c.nmk,1,35),    -- АСВО нерухом
         a.nls, m.ost,m.ostq,
         '', 0, 0, a.nlsalt, 1
  from accounts a,
       (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) m,
        customer c,   specparam_int s
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and a.acc=m.acc and   a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and not exists (select 1 from int_accn i where a.acc=i.acc and i.id=1 and i.acra is not null)
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.acc=s.acc(+)
     ;

ElsIf mode_ = 1 then  /* консолiдовано на дату, без корр */
--bars_audit.info ('dpt_inv === 1'||' mode_ = '||mode_||' p_dat = '||p_dat||' BRANCH_ = '||BRANCH_);
--bars_audit.info ('dpt_inv === 1 Dat_ = '||Dat_||'sys_context = '||l_cont);
  insert into TMP_DPT_INV
  (branch,
      nbs,
       kv,
     ob22,
     vidd,
      ost,
     ostq,
     nost,
    nostq,
      kol)
  select a.branch,     a.nbs,   a.kv,   a.ob22,
         d.vidd vidd,  sum(nvl(m.ost,0)), sum(nvl(m.ostq,0)),
         sum(decode(a.nls,b.nls,0,nvl(n.ost,0))), sum(decode(a.nls,b.nls,0,nvl(n.ostq,0))), count(*)
  from accounts a
       left outer join
       (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) m on (a.acc = m.acc),
       (select a.acc,a.vidd,a.deposit_id,a.idupd
               from dpt_deposit_clos a,
                   (select distinct acc,  deposit_id,
                            max(idupd)  over (partition by acc, deposit_id) idupd
                    from dpt_deposit_clos   ) b
              where a.acc=b.acc and a.deposit_id=a.deposit_id and a.idupd=b.idupd
       ) d,
       int_accn i,
          accounts b
              left outer join
          (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) n  on (b.acc = n.acc)
  where d.acc=a.acc
    and a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and i.acc=a.acc
    and i.id=1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    group by a.branch, a.nbs,a.kv,a.ob22,d.vidd
union all
   select a.branch, a.nbs,a.kv, a.ob22,
          decode(a.nbs,'2620',decode(a.ob22,'07',262007,99998),99998) vidd,       -- _нш_ котлов_ по ОБ22 (коректн_)
           sum(m.ost), sum(m.ostq),                                               -- в т.ч. 262007 приватн_ нотар_уси
           sum(decode(a.nls,b.nls,0,n.ost)), sum(decode(a.nls,b.nls,0,n.ostq)), count(*)
  from accounts a
       left outer join
       (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) m on (a.acc = m.acc),
       int_accn i,
        accounts b
         left outer join
       (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) n on (b.acc = n.acc)
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and a.acc=m.acc
    and a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and i.acc=a.acc
    and i.id=1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
  group by a.branch, a.nbs,a.kv,a.ob22
  union all                                                  -- АСВО нерухом
   select  a.branch, a.nbs,a.kv, a.ob22,
           decode(a.nbs,'2620',decode(a.ob22,'07',262007,99999),99999) vidd,
           sum(m.ost), sum(m.ostq),   0, 0, count(*)
  from accounts a
       left outer join
        (select acc,rnk,ost,ostq from SNAP_BALANCES where fdat=Dat_) m on (a.acc = m.acc)
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and  a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and  not exists (select 1 from int_accn i where a.acc=i.acc and i.id=1 and i.acra is not null)
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
  group by a.branch, a.nbs,a.kv,a.ob22;

ElsIf mode_ = 100 then  /* на зв.мес, з корр*/

--bars_audit.info ('dpt_inv === 100'||' mode_ = '||mode_||' p_dat = '||p_dat||' BRANCH_ = '||BRANCH_);
--bars_audit.info ('dpt_inv === 100 Dat_ = '||Dat_||'sys_context = '||l_cont);

  insert into TMP_DPT_INV (branch,  nbs,  kv,  ob22, vidd,  nmk,  nls,  ost,  ostq, nlsn, nost, nostq,  nlsalt, prizn )
  select a.branch,   a.nbs,   a.kv,   a.ob22,   d.vidd vidd,    substr(c.nmk,1,35),
         a.nls, m.ost-m.crdos+m.crkos OST,  m.ostq-m.crdosQ+m.crkosQ OSTQ,
         b.nls, decode(a.nls,b.nls,0,n.ost-n.crdos+n.crkos)    OSTn,
                decode(a.nls,b.nls,0,n.ostq-n.crdosQ+n.crkosQ) OSTQn,
         nvl(a.nlsalt,to_char(d.deposit_id)),                  --
         decode(a.nlsalt,null,2,1)                               -- разделение на АСВО=1, АБС=2
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) m on (a.acc = m.acc),
       (select a.acc,a.vidd,a.deposit_id,a.idupd
               from dpt_deposit_clos a,
                   (select distinct acc,  deposit_id,
                            max(idupd)  over (partition by acc, deposit_id) idupd
                    from dpt_deposit_clos   ) b
              where a.acc=b.acc and a.deposit_id=a.deposit_id and a.idupd=b.idupd
       ) d,
       customer c, int_accn i, accounts b left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) n on (b.acc = n.acc)
  where d.acc=a.acc
    and   a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and i.acc=a.acc
    and i.id =1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
union all
  select a.branch, a.nbs,a.kv,a.ob22,
         decode(a.nbs,'2620',decode(a.ob22,'07',262007,99998),99998) vidd,    -- _нш_ котлов_ по ОБ22 (коректн_)
         substr(c.nmk,1,35),
         a.nls, m.ost-m.crdos+m.crkos OST,  m.ostq-m.crdosQ+m.crkosQ  OSTQ,
         b.nls, decode(a.nls,b.nls,0,n.ost-n.crdos+n.crkos)    OSTn,
                decode(a.nls,b.nls,0,n.ostq-n.crdosQ+n.crkosQ) OSTQn,
         a.nlsalt, 1
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) m on (a.acc = m.acc),
       customer c, int_accn i, accounts b left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) n on (b.acc = n.acc)
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and   a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and i.acc=a.acc
    and i.id =1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
union all
  select a.branch, a.nbs,a.kv,a.ob22,
         decode(a.nbs,'2620',decode(a.ob22,'07',262007,99999),99999) vidd,
         substr(c.nmk,1,35),    -- АСВО нерухом
         a.nls, m.ost-m.crdos+m.crkos OST, m.ostq-m.crdosQ+m.crkosQ OSTQ,
         '', 0, 0,
         a.nlsalt, 1
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) m on (a.acc = m.acc),
       customer c
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and   a.nbs not like '8%'   and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and not exists (select 1 from int_accn i where a.acc=i.acc and i.id=1 and i.acra is not null)
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
     ;

ElsIf mode_ = 101 then  /* консолiдовано на зв.мес, з корр */
--bars_audit.info ('dpt_inv === 101'||' mode_ = '||mode_||' p_dat = '||p_dat||' BRANCH_ = '||BRANCH_);
--bars_audit.info ('dpt_inv === 101 Dat_ = '||Dat_||'sys_context = '||l_cont);
  insert into TMP_DPT_INV (branch, nbs,  kv, ob22, vidd, ost, ostq, nost, nostq, kol)
  select a.branch, a.nbs,a.kv,a.ob22,d.vidd vidd,
          sum(m.ost-m.crdos+m.crkos), sum(m.ostq-m.crdosQ+m.crkosQ),
          sum(decode(a.nls,b.nls,0,n.ost-n.crdos+n.crkos)),
          sum(decode(a.nls,b.nls,0,n.ostq-n.crdosQ+n.crkosQ)),
          count(*)
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) m on (a.acc = m.acc),
       (select a.acc,a.vidd,a.deposit_id,a.idupd
               from dpt_deposit_clos a,
                   (select distinct acc,  deposit_id,
                            max(idupd)  over (partition by acc, deposit_id) idupd
                    from dpt_deposit_clos   ) b
               where a.acc=b.acc and a.deposit_id=a.deposit_id and a.idupd=b.idupd
       ) d,
       customer c, int_accn i,
       accounts b left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) n on (b.acc = n.acc)
  where d.acc=a.acc
    and   a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and i.acc=a.acc
    and i.id=1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
     group by a.branch, a.nbs,a.kv,a.ob22,d.vidd
union all
   select a.branch, a.nbs,a.kv, a.ob22,
          decode(a.nbs,'2620',decode(a.ob22,'07',262007,99998),99998) vidd, -- _нш_ котлов_ по ОБ22 (коректн_)
          sum(m.ost -m.crdos +m.crkos),
          sum(m.ostq-m.crdosQ+m.crkosQ),
          sum(decode(a.nls,b.nls,0,n.ost -n.crdos +n.crkos)),
          sum(decode(a.nls,b.nls,0,n.ostq-n.crdosQ+n.crkosQ)),
          count(*)
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) m on (a.acc = m.acc),
       customer c, int_accn i, accounts b left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) n on (b.acc = n.acc)
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and   a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and a.rnk=c.rnk
    and i.acc=a.acc
    and i.id=1
    and i.acra=b.acc
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
  group by a.branch, a.nbs,a.kv,a.ob22
  union all                                                  -- АСВО нерухом
   select a.branch, a.nbs,a.kv, a.ob22,
          decode(a.nbs,'2620',decode(a.ob22,'07',262007,99999),99999) vidd,
          sum(m.ost -m.crdos +m.crkos),
          sum(m.ostq-m.crdosQ+m.crkosQ),
          0, 0, count(*)
  from accounts a left outer join
       (select acc,rnk,ost,ostq,crdos,crkos,crdosQ,crkosQ
          from AGG_MONBALS where fdat=Dat_) m on (a.acc = m.acc),
       customer c
  where a.acc not in (select acc from dpt_deposit_clos)
    and ((newnbs.g_state = 1 and a.nbs in ('2620','2630')) or (newnbs.g_state = 0 and a.nbs in ('2620','2630','2635')))
    and   a.nbs not like '8%'     and a.nls not like '8%'
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and  not exists (select 1 from int_accn i where a.acc=i.acc and i.id=1 and i.acra is not null)
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.daos < p_DAT
  group by a.branch, a.nbs,a.kv,a.ob22;

ElsIf mode_ = 102 then  /* сальдовка  на отч.мес, с корр 096*/

  insert into CCK_AN_TMP
             (branch,nbs,kv,name,name1,nls,n1,n2,n3,n4,n5,zalq,zal,rezq)
  select a.branch,
         a.nbs,
         a.kv,
         nvl(s.ob22,'00') ob22,
         substr(a.nms,1,35) nms,
         a.nls,
         m.ost  + m.dos    -m.kos  -m.cudos  + m.cukos  ost,
         m.ostq + m.dosq   -m.kosq -m.cudosq + m.cukosq ostq,
         m.dos  + m.crdos  -m.cudos   dos,
         m.dosq + m.crdosq -m.cudosq  dosq,
         m.kos +  m.crkos  -m.cukos   kos,
         m.kosq + m.crkosq -m.cukosq  kosq,
         m.ost -  m.crdos +m.crkos  osti,
         m.ostq-  m.crdosQ+m.crkosQ ostiq
  from accounts a,
       (select acc,rnk,
               dos,    kos,   dosQ,   kosQ,
               ost,    ostq,
               crdos,  crkos, crdosQ, crkosQ,
               cudos,  cukos, cudosQ, cukosQ
          from AGG_MONBALS where fdat=Dat_) m,
       customer c, specparam_int s
  where a.acc=m.acc
    and ( a.dazs is null or a.dazs > p_dat)
    and m.rnk=c.rnk
    and a.branch like BRANCH_||'%'
    and a.branch like sys_context('bars_context','user_branch')||'%'
    and a.acc=s.acc(+);
end if;

commit;
--select count(*) into l_kk from tmp_dpt_inv;
--bars_audit.info ('dpt_inv === end'||' l_kk = '||l_kk);
Return;
end DPT_INV;
/
show err;

PROMPT *** Create  grants  DPT_INV ***
grant EXECUTE                                                                on DPT_INV         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_INV         to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_INV.sql =========*** End *** =
PROMPT ===================================================================================== 
