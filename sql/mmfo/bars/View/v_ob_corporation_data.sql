

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB_CORPORATION_DATA.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB_CORPORATION_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB_CORPORATION_DATA ("ROWTYPE", "OURMFO", "NLS", "KV", "OKPO", "OBDB", "OBDBQ", "OBKR", "OBKRQ", "OST", "OSTQ", "KOD_CORP", "KOD_USTAN", "KOD_ANALYT", "DAPP", "POSTDAT", "DOCDAT", "VALDAT", "ND", "VOB", "DK", "MFOA", "NLSA", "KVA", "NAMA", "OKPOA", "MFOB", "NLSB", "KVB", "NAMB", "OKPOB", "S", "DOCKV", "SQ", "NAZN", "DOCTYPE", "POSTTIME", "NAMK", "NMS", "TT", "SESSION_ID") AS 
  SELECT corpd.ROWTYPE as rowtype,
            corpd.kf as ourmfo,
            corpd.NLS as nls,
            tab1.name as kv,
            corpd.OKPO as okpo,
            corpd.OBDB as obdb,
            corpd.OBDBQ as obdbq,
            corpd.OBKR as obkr,
            corpd.OBKRQ as obkrq,
            corpd.OST as ost,
            corpd.OSTQ as ostq,
            corpd.KOD_CORP as kod_corp,
            corpd.KOD_USTAN as kod_ustan,
            corpd.KOD_ANALYT as kod_analyt,
            corpd.DAPP as dapp,
            corpd.POSTDAT as postdat,
            corpd.DOCDAT as docdat,
            corpd.VALDAT as valdat,
            corpd.ND as nd,
            corpd.VOB as vob,
            corpd.DK as dk,
            corpd.MFOA as mfoa,
            corpd.NLSA as nlsa,
            corpd.KVA as kva,
            corpd.NAMA as nama,
            corpd.OKPOA as okpoa,
            corpd.MFOB as mfob,
            corpd.NLSB as nlsb,
            corpd.KVB as kvb,
            corpd.NAMB as namb,
            corpd.OKPOB as okpob,
            corpd.S as s,
            tab2.name as dockv,
            corpd.SQ as sq,
            corpd.NAZN as nazn,
            corpd.DOCTYPE as doctype,
            corpd.POSTTIME as posttime,
            corpd.NAMK as namk,
            corpd.NMS as nms,
            corpd.TT as tt,
            corpd.SESSION_ID as session_id
     FROM BARS.ob_corporation_data corpd, tabval tab1, tabval tab2
     where corpd.kv = tab1.kv and corpd.dockv = tab2.kv;

PROMPT *** Create  grants  V_OB_CORPORATION_DATA ***
grant SELECT                                                                 on V_OB_CORPORATION_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on V_OB_CORPORATION_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB_CORPORATION_DATA to CORP_CLIENT;
grant SELECT                                                                 on V_OB_CORPORATION_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB_CORPORATION_DATA.sql =========*** 
PROMPT ===================================================================================== 
