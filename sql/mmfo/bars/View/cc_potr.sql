

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_POTR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_POTR ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_POTR ("ID", "NAME", "S260") AS 
  SELECT s.r020 || s.ob22, SUBSTR (s.txt, 1, 250), c.s260
     FROM sb_ob22 s, cck_ob22 c
    WHERE     s.d_close IS NULL
          AND s.r020 = c.nbs(+)
          AND s.ob22 = c.ob22(+)
          AND r020 = SUBSTR (pul.get_mas_ini_val ('NBS_AIM'), 1, 4);

PROMPT *** Create  grants  CC_POTR ***
grant SELECT                                                                 on CC_POTR         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_POTR         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_POTR         to RCC_DEAL;
grant SELECT                                                                 on CC_POTR         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_POTR         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_POTR.sql =========*** End *** ======
PROMPT ===================================================================================== 
