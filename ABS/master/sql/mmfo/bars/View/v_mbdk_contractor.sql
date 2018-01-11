

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_CONTRACTOR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_CONTRACTOR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_CONTRACTOR ("RNK", "NMK", "OKPO", "MFO", "BIC", "KOD_B", "CUSTTYPE", "DATE_ON", "DATE_OFF", "TGR", "C_DST", "C_REG", "ND", "CODCAGENT", "COD_NAME", "COUNTRY", "PRINSIDER", "PRINS_NAME", "STMT", "SAB", "CRISK", "ADR", "VED", "SED") AS 
  SELECT c.rnk,
            c.NMK,
            c.okpo,
            MFO,
            BIC,
            KOD_B,
            c.custtype,
            c.date_on,
            c.date_off,
            c.tgr,
            c.c_dst,
            c.c_reg,
            c.nd,
            c.codcagent,
            g.name cod_name,
            c.country,
            c.prinsider,
            p.name prins_name,
            c.stmt,
            c.SAB,
            c.crisk,
            c.adr,
            c.ved,
            c.sed
       FROM CUSTOMER c
            JOIN CUSTBANK b ON (c.rnk = b.rnk)
            JOIN CODCAGENT g ON (c.codcagent = g.codcagent)
            JOIN PRINSIDER p ON (c.prinsider = p.prinsider)
      WHERE     c.DATE_OFF IS NULL
            AND c.custtype = 1
            AND  (   (c.codcagent = 1 AND b.mfo <> '300465')  OR (c.codcagent = 2 AND b.bic IS NOT NULL))
            AND c.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
            AND c.codcagent IN (1, 2)
      ORDER BY 1;

PROMPT *** Create  grants  V_MBDK_CONTRACTOR ***
grant SELECT                                                                 on V_MBDK_CONTRACTOR to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBDK_CONTRACTOR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBDK_CONTRACTOR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_CONTRACTOR.sql =========*** End 
PROMPT ===================================================================================== 
