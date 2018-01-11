

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TOBO_PARAMS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TOBO_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.TOBO_PARAMS ("TOBO", "TAG", "VAL") AS 
  select branch,tag,val from branch_parameters
 ;

PROMPT *** Create  grants  TOBO_PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TOBO_PARAMS     to ABS_ADMIN;
grant SELECT                                                                 on TOBO_PARAMS     to BARS009;
grant SELECT                                                                 on TOBO_PARAMS     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TOBO_PARAMS     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT                                                   on TOBO_PARAMS     to R_KP;
grant SELECT                                                                 on TOBO_PARAMS     to START1;
grant SELECT                                                                 on TOBO_PARAMS     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TOBO_PARAMS     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TOBO_PARAMS.sql =========*** End *** ==
PROMPT ===================================================================================== 
