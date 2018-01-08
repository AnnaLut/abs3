

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_ZV4.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_ZV4 ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_ZV4 ("IDZ", "DAT1", "SOS", "BRANCH", "KODV", "KV", "DAT2", "IDU", "KOL", "REFA", "REFB") AS 
  select idz,
       to_char(DAT1,'dd/mm/yyyy hh24:mi:ss') dat1,
       SOS,BRANCH,kodv,KV,
       to_char(DAT2,'dd/mm/yyyy') DAT2,
       idu,kol,REFa,refb
from KAS_Z where vid=4 and sos=0;

PROMPT *** Create  grants  KAS_ZV4 ***
grant SELECT                                                                 on KAS_ZV4         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_ZV4         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_ZV4         to PYOD001;
grant SELECT                                                                 on KAS_ZV4         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_ZV4.sql =========*** End *** ======
PROMPT ===================================================================================== 
