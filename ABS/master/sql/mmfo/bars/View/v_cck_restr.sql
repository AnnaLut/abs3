

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_RESTR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_RESTR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_RESTR ("ND", "FDAT", "VID_RESTR", "TXT", "SUMR", "FDAT_END", "PR_NO") AS 
  SELECT ND,
          FDAT,
          VID_RESTR,
          TXT,
          SUMR,
          FDAT_END,
          PR_NO
     FROM cck_restr
   UNION ALL
   SELECT -acc,
          FDAT,
          VID_RESTR,
          TXT,
          SUMR,
          FDAT_END,
          PR_NO
     FROM cck_restr_acc;

PROMPT *** Create  grants  V_CCK_RESTR ***
grant SELECT                                                                 on V_CCK_RESTR     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CCK_RESTR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_RESTR     to START1;
grant SELECT                                                                 on V_CCK_RESTR     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_RESTR.sql =========*** End *** ==
PROMPT ===================================================================================== 
