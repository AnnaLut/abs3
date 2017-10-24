

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_COOWNERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_COOWNERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_COOWNERS ("DPT_ID", "DPT_NUM", "RNK", "OWNER_TYPE", "OWNER_NAME", "NMK", "SER", "NUMDOC", "BRANCH", "KV", "ACC", "VIDD", "DAT_BEGIN", "DAT_END") AS 
  SELECT d.deposit_id, d.ND, d.rnk, t.id, t.name, c.nmk,
       p.ser, p.numdoc, d.branch, d.kv, d.acc,
       d.vidd, d.dat_begin, d.dat_end
  FROM dpt_deposit d, dpt_trustee_type t, customer c, person p
 WHERE t.fl_owner = 1
   AND d.rnk = c.rnk
   AND c.rnk = p.rnk
 UNION ALL
SELECT dt.dpt_id, d.nd, dt.rnk_tr, t.id, t.name, c.nmk,
       p.ser, p.numdoc, d.branch, d.kv, d.acc,
       d.vidd, d.dat_begin, d.dat_end
  FROM dpt_trustee dt, dpt_deposit d, dpt_trustee_type t, customer c, person p
 WHERE dt.fl_act = 1
   AND dt.typ_tr = t.id
   AND dt.undo_id IS NULL
   AND d.deposit_id = dt.dpt_id
   AND dt.rnk_tr != d.rnk
   AND dt.rnk_tr = c.rnk
   AND c.rnk = p.rnk
 UNION ALL
SELECT d.dpt_id,arc.nd, d.rnk, t.id, t.name, c.nmk,
       p.ser, p.numdoc, d.branch, arc.kv, d.tech_acc,
       arc.vidd, d.dpt_datbegin, d.dpt_datend
  FROM dpt_techaccounts d, dpt_deposit_clos arc, dpt_trustee_type t,
       customer c, person p
 WHERE arc.idupd = d.dpt_idupd
   AND arc.deposit_id = d.dpt_id
   AND t.fl_owner = 1
   AND d.rnk = c.rnk
   AND c.rnk = p.rnk
 ;

PROMPT *** Create  grants  V_DPT_COOWNERS ***
grant SELECT                                                                 on V_DPT_COOWNERS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_COOWNERS  to DPT_ROLE;
grant SELECT                                                                 on V_DPT_COOWNERS  to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_COOWNERS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_COOWNERS.sql =========*** End ***
PROMPT ===================================================================================== 
