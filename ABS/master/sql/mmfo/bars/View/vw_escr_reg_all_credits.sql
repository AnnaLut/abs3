
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/vw_escr_reg_all_credits.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REG_ALL_CREDITS ("CUSTOMER_ID", "CUSTOMER_NAME", "CUSTOMER_OKPO", "CUSTOMER_REGION", "CUSTOMER_FULL_ADDRESS", "CUSTOMER_TYPE", "SUBS_NUMB", "SUBS_DATE", "SUBS_DOC_TYPE", "DEAL_ID", "DEAL_NUMBER", "DEAL_DATE_FROM", "DEAL_DATE_TO", "DEAL_TERM", "DEAL_PRODUCT", "DEAL_STATE", "DEAL_TYPE_CODE", "DEAL_TYPE_NAME", "DEAL_SUM", "CREDIT_STATUS_ID", "CREDIT_STATUS_NAME", "CREDIT_STATUS_CODE", "CREDIT_COMMENT", "STATE_FOR_UI", "GOOD_COST", "NLS", "ACC", "DOC_DATE", "MONEY_DATE", "COMP_SUM", "VALID_STATUS", "BRANCH_CODE", "BRANCH_NAME", "MFO", "USER_ID", "USER_NAME", "REG_KIND_CODE", "REG_KIND_NAME", "REG_TYPE_CODE", "REG_TYPE_NAME", "CREDIT_STATUS_DATE", "OUTER_NUMBER", "NEW_DEAL_SUM", "NEW_COMP_SUM", "NEW_GOOD_COST", "REG_TYPE_ID", "REG_KIND_ID", "STATE_PRIORITY", "SUBS_AVAILABLE", "AVR_DATE") AS 
  SELECT rez.customer_id,
          rez.customer_name,
          rez.customer_okpo,
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
          rez.customer_type,
          rez.subs_numb,
          rez.subs_date,
          rez.subs_doc_type,
          rez.deal_id,
          rez.deal_number,
          rez.deal_date_from,
          rez.deal_date_to,
          rez.deal_term,
          rez.deal_product,
          rez.deal_state,
          rez.deal_type_code,
          rez.deal_type_name,
          rez.deal_sum,
          rez.credit_status_id,
          rez.credit_status_name,
          rez.credit_status_code,
          rez.credit_comment,
          CASE
             WHEN    rez.credit_status_id IN (5,
                                              8,
                                              9,
                                              13,
                                              15,
                                              16)
                  OR ( (NVL (rez.good_cost, 0) * 0.9) - (rez.deal_sum / 100) <=
                         0)
             THEN
                'ERROR'
             WHEN rez.credit_status_id IN (10)
             THEN
                'SUCCESS'
          END
             state_for_ui,
          rez.good_cost,
          NVL (rez.nls, -999) nls,
          1 AS acc,
          rez.doc_date,
          rez.money_date,
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
          /*          CASE
                       WHEN   (NVL (rez.good_cost, 0) - (rez.deal_sum / 100))
                            * 100
                            / (rez.deal_sum / 100) >= 10 THEN 1
                       WHEN   (NVL (rez.good_cost, 0) - (rez.deal_sum / 100))
                            * 100
                            / (rez.deal_sum / 100) < 10 THEN 0
                    END valid_status,*/
          CASE                          ---(ñóììà òîâàðà*0.9)-ñóììà êðåäèòà>0.
             WHEN ( (NVL (rez.good_cost, 0) * 0.9) - (rez.deal_sum / 100) <=
                      0)
             THEN
                1
             WHEN ( (NVL (rez.good_cost, 0) * 0.9) - (rez.deal_sum / 100) > 0)
             THEN
                0
          END
             valid_status,
          rez.branch_code,
          rez.branch_name,
          rez.mfo,
          rez.user_id,
          rez.user_name,
          ek.code reg_kind_code,
          ek.name reg_kind_name,
          et.code reg_type_code,
          et.name reg_type_name,
          rez.status_date Credit_status_date,
          rez.OUTER_NUMBER,
          rez.new_deal_SUM,
          REZ.NEW_COMP_SUM,
          REZ.new_good_cost,
          rez.reg_type_id,
          rez.reg_kind_id,
          rez.state_priority,
          rez.subs_available,
          rez.avr_date
     FROM (WITH deal_sum
                AS (  SELECT c.nd deal_nd,
                             /*GREATEST (*/c.sdog * 100/*,
                                       SUM (NVL (cc_pog.sumg, 0)))*/
                                deal_sum
                        FROM /*cc_pog,*/ bars.cc_deal c
                       /*WHERE cc_pog.nd = c.nd AND (sumg > 0 OR sumo > 0)
                    GROUP BY c.nd, c.sdog*/),
                deal_term
                AS (SELECT t.nd, t.wdate
                      FROM bars.cc_deal_update t
                     WHERE     t.chgdate = (SELECT MIN (tt.chgdate)
                                              FROM bars.cc_deal_update tt
                                             WHERE tt.nd = t.nd)
                           AND t.chgaction = 'I'),
                deal_atr
                AS (SELECT *
                      FROM (SELECT t.nd, t.tag, t.txt
                              FROM nd_txt t
                             WHERE t.tag IN ('ES000',
                                             'ES001',
                                             'ES002',
                                             'ES003',
                                             'ES006',
                                             'ES007',
                                             'ES008',
                                             'ES010',
                                             'ES011',
                                             'ES012',
                                             'ES013')) PIVOT (MAX (txt)
                                                       FOR tag
                                                       IN  ('ES000' AS credit_status,
                                                           'ES001' AS good_cost,
                                                           'ES002' AS doc_date,
                                                           'ES003' AS money_date,
                                                           'ES006' AS status_date,
                                                           'ES007' AS credit_comment,
                                                           'ES008' AS OUTER_NUMBER,
                                                           'ES010' AS new_good_cost,
                                                           'ES011' AS new_deal_sum,
                                                           'ES012' AS new_comp_sum,
                                                           'ES013' AS avr_date))),
                customer_subs
                AS (SELECT *
                      FROM (SELECT t.rnk, t.tag, t.VALUE
                              FROM bars.customerw t
                             WHERE t.tag IN ('SUBSN',
                                             'SUBSD',
                                             'SUBDT',
                                             'SUBS')) PIVOT (MAX (VALUE)
                                                      FOR tag
                                                      IN  ('SUBSN' AS subs_numb,
                                                          'SUBSD' AS subs_date,
                                                          'SUBDT' AS subs_doc_type,
                                                          'SUBS' AS subs_available)))
           SELECT                                                   --customer
                 c.rnk customer_id,
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
                  DECODE (cs.subs_available, NULL, 0, cs.subs_available)
                     subs_available,
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
                  da.credit_status credit_status_id,
                  (SELECT t1.name
                     FROM bars.escr_reg_status t1
                    WHERE t1.id = TO_NUMBER (da.credit_status))
                     credit_status_name,
                  (SELECT t1.code
                     FROM bars.escr_reg_status t1
                    WHERE t1.id = TO_NUMBER (da.credit_status))
                     credit_status_code,
                  da.credit_comment credit_comment,
                  ds.deal_sum / 100 deal_sum,
                  CASE
                     WHEN da.good_cost IS NULL
                     THEN
                        0
                     ELSE
                        TO_NUMBER (
                           REPLACE (
                              REGEXP_REPLACE (TRIM (da.good_cost), '( )', ''),
                              ',',
                              '.'))
                  END
                     good_cost,
                  (SELECT a.nls
                     FROM bars.nd_acc na, bars.accounts a
                    WHERE     a.nbs IN ('2620')
                          AND a.dazs IS NULL
                          AND na.acc = a.acc
                          AND na.nd = t.nd
                          AND ROWNUM = 1)
                     AS nls,
                  '' acc,
                  da.doc_date,
                  da.money_date,
                  da.new_deal_sum,
                  da.new_good_cost,
                  da.new_comp_sum,
                  da.status_date,
                  da.OUTER_NUMBER,
                  da.avr_date,
                  t.branch branch_code,
                  b.name branch_name,
                  t.kf mfo,
                  t.user_id user_id,
                  s.fio user_name,
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
                     WHEN     EXTRACT (YEAR FROM t.sdate) = 2017
                          AND SUBSTR (t.prod, 1, 6) NOT IN ('220257',
                                                            '220347',
                                                            '220373')
                     THEN
                        TO_NUMBER (6)
                  END
                     reg_kind_id,
                  (SELECT t1.priority
                     FROM bars.escr_reg_status t1
                    WHERE t1.id = TO_NUMBER (da.credit_status))
                     state_priority
             FROM bars.cc_deal t
                  JOIN bars.cc_vidd t1 ON t.vidd = t1.vidd
                  JOIN deal_term dt ON dt.nd = t.nd
                  JOIN bars.staff$base s ON t.user_id = s.id
                  JOIN bars.branch b ON b.branch = t.branch
                  JOIN bars.customer c ON c.rnk = t.rnk
                  JOIN bars.customer_address ca_reg
                     ON c.rnk = ca_reg.rnk AND ca_reg.type_id = 1
                  LEFT JOIN bars.customer_address ca_fact
                     ON c.rnk = ca_fact.rnk AND ca_fact.type_id = 2
                  LEFT JOIN bars.ADR_SETTLEMENT_TYPES lt
                     ON lt.SETTLEMENT_TP_ID = ca_reg.locality_type
                  JOIN bars.cc_add ad ON ad.nd = t.nd
                  JOIN deal_sum ds ON t.nd = ds.deal_nd
                  JOIN bars.cc_sos ccs ON t.sos = ccs.sos
                  LEFT JOIN deal_atr da ON da.nd = t.nd
                  LEFT JOIN customer_subs cs ON cs.rnk = c.rnk
                  JOIN bars.person p ON p.rnk = c.rnk
            WHERE t.sdate >= to_date('01.04.2018','dd.mm.yyyy')
                  and c.custtype = '3'
                  AND t.nd NOT IN (SELECT er.deal_numb
                                     FROM bars.vw_escr_errors er)
                  AND t.sos IN (10, 13, 15)
                  AND t.vidd IN (11, 12, 13)
                  AND SUBSTR (t.prod, 1, 6) IN ('220257',
                                                '220258',
                                                '220347',
                                                '220348',
                                                '220372',
                                                '220373',
												'220374')
                  AND t.branch LIKE
                            SYS_CONTEXT ('bars_context', 'user_branch_mask')
                         || '%') rez
          JOIN bars.escr_reg_kind ek ON rez.reg_kind_id = ek.id
          JOIN bars.escr_reg_types et ON rez.reg_type_id = et.id
;
 show err;
 
PROMPT *** Create  grants  VW_ESCR_REG_ALL_CREDITS ***
grant SELECT                                                                 on VW_ESCR_REG_ALL_CREDITS to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_REG_ALL_CREDITS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_REG_ALL_CREDITS to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/vw_escr_reg_all_credits.sql =========**
 PROMPT ===================================================================================== 
 