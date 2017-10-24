

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUST_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CUST_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.CUST_ACC ("ACC", "RNK") AS 
  select acc, rnk from accounts
 ;

PROMPT *** Create  grants  CUST_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_ACC        to ABS_ADMIN;
grant SELECT                                                                 on CUST_ACC        to BARS009;
grant SELECT                                                                 on CUST_ACC        to BARS010;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_ACC        to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on CUST_ACC        to CUST001;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on CUST_ACC        to FINMON;
grant SELECT                                                                 on CUST_ACC        to OBPC;
grant SELECT                                                                 on CUST_ACC        to PYOD001;
grant INSERT                                                                 on CUST_ACC        to RCC_DEAL;
grant SELECT                                                                 on CUST_ACC        to RPBN001;
grant SELECT                                                                 on CUST_ACC        to RPBN002;
grant SELECT                                                                 on CUST_ACC        to SALGL;
grant SELECT                                                                 on CUST_ACC        to START1;
grant SELECT                                                                 on CUST_ACC        to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_ACC        to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUST_ACC        to WR_CREPORTS;
grant SELECT                                                                 on CUST_ACC        to WR_CUSTLIST;
grant SELECT                                                                 on CUST_ACC        to WR_DEPOSIT_U;
grant SELECT                                                                 on CUST_ACC        to WR_DOCHAND;
grant SELECT                                                                 on CUST_ACC        to WR_DOC_INPUT;
grant SELECT                                                                 on CUST_ACC        to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on CUST_ACC        to WR_USER_ACCOUNTS_LIST;
grant SELECT                                                                 on CUST_ACC        to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUST_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
