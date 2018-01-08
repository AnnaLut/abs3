

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_TURNOVERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_TURNOVERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_TURNOVERS ("ID", "ACC_ID", "STATE", "TRANSACTION_TYPE", "DOCUMENT_ID", "DOCUMENT_NUMBER", "DEBIT", "KREDIT", "PURPOSE", "TURNOVER_DATE", "CORESPONDETN_BANK_ID", "CORESPONDENT_ACC_NUMBER", "CORESPONDENT_CURRENCY_ID", "CORESPONDENT_NAME", "CORESPONDENT_CODE", "CREATED_DATE", "PAYED_DATE") AS 
  SELECT op.STMT AS ID,
          op.ACC AS ACC_ID,
          op.SOS AS STATE,
          op.TT AS Transaction_Type,
          op.REF AS DOCUMENT_ID,
          op.ND AS DOCUMENT_NUMBER,
          op.DOS * 100 AS DEBIT,
          op.KOS * 100 AS KREDIT,
          op.COMM AS PURPOSE,
          op.FDAT AS TURNOVER_DATE,
          case when dkp = 0 then  CASE WHEN op.DK = 1  THEN op.MFOB ELSE op.mfoa END
                             else CASE WHEN op.DK = 0  THEN op.MFOB ELSE op.mfoa END
          end  AS CORESPONDETN_BANK_ID,
          case when dkp = 0 then CASE WHEN op.DK = 1 THEN op.NLSB ELSE op.nlsa END
                            else CASE WHEN op.DK = 0 THEN op.NLSB ELSE op.nlsa END
          end  AS CORESPONDENT_ACC_NUMBER,
          case when dkp = 0 then CASE WHEN op.DK = 1 THEN op.KV2 ELSE op.kv END
                            else CASE WHEN op.DK = 0 THEN op.KV2 ELSE op.kv END
          end  AS CORESPONDENT_CURRENCY_ID,
          case when dkp = 0 then CASE WHEN op.DK = 1 THEN op.NAM_B ELSE op.nam_a END
                            else CASE WHEN op.DK = 0 THEN op.NAM_B ELSE op.nam_a END
          end  AS CORESPONDENT_NAME,
          case when dkp = 0 then CASE WHEN op.DK = 1 THEN op.idb ELSE op.ida END
                            else CASE WHEN op.DK = 0 THEN op.idb ELSE op.ida END
          end  AS CORESPONDENT_CODE,
          OP.PDAT AS CREATED_DATE,
          OP.PDAT AS PAYED_DATE
     FROM V_ACCT_STATEMENTS op
     where op.sos = 5;

PROMPT *** Create  grants  V_MBM_TURNOVERS ***
grant SELECT                                                                 on V_MBM_TURNOVERS to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBM_TURNOVERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBM_TURNOVERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_TURNOVERS.sql =========*** End **
PROMPT ===================================================================================== 
