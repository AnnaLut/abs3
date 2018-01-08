

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_DET.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_DET ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_DET ("IDS", "IDD", "STATUS_ID", "DISCLAIM_ID", "STATUS_DATE", "STATUS_UID", "ORD", "TT", "DAT1", "DAT2", "FREQ", "NLSA", "KVA", "NLSB", "KVB", "MFOB", "POLU", "NAZN", "FSUM", "OKPO", "DAT0", "WEND", "BRANCH", "BRANCH_MADE", "DATETIMESTAMP", "BRANCH_CARD", "USERID_MADE") AS 
  SELECT  IDS, IDD,
        (select name from sto_status where s.status_id = id) as STATUS_ID,
        (select name from sto_disclaimer where s.disclaim_id = id) as DISCLAIM_ID,
        STATUS_DATE,
        (select FIO from staff$base where id = s.STATUS_UID) as STATUS_UID,
        ORD,
        TT,
        DAT1,
        DAT2,
        F.NAME AS FREQ,
        NLSA,
        KVA,
        NLSB,
        KVB,
        MFOB,
        POLU,
        NAZN,
        FSUM,
        OKPO,
        DAT0,
        WEND,
        BRANCH,
        BRANCH_MADE,
        DATETIMESTAMP,
        BRANCH_CARD,
        (select FIO from staff$base where id = s.USERID_MADE) as USERID_MADE
      FROM sto_det s, freq f
     WHERE  f.freq = s.freq;

PROMPT *** Create  grants  V_STO_DET ***
grant SELECT                                                                 on V_STO_DET       to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_STO_DET       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STO_DET       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_DET.sql =========*** End *** ====
PROMPT ===================================================================================== 
