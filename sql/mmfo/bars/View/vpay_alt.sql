

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VPAY_ALT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view VPAY_ALT ***

  CREATE OR REPLACE FORCE VIEW BARS.VPAY_ALT ("ID", "ISP", "ND", "S", "DOPR", "NMSA", "NLSA", "NLSA_ALT", "NMSB", "NLSB", "NLSB_ALT", "NAZN", "S2", "SOS", "DATD", "SK_ZB", "NLS6", "IR", "CEP_ACC") AS 
  SELECT "ID", "ISP", "ND", "S", "DOPR", "NMSA", "NLSA", "NLSA_ALT", "NMSB",
          "NLSB", "NLSB_ALT", "NAZN", "S2", "SOS", "DATD", "SK_ZB", "NLS6",
          "IR", "CEP_ACC"
     FROM pay_alt
    WHERE isp = user_id
 ;

PROMPT *** Create  grants  VPAY_ALT ***
grant SELECT                                                                 on VPAY_ALT        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VPAY_ALT        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VPAY_ALT        to PYOD001;
grant SELECT                                                                 on VPAY_ALT        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VPAY_ALT        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VPAY_ALT.sql =========*** End *** =====
PROMPT ===================================================================================== 
