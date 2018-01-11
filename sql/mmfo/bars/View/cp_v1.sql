

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V1 ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V1 ("BAL_VAR", "SOS", "ND", "DATD", "SUMB", "DAZS", "TIP", "REF", "ID", "CP_ID", "MDATE", "IR", "ERAT", "RYN", "VIDD", "KV", "ACC", "ACCD", "ACCP", "ACCR", "ACCR2", "ACCR3", "ACCUNREC", "ACCS", "OSTA", "OSTD", "OSTP", "OSTR", "OSTR2", "OSTR3", "OSTUNREC", "OSTEXPN", "OSTEXPR", "OSTS", "OSTAB", "OSTAF", "EMI", "DOX", "RNK", "PF", "PFNAME", "DAPP", "DATP", "OST_2VD", "OST_2VP", "ZAL", "COUNTRY") AS 
  SELECT "BAL_VAR",
          "SOS",
          "ND",
          "DATD",
          "SUMB",
          "DAZS",
          "TIP",
          "REF",
          "ID",
          "CP_ID",
          "MDATE",
          "IR",
          "ERAT",
          "RYN",
          "VIDD",
          "KV",
          "ACC",
          "ACCD",
          "ACCP",
          "ACCR",
          "ACCR2",
          "ACCR3",
          "ACCUNREC",
          "ACCS",
          "OSTA",
          "OSTD",
          "OSTP",
          "OSTR",
          "OSTR2",
          "OSTR3",
          "OSTUNREC",
          "OSTEXPN",
          "OSTEXPR",
          "OSTS",
          "OSTAB",
          "OSTAF",
          "EMI",
          "DOX",
          "RNK",
          "PF",
          "PFNAME",
          "DAPP",
          "DATP",
          "OST_2VD",
          "OST_2VP",
          "ZAL",
          "COUNTRY"
     FROM bars.cp_v
    WHERE     OSTA <> 0
          AND ID = TO_NUMBER (bars.PUL.GET ('CP_ID'))
          AND PF = TO_NUMBER (bars.PUL.GET ('CP_PF'))
          AND RYN = TO_NUMBER (bars.PUL.GET ('CP_RYN'));

PROMPT *** Create  grants  CP_V1 ***
grant SELECT                                                                 on CP_V1           to BARSREADER_ROLE;
grant SELECT                                                                 on CP_V1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_V1           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V1.sql =========*** End *** ========
PROMPT ===================================================================================== 
