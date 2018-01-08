

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC_KLIENT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC_KLIENT ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC_KLIENT ("ACC", "RNK", "COUNTRY", "NMK", "PRINSIDER", "OKPO") AS 
  select u.acc, u.rnk, c.COUNTRY  , c.NMK       ,c.PRINSIDER ,     c.OKPO
from cust_acc u, customer c
where u.rnk=c.rnk;

PROMPT *** Create  grants  ACC_KLIENT ***
grant SELECT                                                                 on ACC_KLIENT      to BARSREADER_ROLE;
grant SELECT                                                                 on ACC_KLIENT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_KLIENT      to START1;
grant SELECT                                                                 on ACC_KLIENT      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC_KLIENT.sql =========*** End *** ===
PROMPT ===================================================================================== 
