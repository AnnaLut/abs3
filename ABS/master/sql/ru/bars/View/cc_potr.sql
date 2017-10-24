

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_POTR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_POTR ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_POTR ("ID", "NAME", "S260") AS 
  SELECT s.r020 || s.ob22, SUBSTR (s.txt, 1, 250) ,c.s260
      FROM sb_ob22 s,  cck_ob22 c
     WHERE d_close IS NULL and s.r020=c.nbs(+) and s.ob22=c.ob22(+)
             AND r020 = SUBSTR (pul.get_mas_ini_val ('NBS_AIM'), 1, 4);

PROMPT *** Create  grants  CC_POTR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_POTR         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_POTR         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_POTR         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_POTR.sql =========*** End *** ======
PROMPT ===================================================================================== 
