

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_COOWNERS_ALL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_COOWNERS_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_COOWNERS_ALL ("DPT_ID", "DPT_NUM", "RNK", "OWNER_TYPE", "OWNER_NAME", "NMK", "OKPO", "SER", "NUMDOC", "ORGAN", "PDATE", "BRANCH", "KV", "ACC", "VIDD", "DAT_BEGIN", "DAT_END") AS 
  SELECT d.deposit_id, d.nd, d.rnk, t.ID, t.NAME, c.nmk, c.okpo, p.ser, p.numdoc, p.organ, p.pdate,
          d.branch, d.kv, d.acc, d.vidd, d.dat_begin, d.dat_end
     FROM dpt_deposit_clos d, dpt_trustee_type t, customer c, person p
    WHERE d.action_id = 0 AND t.fl_owner = 1 AND d.rnk = c.rnk AND c.rnk = p.rnk
    UNION ALL
   SELECT dt.dpt_id, d.nd, dt.rnk_tr, t.ID, t.NAME, c.nmk, c.okpo,  p.ser, p.numdoc, p.organ, p.pdate,
          d.branch, d.kv, d.acc, d.vidd, d.dat_begin, d.dat_end
     FROM dpt_trustee dt,
          dpt_deposit_clos d,
          dpt_trustee_type t,
          customer c,
          person p
    WHERE d.action_id = 0
      AND dt.fl_act = 1
      AND dt.typ_tr = t.ID
      AND dt.undo_id IS NULL
      AND d.deposit_id = dt.dpt_id
      AND dt.rnk_tr != d.rnk
      AND dt.rnk_tr = c.rnk
      AND c.rnk = p.rnk
   UNION ALL
   SELECT d.dpt_id, arc.nd, d.rnk, t.ID, t.NAME, c.nmk, c.okpo, p.ser, p.numdoc, p.organ, p.pdate,
          d.branch, arc.kv, d.tech_acc, arc.vidd, d.dpt_datbegin, d.dpt_datend
     FROM dpt_techaccounts d,
          dpt_deposit_clos arc,
          dpt_trustee_type t,
          customer c,
          person p
    WHERE arc.idupd = d.dpt_idupd
      AND arc.deposit_id = d.dpt_id
      AND t.fl_owner = 1
      AND d.rnk = c.rnk
      AND c.rnk = p.rnk
 ;

PROMPT *** Create  grants  V_DPT_COOWNERS_ALL ***
grant SELECT                                                                 on V_DPT_COOWNERS_ALL to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_COOWNERS_ALL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_COOWNERS_ALL to DPT_ROLE;
grant SELECT                                                                 on V_DPT_COOWNERS_ALL to RPBN001;
grant SELECT                                                                 on V_DPT_COOWNERS_ALL to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_COOWNERS_ALL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_COOWNERS_ALL.sql =========*** End
PROMPT ===================================================================================== 
