

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NRU_NLS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NRU_NLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NRU_NLS ("BUSSL", "BUS", "BLKD", "BLK", "RNK", "OKPO", "NMK", "ADR", "TEL", "NLS", "KV", "DAPP", "OST", "KOL", "ZDAT", "ACC", "NBS", "BRANCH", "PRIM", "OK", "SERR") AS 
  select x.bussl,
          substr ( (select name from cust_business_line where id = x.bussl), 1, 25 ) as bus,
          x.blkd,
          substr ( (select name from rang where rang = x.blkd), 1, 25 ) as blk,
          x.rnk,
          x.okpo,
          x.nmk,
          x.adr,
          x.tel,
          x.nls,
          x.kv,
          x.dapp,
          x.ost,
          x.kol,
          x.zdat,
          x.acc,
          x.nbs,
          x.branch,
          case
             when x.blkd > 0
             then
                '���������, ��������� ��������� �������� �������'
             when x.kol > 0
             then
                '���`����, ��������� ��������� �������� �������'
             when x.nbs in ('2605', '2604')
             then
                '2605/2604, ��������� ��������� �������� �������'
             else
                null -- � ��� �������� ����������� ����������� ����������� ������, ��������� ��������� �������� �������,
          end
             prim, -- ���� ������ �������� ����������, ���������� �� ������� ��� ���������� ������� � 2605, 2604.
          x.accn / x.accn as ok,
          x.serr
     -- �������� ����������� �� "������̲"
     from (select a.acc,
                  d.zdat, -- 00 ����� ����
                  n.serr,
                  n.acc as accn,
                  to_number ( (select value from customerw where rnk = c.rnk and tag = 'BUSSL')) bussl, -- 01 ������ ��������
                  c.rnk, -- 02 ���
                  c.okpo, -- 03 ������/���
                  c.nmk, -- 04 �����
                  c.adr, -- 05 ������ �볺���
                  p.telr || ',' || p.telb tel, -- 06 �������� �������� �볺���
                  a.nls, -- 07 � �������
                  a.nbs,
                  a.branch,
                  a.kv, -- 08 ���
                  nvl (a.dapp, a.daos) as dapp, -- 09 ���� �����.����
                  fost (a.acc, d.zdat) / 100 as ost, -- 10 ��� �� ����
                  decode (a.blkd, 0, null, a.blkd) as blkd, -- 11 ������/�������� �������� ���������� ��������� �������
                  (select count (*) - 1 from accounts where rnk = c.rnk and dazs is null and nbs > '2' and nbs < '4') as kol -- 12 ��������  ��������� ������� �� ��������� �������
             from accounts a,
                  nru_bal b,
                  customer c,
                  corps p,
                  nru_ok n,
                  (select to_date (pul.get ('DAT'), 'dd.mm.yyyy') zdat from dual) d
            where     c.rnk = a.rnk
                  and a.nbs = b.nbs
                  and a.ob22 = decode (a.nbs, '2650', b.ob22, a.ob22)
                  and a.dazs is null
                  and c.rnk = p.rnk(+)
                  and nvl (a.dapp, a.daos) <= add_months (d.zdat, -36)
                  and a.acc = n.acc(+)) x;

PROMPT *** Create  grants  V_NRU_NLS ***
grant SELECT                                                                 on V_NRU_NLS       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NRU_NLS.sql =========*** End *** ====
PROMPT ===================================================================================== 
