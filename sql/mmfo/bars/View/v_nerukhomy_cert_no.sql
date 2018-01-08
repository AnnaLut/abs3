

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NERUKHOMY_CERT_NO.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NERUKHOMY_CERT_NO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NERUKHOMY_CERT_NO ("KEY_ID", "REGION", "STATUS") AS 
  SELECT UNIQUE SUBSTR (l.idr, 1, 2) || a.id_o,
                 b.nb,
--                 a.dat_a,
                 'VEGA-216: Відсутній сертифікат.'
     FROM arc_rrp a, banks b, lkl_rrp l
    WHERE     a.dat_a >= TRUNC (SYSDATE) - 5
          AND a.blk = 3301
          AND a.dk = 1
          AND SUBSTR (a.nlsa, -6) = b.mfo
          AND b.mfo = l.mfo
;

PROMPT *** Create  grants  V_NERUKHOMY_CERT_NO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NERUKHOMY_CERT_NO to ABS_ADMIN;
grant SELECT                                                                 on V_NERUKHOMY_CERT_NO to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NERUKHOMY_CERT_NO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NERUKHOMY_CERT_NO to UPLD;
grant FLASHBACK,SELECT                                                       on V_NERUKHOMY_CERT_NO to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NERUKHOMY_CERT_NO.sql =========*** En
PROMPT ===================================================================================== 
