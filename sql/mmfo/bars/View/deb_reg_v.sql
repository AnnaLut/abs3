

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DEB_REG_V.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view DEB_REG_V ***

  CREATE OR REPLACE FORCE VIEW BARS.DEB_REG_V ("OKPO", "NMK", "ADR", "CUSTTYPE", "PRINSIDER", "KV", "CRDAGRNUM", "CRDDATE", "SUM", "DEBDATE") AS 
  select
 c.okpo, c.nmk, c.ADR, c.CUSTTYPE, c.PRINSIDER,
 a.kv,   a.nls,      a.daos,     -a.ostc ,   a.mdate
from customer c, cust_acc cu, accounts a, proc_dr p
where c.rnk=cu.rnk and cu.acc=a.acc and a.mdate<bankdate and
a.ostc <0 and a.nbs=p.nbs and p.nbsn is not null;

PROMPT *** Create  grants  DEB_REG_V ***
grant SELECT                                                                 on DEB_REG_V       to BARSREADER_ROLE;
grant SELECT                                                                 on DEB_REG_V       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEB_REG_V       to START1;
grant SELECT                                                                 on DEB_REG_V       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DEB_REG_V.sql =========*** End *** ====
PROMPT ===================================================================================== 
