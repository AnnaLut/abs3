

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBSOB22.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBSOB22 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBSOB22 ("KOD", "NAME", "D_CLOSE", "R020", "OB22") AS 
  SELECT R020 || ob22,
          txt,
          d_close,
          R020,
          ob22
     FROM sb_ob22 where d_close is null;

PROMPT *** Create  grants  V_NBSOB22 ***
grant SELECT                                                                 on V_NBSOB22       to ABS_ADMIN;
grant SELECT                                                                 on V_NBSOB22       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBSOB22       to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBSOB22.sql =========*** End *** ====
PROMPT ===================================================================================== 
