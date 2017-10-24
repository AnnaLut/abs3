

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALNC.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view SALNC ***

  CREATE OR REPLACE FORCE VIEW BARS.SALNC ("DAPP", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTF", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "APP", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  with
a as
  ( select a.*, nvl(a.dapp, a.daos) dapp2, c.cdat as bdat
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
      from saldoa s, iot_calendar c
     where s.fdat >= c.cdat
     group by c.cdat, s.acc
  )
select    -- дата предыдущего движения относительно отчетной
          case
              when a.dapp2 < a.bdat then a.dapp2
              else                       s.pdat
          end as dapp,
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
              else                       a.ostc - (s.sum_kos - s.sum_dos)
          end as ostf,
          -- дебетовые обороты на отчетную дату
          case
              when a.dapp2 < a.bdat then 0
              when a.dapp2 = a.bdat then a.dos
              else                       s.today_dos
          end as dos,
          -- кредитовые обороты на отчетную дату
          case
              when a.dapp2 < a.bdat then 0
              when a.dapp2 = a.bdat then a.kos
              else                       s.today_kos
          end as kos,
          -- исходящий остаток на отчетную дату
          case
              when a.dapp2 <= a.bdat then a.ostc
              else                        a.ostc - (s.sum_kos - s.sum_dos) + (s.today_kos - s.today_dos)
          end as ost,
          a.nbs,
          a.isp,
          a.nlsalt,
          a.dazs,
          case
              when a.dapp2 <= a.bdat then a.dapp2
              else
                  case
                      when s.bdat = s.fdat then s.fdat
                      else                      s.pdat
                  end
          end as app,   -- дата последнего движения относительно отчетной
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

PROMPT *** Create  grants  SALNC ***
grant SELECT                                                                 on SALNC           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALNC           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALNC.sql =========*** End *** ========
PROMPT ===================================================================================== 
