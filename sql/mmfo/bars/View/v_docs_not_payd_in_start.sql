

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCS_NOT_PAYD_IN_START.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCS_NOT_PAYD_IN_START ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCS_NOT_PAYD_IN_START ("MFOA", "MFOB", "NLSA", "NLSB", "S", "KV", "LCV", "DIG", "S2", "KV2", "LCV2", "DIG2", "SK", "DK", "VOB", "DATD", "VDAT", "TT", "ID", "REF", "SOS", "USERID", "ND", "NAZN", "FLAG", "ID_A", "NAM_A", "ID_B", "NAM_B", "TOBO") AS 
  SELECT a.mfoa,
          a.mfob,
          a.nlsa,
          a.nlsb,
          a.s,
          a.kv,
          v.lcv,
          v.dig,
          a.s2,
          a.kv2,
          v2.lcv lcv2,
          v2.dig dig2,
          a.sk,
          a.dk,
          a.vob,
          a.datd,
          a.vdat,
          a.tt,
          a.REF id,
          a.REF,
          a.sos,
          a.userid,
          a.nd,
          a.nazn,
          1 AS flag,
          a.id_a,
          a.nam_a,
          a.id_b,
          a.nam_b,
          a.tobo
     FROM oper a, tabval$global v, tabval$global v2
    WHERE     a.pdat >= TRUNC (SYSDATE) - 10
          AND v.kv = a.kv
          AND v2.kv = a.kv2
          AND a.REF IN (SELECT REF
                          FROM tmp_log);

PROMPT *** Create  grants  V_DOCS_NOT_PAYD_IN_START ***
grant SELECT                                                                 on V_DOCS_NOT_PAYD_IN_START to BARSREADER_ROLE;
grant SELECT                                                                 on V_DOCS_NOT_PAYD_IN_START to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCS_NOT_PAYD_IN_START to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCS_NOT_PAYD_IN_START.sql =========*
PROMPT ===================================================================================== 
