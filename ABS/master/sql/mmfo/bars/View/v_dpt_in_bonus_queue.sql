

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_IN_BONUS_QUEUE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_IN_BONUS_QUEUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_IN_BONUS_QUEUE ("DPT_ID", "DPT_NUM", "DPT_DAT", "DPT_RATE", "CUST_ID", "CUST_NAME", "CUST_CODE", "TYPE_ID", "TYPE_NAME", "TYPE_CODE", "BRANCH_ID", "BRANCH_NAME") AS 
  SELECT d.deposit_id, d.nd, d.datz, acrn.fproc(d.acc, bankdate),
       c.rnk, c.nmk, c.okpo,
       v.vidd, v.type_name, v.type_cod,
       b.branch, b.name
  FROM v_dpt_bonus_queue q, dpt_deposit d, customer c, dpt_vidd v, branch b
 WHERE q.dpt_id = d.deposit_id
   AND d.branch = b.branch
   AND d.rnk = c.rnk
   AND d.vidd = v.vidd
 ;

PROMPT *** Create  grants  V_DPT_IN_BONUS_QUEUE ***
grant SELECT                                                                 on V_DPT_IN_BONUS_QUEUE to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_IN_BONUS_QUEUE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_IN_BONUS_QUEUE to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_IN_BONUS_QUEUE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_IN_BONUS_QUEUE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_IN_BONUS_QUEUE.sql =========*** E
PROMPT ===================================================================================== 
