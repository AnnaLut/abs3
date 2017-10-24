

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MS_NX_K.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view MS_NX_K ***

  CREATE OR REPLACE FORCE VIEW BARS.MS_NX_K ("ID", "NAME", "S260") AS 
  SELECT s260 id, txt name, s260
     FROM kl_s260 where nvl(d_open,gl.bd)<=gl.bd and nvl(d_close,gl.bd+1)>gl.bd;

PROMPT *** Create  grants  MS_NX_K ***
grant SELECT                                                                 on MS_NX_K         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MS_NX_K         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MS_NX_K         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MS_NX_K.sql =========*** End *** ======
PROMPT ===================================================================================== 
