

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX_DEAL_DOCUMENTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX_DEAL_DOCUMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_DEAL_DOCUMENTS ("REF", "TT", "USERID", "ND", "NLSA", "S", "KV", "PDAT", "S2", "KV2", "MFOB", "NLSB", "DK", "DATD", "NAZN", "BRANCH", "ID_A", "NAM_A", "ID_B", "NAM_B", "DEAL_TAG", "SOS") AS 
  SELECT o.REF,
            o.tt,
            o.userid,
            o.nd,
            o.nlsa,
            o.s/100,
            o.kv,
            o.pdat,
            o.s2/100,
            o.kv2,
            o.mfob,
            o.nlsb,
            o.dk,
            o.datd,
            o.nazn,
            o.branch,
            o.id_a,
            o.nam_a,
            o.id_b,
            o.nam_b,
            fx.deal_tag,
            o.sos
       FROM oper o JOIN fx_deal_ref fx ON o.REF = fx.REF
   ORDER BY REF DESC;

PROMPT *** Create  grants  V_FOREX_DEAL_DOCUMENTS ***
grant SELECT                                                                 on V_FOREX_DEAL_DOCUMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_FOREX_DEAL_DOCUMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FOREX_DEAL_DOCUMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX_DEAL_DOCUMENTS.sql =========***
PROMPT ===================================================================================== 
