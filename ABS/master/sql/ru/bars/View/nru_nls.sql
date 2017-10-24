

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NRU_NLS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view NRU_NLS ***

  CREATE OR REPLACE FORCE VIEW BARS.NRU_NLS ("BUSSL", "BUS", "BLKD", "BLK", "RNK", "OKPO", "NMK", "ADR", "TEL", "NLS", "KV", "DAPP", "OST", "KOL", "ZDAT", "ACC", "NBS", "BRANCH", "PRIM", "OK", "SERR") AS 
  SELECT x.BUSSL, Substr( (select name from CUST_BUSINESS_LINE where id   = x.BUSSL),1, 25)  BUS,
       x.blkd , Substr( (select name from RaNG               where rang = x.blkd ),1, 25)  BLK,
       x.RNK  , x.okpo, x.nmk, x.adr, x.tel, x.nls, x.kv, x.dapp, x.ost, x.kol, x.zdat, x.acc , x.NBS, x.branch,
       CASE WHEN x.blkd > 0                THEN '���������, ��������� ��������� �������� �������'
            WHEN x.kol > 0                 THEN '���`����, ��������� ��������� �������� �������'
            WHEN x.nbs in ('2605', '2604') THEN '2605/2604, ��������� ��������� �������� �������'
       else null  -- � ��� �������� ����������� ����������� ����������� ������, ��������� ��������� �������� �������,
       end  PRIM, -- ���� ������ �������� ����������, ���������� �� ������� ��� ���������� ������� � 2605, 2604.
       x.accn/x.accn OK, x.serr
-- �������� ����������� �� "������̲"
FROM (select a.acc, d.zdat , n.serr ,  n.acc accn,               -- 00 ����� ����
         to_number((select value from customerW where rnk=c.rnk and tag='BUSSL')) BUSSL,               -- 01 ������ ��������
         c.RNK, c.okpo, c.nmk, c.adr, p. telr ||','||p.telb tel,        -- 02 ���   03 ������/���      -- 04 �����  -- 05 ������ �볺���  -- 06 �������� �������� �볺���
         a.nls,  a.nbs, a.branch,  a.kv,  nvl(a.dapp, a.daos) dapp,     -- 07 � �������                -- 08 ���    -- 09 ���� �����.����
         fost(a.acc,d.zdat)/100 ost, decode(a.blkd,0,null,a.blkd) blkd, -- 10 ��� �� ����              -- 11 ������/�������� �������� ���������� ��������� �������
        (select count(*)-1 from accounts where rnk=c.rnk and dazs is null and nbs>'2' and nbs<'4') kol -- 12 ��������  ��������� ������� �� ��������� �������
      from accounts a, nru_bal b , customer c, corps p, NRU_ok n,
          (select to_date(pul.get('DAT'), 'dd.mm.yyyy') zdat  from dual) d
      where c.rnk = a.rnk and a.nbs = B.NBS and a.ob22 = decode (a.nbs, '2650', b.ob22, a.ob22) and a.dazs is null
        and c.rnk = p.rnk (+) and nvl(a.dapp, a.daos) <= add_months ( d.zdat, - 36 )
        and a.acc = n.acc (+)
      ) x ;

PROMPT *** Create  grants  NRU_NLS ***
grant SELECT                                                                 on NRU_NLS         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NRU_NLS.sql =========*** End *** ======
PROMPT ===================================================================================== 
