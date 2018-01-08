

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_DKBO_WEB_OLD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_DKBO_WEB_OLD ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_DKBO_WEB_OLD ("DEAL_ID", "DKBO_STATUS", "DKBO_CONTRACT_ID", "DKBO_DATE_FROM", "BDKBO_DATE_TO", "ACC_ACC", "CARD_ACC", "BRANCH", "CUSTOMER_ID", "CUSTOMER_NAME", "CUSTOMER_ZKPO", "CUSTOMER_BDAY", "PASS_SERIAL", "PASS_NUMBER", "PASS_DATE", "PASS_ORGAN", "ID_SAL_PR", "NAME_SAL_PR", "OKPO_SAL_PR", "IS_ACC_CLOSE") AS 
  WITH TT as (select d.id,d.state_id, d.deal_type_id,d.close_date, d.start_date, d.deal_number, avs.number_values
            from attribute_values avs
               JOIN (select  max(t.nested_table_id) keep (dense_rank last order by t.value_date) nested_table_id ,
                             t.object_id,
                             t.attribute_id
                      from ATTRIBUTE_VALUE_BY_DATE t
                      where   t.attribute_id = (SELECT ak.id
                                              FROM   attribute_kind ak
                                              WHERE  ak.attribute_code = 'DKBO_ACC_LIST')
                      group by t.object_id, t.attribute_id)  av   on av.nested_table_id = avs.nested_table_id
                                                                      AND av.attribute_id IN
                                                 (SELECT ak.id
                                                    FROM attribute_kind ak
                                                   WHERE ak.attribute_code = 'DKBO_ACC_LIST')
              JOIN deal d                ON d.id = av.object_id
                                         AND d.deal_type_id IN (SELECT tt.id FROM object_type tt WHERE tt.type_code = 'DKBO')
           )
SELECT
      d.id deal_id
      ,'' AS dkbo_status
      ,d.deal_number dkbo_contract_id
      ,d.start_date dkbo_date_from
      ,d.close_date bdkbo_date_to
      ,o.acc AS acc_acc
      ,o.nls AS card_acc
      ,o.branch
      ,o.rnk customer_id
      ,o.nmk customer_name
      ,o.okpo customer_zkpo
      ,o.bday customer_bday
      ,o.ser pass_serial
      ,o.numdoc pass_number
      ,o.pdate pass_date
      ,o.organ pass_organ
      ,bp.id id_sal_pr
      ,upper(bp.name) name_sal_pr
      ,bp.okpo okpo_sal_pr
      ,case when o.dazs  is null  then 0 else
        1 end is_acc_close
  FROM (SELECT o.nd
              ,a.branch
              ,o.card_code
              ,wp.code product_code
              ,a.acc
              ,a.nls
              ,a.kv
              ,t.lcv
              ,a.ob22
              ,a.tip
              ,s.name
              ,a.ostc / power(10, 2) ost
              ,a.daos
              ,a.dazs
              ,c.rnk
              ,upper(c.nmk) nmk
              ,c.okpo
              ,c.custtype
              ,aw.value
              ,p.bday
              ,p.ser
              ,p.numdoc
              ,p.pdate
              ,upper(p.organ) organ
          FROM w4_acc        o
              ,accounts      a
              ,customer      c
              ,person        p
              ,tips          s
              ,tabval$global t
              ,w4_card       wc
              ,w4_product    wp
              ,w4_nbs_ob22   n
              ,accountsw     aw
         WHERE o.acc_pk = a.acc
           AND a.rnk = c.rnk
           AND p.rnk = c.rnk
           AND a.tip = s.tip
           AND a.kv = t.kv
           AND o.card_code = wc.code
           AND wc.product_code = wp.code
           AND a.tip LIKE 'W4%'
           AND s.tip LIKE 'W4%'
           AND substr(a.nls, 1, 4) = n.nbs
           AND a.ob22 = n.ob22
           AND a.tip = n.tip
           AND substr(a.nls, 1, 4) NOT IN ('2605', '2655', '2552', '2554')
           AND a.dazs IS NULL
           AND a.nbs = '2625'
           AND aw.acc(+) = a.acc
           AND aw.tag(+) = 'PK_PRCT'
           AND (regexp_like(aw.value, '^(\d+)([.]?)(\d*)$') OR
               aw.value IS NULL)) o
           LEFT JOIN TT d  on d.number_values=o.acc
           LEFT JOIN bpk_proect bp ON bp.id = o.value
;

PROMPT *** Create  grants  W4_DKBO_WEB_OLD ***
grant SELECT                                                                 on W4_DKBO_WEB_OLD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_DKBO_WEB_OLD.sql =========*** End **
PROMPT ===================================================================================== 
