

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_DEALS_DWH.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_DEALS_DWH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_DEALS_DWH ("DEAL_TYPES_ID", "DEAL_TYPES_NAME", "DEAL_OBJECT_TYPE_СODE", "DEAL_OBJECT_TYPE_NAME", "CUST_TYPE_NUMB", "CUST_TYPE_TXT", "CUST_OKPO", "CUST_NAME", "CUST_BRANCH", "CUST_BIRTHDAY", "CUST_WORK_PHONE", "CUST_CELLPHONE", "CUST_HOME_PHONE", "CUST_ADR", "PARTNERS_NAME", "PARTNERS_OKPO", "PARTNERS_ID", "DEAL_ID", "DEAL_BRANCH", "DEAL_DATE", "DEAL_LAST_MODIFY_DATE", "DEAL_CREATE_DATE", "DEAL_STATUS_ID", "DEAL_STATUS_CODE", "DEAL_SERIAL", "DEAL_NUMB", "DEAL_START_DATE", "DEAL_END_DATE", "DEAL_SUM", "DEAL_CURRENCY", "DEAL_TARIFF", "PAYMENT_FACT_DATE", "PAYMENT_FACT_SUM", "PAYMENT_PLAN_DATE", "PAYMENT_PLAN_SUM", "GRT_DEAL_NUMB", "GRT_DEAL_NAME", "GRT_DEAL_BRANCH") AS 
  (
select "DEAL_TYPES_ID","DEAL_TYPES_NAME","DEAL_OBJECT_TYPE_СODE","DEAL_OBJECT_TYPE_NAME","CUST_TYPE_NUMB","CUST_TYPE_TXT","CUST_OKPO","CUST_NAME","CUST_BRANCH","CUST_BIRTHDAY","CUST_WORK_PHONE","CUST_CELLPHONE","CUST_HOME_PHONE","CUST_ADR","PARTNERS_NAME","PARTNERS_OKPO","PARTNERS_ID","DEAL_ID","DEAL_BRANCH","DEAL_DATE","DEAL_LAST_MODIFY_DATE","DEAL_CREATE_DATE","DEAL_STATUS_ID","DEAL_STATUS_CODE","DEAL_SERIAL","DEAL_NUMB","DEAL_START_DATE","DEAL_END_DATE","DEAL_SUM","DEAL_CURRENCY","DEAL_TARIFF","PAYMENT_FACT_DATE","PAYMENT_FACT_SUM","PAYMENT_PLAN_DATE","PAYMENT_PLAN_SUM","GRT_DEAL_NUMB","GRT_DEAL_NAME","GRT_DEAL_BRANCH" from (
    WITH partners AS
       (SELECT ip.id, ip.name, c.okpo, c.branch
          FROM ins_partners ip, customer c
         WHERE c.rnk(+) = ip.rnk),
      paid AS
       (SELECT isd.deal_id
              ,isd.fact_sum
              ,isd.pmt_num
              ,MAX(isd.fact_date) fact_date
          FROM ins_payments_schedule isd
         WHERE isd.payed = 1
         GROUP BY isd.deal_id, isd.fact_sum, isd.pmt_num),
      unpaid AS
       (SELECT isd.deal_id, isd.plan_sum, MIN(isd.plan_date) plan_date
          FROM ins_payments_schedule isd
         WHERE isd.payed = 0
         GROUP BY isd.deal_id, isd.plan_sum),
      deals_grt AS
       (SELECT g.deal_id
              ,g.grt_type_id
              ,g.deal_num
              ,g.deal_rnk
              ,g.deal_name
              ,g.deal_place
              ,g.branch
          FROM grt_deals g)
      SELECT
      -- deal types
       types.id deal_types_id
      ,types.name deal_types_name
      ,types.object_type deal_object_type_сode
      ,CASE
         WHEN types.object_type = 'GRT' THEN
          'Застава'
         ELSE
          'Не застава'
       END deal_object_type_name
       -- customer info
      ,cust.custtype cust_type_numb
      ,decode(cust.custtype
             ,1
             ,'Банк'
             ,2
             ,'Юридична особа'
             ,3
             ,'Фізична особа') cust_type_txt
      ,cust.okpo cust_okpo
      ,cust.nmk cust_name
      ,cust.branch cust_branch
      ,pers.bday cust_birthday
      ,pers.telw cust_work_phone
      ,pers.cellphone cust_cellphone
      ,pers.teld cust_home_phone
      ,cust.adr cust_adr
       -- parthers info
      ,part.name partners_name
      ,part.okpo partners_okpo
      ,part.id   partners_id
       -- deal info
      ,deal.id deal_id
      ,deal.branch deal_branch
      ,deal.crt_date deal_date
      ,deal.status_date deal_last_modify_date
      ,deal.crt_date deal_create_date
      ,status.id deal_status_id
      ,status.name deal_status_code
      ,deal.ser deal_serial
      ,deal.num deal_numb
      ,deal.sdate deal_start_date
      ,deal.edate deal_end_date
      ,deal.sum deal_sum
      ,deal.sum_kv deal_currency
      ,round(nvl(deal.insu_tariff, deal.sum * deal.insu_sum / 100), 2) deal_tariff
      ,paid.fact_date payment_fact_date
      ,paid.fact_sum payment_fact_sum
      ,unpaid.plan_date payment_plan_date
      ,unpaid.plan_sum payment_plan_sum
       --grt deal info
      ,deals_grt.deal_num  grt_deal_numb
      ,deals_grt.deal_name grt_deal_name
      ,deals_grt.branch    grt_deal_branch
 FROM ins_deals         deal
            ,customer          cust
            ,partners          part
            ,person            pers
            ,ins_types         types
            ,ins_deal_statuses status
            ,paid              paid
            ,unpaid            unpaid
            ,deals_grt         deals_grt
       WHERE 1 = 1
         AND deal.partner_id = part.id
         AND cust.rnk = deal.ins_rnk
         AND pers.rnk = cust.rnk
         AND types.id = deal.type_id
         AND types.object_type = deal.object_type
         AND status.id = deal.status_id
         AND paid.deal_id(+) = deal.id
         AND unpaid.deal_id(+) = deal.id
         AND deals_grt.deal_id(+) = deal.grt_id));

PROMPT *** Create  grants  V_INS_DEALS_DWH ***
grant SELECT                                                                 on V_INS_DEALS_DWH to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_DEALS_DWH.sql =========*** End **
PROMPT ===================================================================================== 
