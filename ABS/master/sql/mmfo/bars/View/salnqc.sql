

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALNQC.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view SALNQC ***

  CREATE OR REPLACE FORCE VIEW BARS.SALNQC ("DAPP", "DAPPQ", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTF", "DOS", "KOS", "OST", "OSTFQ", "DOSQ", "KOSQ", "OSTQ", "NBS", "ISP", "NLSALT", "DAZS", "MDATE", "APP", "APPQ", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF", "OB22") AS 
  select    dapp,
   decode(kv, 980, to_date(null), dappq) dappq,
   accc,
   acc,
   nls,
   kv,
   nms,
   grp,
   fdat,
   ostf,
   dos,
   kos,
   ost,
   decode(kv, 980, ostf, ostfq) ostfq,
   decode(kv, 980, dos, dosq) dosq,
   decode(kv, 980, kos, kosq) kosq,
   decode(kv, 980, ost, ostq) ostq,
   nbs,
   isp,
   nlsalt,
   dazs,
   mdate,
   app,
   decode(kv, 980, to_date(null), appq) appq,
   tip,
   daos,
   pap,
   rnk,
   tobo
   ,branch
   ,kf
   ,ob22
from
(
with
a as
  ( select a.*, nvl(a.dapp, a.daos) dapp2, nvl(a.dappq, a.daos) dappq2, c.cdat as bdat
      from accounts a, iot_calendar c
     where a.daos <= c.cdat
       and (a.dazs is null or a.dazs >= c.cdat)
  ),
s as
  ( select c.cdat as bdat,
           s.acc,
           min(s.fdat) as fdat,
           min(s.pdat) keep (dense_rank first order by s.fdat) as pdat,
           sum(s.dos) as sum_dos,
           sum(s.kos) as sum_kos,
           sum(case when s.fdat=c.cdat then s.dos else 0 end) as today_dos,
           sum(case when s.fdat=c.cdat then s.kos else 0 end) as today_kos
      from saldoa s, iot_calendar c
     where s.fdat >= c.cdat
     group by c.cdat, s.acc
  ),
q as
  ( select c.cdat as bdat,
           s.acc,
           min(s.fdat) as fdat,
           min(s.pdat) keep (dense_rank first order by s.fdat) as pdat,
           sum(s.dos) as sum_dos,
           sum(s.kos) as sum_kos,
           sum(case when s.fdat=c.cdat then s.dos else 0 end) as today_dos,
           sum(case when s.fdat=c.cdat then s.kos else 0 end) as today_kos
      from saldob s, iot_calendar c
     where s.fdat >= c.cdat
     group by c.cdat, s.acc
  )
select    -- дата предыдущего движения относительно отчетной
          case
              when a.dapp2 < a.bdat then a.dapp2
              else                       s.pdat
          end as dapp,
          -- дата предыдущей переоценки относительно отчетной
          case
              when a.dappq2 < a.bdat then a.dappq2
              else                       q.pdat
          end as dappq,
          a.accc,
          a.acc,
          a.nls,
          a.kv,
          a.nms,
          a.grp,
          -- отчетная дата
          a.bdat as fdat,
          -- входящий остаток на отчетную дату
          case
              when a.dapp2 < a.bdat then a.ostc
              when a.dapp2 = a.bdat then a.ostc - (a.kos - a.dos)
              else                       a.ostc - nvl(s.sum_kos - s.sum_dos, 0)
          end as ostf,
          -- дебетовые обороты на отчетную дату
          case
              when a.dapp2 < a.bdat then 0
              when a.dapp2 = a.bdat then a.dos
              else                       nvl(s.today_dos, 0)
          end as dos,
          -- кредитовые обороты на отчетную дату
          case
              when a.dapp2 < a.bdat then 0
              when a.dapp2 = a.bdat then a.kos
              else                       nvl(s.today_kos, 0)
          end as kos,
          -- исходящий остаток на отчетную дату
          case
              when a.dapp2 <= a.bdat then a.ostc
              else       a.ostc
			 - nvl(
                              (s.sum_kos - s.sum_dos)
                              -
                              (s.today_kos - s.today_dos),
                              0
                          )
          end as ost,
          -- входящий эквивалент на отчетную дату
          case
              when a.dappq2 < a.bdat then a.ostq
              when a.dappq2 = a.bdat then a.ostq - (a.kosq - a.dosq)
              else                        a.ostq - nvl(q.sum_kos - q.sum_dos, 0)
          end as ostfq,
          -- дебетовые обороты на отчетную дату
          case
              when a.dappq2 < a.bdat then 0
              when a.dappq2 = a.bdat then a.dosq
              else                       nvl(q.today_dos, 0)
          end as dosq,
          -- кредитовые обороты на отчетную дату
          case
              when a.dappq2 < a.bdat then 0
              when a.dappq2 = a.bdat then a.kosq
              else                       nvl(q.today_kos, 0)
          end as kosq,
          -- исходящий эквивалент на отчетную дату
          case
              when a.dappq2 <= a.bdat then a.ostq
              else      a.ostq
                        - nvl(
                              (q.sum_kos - q.sum_dos)
                            -
                              (q.today_kos - q.today_dos),
                              0
                          )
          end as ostq,
          a.nbs,
          a.isp,
          a.nlsalt,
          a.dazs,
          a.mdate,
          case
              when a.dapp2 <= a.bdat then a.dapp2
              else
                  case
                      when s.bdat = s.fdat then s.fdat
                      else                      s.pdat
                  end
          end as app,   -- дата последнего движения относительно отчетной
          case
              when a.dappq2 <= a.bdat then a.dappq2
              else
                  case
                      when q.bdat = q.fdat then q.fdat
                      else                      q.pdat
                  end
          end as appq,   -- дата последней переоценки относительно отчетной
          a.tip,
          a.daos,
          a.pap,
          a.rnk
          ,a.tobo
          ,a.branch
          ,a.kf
          ,a.ob22
     from a, s, q
    where a.acc = s.acc(+)
      and a.bdat = s.bdat(+)
      and a.acc = q.acc(+)
      and a.bdat = q.bdat(+)
);

PROMPT *** Create  grants  SALNQC ***
grant SELECT                                                                 on SALNQC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALNQC          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALNQC.sql =========*** End *** =======
PROMPT ===================================================================================== 
