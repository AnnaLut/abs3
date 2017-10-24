

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_HEADER.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_REG_HEADER ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REG_HEADER ("CUSTOMER_ID", "CUSTOMER_NAME", "CUSTOMER_OKPO", "CUSTOMER_REGION", "CUSTOMER_FULL_ADDRESS", "CUSTOMER_TYPE", "SUBS_NUMB", "SUBS_DATE", "SUBS_DOC_TYPE", "DEAL_ID", "DEAL_NUMBER", "DEAL_DATE_FROM", "DEAL_DATE_TO", "DEAL_TERM", "DEAL_PRODUCT", "DEAL_STATE", "DEAL_TYPE_CODE", "DEAL_TYPE_NAME", "DEAL_SUM", "CREDIT_STATUS_ID", "CREDIT_STATUS_NAME", "CREDIT_STATUS_CODE", "CREDIT_COMMENT", "STATE_FOR_UI", "GOOD_COST", "NLS", "ACC", "DOC_DATE", "MONEY_DATE", "COMP_SUM", "VALID_STATUS", "BRANCH_CODE", "BRANCH_NAME", "MFO", "USER_ID", "USER_NAME", "REG_TYPE_ID", "REG_KIND_ID", "REG_ID", "CREATE_DATE", "DATE_FROM", "DATE_TO", "CREDIT_COUNT", "REG_KIND_CODE", "REG_TYPE_CODE", "REG_KIND_NAME", "REG_TYPE_NAME", "CREDIT_STATUS_DATE", "OUTER_NUMBER", "NEW_DEAL_SUM", "NEW_COMP_SUM", "NEW_GOOD_COST") AS 
  SELECT rez.CUSTOMER_ID
       ,rez.CUSTOMER_NAME
       ,rez.CUSTOMER_OKPO
          ,case when  rez.customer_region_reg=rez.customer_region_fact then rez.customer_region_reg else
          rez.customer_region_reg||decode(rez.customer_region_fact,null,'',' ,'|| rez.customer_region_fact) end CUSTOMER_REGION,
          case when rez.customer_full_address_reg=rez.customer_full_address_fact then rez.customer_full_address_reg else
              rez.customer_full_address_reg||' ,'|| rez.customer_full_address_fact end customer_full_address,
       rez.CUSTOMER_TYPE
       ,rez.SUBS_NUMB
       ,rez.SUBS_DATE
       ,rez.SUBS_DOC_TYPE
       ,rez.DEAL_ID
       ,rez.DEAL_NUMBER
       ,rez.DEAL_DATE_FROM
       ,rez.DEAL_DATE_TO
       ,rez.DEAL_TERM
       ,rez.DEAL_PRODUCT
       ,rez.DEAL_STATE
       ,rez.DEAL_TYPE_CODE
       ,rez.DEAL_TYPE_NAME
       ,rez.DEAL_SUM
       ,rez.credit_status_id
       ,est.name credit_status_name
       ,est.code credit_status_code
       ,rez.credit_comment
       ,'rez.' state_for_ui
       ,rez.GOOD_COST
       ,nvl(rez.NLS,-999) NLS
       ,rez.ACC
       ,rez.DOC_DATE
       ,rez.MONEY_DATE
      ,CASE
   WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy')
        AND round(rez.deal_sum  * 0.3, 2)<=5000
        AND rez.subs_numb IS NULL
        and rez.REG_TYPE_ID=1 THEN
    round(rez.deal_sum  * 0.2 , 2)
   WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy')
        AND round(rez.deal_sum  * 0.2 ,2)>5000
        AND rez.subs_numb IS NULL
         and rez.REG_TYPE_ID=1 THEN
    5000
   WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy')
        AND round(rez.deal_sum  * 0.3, 2)<=10000
        AND rez.subs_numb IS NULL
        and rez.REG_TYPE_ID=2 THEN
    round(rez.deal_sum  * 0.3 , 2)
   WHEN rez.deal_date_from<= to_date('26/08/2015', 'dd/mm/yyyy')
        AND round(rez.deal_sum  * 0.3 ,2)>10000
        AND rez.subs_numb IS NULL
         and rez.REG_TYPE_ID=2 THEN
    10000
 WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
        and round(rez.deal_sum* 0.2, 2)> 12000
        AND rez.subs_numb IS NULL
        and rez.REG_TYPE_ID=1 THEN
    12000
 WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
        and round(rez.deal_sum* 0.2, 2)> 12000
        AND rez.subs_numb IS NULL
        and rez.REG_TYPE_ID=1 THEN
    12000
   WHEN rez.deal_date_from  >= to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
        AND round(rez.deal_sum * 0.2, 2) <= 12000
        AND rez.subs_numb IS NULL
        and rez.REG_TYPE_ID=1 THEN
    round(rez.deal_sum  * 0.2, 2)
   WHEN rez.deal_date_from>= to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
      and  round(rez.deal_sum  * 0.7, 2)<= 12000
        AND rez.subs_numb IS NOT NULL
        and rez.REG_TYPE_ID=1 THEN
    round(rez.deal_sum  * 0.7, 2)
  WHEN rez.deal_date_from > =to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
        AND round(rez.deal_sum * 0.7, 2) > 12000
        AND rez.subs_numb IS NOT NULL
        and rez.REG_TYPE_ID=1 THEN
    12000
   WHEN rez.deal_date_from>=to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
        and round(rez.deal_sum* 0.2, 2)> 12000
        AND rez.subs_numb IS  NULL
        and rez.REG_TYPE_ID=1 THEN
    12000
 WHEN rez.deal_date_from>= to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
        and round(rez.deal_sum* 0.3, 2)> 14000
        AND rez.subs_numb IS NULL
        and rez.REG_TYPE_ID=2 THEN
    14000
   WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
        AND round(rez.deal_sum * 0.3, 2) <= 14000
        AND rez.subs_numb IS NULL
        and rez.REG_TYPE_ID=2 THEN
    round(rez.deal_sum  * 0.3, 2)
   WHEN rez.deal_date_from>= to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
      and  round(rez.deal_sum  * 0.7, 2)<= 14000
        AND rez.subs_numb IS NOT NULL
        and rez.REG_TYPE_ID=2 THEN
    round(rez.deal_sum  * 0.7, 2)
  WHEN rez.deal_date_from> =to_date('27/08/2015', 'dd/mm/yyyy') and rez.deal_date_from <to_date('19/09/2016', 'dd/mm/yyyy')
        AND round(rez.deal_sum * 0.7, 2) > 14000
        AND rez.subs_numb IS NOT NULL
        and rez.REG_TYPE_ID=2 THEN
    14000
  WHEN rez.deal_date_from>= to_date('19/09/2016', 'dd/mm/yyyy')
        and round(rez.deal_sum* 0.35, 2)> 12000
        AND rez.subs_numb IS not NULL
        and rez.REG_TYPE_ID=1 THEN
    12000
 WHEN rez.deal_date_from>= to_date('19/09/2016', 'dd/mm/yyyy')
      and  round(rez.deal_sum  * 0.35, 2)<= 12000
        AND rez.subs_numb IS not NULL
        and rez.REG_TYPE_ID=1 THEN
     round(rez.deal_sum  * 0.35, 2)
 WHEN rez.deal_date_from>= to_date('19/09/2016', 'dd/mm/yyyy')
        and round(rez.deal_sum* 0.2, 2)> 12000
        AND rez.subs_numb IS  NULL
        and rez.REG_TYPE_ID=1 THEN
    12000
 WHEN rez.deal_date_from>= to_date('19/09/2016', 'dd/mm/yyyy')
      and  round(rez.deal_sum  * 0.2, 2)<= 12000
        AND rez.subs_numb IS  NULL
        and rez.REG_TYPE_ID=1 THEN
     round(rez.deal_sum  * 0.2, 2)
  WHEN rez.deal_date_from>= to_date('19/09/2016', 'dd/mm/yyyy')
        and round(rez.deal_sum* 0.35, 2)> 14000
        and rez.REG_TYPE_ID=2 THEN
    14000
            WHEN rez.deal_date_from>= to_date('19/09/2016', 'dd/mm/yyyy')
        and round(rez.deal_sum* 0.35, 2)<= 14000
        and rez.REG_TYPE_ID=2 THEN
     round(rez.deal_sum  * 0.35, 2)
