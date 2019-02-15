CREATE OR REPLACE FORCE VIEW BARS.W4_DEAL_WEB
(
    ND,
    BRANCH,
    CARD_CODE,
    PRODUCT_CODE,
    ACC_ACC,
    ACC_NLS,
    ACC_KV,
    ACC_LCV,
    ACC_OB22,
    ACC_TIP,
    ACC_TIPNAME,
    ACC_OST,
    ACC_DAOS,
    ACC_DAZS,
    CUST_RNK,
    CUST_NAME,
    CUST_OKPO,
    CUST_TYPE,
    CARD_IDAT,
    CARD_IDAT2,
    CARD_IDAT_BANKDATE,
    DOC_ID,
    BARCOD,
    COBRANDID,
    ISDKBO,
    DKBO_ID,
    DKBO_NUMBER,
    DKBO_DATE_FROM,
    DKBO_DATE_TO,
    DEAL_TYPE_ID,
    DEAL_STATE_ID,
    CARD_DATE_FROM,
    CARD_DATE_TO,
    SED,
    IS_ACC_CLOSE,
    PASS_DATE,
    PASS_STATE
)
AS
    SELECT o.nd,
           o.branch,
           o.card_code,
           o.product_code,
           o.acc
               acc_acc,
           o.nls
               acc_nls,
           o.kv
               acc_kv,
           o.lcv
               acc_lcv,
           o.ob22
               acc_ob22,
           o.tip
               acc_tip,
           o.name
               acc_tipname,
           o.ost
               acc_ost,
           o.daos
               acc_daos,
           o.dazs
               acc_dazs,
           o.rnk
               cust_rnk,
           o.nmk
               cust_name,
           o.okpo
               cust_okpo,
           o.custtype
               cust_type,
           TO_DATE (aw.VALUE, 'dd.mm.yyyy')
               card_idat,
           TO_DATE (aw.VALUE, 'dd.mm.yyyy')
               card_idat2,
           NVL (TO_DATE (aw.VALUE, 'dd.mm.yyyy'), bankdate)
               card_idat_bankdate,
           o.doc_id,
           bp1.VALUE
               BARCOD,
           bp2.VALUE
               COBRANDID,
           --0 AS isdkbo,
           DECODE (
               (SELECT /* d.id,
     d.state_id,
     d.deal_type_id,
     d.close_date,
     d.start_date,
     d.deal_number,
     avs.number_values*/
 /*                    MAX (d.id) KEEP (DENSE_RANK LAST ORDER BY av.value_date) id,
                     MAX (d.state_id) KEEP (DENSE_RANK LAST ORDER BY av.value_date) state_id,
                     MAX (d.deal_type_id) KEEP (DENSE_RANK LAST ORDER BY av.value_date) deal_type_id,
                     MAX (d.close_date) KEEP (DENSE_RANK LAST ORDER BY av.value_date) close_date,
                     MAX (d.start_date) KEEP (DENSE_RANK LAST ORDER BY av.value_date) start_date,
                     MAX (d.deal_number) KEEP (DENSE_RANK LAST ORDER BY av.value_date) deal_number,*/
                      MAX (d.id) KEEP (DENSE_RANK LAST ORDER BY av.value_date)
                          number_values
                 FROM attribute_values avs
                      JOIN
                      (SELECT /*MAX (t.nested_table_id) KEEP (DENSE_RANK LAST ORDER BY t.value_date)*/
                              t.nested_table_id,
                              t.object_id,
                              t.attribute_id,
                              t.value_date
                         FROM ATTRIBUTE_VALUE_BY_DATE t
                        WHERE t.attribute_id =
                              (SELECT ak.id
                                 FROM attribute_kind ak
                                WHERE ak.attribute_code = 'DKBO_ACC_LIST') /*GROUP BY t.object_id, t.attribute_id*/
                                                                          ) av
                          ON av.nested_table_id = avs.nested_table_id
                      JOIN deal d
                          ON     d.id = av.object_id
                             AND d.deal_type_id IN
                                     (SELECT tt.id
                                        FROM object_type tt
                                       WHERE tt.type_code = 'DKBO')
                WHERE avs.number_values = o.acc),
               NULL, 0,
               1)
               AS isdkbo,
           --MPivanova заявка COBUSUPABS-3895
           NULL
               AS dkbo_id,
           NULL
               AS dkbo_number,
           NULL
               dkbo_date_from,
           NULL
               dkbo_date_to,
           NULL
               deal_type_id,
           NULL
               deal_state_id,
           o.date_open
               card_date_from,
           o.date_close
               card_date_to,
           o.sed,
           CASE WHEN o.dazs IS NULL THEN 0 WHEN o.dazs IS NOT NULL THEN 1 END
               is_acc_close,
           o.pass_date,
           o.pass_state
      FROM (SELECT o.nd,
                   a.branch,
                   o.card_code,
                   wp.code
                       product_code,
                   a.acc,
                   a.nls,
                   a.kv,
                   t.lcv,
                   a.ob22,
                   a.tip,
                   s.name,
                   a.ostc / POWER (10, 2)
                       ost,
                   a.daos,
                   a.dazs,
                   c.rnk,
                   c.sed,                   --MPivanova заявка COBUSUPABS-3895
                   UPPER (c.nmk)
                       nmk,
                   c.okpo,
                   c.custtype,
                      'id in (select doc_id from w4_product_doc where grp_code='''
                   || wp.grp_code
                   || ''' and doc_id not like ''%MIGR%'' and type is null)'
                       doc_id,
                   cw.VALUE
                       workb,
                   wc.date_open,
                   wc.date_close,
                   o.pass_date,
                   o.pass_state
              FROM w4_acc         o,
                   accounts       a,
                   customer       c,
                   customerw      cw,
                   tips           s,
                   tabval$global  t,
                   w4_card        wc,
                   w4_product     wp,
                   w4_nbs_ob22    n
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
                   AND SUBSTR (a.nls, 1, 4) NOT IN ('2605',
                                                    '2655',
                                                    '2552',
                                                    '2554',
                                                    '2600',
                                                    '1919',
                                                    '2520')
                   AND c.rnk = cw.rnk(+)
                   AND cw.tag(+) = 'WORKB') o
           LEFT JOIN bpk_parameters bp1
               ON o.nd = bp1.nd AND bp1.tag = 'BARCOD'
           LEFT JOIN bpk_parameters bp2
               ON o.nd = bp2.nd AND bp2.tag = 'COBRANDID'
           LEFT JOIN accountsw aw ON o.acc = aw.acc AND aw.tag = 'PK_IDAT'
     WHERE (   NVL (TRIM (o.workb), 0) <> '1'
            OR o.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask'));


GRANT SELECT ON BARS.W4_DEAL_WEB TO BARSREADER_ROLE;

GRANT SELECT ON BARS.W4_DEAL_WEB TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.W4_DEAL_WEB TO UPLD;
