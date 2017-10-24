

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DEPRICATED_PARAMS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view DEPRICATED_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.DEPRICATED_PARAMS ("PAR", "VAL", "COMM") AS 
  select par, val, comm
     from params$base
    where kf = sys_context ('bars_context', 'user_mfo')
   union all
   select par, val, comm
     from params$global
 ;

PROMPT *** Create  grants  DEPRICATED_PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPRICATED_PARAMS to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPRICATED_PARAMS to BARS014;
grant FLASHBACK,REFERENCES,SELECT                                            on DEPRICATED_PARAMS to BARSAQ with grant option;
grant SELECT                                                                 on DEPRICATED_PARAMS to BARSAQ_ADM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEPRICATED_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEPRICATED_PARAMS to BARS_CONNECT;
grant FLASHBACK,SELECT                                                       on DEPRICATED_PARAMS to BASIC_INFO;
grant SELECT                                                                 on DEPRICATED_PARAMS to CC_DOC;
grant INSERT,UPDATE                                                          on DEPRICATED_PARAMS to CHCK;
grant SELECT                                                                 on DEPRICATED_PARAMS to DEB_REG;
grant SELECT                                                                 on DEPRICATED_PARAMS to DPT;
grant SELECT                                                                 on DEPRICATED_PARAMS to DPT_ROLE;
grant SELECT                                                                 on DEPRICATED_PARAMS to KLBX;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPRICATED_PARAMS to PARAMS;
grant SELECT                                                                 on DEPRICATED_PARAMS to PUBLIC;
grant SELECT                                                                 on DEPRICATED_PARAMS to RCC_DEAL;
grant SELECT                                                                 on DEPRICATED_PARAMS to REPORTER;
grant INSERT,UPDATE                                                          on DEPRICATED_PARAMS to RPBN001;
grant SELECT                                                                 on DEPRICATED_PARAMS to START1;
grant SELECT                                                                 on DEPRICATED_PARAMS to SUR_ROLE;
grant UPDATE                                                                 on DEPRICATED_PARAMS to TECH005;
grant SELECT                                                                 on DEPRICATED_PARAMS to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEPRICATED_PARAMS to WR_ALL_RIGHTS;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_CHCKINNR_ALL;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_CHCKINNR_CASH;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_CHCKINNR_SELF;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_CHCKINNR_SUBTOBO;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_CHCKINNR_TOBO;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_CREDIT;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_CUSTREG;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_DEPOSIT_U;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_DOCVIEW;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_DOC_INPUT;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_IMPEXP;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_KP;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_QDOCS;
grant FLASHBACK,SELECT                                                       on DEPRICATED_PARAMS to WR_REFREAD;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_VERIFDOC;
grant SELECT                                                                 on DEPRICATED_PARAMS to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DEPRICATED_PARAMS.sql =========*** End 
PROMPT ===================================================================================== 
