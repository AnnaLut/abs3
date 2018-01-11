

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CRD_CUSTOMERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view CRD_CUSTOMERS ***

  CREATE OR REPLACE FORCE VIEW BARS.CRD_CUSTOMERS ("RNK") AS 
  select rnk from (
    select  rnk
    from cc_deal
    union
    select  rnk
    from bpk_acc b, accounts  a where b.acc_pk = a.acc );

PROMPT *** Create  grants  CRD_CUSTOMERS ***
grant SELECT                                                                 on CRD_CUSTOMERS   to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CRD_CUSTOMERS   to BARSREADER_ROLE;
grant SELECT                                                                 on CRD_CUSTOMERS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CRD_CUSTOMERS.sql =========*** End *** 
PROMPT ===================================================================================== 
