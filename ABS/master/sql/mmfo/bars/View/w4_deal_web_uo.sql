

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_DEAL_WEB_UO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_DEAL_WEB_UO ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_DEAL_WEB_UO ("ND", "BRANCH", "CARD_CODE", "PRODUCT_CODE", "ACC_ACC", "ACC_NLS", "ACC_KV", "ACC_LCV", "ACC_OB22", "ACC_TIP", "ACC_TIPNAME", "ACC_OST", "ACC_DAOS", "ACC_DAZS", "CUST_RNK", "CUST_NAME", "CUST_OKPO", "CUST_TYPE", "CARD_IDAT", "CARD_IDAT2", "CARD_IDAT_BANKDATE", "DOC_ID") AS 
  SELECT nd,
          branch,
          card_code,
          product_code,
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
          idat card_idat,
          idat card_idat2,
          NVL (idat, bankdate) card_idat_bankdate,
          doc_id
     FROM (SELECT o.nd,
                  a.branch,
                  o.card_code,
                  wp.code product_code,
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
                  (SELECT TO_DATE (VALUE, 'dd.mm.yyyy')
                     FROM accountsw
                    WHERE acc = a.acc AND tag = 'PK_IDAT')
                     idat,
                     'id in (select doc_id from w4_product_doc where grp_code='''
                  || wp.grp_code
                  || ''' and doc_id not like ''%MIGR%'')'
                     doc_id
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
                  AND SUBSTR (a.nls, 1, 4) in ('2605', '2655', '2552', '2554', '2600', '1919', '2520')
                  AND a.branch LIKE
                         SYS_CONTEXT ('bars_context', 'user_branch_mask'));

PROMPT *** Create  grants  W4_DEAL_WEB_UO ***
grant SELECT                                                                 on W4_DEAL_WEB_UO  to BARSREADER_ROLE;
grant SELECT                                                                 on W4_DEAL_WEB_UO  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_DEAL_WEB_UO  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_DEAL_WEB_UO.sql =========*** End ***
PROMPT ===================================================================================== 
