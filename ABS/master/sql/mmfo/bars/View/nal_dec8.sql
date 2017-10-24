

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NAL_DEC8.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view NAL_DEC8 ***

  CREATE OR REPLACE FORCE VIEW BARS.NAL_DEC8 ("NLS", "NLS8") AS 
  SELECT  NLS,  NLS8
FROM   NAL_DEC8$BASE
WHERE  KF=SYS_CONTEXT('bars_context','params_mfo')
       with check option
 ;

PROMPT *** Create  grants  NAL_DEC8 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAL_DEC8        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC8        to NALOG;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC8        to NAL_DEC8;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAL_DEC8        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NAL_DEC8        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NAL_DEC8.sql =========*** End *** =====
PROMPT ===================================================================================== 
