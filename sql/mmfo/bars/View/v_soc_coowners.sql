

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SOC_COOWNERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SOC_COOWNERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SOC_COOWNERS ("CONTRACT_ID", "CONTRACT_NUM", "RNK", "OWNER_TYPE", "OWNER_NAME", "NMK", "SER", "NUMDOC", "BRANCH", "ACC", "VIDD", "DAT_BEGIN", "DAT_END") AS 
  SELECT d.contract_id, d.contract_num, d.rnk, t.ID, t.NAME, c.nmk, p.ser, p.numdoc,
          d.branch, d.acc, d.type_id, d.contract_date, d.closed_date
     FROM social_contracts d, dpt_trustee_type t, customer c, person p
    WHERE t.fl_owner = 1 AND d.rnk = c.rnk AND c.rnk = p.rnk
   UNION ALL
   SELECT dt.contract_id, d.contract_num, dt.trust_rnk, t.ID, t.NAME, c.nmk, p.ser, p.numdoc,
          d.branch, d.acc, d.type_id, d.contract_date, d.closed_date
     FROM social_trustee dt,
          social_contracts d,
          dpt_trustee_type t,
          customer c,
          person p
    WHERE dt.fl_act = 1
      AND dt.trust_type = t.ID
      AND dt.undo_id IS NULL
      AND d.contract_id = dt.contract_id
      AND dt.trust_rnk != d.rnk
      AND dt.trust_rnk = c.rnk
      AND c.rnk = p.rnk
 ;

PROMPT *** Create  grants  V_SOC_COOWNERS ***
grant SELECT                                                                 on V_SOC_COOWNERS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SOC_COOWNERS  to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOC_COOWNERS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SOC_COOWNERS.sql =========*** End ***
PROMPT ===================================================================================== 
