

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACCOUNTS_RNK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view ACCOUNTS_RNK ***

  CREATE OR REPLACE FORCE VIEW BARS.ACCOUNTS_RNK ("NLS", "KV", "TOBO", "ACC", "DAOS", "RNK") AS 
  SELECT a.nls,a.kv,a.TOBO,a.acc,a.daos,c.rnk
    FROM ACCOUNTS a,CUSTOMER c,CUST_ACC u
    WHERE a.acc=u.acc
      AND u.rnk=c.rnk --AND a.dazs IS NULL;;

PROMPT *** Create  grants  ACCOUNTS_RNK ***
grant SELECT                                                                 on ACCOUNTS_RNK    to BARSREADER_ROLE;
grant SELECT                                                                 on ACCOUNTS_RNK    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_RNK    to START1;
grant SELECT                                                                 on ACCOUNTS_RNK    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACCOUNTS_RNK.sql =========*** End *** =
PROMPT ===================================================================================== 
