

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SOCIALTRUSTEE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SOCIALTRUSTEE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SOCIALTRUSTEE ("CONTRACT_ID", "RNK", "TYPE_ID", "TRUST_ID", "TRUST_TYPE", "TRUST_RNK", "TRUST_NAME", "ADD_NUM", "ADD_DAT", "FL_ACTIVITY", "FLAG_ID", "TEMPLATE_ID", "FLAG_NAME", "DETAILS") AS 
  SELECT t.contract_id, t.rnk, s.type_id, t.trust_id, t.trust_type,
          t.trust_rnk, c.nmk, t.add_num, t.add_dat, t.fl_act, m.flag_id,
          m.template_id, f.NAME,
          DECODE (t.fl_act,
                  1, 'активна',
                  'анульована дод.угодою №' || t.add_num
                 )
     FROM social_trustee t,
          social_contracts s,
          customer c,
          social_templates m,
          dpt_vidd_flags f
    WHERE t.contract_id = s.contract_id
      AND t.trust_rnk = c.rnk
      AND s.type_id = m.type_id
      AND t.template_id = m.template_id
      AND m.flag_id = f.ID 
 ;

PROMPT *** Create  grants  V_SOCIALTRUSTEE ***
grant SELECT                                                                 on V_SOCIALTRUSTEE to BARSREADER_ROLE;
grant SELECT                                                                 on V_SOCIALTRUSTEE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SOCIALTRUSTEE to DPT_ROLE;
grant SELECT                                                                 on V_SOCIALTRUSTEE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCIALTRUSTEE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SOCIALTRUSTEE.sql =========*** End **
PROMPT ===================================================================================== 