END comp_sum
       ,rez.VALID_STATUS
       ,rez.BRANCH_CODE
       ,rez.BRANCH_NAME
       ,rez.MFO
       ,rez.USER_ID
       ,rez.USER_NAME
       ,rez.REG_TYPE_ID
       ,rez.REG_KIND_ID
       ,rez.REG_ID
       ,rez.CREATE_DATE
       ,rez.DATE_FROM
       ,rez.DATE_TO
       ,1 as credit_count
       ,ek.code reg_kind_code
       ,(SELECT t.code FROM escr_reg_types t WHERE t.id = rez.reg_type_id) reg_type_code
       ,ek.name reg_kind_name
       ,(SELECT t.name FROM escr_reg_types t WHERE t.id = rez.reg_type_id) reg_type_name
       ,rez.status_date Credit_status_date
       ,rez.OUTER_NUMBER
       ,rez.new_deal_SUM
       ,REZ.NEW_COMP_SUM
       ,REZ.new_good_cost
  FROM (
  WITH
  credit_status as (
  SELECT os.id,os.obj_id, os.status_id, os.status_comment,os.obj_type,os.set_date
    FROM escr_reg_obj_state os
   WHERE os.obj_type = 0)
   , reg_union AS
   (SELECT t.id
          ,t.in_doc_id
          ,t.in_doc_type
          ,t.out_doc_id
          ,t.out_doc_type
          ,t.branch
          ,t.oper_type
          ,t.oper_date
      FROM escr_reg_mapping t
     WHERE t.oper_type = 1),
  deal_sum AS
   (SELECT c.nd deal_nd
          ,greatest(c.sdog * 100, SUM(nvl(cc_pog.sumg, 0))) deal_sum
      FROM cc_pog, cc_deal c
     WHERE cc_pog.nd = c.nd
       AND (sumg > 0 OR sumo > 0)
     GROUP BY c.nd, c.sdog)
   ,deal_term as (SELECT t.nd,t.wdate
  FROM cc_deal_update t
 WHERE  t.chgdate =   (SELECT MIN(tt.chgdate) FROM cc_deal_update tt WHERE tt.nd = t.nd )
   and t.chgaction='I')
, deal_atr
                   AS (SELECT *
                         FROM (SELECT t.nd, t.tag, t.txt
                                 FROM nd_txt t
                                WHERE t.tag IN
                                         ('ES000',
                                          'ES001',
                                          'ES002',
                                          'ES003'
                                          ,'ES006'
                                          ,'ES007'
                                          ,'ES008'
                                          ,'ES010'
                                         ,'ES011'
                                         ,'ES012'
                                          )) PIVOT (MAX (txt)
                                                    FOR tag
                                                    IN  ('ES000' AS credit_status
                                                        ,'ES001' AS good_cost
                                                        ,'ES002' AS doc_date
                                                        ,'ES003' AS money_date
                                                        ,'ES006' as status_date
                                                        ,'ES007' AS credit_comment
                                                        ,'ES008' as OUTER_NUMBER
                                                        ,'ES010' as new_good_cost
                                                        ,'ES011' as new_deal_sum
                                                       ,'ES012' as new_comp_sum
                                                        )))
  ,customer_subs AS
   (SELECT *
      FROM (SELECT t.rnk, t.tag, t.value
              FROM customerw t
             WHERE t.tag IN ('SUBSN', 'SUBSD', 'SUBDT')) pivot(MAX(VALUE) FOR tag IN('SUBSN' AS
                                                                                     subs_numb
                                                                                    ,'SUBSD' AS
                                                                                     subs_date
                                                                                    ,'SUBDT' AS
                                                                                     subs_doc_type)))
  SELECT
--customer
 c.rnk customer_id
,REGEXP_REPLACE (
                     REPLACE (INITCAP (replace(replace(REPLACE (c.nmk, '''', '999'),'`',''''),'’','''')),
                              '999',
                              ''''),
                     '( ){2,}',
                     ' ')
                     customer_name
, CASE
                     WHEN TRIM (c.okpo) IS NOT NULL
                          AND c.okpo NOT IN
                                 ('0000000000', '000000000', '9999999999')
                     THEN
                        c.okpo
                     WHEN TRIM (c.okpo) IN
                             ('0000000000', '9999999999', '000000000')
                     THEN
                        'Â³äì³òêà ïðî â³äñóòí³ñòü : '
                        || p.ser
                        || ' '
                        || p.numdoc
                        || ' â³ä '
                        || TO_CHAR (p.pdate, 'dd/mm/yyyy')           END
                     customer_okpo
,                  TRIM (
                     INITCAP (
                        REGEXP_REPLACE (
                           upper(TRIM (ca_reg.domain)),
                         '(ÊÈ¯Â$|ÎÁËÀÑÒÜ|ÎÁË.|ÊÈ¯Â, Ì²ÑÒÎ)',
                           '')))
                    customer_region_reg,
                       trim(decode(TRIM (ca_reg.region),null,'',initcap(REGEXP_REPLACE (TRIM (lower(ca_reg.region)),
                                  '(ðàéîí$|ð-í\.|ð-í)',
                                  ''))||' ð-í.,')
                  || decode (lt.SETTLEMENT_TP_CODE,null,' ',lower(lt.SETTLEMENT_TP_CODE||' '))
                  || decode (ca_reg.locality,null,'',ca_reg.locality||', ')
                  || initcap(ca_reg.address))
                    customer_full_address_reg,
                    TRIM (
                     INITCAP (
                        REGEXP_REPLACE (
                           upper(TRIM (ca_fact.domain)),
                         '(ÊÈ¯Â$|ÎÁËÀÑÒÜ|ÎÁË.|ÊÈ¯Â, Ì²ÑÒÎ)',
                           '')))
                     customer_region_fact,
                       case when ca_fact.type_id=2 then trim(decode(TRIM (ca_fact.region),null,'',initcap(REGEXP_REPLACE (TRIM (lower(ca_fact.region)),
                                  '(ðàéîí$|ð-í\.|ð-í)',
                                  ''))||' ð-í.,')
                  || decode (lt.SETTLEMENT_TP_CODE,null,' ',lower(lt.SETTLEMENT_TP_CODE||' '))
                  || decode (ca_fact.locality,null,'',ca_fact.locality||', ')
                  || initcap(ca_fact.address))
                   end  customer_full_address_fact,
c.custtype customer_type
   -- subsidy info
  ,cs.subs_numb
  ,to_date(cs.subs_date,'dd/mm/yyyy') subs_date
  ,cs.subs_doc_type subs_doc_type
   --deal generel inf
  ,t.nd    deal_id
  ,t.cc_id deal_number
   -- deal dates
  ,t.sdate deal_date_from
  ,t.wdate deal_date_to
  ,round(months_between(dt.wdate, t.sdate), 0) deal_term
   -- deal status,state and others
  ,t.prod   deal_product
  ,ccs.name deal_state
  ,t.vidd   deal_type_code
  ,t1.name  deal_type_name
   --deal sum
  ,ds.deal_sum / 100 deal_sum
  ,da.good_cost good_cost
  -- deal status in register
  ,crs.status_id   credit_status_id
  ,crs.STATUS_COMMENT  credit_comment
   -- accounts
  ,(SELECT a.nls/*,a.acc,na.nd*/
          FROM nd_acc na, accounts a
         WHERE a.nbs IN ('2620')
           AND a.dazs IS NULL
           AND na.acc = a.acc
           and  na.nd = t.nd and
          rownum=1) as nls--ac.nls
  ,ac.acc
   -- info about compensation  doc
  ,da.doc_date /*to_char(trunc(SYSDATE), 'dd.mm.yyyy')*/   AS doc_date --
  ,da.money_date
  ,da.new_deal_sum
  ,da.new_good_cost
  ,da.new_comp_sum
  ,da.status_date
  ,da.OUTER_NUMBER
   ,CASE
             WHEN   round((NVL (to_number(replace(da.good_cost,',','.')), 0) - (ds.deal_sum / 100))
                  * 100
                  / (ds.deal_sum / 100)) >= 10   THEN 1
             WHEN   round((NVL (to_number(replace(da.good_cost,',','.')), 0) - (ds.deal_sum / 100))
                  * 100
                  / (ds.deal_sum / 100)) < 10  THEN 0
          END valid_status
   -- branch
  ,t.branch branch_code
  ,b.name   branch_name
  ,t.kf     mfo
   --user
  ,er.user_id   user_id
  ,er.user_name user_name
   -- register
  ,CASE
     WHEN substr(t.prod,1,6)  IN (220347, 220257) THEN
      to_number(1)
     ELSE
      to_number(2)
   END reg_type_id
  ,CASE
                     WHEN cs.subs_numb IS NOT NULL  AND t.sdate <TO_DATE('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (1)
                     WHEN cs.subs_numb IS NULL
                          AND t.sdate < TO_DATE ('27/08/2015', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (2)
                     WHEN cs.subs_numb IS NULL
                          AND t.sdate >= TO_DATE ('27/08/2015', 'dd/mm/yyyy') and t.sdate <TO_DATE('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (3)
                     WHEN cs.subs_numb IS not  NULL and  EXTRACT(YEAR from t.sdate )<>2017
                          AND t.sdate >=TO_DATE('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (4)
                     WHEN cs.subs_numb IS NULL  and  EXTRACT(YEAR from t.sdate )<>2017
                          AND t.sdate >=TO_DATE('19/09/2016', 'dd/mm/yyyy')
                     THEN
                        TO_NUMBER (5)
                     WHEN  EXTRACT(YEAR from t.sdate )=2017
                     THEN
                        TO_NUMBER (6)
                  END
                     reg_kind_id,
  CASE
     WHEN ru.id IS NOT NULL THEN
      ru.in_doc_id
     WHEN ru.id IS NULL THEN
      rm.in_doc_id
   END reg_id
  ,er.create_date
  ,er.date_from
  ,er.date_to
    FROM escr_reg_mapping rm
    JOIN cc_deal t
      ON rm.out_doc_id = t.nd
   join deal_term dt
  on dt.nd=t.nd
    join credit_status crs
     on  t.nd=crs.obj_id
     and crs.id=(select max(ros.id)  from escr_reg_obj_state ros  where ros.obj_id=t.nd)
    JOIN cc_vidd t1
      ON t.vidd = t1.vidd
    JOIN staff$base s
      ON t.user_id = s.id
    JOIN branch b
      ON b.branch = t.branch
    JOIN customer c
      ON c.rnk = t.rnk
 JOIN bars.customer_address ca_reg
  ON c.rnk = ca_reg.rnk AND ca_reg.type_id = 1
                  JOIN bars.customer_address ca_fact
   ON c.rnk = ca_fact.rnk AND ca_fact.type_id =2
LEFT JOIN bars.ADR_SETTLEMENT_TYPES lt
   ON lt.SETTLEMENT_TP_ID = ca_reg.locality_type
    JOIN cc_add ad
      ON ad.nd = t.nd
    JOIN accounts ac
      ON ad.accs = ac.acc
    JOIN deal_sum ds
      ON t.nd = ds.deal_nd
    JOIN cc_sos ccs
      ON t.sos = ccs.sos
    LEFT JOIN deal_atr da
      ON da.nd = t.nd
    LEFT JOIN customer_subs cs
      ON cs.rnk = c.rnk
    LEFT JOIN reg_union ru
      ON rm.in_doc_id = ru.out_doc_id
    JOIN person p
      ON p.rnk = c.rnk
    JOIN escr_register er
      ON er.id = rm.in_doc_id
   WHERE c.custtype = '3') rez
   JOIN escr_reg_kind ek
     ON rez.reg_kind_id = ek.id
  join escr_reg_status est
    on rez.credit_status_id=est.id
;

PROMPT *** Create  grants  VW_ESCR_REG_HEADER ***
grant SELECT                                                                 on VW_ESCR_REG_HEADER to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_HEADER.sql =========*** End
PROMPT ===================================================================================== 
