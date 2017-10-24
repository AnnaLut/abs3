

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PARAMS.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.PARAMS ("PAR", "VAL", "COMM") AS 
  select par, val, comm
     from params$base
    where kf = sys_context ('bars_context', 'user_mfo')
   union all
   select par, val, comm
     from params$global;

PROMPT *** Create  grants  PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PARAMS          to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on PARAMS          to BARS014;
grant FLASHBACK,REFERENCES,SELECT                                            on PARAMS          to BARSAQ with grant option;
grant SELECT                                                                 on PARAMS          to BARSAQ_ADM;
grant SELECT                                                                 on PARAMS          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PARAMS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PARAMS          to BARS_CONNECT;
grant SELECT                                                                 on PARAMS          to BARS_SUP;
grant FLASHBACK,SELECT                                                       on PARAMS          to BASIC_INFO;
grant SELECT                                                                 on PARAMS          to CC_DOC;
grant INSERT,UPDATE                                                          on PARAMS          to CHCK;
grant SELECT                                                                 on PARAMS          to DEB_REG;
grant SELECT                                                                 on PARAMS          to DPT;
grant SELECT                                                                 on PARAMS          to DPT_ROLE;
grant SELECT                                                                 on PARAMS          to KLBX;
grant SELECT                                                                 on PARAMS          to PUBLIC;
grant SELECT                                                                 on PARAMS          to RCC_DEAL;
grant SELECT                                                                 on PARAMS          to REPORTER;
grant INSERT,UPDATE                                                          on PARAMS          to RPBN001;
grant SELECT                                                                 on PARAMS          to START1;
grant SELECT                                                                 on PARAMS          to SUR_ROLE;
grant UPDATE                                                                 on PARAMS          to TECH005;
grant SELECT                                                                 on PARAMS          to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PARAMS          to WR_ALL_RIGHTS;
grant SELECT                                                                 on PARAMS          to WR_CHCKINNR_ALL;
grant SELECT                                                                 on PARAMS          to WR_CHCKINNR_CASH;
grant SELECT                                                                 on PARAMS          to WR_CHCKINNR_SELF;
grant SELECT                                                                 on PARAMS          to WR_CHCKINNR_SUBTOBO;
grant SELECT                                                                 on PARAMS          to WR_CHCKINNR_TOBO;
grant SELECT                                                                 on PARAMS          to WR_CREDIT;
grant SELECT                                                                 on PARAMS          to WR_CUSTREG;
grant SELECT                                                                 on PARAMS          to WR_DEPOSIT_U;
grant SELECT                                                                 on PARAMS          to WR_DOCVIEW;
grant SELECT                                                                 on PARAMS          to WR_DOC_INPUT;
grant SELECT                                                                 on PARAMS          to WR_IMPEXP;
grant SELECT                                                                 on PARAMS          to WR_KP;
grant SELECT                                                                 on PARAMS          to WR_QDOCS;
grant FLASHBACK,SELECT                                                       on PARAMS          to WR_REFREAD;
grant SELECT                                                                 on PARAMS          to WR_VERIFDOC;
grant SELECT                                                                 on PARAMS          to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PARAMS.sql =========*** End *** =======
PROMPT ===================================================================================== 
