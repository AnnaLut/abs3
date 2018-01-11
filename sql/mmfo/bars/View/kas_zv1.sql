

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_ZV1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_ZV1 ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_ZV1 ("IDZ", "DAT1", "SOS", "BRANCH", "KV", "DAT2", "IDU", "S", "REFA", "REFB") AS 
  SELECT idz, TO_CHAR (dat1, 'dd/mm/yyyy hh24:mi:ss') dat1, sos, branch, kv,
          TO_CHAR (dat2, 'dd/mm/yyyy') dat2, idu, s, refa, refb
     FROM kas_z
    WHERE vid = 1 AND kv NOT IN (961, 959, 962, 960) AND sos = 0;

PROMPT *** Create  grants  KAS_ZV1 ***
grant SELECT                                                                 on KAS_ZV1         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_ZV1         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_ZV1         to PYOD001;
grant SELECT                                                                 on KAS_ZV1         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_ZV1.sql =========*** End *** ======
PROMPT ===================================================================================== 
