

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALROW.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view SALROW ***

  CREATE OR REPLACE FORCE VIEW BARS.SALROW ("DAPP", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTF", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "APP", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  with
a as
  ( select a.*, nvl(a.dapp, a.daos) dapp2, c.cdat as bdat
      from accounts a, iot_calendar c
  )
select    -- ���� ����������� �������� ������������ ��������
          case
              when a.dapp2 < a.bdat then a.dapp2
              else                       (select min(pdat) keep (dense_rank first order by fdat) as pdat
                                            from saldoa
                                           where acc = a.acc
                                             and fdat >= a.bdat
                                         )
          end as dapp,
          a.accc,
          a.acc,
          a.nls,
          a.kv,
          a.nms,
          a.grp,
          -- �������� ����
          a.bdat as fdat,
          -- �������� ������� �� �������� ����
          case
              when a.dapp2 < a.bdat then a.ostc
              when a.dapp2 = a.bdat then a.ostc - (a.kos - a.dos)
              else                       a.ostc - (select sum(kos-dos)
                                                     from saldoa
                                                    where acc = a.acc
                                                      and fdat >= a.bdat
                                                   )
          end as ostf,
          -- ��������� ������� �� �������� ����
          case
              when a.dapp2 < a.bdat then 0
              when a.dapp2 = a.bdat then a.dos
              else                       (select nvl(min(dos),0)
                                            from saldoa
                                           where acc = a.acc
                                             and fdat = a.bdat
                                         )
          end as dos,
          -- ���������� ������� �� �������� ����
          case
              when a.dapp2 < a.bdat then 0
              when a.dapp2 = a.bdat then a.kos
              else                       (select nvl(min(kos),0)
                                            from saldoa
                                           where acc = a.acc
                                             and fdat = a.bdat
                                         )
          end as kos,
          -- ��������� ������� �� �������� ����
          case
              when a.dapp2 <= a.bdat then a.ostc
              else                        a.ostc - (select sum(kos-dos)
                                                      from saldoa
                                                     where acc = a.acc
                                                       and fdat > a.bdat
                                                   )
          end as ost,
          a.nbs,
          a.isp,
          a.nlsalt,
          a.dazs,
          case
              when a.dapp2 <= a.bdat then a.dapp2
              else (select min(pdat) keep (dense_rank first order by fdat) as pdat
                      from saldoa
                     where acc = a.acc
                       and fdat > a.bdat
                   )
          end as app,   -- ���� ���������� �������� ������������ ��������
          a.tip,
          a.daos,
          a.pap,
          a.rnk
          ,a.tobo
          ,a.branch
          ,a.kf
     from a;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALROW.sql =========*** End *** =======
PROMPT ===================================================================================== 
