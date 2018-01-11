

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/WCS_PARTNERS_MATHER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view WCS_PARTNERS_MATHER ***

  CREATE OR REPLACE FORCE VIEW BARS.WCS_PARTNERS_MATHER ("ID", "NAME", "TYPE_ID", "FLAG_A") AS 
  SELECT ID,
          NAME,
          TYPE_ID,
          FLAG_A
     FROM WCS_PARTNERS_ALL
    WHERE ID_MATHER IS NULL;

PROMPT *** Create  grants  WCS_PARTNERS_MATHER ***
grant SELECT                                                                 on WCS_PARTNERS_MATHER to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WCS_PARTNERS_MATHER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PARTNERS_MATHER to UPLD;
grant SELECT                                                                 on WCS_PARTNERS_MATHER to WCS_SYNC_USER;
grant FLASHBACK,SELECT                                                       on WCS_PARTNERS_MATHER to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/WCS_PARTNERS_MATHER.sql =========*** En
PROMPT ===================================================================================== 
