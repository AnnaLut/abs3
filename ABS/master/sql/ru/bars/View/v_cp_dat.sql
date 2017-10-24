

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_DAT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_DAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_DAT ("CP_ID", "ID", "DAT_EM", "DOK", "NPP", "KUP", "NOM", "DATP", "EXPIRY_DATE") AS 
  (SELECT k.cp_id,
           k.id,
           k.dat_em,
           d.dok,
           npp,
           kup,
           nom,
           k.datp,
           case when d.dok >= bankdate then COALESCE (d.EXPIRY_DATE, d.dok + NVL (k.expiry, 0)) else null end
      FROM cp_kod k, cp_dat d
     WHERE k.id = d.id);

PROMPT *** Create  grants  V_CP_DAT ***
grant SELECT                                                                 on V_CP_DAT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_DAT        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_DAT.sql =========*** End *** =====
PROMPT ===================================================================================== 
