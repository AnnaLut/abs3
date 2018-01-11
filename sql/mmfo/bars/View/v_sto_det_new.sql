

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_DET_NEW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_DET_NEW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_DET_NEW ("IDD", "DAT1", "DAT2", "FREQ", "NLSA", "KVA", "NLSB", "KVB", "MFOB", "POLU", "NAZN", "FSUM", "OKPO", "WEND", "BRANCH_MADE", "BRANCH_CARD", "USERID_MADE", "STATUS_ID", "DISCLAIM_ID") AS 
  SELECT s.IDD,
       s.DAT1,
       s.DAT2,
       F.NAME "FREQ",
       s.NLSA,
       s.KVA,
       s.NLSB,
       s.KVB,
       s.MFOB,
       s.POLU,
       s.NAZN,
       s.FSUM,
       s.OKPO,
       s.WEND,
       s.BRANCH_MADE,
       s.BRANCH_CARD,
       s.USERID_MADE,
       s.STATUS_ID,
       s.DISCLAIM_ID
      FROM sto_det s, freq f
     WHERE s.status_id = 0
       and f.freq = s.freq;

PROMPT *** Create  grants  V_STO_DET_NEW ***
grant SELECT                                                                 on V_STO_DET_NEW   to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_STO_DET_NEW   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STO_DET_NEW   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_DET_NEW.sql =========*** End *** 
PROMPT ===================================================================================== 
