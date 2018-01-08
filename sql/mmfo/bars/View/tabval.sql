

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TABVAL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view TABVAL ***

  CREATE OR REPLACE FORCE VIEW BARS.TABVAL ("COIN", "KV", "GRP", "NAME", "LCV", "NOMINAL", "SV", "DIG", "DENOM", "UNIT", "COUNTRY", "BASEY", "GENDER", "PRV", "D_CLOSE", "FX_BASE", "SKV", "S0000", "S3800", "S3801", "S3802", "S6201", "S7201", "S9282", "S9280", "S9281", "S0009", "G0000") AS 
  SELECT g.coin,g.kv,g.grp,g.NAME,g.lcv,g.nominal,
 g.sv, g.dig, g.denom, g.unit,g.country, g.basey, g.gender, g.prv, g.d_close ,g.fx_base,
 l.skv,l.s0000,l.s3800,l.s3801,l.s3802,l.s6201,l.s7201,l.s9282, l.s9280,l.s9281,l.s0009,l.g0000  
 FROM tabval$global g, tabval$local l 
  WHERE l.kv(+) = g.kv AND l.kf(+) = gl.kf;

PROMPT *** Create  grants  TABVAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL          to ABS_ADMIN;
grant SELECT                                                                 on TABVAL          to BARS010;
grant SELECT                                                                 on TABVAL          to BARS015;
grant FLASHBACK,REFERENCES,SELECT                                            on TABVAL          to BARSAQ with grant option;
grant SELECT                                                                 on TABVAL          to BARSAQ_ADM with grant option;
grant SELECT                                                                 on TABVAL          to BARSREADER_ROLE;
grant SELECT                                                                 on TABVAL          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TABVAL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TABVAL          to CC_DOC;
grant SELECT                                                                 on TABVAL          to CUST001;
grant SELECT                                                                 on TABVAL          to DEP_SKRN;
grant SELECT                                                                 on TABVAL          to DPT;
grant SELECT                                                                 on TABVAL          to DPT_ADMIN;
grant SELECT                                                                 on TABVAL          to DPT_ROLE;
grant SELECT                                                                 on TABVAL          to FINMON01;
grant SELECT                                                                 on TABVAL          to FOREX;
grant SELECT                                                                 on TABVAL          to OBPC;
grant SELECT                                                                 on TABVAL          to PYOD001;
grant SELECT                                                                 on TABVAL          to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL          to START1;
grant SELECT                                                                 on TABVAL          to SWTOSS;
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL          to TABVAL;
grant SELECT                                                                 on TABVAL          to TASK_LIST;
grant SELECT                                                                 on TABVAL          to TOSS;
grant SELECT                                                                 on TABVAL          to UPLD;
grant SELECT                                                                 on TABVAL          to WEB_BALANS;
grant SELECT                                                                 on TABVAL          to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TABVAL          to WR_ALL_RIGHTS;
grant SELECT                                                                 on TABVAL          to WR_CREDIT;
grant SELECT                                                                 on TABVAL          to WR_CUSTLIST;
grant SELECT                                                                 on TABVAL          to WR_DEPOSIT_U;
grant SELECT                                                                 on TABVAL          to WR_DOCHAND;
grant SELECT                                                                 on TABVAL          to WR_DOCVIEW;
grant SELECT                                                                 on TABVAL          to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on TABVAL          to WR_REFREAD;
grant SELECT                                                                 on TABVAL          to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on TABVAL          to WR_USER_ACCOUNTS_LIST;
grant SELECT                                                                 on TABVAL          to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TABVAL.sql =========*** End *** =======
PROMPT ===================================================================================== 
