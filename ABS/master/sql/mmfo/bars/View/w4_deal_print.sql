

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
          --NVL (proect_okpo, grp_code) proect_okpo,
          proect_okpo,
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
     FROM (
    SELECT o.nd,
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
       c.custtype
       ,wc.product_code
       ,(select wp.grp_code from w4_product wp where wp.code=wc.product_code and wp.kf=a.kf )grp_code
       ,b.okpo proect_okpo
       --,null proect_okpo
   FROM accountsw w
     inner join bpk_proect b on to_char(b.id)=w.VALUE --and b.okpo='19121522'
     inner join w4_acc o on o.acc_pk=w.acc
     inner join accounts a on a.acc=w.acc  and a.tip  LIKE 'W4%' AND a.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
     inner join tabval$global t on t.kv=a.kv
     inner join tips s on s.tip=a.tip
     inner join customer c on c.rnk=a.rnk
     inner join w4_nbs_ob22 n on n.nbs=a.nbs and  n.ob22=a.ob22   and n.tip=a.tip
     inner join w4_card wc on wc.code=o.card_code and wc.kf=a.kf  and wc.date_close is null
WHERE
    w.tag = 'PK_PRCT'
          );

PROMPT *** Create  grants  W4_DEAL_PRINT ***
grant SELECT                                                                 on W4_DEAL_PRINT   to BARSREADER_ROLE;
grant SELECT                                                                 on W4_DEAL_PRINT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_DEAL_PRINT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_DEAL_PRINT.sql =========*** End *** 
PROMPT ===================================================================================== 
