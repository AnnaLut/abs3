

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_DEAL_PRINT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_DEAL_PRINT ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_DEAL_PRINT ("ND", "BRANCH", "CARD_CODE", "ACC_ACC", "ACC_NLS", "ACC_KV", "ACC_LCV", "ACC_OB22", "ACC_TIP", "ACC_TIPNAME", "ACC_OST", "ACC_DAOS", "ACC_DAZS", "CUST_RNK", "CUST_NAME", "CUST_OKPO", "CUST_TYPE", "GRP_CODE", "PROECT_OKPO", "DOC_ID") AS 
  SELECT nd,
          branch,
          card_code,
          acc acc_acc,
          nls acc_nls,
          kv acc_kv,
          lcv acc_lcv,
          ob22 acc_ob22,
          tip acc_tip,
          name acc_tipname,
          ost acc_ost,
          daos acc_daos,
          dazs acc_dazs,
          rnk cust_rnk,
          nmk cust_name,
          okpo cust_okpo,
          custtype cust_type,
          grp_code,
          NVL (proect_okpo, grp_code) proect_okpo,
             'id in (select doc_id from w4_product_doc where nvl(d_close, sysdate)>=sysdate and grp_code='''
          || grp_code
          || ''' and doc_id not like ''%MIGR%'')'
          || CASE
                WHEN (   INSTR (card_code, '_MDUKK') > 0
                      OR INSTR (card_code, '_VCUKK') > 0)
                THEN
                   ' or id in (''ACC_BPK_ANKETA_KK'',''ACC_1_BPK_ZAYAVA_NEW_DKBO_KK'',''ACC_2_BPK_ZAYAVA_NEW_DKBO_KK'')'
             END
             doc_id
     FROM (SELECT o.nd,
                  a.branch,
                  o.card_code,
                  a.acc,
                  a.nls,
                  a.kv,
                  t.lcv,
                  a.ob22,
                  a.tip,
                  s.name,
                  a.ostc / POWER (10, 2) ost,
                  a.daos,
                  a.dazs,
                  c.rnk,
                  UPPER (c.nmk) nmk,
                  c.okpo,
                  c.custtype,
                  wp.grp_code,
                  (SELECT b.okpo
                     FROM accountsw w, bpk_proect b
                    WHERE     w.acc = a.acc
                          AND w.tag = 'PK_PRCT'
                          AND w.VALUE = TO_CHAR (b.id))
                     proect_okpo
             FROM w4_acc o,
                  accounts a,
                  customer c,
                  tips s,
                  tabval$global t,
                  w4_card wc,
                  w4_product wp,
                  w4_nbs_ob22 n
            WHERE     o.acc_pk = a.acc
                  AND a.rnk = c.rnk
                  AND a.tip = s.tip
                  AND a.kv = t.kv
                  AND o.card_code = wc.code
                  AND wc.product_code = wp.code
                  AND a.tip LIKE 'W4%'
                  AND s.tip LIKE 'W4%'
                  AND SUBSTR (a.nls, 1, 4) = n.nbs
                  AND a.ob22 = n.ob22
                  AND a.tip = n.tip
                  AND a.branch LIKE
                         SYS_CONTEXT ('bars_context', 'user_branch_mask'));

PROMPT *** Create  grants  W4_DEAL_PRINT ***
grant SELECT                                                                 on W4_DEAL_PRINT   to BARSREADER_ROLE;
grant SELECT                                                                 on W4_DEAL_PRINT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_DEAL_PRINT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_DEAL_PRINT.sql =========*** End *** 
PROMPT ===================================================================================== 
