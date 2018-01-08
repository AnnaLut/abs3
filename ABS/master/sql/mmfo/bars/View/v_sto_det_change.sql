

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_DET_CHANGE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_DET_CHANGE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_DET_CHANGE ("IDD", "DAT0", "DAT1", "DAT2", "FREQ", "NLSA", "KVA", "NLSB", "KVB", "MFOB", "POLU", "NAZN", "FSUM", "OKPO", "WEND", "BRANCH_MADE", "BRANCH_CARD", "USERID_MADE", "STATUS_ID", "DISCLAIM_ID") AS 
  SELECT s.IDD,
       s.DAT0,
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
     WHERE  f.freq = s.freq
       AND s.DAT2 >= trunc(sysdate);

PROMPT *** Create  grants  V_STO_DET_CHANGE ***
grant SELECT                                                                 on V_STO_DET_CHANGE to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_STO_DET_CHANGE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STO_DET_CHANGE to UPLD;
grant FLASHBACK,SELECT                                                       on V_STO_DET_CHANGE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_DET_CHANGE.sql =========*** End *
PROMPT ===================================================================================== 
