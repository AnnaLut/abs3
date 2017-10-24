

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_POTRA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_POTRA ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_POTRA ("ID", "NAME", "S260") AS 
  SELECT s.r020 ||s.ob22, SUBSTR (txt, 1, 250),c.s260 FROM sb_ob22 s, cck_ob22 c
        WHERE s.r020=c.nbs and s.ob22=c.ob22
              and  (s.d_close >nvl(gl.bd,sysdate) or s.d_close is null);

PROMPT *** Create  grants  CC_POTRA ***
grant SELECT                                                                 on CC_POTRA        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_POTRA        to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_POTRA        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_POTRA.sql =========*** End *** =====
PROMPT ===================================================================================== 
