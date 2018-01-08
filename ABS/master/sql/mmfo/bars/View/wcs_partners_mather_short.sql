

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/WCS_PARTNERS_MATHER_SHORT.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view WCS_PARTNERS_MATHER_SHORT ***

  CREATE OR REPLACE FORCE VIEW BARS.WCS_PARTNERS_MATHER_SHORT ("ID", "NAME") AS 
  SELECT ID,
          NAME
     FROM WCS_PARTNERS_ALL
    WHERE ID_MATHER IS NULL and FLAG_A =1;

PROMPT *** Create  grants  WCS_PARTNERS_MATHER_SHORT ***
grant SELECT                                                                 on WCS_PARTNERS_MATHER_SHORT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/WCS_PARTNERS_MATHER_SHORT.sql =========
PROMPT ===================================================================================== 
