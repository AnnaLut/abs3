

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PODOTW.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view PODOTW ***

  CREATE OR REPLACE FORCE VIEW BARS.PODOTW ("ID", "TAG", "VAL") AS 
  SELECT ID, tag, val     FROM podotc 
 ;

PROMPT *** Create  grants  PODOTW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PODOTW          to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on PODOTW          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PODOTW          to PYOD001;
grant SELECT                                                                 on PODOTW          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PODOTW          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PODOTW.sql =========*** End *** =======
PROMPT ===================================================================================== 
