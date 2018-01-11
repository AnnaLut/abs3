

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/WCS_PARTNERS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view WCS_PARTNERS ***

  CREATE OR REPLACE FORCE VIEW BARS.WCS_PARTNERS ("ID", "NAME", "TYPE_ID", "BRANCH", "PTN_MFO", "PTN_NLS", "PTN_OKPO", "PTN_NAME", "ID_MATHER", "FLAG_A") AS 
  SELECT a.ID,
          a.NAME,
          a.TYPE_ID,
          a.BRANCH,
          a.PTN_MFO,
          a.PTN_NLS,
          a.PTN_OKPO,
          a.PTN_NAME,
          a.ID_MATHER,
          a.FLAG_A
     FROM WCS_PARTNERS_ALL a, wcs_partners_mather m
    WHERE a.ID_MATHER IS NOT NULL AND m.id = a.ID_MATHER AND m.FLAG_A = 1;

PROMPT *** Create  grants  WCS_PARTNERS ***
grant SELECT                                                                 on WCS_PARTNERS    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WCS_PARTNERS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PARTNERS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/WCS_PARTNERS.sql =========*** End *** =
PROMPT ===================================================================================== 
