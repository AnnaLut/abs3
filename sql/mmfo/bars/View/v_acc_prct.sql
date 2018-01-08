

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACC_PRCT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACC_PRCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACC_PRCT ("ACC", "PROECT") AS 
  SELECT a.acc, w.VALUE PROECT
     FROM accounts a,
          (SELECT acc, VALUE
             FROM accountsw
            WHERE tag = 'PK_PRCT') w
    WHERE a.acc = w.acc(+);

PROMPT *** Create  grants  V_ACC_PRCT ***
grant SELECT                                                                 on V_ACC_PRCT      to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACC_PRCT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACC_PRCT      to CUST001;
grant SELECT                                                                 on V_ACC_PRCT      to START1;
grant SELECT                                                                 on V_ACC_PRCT      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACC_PRCT.sql =========*** End *** ===
PROMPT ===================================================================================== 
