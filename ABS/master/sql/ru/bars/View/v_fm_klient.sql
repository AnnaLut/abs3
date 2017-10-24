

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_KLIENT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_KLIENT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_KLIENT ("RNK", "NMK", "CUSTTYPE", "KOD", "DAT") AS 
  select c.rnk, c.nmk, c.custtype, k.kod, k.dat
  from fm_klient k, customer c
 where k.rnk = c.rnk;

PROMPT *** Create  grants  V_FM_KLIENT ***
grant SELECT                                                                 on V_FM_KLIENT     to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_KLIENT.sql =========*** End *** ==
PROMPT ===================================================================================== 
