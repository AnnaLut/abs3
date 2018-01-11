

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CREDIT_PRODUCTS_PORTFOLIO.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CREDIT_PRODUCTS_PORTFOLIO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CREDIT_PRODUCTS_PORTFOLIO ("KF", "CONTRACT_ID", "CONTRACT_NUMBER", "CONTRACT_DATE", "CONTRACT_DATE_EXPIRY", "CONTRACT_BRANCH", "PRODUCT_NAME", "CLIENT_ID", "CLIENT_NAME") AS 
  select p.KF,
         p.ND,
         p.CC_ID,
         p.SDATE,
         p.WDATE,
         p.BRANCH,
         p.NAME,
         p.RNK,
         c.NMK
    from ( select c.KF,
                  c.ND,
                  c.CC_ID,
                  c.SDATE,
                  c.WDATE,
                  c.RNK,
                  c.BRANCH,
                  v.name
             from BARS.CC_DEAL c
            inner
             join CC_VIDD v
               on ( v.vidd = c.vidd AND v.CUSTTYPE = 2)
            where c.VIDD in ( 1, 2, 3 )
              and c.SOS  in ( 10, 11, 13 )
            union all
           select o.KF,
                  o.ND,
                  o.NDOC,
                  o.DATD,
                  o.DATD2,
                  a.rnk,
                  a.branch,
                  'ЮО Овердрафт'
             from ACC_OVER o
            inner
             join ACCOUNTS a
               on ( a.acc = o.acc )
            where o.ACC = o.acco
              and a.DAZS is null
         ) p
   inner
    join BARS.CUSTOMER c
      on ( c.rnk = p.rnk );

PROMPT *** Create  grants  V_CREDIT_PRODUCTS_PORTFOLIO ***
grant SELECT                                                                 on V_CREDIT_PRODUCTS_PORTFOLIO to BARSREADER_ROLE;
grant SELECT                                                                 on V_CREDIT_PRODUCTS_PORTFOLIO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CREDIT_PRODUCTS_PORTFOLIO to DPT_ROLE;
grant SELECT                                                                 on V_CREDIT_PRODUCTS_PORTFOLIO to START1;
grant SELECT                                                                 on V_CREDIT_PRODUCTS_PORTFOLIO to UPLD;
grant SELECT                                                                 on V_CREDIT_PRODUCTS_PORTFOLIO to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CREDIT_PRODUCTS_PORTFOLIO.sql =======
PROMPT ===================================================================================== 
