

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_HEADER.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_REG_HEADER ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REG_HEADER ("CUSTOMER_ID", "CUSTOMER_NAME", "CUSTOMER_OKPO", "CUSTOMER_REGION", "CUSTOMER_FULL_ADDRESS", "CUSTOMER_TYPE", "SUBS_NUMB", "SUBS_DATE", "SUBS_DOC_TYPE", "DEAL_ID", "DEAL_NUMBER", "DEAL_DATE_FROM", "DEAL_DATE_TO", "DEAL_TERM", "DEAL_PRODUCT", "DEAL_STATE", "DEAL_TYPE_CODE", "DEAL_TYPE_NAME", "DEAL_SUM", "CREDIT_STATUS_ID", "CREDIT_STATUS_NAME", "CREDIT_STATUS_CODE", "CREDIT_COMMENT", "STATE_FOR_UI", "GOOD_COST", "NLS", "ACC", "DOC_DATE", "MONEY_DATE", "COMP_SUM", "VALID_STATUS", "BRANCH_CODE", "BRANCH_NAME", "MFO", "USER_ID", "USER_NAME", "REG_TYPE_ID", "REG_KIND_ID", "REG_ID", "CREATE_DATE", "DATE_FROM", "DATE_TO", "CREDIT_COUNT", "REG_KIND_CODE", "REG_TYPE_CODE", "REG_KIND_NAME", "REG_TYPE_NAME", "CREDIT_STATUS_DATE", "OUTER_NUMBER", "NEW_DEAL_SUM", "NEW_COMP_SUM", "NEW_GOOD_COST") AS 
  SELECT rez.CUSTOMER_ID,
          rez.CUSTOMER_NAME,
          rez.CUSTOMER_OKPO,
          CASE
             WHEN rez.customer_region_reg = rez.customer_region_fact
             THEN
                rez.customer_region_reg
             ELSE
                   rez.customer_region_reg
                || DECODE (rez.customer_region_fact,
                           NULL, '',
                           ' ,' || rez.customer_region_fact)
          END
             CUSTOMER_REGION,
          CASE
             WHEN rez.customer_full_address_reg =
                     rez.customer_full_address_fact
             THEN
                rez.customer_full_address_reg
             ELSE
                   rez.customer_full_address_reg
                || ' ,'
                || rez.customer_full_address_fact
          END
             customer_full_address,
          rez.CUSTOMER_TYPE,
          rez.SUBS_NUMB,
          rez.SUBS_DATE,
          rez.SUBS_DOC_TYPE,
          rez.DEAL_ID,
          rez.DEAL_NUMBER,
          rez.DEAL_DATE_FROM,
          rez.DEAL_DATE_TO,
          rez.DEAL_TERM,
          rez.DEAL_PRODUCT,
          rez.DEAL_STATE,
          rez.DEAL_TYPE_CODE,
          rez.DEAL_TYPE_NAME,
          rez.DEAL_SUM,
          rez.credit_status_id,
          est.name credit_status_name,
          est.code credit_status_code,
          rez.credit_comment,
          'rez.' state_for_ui,
          rez.GOOD_COST,
          NVL (rez.NLS, -999) NLS,
          rez.ACC,
          rez.DOC_DATE,
          rez.MONEY_DATE,
          CASE
             WHEN     rez.deal_date_from <=
                         TO_DATE ('26/08/2015', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.3, 2) <= 5000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                ROUND (rez.deal_sum * 0.2, 2)
             WHEN     rez.deal_date_from <=
                         TO_DATE ('26/08/2015', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.2, 2) > 5000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                5000
             WHEN     rez.deal_date_from <=
                         TO_DATE ('26/08/2015', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.3, 2) <= 10000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 2
             THEN
                ROUND (rez.deal_sum * 0.3, 2)
             WHEN     rez.deal_date_from <=
                         TO_DATE ('26/08/2015', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.3, 2) > 10000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 2
             THEN
                10000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.2, 2) > 12000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                12000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.2, 2) > 12000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                12000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.2, 2) <= 12000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                ROUND (rez.deal_sum * 0.2, 2)
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.7, 2) <= 12000
                  AND rez.subs_numb IS NOT NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                ROUND (rez.deal_sum * 0.7, 2)
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.7, 2) > 12000
                  AND rez.subs_numb IS NOT NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                12000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.2, 2) > 12000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                12000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.3, 2) > 14000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 2
             THEN
                14000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.3, 2) <= 14000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 2
             THEN
                ROUND (rez.deal_sum * 0.3, 2)
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.7, 2) <= 14000
                  AND rez.subs_numb IS NOT NULL
                  AND rez.REG_TYPE_ID = 2
             THEN
                ROUND (rez.deal_sum * 0.7, 2)
             WHEN     rez.deal_date_from >=
                         TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                  AND rez.deal_date_from <
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.7, 2) > 14000
                  AND rez.subs_numb IS NOT NULL
                  AND rez.REG_TYPE_ID = 2
             THEN
                14000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.35, 2) > 12000
                  AND rez.subs_numb IS NOT NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                12000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.35, 2) <= 12000
                  AND rez.subs_numb IS NOT NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                ROUND (rez.deal_sum * 0.35, 2)
             WHEN     rez.deal_date_from >=
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.2, 2) > 12000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                12000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.2, 2) <= 12000
                  AND rez.subs_numb IS NULL
                  AND rez.REG_TYPE_ID = 1
             THEN
                ROUND (rez.deal_sum * 0.2, 2)
             WHEN     rez.deal_date_from >=
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.35, 2) > 14000
                  AND rez.REG_TYPE_ID = 2
             THEN
                14000
             WHEN     rez.deal_date_from >=
                         TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                  AND ROUND (rez.deal_sum * 0.35, 2) <= 14000
                  AND rez.REG_TYPE_ID = 2
             THEN
                ROUND (rez.deal_sum * 0.35, 2)
          END
             comp_sum,
          rez.VALID_STATUS,
          rez.BRANCH_CODE,
          rez.BRANCH_NAME,
          rez.MFO,
          rez.USER_ID,
          rez.USER_NAME,
          rez.REG_TYPE_ID,
          rez.REG_KIND_ID,
          rez.REG_ID,
          rez.CREATE_DATE,
          rez.DATE_FROM,
          rez.DATE_TO,
          1 AS credit_count,
          ek.code reg_kind_code,
          (SELECT t.code
             FROM escr_reg_types t
            WHERE t.id = rez.reg_type_id)
             reg_type_code,
          ek.name reg_kind_name,
          (SELECT t.name
             FROM escr_reg_types t
            WHERE t.id = rez.reg_type_id)
             reg_type_name,
          rez.status_date Credit_status_date,
          rez.OUTER_NUMBER,
          rez.new_deal_SUM,
          REZ.NEW_COMP_SUM,
          REZ.new_good_cost
     FROM (WITH reg_union
                AS (SELECT t.id,
                           t.in_doc_id,
                           t.in_doc_type,
                           t.out_doc_id,
                           t.out_doc_type,
                           t.branch,
                           t.oper_type,
                           t.oper_date
                      FROM escr_reg_mapping t
                     WHERE t.oper_type = 1),
                deal_sum
                AS (  SELECT c.nd deal_nd,
                             /*GREATEST (*/c.sdog * 100/*,
                                       SUM (NVL (cc_pog.sumg, 0)))*/
                                deal_sum
                        FROM /*cc_pog,*/ bars.cc_deal c
                       /*WHERE cc_pog.nd = c.nd AND (sumg > 0 OR sumo > 0)
                    GROUP BY c.nd, c.sdog*/),
                deal_term
                AS (SELECT t.nd, t.wdate
                      FROM cc_deal_update t
                     WHERE     t.chgdate = (SELECT MIN (tt.chgdate)
                                              FROM cc_deal_update tt
                                             WHERE tt.nd = t.nd)
                           AND t.chgaction = 'I'),
                deal_atr
                AS (SELECT *
                      FROM (SELECT t.nd, t.tag, t.txt
                              FROM nd_txt t
                             WHERE t.tag IN ('ES000',
                                             'ES007',
                                             'ES001',
                                             'ES002',
                                             'ES003',
                                             'ES006',
                                             'ES007',
                                             'ES008',
                                             'ES010',
                                             'ES011',
                                             'ES012')) PIVOT (MAX (txt)
                                                       FOR tag
                                                       IN  ('ES000' AS credit_status_ID,
                                                           'ES007' AS credit_status_comment,
                                                           'ES001' AS good_cost,
                                                           'ES002' AS doc_date,
                                                           'ES003' AS money_date,
                                                           'ES006' AS status_date,
                                                           'ES007' AS credit_comment,
                                                           'ES008' AS OUTER_NUMBER,
                                                           'ES010' AS new_good_cost,
                                                           'ES011' AS new_deal_sum,
                                                           'ES012' AS new_comp_sum))),
                customer_subs
                AS (SELECT *
                      FROM (SELECT t.rnk, t.tag, t.VALUE
                              FROM customerw t
                             WHERE t.tag IN ('SUBSN', 'SUBSD', 'SUBDT')) PIVOT (MAX (
                                                                                   VALUE)
                                                                         FOR tag
                                                                         IN  ('SUBSN' AS subs_numb,
                                                                             'SUBSD' AS subs_date,
                                                                             'SUBDT' AS subs_doc_type)))
           SELECT c.rnk customer_id,
                  REGEXP_REPLACE (
                     REPLACE (
                        INITCAP (
                           REPLACE (
                              REPLACE (REPLACE (c.nmk, '''', '999'),
                                       '`',
                                       ''''),
                              '’',
                              '''')),
                        '999',
                        ''''),
                     '( ){2,}',
                     ' ')
                     customer_name,
                  CASE
                     WHEN     TRIM (c.okpo) IS NOT NULL
                          AND c.okpo NOT IN ('0000000000',
                                             '000000000',
                                             '9999999999')
                     THEN
                        c.okpo
                     WHEN TRIM (c.okpo) IN ('0000000000',
                                            '9999999999',
                                            '000000000')
                     THEN
                           'Â³äì³òêà ïðî â³äñóòí³ñòü : '
                        || p.ser
                        || ' '
                        || p.numdoc
                        || ' â³ä '
                        || TO_CHAR (p.pdate, 'dd/mm/yyyy')
                  END
                     customer_okpo,
                  TRIM (
                     INITCAP (
                        REGEXP_REPLACE (
                           UPPER (TRIM (ca_reg.domain)),
                           '(ÊÈ¯Â$|ÎÁËÀÑÒÜ|ÎÁË.|ÊÈ¯Â, Ì²ÑÒÎ)',
                           '')))
                     customer_region_reg,
                  TRIM (
                        DECODE (
                           TRIM (ca_reg.region),
                           NULL, '',
                              INITCAP (
                                 REGEXP_REPLACE (
                                    TRIM (LOWER (ca_reg.region)),
                                    '(ðàéîí$|ð-í\.|ð-í)',
                                    ''))
                           || ' ð-í.,')
                     || DECODE (lt.SETTLEMENT_TP_CODE,
                                NULL, ' ',
                                LOWER (lt.SETTLEMENT_TP_CODE || ' '))
                     || DECODE (ca_reg.locality,
                                NULL, '',
                                ca_reg.locality || ', ')
                     || INITCAP (ca_reg.address))
                     customer_full_address_reg,
                  TRIM (
                     INITCAP (
                        REGEXP_REPLACE (
                           UPPER (TRIM (ca_fact.domain)),
                           '(ÊÈ¯Â$|ÎÁËÀÑÒÜ|ÎÁË.|ÊÈ¯Â, Ì²ÑÒÎ)',
                           '')))
                     customer_region_fact,
                  CASE
                     WHEN ca_fact.type_id = 2
                     THEN
                        TRIM (
                              DECODE (
                                 TRIM (ca_fact.region),
                                 NULL, '',
                                    INITCAP (
                                       REGEXP_REPLACE (
                                          TRIM (LOWER (ca_fact.region)),
                                          '(ðàéîí$|ð-í\.|ð-í)',
                                          ''))
                                 || ' ð-í.,')
                           || DECODE (lt.SETTLEMENT_TP_CODE,
                                      NULL, ' ',
                                      LOWER (lt.SETTLEMENT_TP_CODE || ' '))
                           || DECODE (ca_fact.locality,
                                      NULL, '',
                                      ca_fact.locality || ', ')
                           || INITCAP (ca_fact.address))
                  END
                     customer_full_address_fact,
                  c.custtype customer_type,
                  cs.subs_numb,
                  TO_DATE (cs.subs_date, 'dd/mm/yyyy') subs_date,
                  cs.subs_doc_type subs_doc_type,
                  t.nd deal_id,
                  t.cc_id deal_number,
                  t.sdate deal_date_from,
                  t.wdate deal_date_to,
                  ROUND (MONTHS_BETWEEN (dt.wdate, t.sdate), 0) deal_term,
                  t.prod deal_product,
                  ccs.name deal_state,
                  t.vidd deal_type_code,
                  t1.name deal_type_name,
                  ds.deal_sum / 100 deal_sum,
                  da.good_cost good_cost,
                  TO_NUMBER (da.credit_status_ID) credit_status_id,
                  da.credit_status_comment credit_comment,
                  (SELECT a.nls
                     FROM nd_acc na, accounts a
                    WHERE     a.nbs IN ('2620')
                          AND a.dazs IS NULL
                          AND na.acc = a.acc
                          AND na.nd = t.nd
                          AND ROWNUM = 1)
                     AS nls,
                  ac.acc,
                  da.doc_date AS doc_date,
                  da.money_date,
                  da.new_deal_sum,
                  da.new_good_cost,
                  da.new_comp_sum,
                  da.status_date,
                  da.OUTER_NUMBER, /*CASE
                                            WHEN   round((NVL (to_number(replace(da.good_cost,',','.')), 0) - (ds.deal_sum / 100))
                                                 * 100
                                                 / (ds.deal_sum / 100)) >= 10   THEN 1
                                            WHEN   round((NVL (to_number(replace(da.good_cost,',','.')), 0) - (ds.deal_sum / 100))
                                                 * 100
                                                 / (ds.deal_sum / 100)) < 10  THEN 0
                                         END valid_status*/
                  CASE                  ---(ñóììà òîâàðà*0.9)-ñóììà êðåäèòà>0.
                     WHEN   (  TO_NUMBER (REPLACE (da.good_cost, ',', '.'))
                             * 0.9)
                          - (ds.deal_sum / 100) <= 0
                     THEN
                        1
                     WHEN   (  TO_NUMBER (REPLACE (da.good_cost, ',', '.'))
                             * 0.9)
                          - (ds.deal_sum / 100) > 0
                     THEN
                        0
                  END
                     valid_status /*    CASE  ---(ñóììà òîâàðà*0.9)-ñóììà êðåäèòà>0.
                                               WHEN   (TO_number(trim(da.good_cost),
                                                       '99999999999D99999',
                                                       'NLS_NUMERIC_CHARACTERS = '', ''')*0.9) - (ds.deal_sum / 100)<=0 THEN 1
                                               WHEN   (TO_number(trim(da.good_cost),
                                                       '99999999999D99999',
                                                       'NLS_NUMERIC_CHARACTERS = '', ''')*0.9*0.9) - (ds.deal_sum/ 100)> 0 THEN 0
                                       END valid_status*/
                                 ,
                  t.branch branch_code,
                  b.name branch_name,
                  t.kf mfo,
                  er.user_id user_id,
                  er.user_name user_name,
                  CASE
                     WHEN SUBSTR (t.prod, 1, 6) IN ('220347', '220257', '220373')
                     THEN
                        TO_NUMBER (1)
                     ELSE
                        TO_NUMBER (2)
                  END
                     reg_type_id,
                  CASE
                     WHEN     cs.subs_numb IS NOT NULL
                          AND t.sdate < TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (1)
                     WHEN     cs.subs_numb IS NULL
                          AND t.sdate < TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                          AND t.sdate < TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (2)
                     WHEN     cs.subs_numb IS NULL
                          AND t.sdate >= TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                          AND t.sdate < TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (3)
		     WHEN     EXTRACT (YEAR FROM t.sdate) >= 2017
                          AND SUBSTR (t.prod, 1, 6) NOT IN ('220257',
                                                            '220347'
                                                            ,'220373')
                          AND t.sdate >= TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (6)
                     WHEN     cs.subs_numb IS NOT NULL
                          AND EXTRACT (YEAR FROM t.sdate) <> 2017
                          AND t.sdate >= TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (4)
                     WHEN     cs.subs_numb IS NULL
                          AND EXTRACT (YEAR FROM t.sdate) <> 2017
                          AND t.sdate >= TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (5)
                     WHEN     cs.subs_numb IS NOT NULL
                          AND EXTRACT (YEAR FROM t.sdate) >= 2017
                          AND SUBSTR (t.prod, 1, 6) IN ('220257', '220347', '220373')
                          AND t.sdate >= TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (4)
                     WHEN     cs.subs_numb IS NULL
                          AND EXTRACT (YEAR FROM t.sdate) >= 2017
                          AND SUBSTR (t.prod, 1, 6) IN ('220257', '220347', '220373')
                          AND t.sdate >= TO_DATE ('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (5)
                  END
                     reg_kind_id,
                  CASE
                     WHEN ru.id IS NOT NULL THEN ru.in_doc_id
                     WHEN ru.id IS NULL THEN rm.in_doc_id
                  END
                     reg_id,
                  er.create_date,
                  er.date_from,
                  er.date_to
             FROM escr_reg_mapping rm
                  JOIN cc_deal t ON rm.out_doc_id = t.nd
                  --and t.kf LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
                  JOIN deal_term dt ON dt.nd = t.nd
                  /*join credit_status crs
                   on  t.nd=crs.obj_id
                   and crs.id=(select max(ros.id)  from escr_reg_obj_state ros  where ros.obj_id=t.nd)*/
                  JOIN cc_vidd t1 ON t.vidd = t1.vidd
                  JOIN staff$base s ON t.user_id = s.id
                  JOIN branch b ON b.branch = t.branch
                  JOIN customer c ON c.rnk = t.rnk
                  JOIN bars.customer_address ca_reg
                     ON c.rnk = ca_reg.rnk AND ca_reg.type_id = 1
                  LEFT JOIN bars.customer_address ca_fact
                     ON c.rnk = ca_fact.rnk AND ca_fact.type_id = 2
                  LEFT JOIN bars.ADR_SETTLEMENT_TYPES lt
                     ON lt.SETTLEMENT_TP_ID = ca_reg.locality_type
                  JOIN cc_add ad ON ad.nd = t.nd
                  JOIN accounts ac ON ad.accs = ac.acc
                  JOIN deal_sum ds ON t.nd = ds.deal_nd
                  JOIN cc_sos ccs ON t.sos = ccs.sos
                  LEFT JOIN deal_atr da ON da.nd = t.nd
                  LEFT JOIN customer_subs cs ON cs.rnk = c.rnk
                  LEFT JOIN reg_union ru ON rm.in_doc_id = ru.out_doc_id
                  JOIN person p ON p.rnk = c.rnk
                  JOIN escr_register er ON er.id = rm.in_doc_id
            WHERE c.custtype = '3') rez
          JOIN escr_reg_kind ek ON rez.reg_kind_id = ek.id
          JOIN escr_reg_status est ON rez.credit_status_id = est.id
;

PROMPT *** Create  grants  VW_ESCR_REG_HEADER ***
grant SELECT                                                                 on VW_ESCR_REG_HEADER to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_REG_HEADER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_REG_HEADER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_HEADER.sql =========*** End
PROMPT ===================================================================================== 
