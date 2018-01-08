

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_4010.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_DFM02_4010 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_DFM02_4010 ("REF") AS 
  select o.ref
  from oper o, opldok p, accounts a, customer c
 where o.ref = p.ref
-- �������-��
   and c.custtype = 2
-- ���� ���. � ������������� �� ��������� 3� �������
   and c.datea between add_months(bankdate_g, -3) and bankdate_g
-- ����� ������� 26%
   and c.rnk = a.rnk and a.nls like '26%'
-- ������� �� ������� (����������) �� ��������� 3 ������
   and a.acc = p.acc and p.dk = 1 and p.fdat >= add_months(bankdate_g, -3)
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_DFM02_4010 ***
grant SELECT                                                                 on V_FM_DFM02_4010 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_DFM02_4010 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_4010.sql =========*** End **
PROMPT ===================================================================================== 
