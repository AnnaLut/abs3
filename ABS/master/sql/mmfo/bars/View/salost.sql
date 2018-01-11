

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALOST.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view SALOST ***

  CREATE OR REPLACE FORCE VIEW BARS.SALOST ("ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OST", "NBS", "ISP", "NLSALT", "DAZS", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  with
a as
  ( select a.*, nvl(a.dapp, a.daos) dapp2, c.cdat as bdat
      from accounts a, iot_calendar c
  ),
s as
  ( select c.cdat as bdat,
           s.acc,
           sum(s.kos-s.dos) as turnover
      from saldoa s, iot_calendar c
     where s.fdat > c.cdat
     group by c.cdat, s.acc
  )
select    a.accc,
          a.acc,
          a.nls,
          a.kv,
          a.nms,
          a.grp,
          -- отчетная дата
          a.bdat as fdat,
          -- исходящий остаток на отчетную дату
          case
              when a.dapp2 <= a.bdat then a.ostc
              else                        a.ostc - s.turnover
          end as ost,
          a.nbs,
          a.isp,
          a.nlsalt,
          a.dazs,
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

PROMPT *** Create  grants  SALOST ***
grant SELECT                                                                 on SALOST          to BARSREADER_ROLE;
grant SELECT                                                                 on SALOST          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALOST          to START1;
grant SELECT                                                                 on SALOST          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALOST.sql =========*** End *** =======
PROMPT ===================================================================================== 
