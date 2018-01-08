

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALQC.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view SALQC ***

  CREATE OR REPLACE FORCE VIEW BARS.SALQC ("DAPPQ", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTFQ", "DOSQ", "KOSQ", "OSTQ", "NBS", "ISP", "NLSALT", "DAZS", "APPQ", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  with
a as
  ( select a.*, nvl(a.dappq, a.daos) dappq2, c.cdat as bdat
      from accounts a, iot_calendar c
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
      from saldob s, iot_calendar c
     where s.fdat >= c.cdat
     group by c.cdat, s.acc
  )
select    -- дата предыдущей переоценки относительно отчетной
          case
              when a.dappq2 < a.bdat then a.dappq2
              else                       s.pdat
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
              when a.dappq2 < a.bdat then a.ostq
              when a.dappq2 = a.bdat then a.ostq - (a.kosq - a.dosq)
              else                       a.ostq - (s.sum_kos - s.sum_dos)
          end as ostfq,
          -- дебетовые обороты на отчетную дату
          case
              when a.dappq2 < a.bdat then 0
              when a.dappq2 = a.bdat then a.dosq
              else                       s.today_dos
          end as dosq,
          -- кредитовые обороты на отчетную дату
          case
              when a.dappq2 < a.bdat then 0
              when a.dappq2 = a.bdat then a.kosq
              else                       s.today_kos
          end as kosq,
          -- исходящий остаток на отчетную дату
          case
              when a.dappq2 <= a.bdat then a.ostq
              else                        a.ostq - (s.sum_kos - s.sum_dos) + (s.today_kos - s.today_dos)
          end as ostq,
          a.nbs,
          a.isp,
          a.nlsalt,
          a.dazs,
          case
              when a.dappq2 <= a.bdat then a.dappq2
              else
                  case
                      when s.bdat = s.fdat then s.fdat
                      else                      s.pdat
                  end
          end as appq,   -- дата последней переоценки относительно отчетной
          a.tip,
          a.daos,
          a.pap,
          a.rnk
          ,a.tobo
          ,a.branch
          ,a.kf
     from a, s
    where a.acc = s.acc(+)
      and a.bdat = s.bdat(+);

PROMPT *** Create  grants  SALQC ***
grant SELECT                                                                 on SALQC           to BARSREADER_ROLE;
grant SELECT                                                                 on SALQC           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALQC           to START1;
grant SELECT                                                                 on SALQC           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALQC.sql =========*** End *** ========
PROMPT ===================================================================================== 
