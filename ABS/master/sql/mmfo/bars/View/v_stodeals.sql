

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STODEALS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STODEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STODEALS ("DEAL_ID", "DEAL_NUM", "DEAL_DAT", "GROUP_ID", "CUST_ID", "CUST_NAME", "CUST_CODE", "TOBO") AS 
  SELECT l.ids,
          l.name,
          l.sdat,
          l.idg,
          c.rnk,
          c.nmk,
          c.okpo,
          l.branch tobo
     FROM sto_lst l, customer c
    WHERE c.rnk = l.rnk;

PROMPT *** Create  grants  V_STODEALS ***
grant SELECT                                                                 on V_STODEALS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STODEALS      to STO;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_STODEALS      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STODEALS.sql =========*** End *** ===
PROMPT ===================================================================================== 
