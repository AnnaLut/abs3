

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TOBO.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view TOBO ***

  CREATE OR REPLACE FORCE VIEW BARS.TOBO ("TOBO", "NAME", "B040", "DESCRIPTION", "DATE_OPENED", "DATE_CLOSED") AS 
  select branch,name,b040,description,date_opened,date_closed from branch;

PROMPT *** Create  grants  TOBO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TOBO            to ABS_ADMIN;
grant FLASHBACK,REFERENCES,SELECT                                            on TOBO            to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on TOBO            to BARSAQ_ADM with grant option;
grant SELECT                                                                 on TOBO            to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TOBO            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TOBO            to BARS_SUP;
grant SELECT                                                                 on TOBO            to PYOD001;
grant SELECT                                                                 on TOBO            to RCC_DEAL;
grant SELECT                                                                 on TOBO            to R_KP;
grant SELECT                                                                 on TOBO            to SALGL;
grant SELECT                                                                 on TOBO            to START1;
grant SELECT                                                                 on TOBO            to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TOBO            to WR_ALL_RIGHTS;
grant SELECT                                                                 on TOBO            to WR_CUSTREG;
grant SELECT                                                                 on TOBO            to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TOBO.sql =========*** End *** =========
PROMPT ===================================================================================== 
