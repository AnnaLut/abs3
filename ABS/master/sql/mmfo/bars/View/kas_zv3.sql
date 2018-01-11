

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_ZV3.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_ZV3 ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_ZV3 ("IDZ", "DAT1", "SOS", "BRANCH", "KODV", "KV", "DAT2", "IDU", "KOL", "REFA", "REFB") AS 
  SELECT idz, TO_CHAR (dat1, 'dd/mm/yyyy hh24:mi:ss') dat1, sos, branch,
          kodv, kv, TO_CHAR (dat2, 'dd/mm/yyyy') dat2, idu, kol, refa, refb
     FROM kas_z
    WHERE vid = 3 AND sos = 0;

PROMPT *** Create  grants  KAS_ZV3 ***
grant SELECT                                                                 on KAS_ZV3         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_ZV3         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_ZV3         to PYOD001;
grant SELECT                                                                 on KAS_ZV3         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_ZV3.sql =========*** End *** ======
PROMPT ===================================================================================== 
