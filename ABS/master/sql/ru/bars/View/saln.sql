

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALN.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view SALN ***

  CREATE OR REPLACE FORCE VIEW BARS.SALN ("DAPP", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTF", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "APP", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  with
a as
  ( select a.*, nvl(a.dapp, a.daos) dapp2, b.fdat as bdat
      from accounts a, fdat b
  ),
s as
  ( select b.fdat as bdat,
           s.acc,
           min(s.fdat) as fdat,
           min(s.pdat) keep (dense_rank first order by s.fdat) as pdat,
           sum(s.dos) as sum_dos,
           sum(s.kos) as sum_kos,
           sum(case when s.fdat=b.fdat then s.dos else 0 end) as today_dos,
           sum(case when s.fdat=b.fdat then s.kos else 0 end) as today_kos
      from saldoa s, fdat b
     where s.fdat >= b.fdat
     group by b.fdat, s.acc
  )
select    -- ���� ����������� �������� ������������ ��������
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
          -- �������� ����
          a.bdat as fdat,
          -- �������� ������� �� �������� ����
          case
              when a.dapp2 < a.bdat then a.ostc
              when a.dapp2 = a.bdat then a.ostc - (a.kos - a.dos)
              else                       a.ostc - (s.sum_kos - s.sum_dos)
          end as ostf,
          -- ��������� ������� �� �������� ����
          case
              when a.dapp2 < a.bdat then 0
              when a.dapp2 = a.bdat then a.dos
              else                       s.today_dos
          end as dos,
          -- ���������� ������� �� �������� ����
          case
              when a.dapp2 < a.bdat then 0
              when a.dapp2 = a.bdat then a.kos
              else                       s.today_kos
          end as kos,
          -- ��������� ������� �� �������� ����
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
          end as app,   -- ���� ���������� �������� ������������ ��������
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



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALN.sql =========*** End *** =========
PROMPT ===================================================================================== 
