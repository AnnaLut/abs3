

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_DEAL_WEB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_DEAL_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_DEAL_WEB ("ND", "BRANCH", "CARD_CODE", "PRODUCT_CODE", "ACC_ACC", "ACC_NLS", "ACC_KV", "ACC_LCV", "ACC_OB22", "ACC_TIP", "ACC_TIPNAME", "ACC_OST", "ACC_DAOS", "ACC_DAZS", "CUST_RNK", "CUST_NAME", "CUST_OKPO", "CUST_TYPE", "CARD_IDAT", "CARD_IDAT2", "CARD_IDAT_BANKDATE", "DOC_ID", "BARCOD", "COBRANDID", "ISDKBO", "DKBO_ID", "DKBO_NUMBER", "DKBO_DATE_FROM", "DKBO_DATE_TO", "DEAL_TYPE_ID", "DEAL_STATE_ID", "CARD_DATE_FROM", "CARD_DATE_TO", "SED", "IS_ACC_CLOSE") AS 
  SELECT o.nd,
          o.branch,
          o.card_code,
          o.product_code,
          o.acc acc_acc,
          o.nls acc_nls,
          o.kv acc_kv,
          o.lcv acc_lcv,
          o.ob22 acc_ob22,
          o.tip acc_tip,
          o.name acc_tipname,
          o.ost acc_ost,
          o.daos acc_daos,
          o.dazs acc_dazs,
          o.rnk cust_rnk,
          o.nmk cust_name,
          o.okpo cust_okpo,
          o.custtype cust_type,
          TO_DATE (aw.VALUE, 'dd.mm.yyyy') card_idat,
          TO_DATE (aw.VALUE, 'dd.mm.yyyy') card_idat2,
          NVL (TO_DATE (aw.VALUE, 'dd.mm.yyyy'), bankdate) card_idat_bankdate,
          o.doc_id,
          bp1.value BARCOD,
          bp2.value COBRANDID,
          decode(av.value, null, 0, 1) as isdkbo,
--MPivanova заявка COBUSUPABS-3895
          d.id as dkbo_id,
          d.deal_number as dkbo_number,
          d.start_date  dkbo_date_from,
          d.close_date dkbo_date_to,
          d.deal_type_id deal_type_id,
          d.state_id  deal_state_id,
          o.date_open  card_date_from,
          o.date_close  card_date_to,
          o.sed,
          case when o.dazs is null then 0
         when  o.dazs is not null then 1 end is_acc_close
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
                  c.sed,--MPivanova заявка COBUSUPABS-3895
                  UPPER (c.nmk) nmk,
                  c.okpo,
                  c.custtype,
                     'id in (select doc_id from w4_product_doc where grp_code='''
                  || wp.grp_code
                  || ''' and doc_id not like ''%MIGR%'' and type is null)'
                     doc_id,
                  cw.value workb,
                  wc.date_open,
                  wc.date_close
             FROM w4_acc o,
                  accounts a,
                  customer c,
                  customerw cw,
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
                  AND SUBSTR (a.nls, 1, 4) NOT IN ('2605', '2655', '2552', '2554')
                  AND c.rnk = cw.rnk(+)
                  AND cw.tag(+) = 'WORKB') o
     left join bpk_parameters bp1 on o.nd = bp1.nd and bp1.tag = 'BARCOD'
     left join bpk_parameters bp2 on o.nd = bp2.nd and bp2.tag = 'COBRANDID'
     left join accountsw aw on o.acc = aw.acc and aw.tag = 'PK_IDAT'
     left join deal d on o.rnk = d.customer_id and d.deal_type_id in(select tt.id from object_type tt where tt.type_code = 'DKBO')
     left join attribute_number_value av on av.value = o.acc and av.attribute_id in(select ak.id from attribute_kind ak where ak.attribute_code = 'DKBO_ACC_LIST')
     where (nvl(trim(o.workb),0) <> '1' OR o.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask') );

PROMPT *** Create  grants  W4_DEAL_WEB ***
grant SELECT                                                                 on W4_DEAL_WEB     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_DEAL_WEB.sql =========*** End *** ==
PROMPT ===================================================================================== 
