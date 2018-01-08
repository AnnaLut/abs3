

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TAROB_360003.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TAROB_360003 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TAROB_360003 ("PDV", "NLS", "NMS", "NAL", "BEZNAL") AS 
  SELECT k.pdv,
          a.nls,
          k.NAME || DECODE (k.pdv, 1, ', â ò÷ ÏÄÂ', ''),
          make_docinput_url (
             'K21',
             'Ãîòiâêîþ',
             'reqv_TAROB',
             a.nls,
             'reqv_TARON',
             k.NAME || DECODE (k.pdv, 1, ', â ò÷ ÏÄÂ', ''),
             'reqv_PDV',
             TO_CHAR (k.pdv),
             'SK',
             k.sk,
             'Nls_B',
             a.nls)
             nal,
          make_docinput_url (
             'K20',
             'ÁåçÃîòiâêîþ',
             'reqv_TAROB',
             a.nls,
             'reqv_TARON',
             k.NAME || DECODE (k.pdv, 1, ', â ò÷ ÏÄÂ', ''),
             'reqv_PDV',
             TO_CHAR (k.pdv),
             'Nls_B',
             a.nls)
             beznal
     FROM accounts a, raz_kom k
    WHERE     a.dazs IS NULL
          AND NVL (k.uo, 0) = 0
          AND bc.is_pbranch (branch, 1) = 1
          AND a.nbs = SUBSTR (k.kod, 1, 4)
          AND a.ob22 = SUBSTR (k.kod, 5, 2)
		  and k.kod ='360003';

PROMPT *** Create  grants  V_TAROB_360003 ***
grant SELECT                                                                 on V_TAROB_360003  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TAROB_360003  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TAROB_360003  to PYOD001;
grant SELECT                                                                 on V_TAROB_360003  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TAROB_360003  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_TAROB_360003  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TAROB_360003.sql =========*** End ***
PROMPT ===================================================================================== 
