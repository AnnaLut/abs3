

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NADA8.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view NADA8 ***

  CREATE OR REPLACE FORCE VIEW BARS.NADA8 ("DAT1", "DAT2", "BRANCH", "PROD", "KV", "NLS", "CC_ID", "ND", "ID1", "ID2", "SPOK", "FIN", "OBS", "NMK", "OST", "ZN50", "MFO_OLD", "FINS", "S6020", "S6040", "S6111", "S6110", "S6113", "S6114", "S6116", "S6118", "S6119", "S6397", "S6399", "ACC", "OSTQS") AS 
  SELECT "DAT1",
          "DAT2",
          "BRANCH",
          "PROD",
          "KV",
          "NLS",
          "CC_ID",
          "ND",
          "ID1",
          "ID2",
          "SPOK",
          "FIN",
          "OBS",
          "NMK",
          "OST",
          "ZN50",
          "MFO_OLD",
          "FINS",
          "S6020",
          "S6040",
          "S6111",
          "S6110",
          "S6113",
          "S6114",
          "S6116",
          "S6118",
          "S6119",
          "S6397",
          "S6399",
          "ACC",
          "OSTQS"
     FROM tmp_nada8;

PROMPT *** Create  grants  NADA8 ***
grant SELECT                                                                 on NADA8           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NADA8           to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NADA8.sql =========*** End *** ========
PROMPT ===================================================================================== 
