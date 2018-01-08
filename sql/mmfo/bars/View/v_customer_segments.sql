

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_SEGMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_SEGMENTS ("RNK", "CUSTOMER_SEGMENT_ACTIVITY", "CSA_DATE_START", "CSA_DATE_STOP", "CUSTOMER_SEGMENT_FINANCIAL", "CSF_DATE_START", "CSF_DATE_STOP", "CUSTOMER_SEGMENT_BEHAVIOR", "CSB_DATE_START", "CSB_DATE_STOP", "CUSTOMER_SEGMENT_PRODUCTS_AMNT", "CSP_DATE_START", "CSP_DATE_STOP", "CUSTOMER_SEGMENT_TRANSACTIONS", "CST_DATE_START", "CST_DATE_STOP", "CUSTOMER_SEGMENT_SOCIAL_VIP", "CSV_DATE_START", "CSV_DATE_STOP", "VIP_CUSTOMER_FLAG", "CUSTOMER_SEGMENT_TVBV", "CUSTOMER_SEGMENT_TVBV_START", "CUSTOMER_SEGMENT_ATM", "CUSTOMER_SEGMENT_ATM_START", "CS_BPK_CREDITLINE", "CS_BPK_CREDITLINE_START", "CS_CASHCREDIT_GIVEN", "CS_CASHCREDIT_GIVEN_START", "CS_CASHCREDIT_GIVEN_STOP", "CUSTOMER_SEGMENT_KODM", "CSK_DATE_START", "CUSTOMER_SEGMENT_MANAGER", "CUSTOMER_SEGMENT_MANAGER_START") AS 
  SELECT c.rnk AS rnk,
       bars.list_utl.get_item_name('CUSTOMER_SEGMENT_ACTIVITY', bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_ACTIVITY', bankdate)) AS customer_segment_activity,
       (SELECT TO_CHAR(MAX(valid_from), 'dd.mm.yyyy')
           FROM bars.attribute_history
          WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_ACTIVITY')
            AND object_id = c.rnk
            AND valid_from <= bankdate)
       /*   to_char(sysdate,'dd.mm.yyyy')*/ AS csa_date_start,
       NULL AS csa_date_stop,

       bars.list_utl.get_item_name('CUSTOMER_SEGMENT_FINANCIAL', bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_FINANCIAL', bankdate)) AS customer_segment_financial,
       /*to_char(sysdate,'dd.mm.yyyy')*/
       (SELECT TO_CHAR(MAX(valid_from), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_FINANCIAL')
           AND object_id = c.rnk
           AND valid_from <= bankdate) AS csf_date_start,
       (SELECT TO_CHAR(MAX(valid_through), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_FINANCIAL')
           AND object_id = c.rnk
           AND valid_through > bankdate) AS csf_date_stop,

       bars.list_utl.get_item_name('CUSTOMER_SEGMENT_BEHAVIOR', bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_BEHAVIOR', bankdate)) AS customer_segment_behavior,
       /*to_char(sysdate,'dd.mm.yyyy')*/
       (SELECT TO_CHAR(MAX(valid_from), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_BEHAVIOR')
           AND object_id = c.rnk
           AND valid_from <= bankdate) AS csb_date_start,
       NULL AS csb_date_stop,

       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_PRODUCTS_AMNT', bankdate) AS customer_segment_products_amnt,
       /*to_char(sysdate,'dd.mm.yyyy')*/
       (SELECT TO_CHAR(MAX(valid_from), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_PRODUCTS_AMNT')
           AND object_id = c.rnk
           AND valid_from <= bankdate) AS csp_date_start,
       NULL AS csp_date_stop,

       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_TRANSACTIONS', bankdate) AS customer_segment_transactions,
       (SELECT TO_CHAR(MAX(valid_from), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_TRANSACTIONS')
           AND object_id = c.rnk
           AND valid_from <= bankdate) AS cst_date_start,
       NULL AS cst_date_stop,

       list_utl.get_item_name('CUSTOMER_SEGMENT_SOCIAL_VIP', f.kvip) customer_segment_social_vip,
       f.datbeg csv_date_start,
       f.datend csv_date_stop,
       w.VALUE vip_customer_flag,

       bars.attribute_utl.get_string_value(c.rnk, 'CUSTOMER_SEGMENT_TVBV', bankdate) AS CUSTOMER_SEGMENT_TVBV, -- Обслуговуюче відділення
       (SELECT TO_CHAR(MAX(valid_from), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_TVBV')
           AND object_id = c.rnk
           AND valid_from <= bankdate) AS CUSTOMER_SEGMENT_TVBV_START, -- Обслуговуюче відділення - Дата встановлення

       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_ATM', bankdate) AS CUSTOMER_SEGMENT_ATM, -- Кількість операцій зняття готівки в АТМ
       (SELECT TO_CHAR(MAX(valid_from), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_ATM')
           AND object_id = c.rnk
           AND valid_from <= bankdate) AS CUSTOMER_SEGMENT_ATM_START, --Кількість операцій зняття готівки в АТМ - Дата встановлення

       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_BPK_CREDITLINE', bankdate) AS CS_BPK_CREDITLINE, -- Сума встановленої кредитної лінії на БПК
       (SELECT TO_CHAR(MAX(valid_from), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_BPK_CREDITLINE')
           AND object_id = c.rnk
           AND valid_from <= bankdate) AS CS_BPK_CREDITLINE_START, -- Сума встановленої кредитної лінії на БПК - Дата встановлення

       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_CASHCREDIT_GIVEN', bankdate) AS CS_CASHCREDIT_GIVEN, -- Сума наданого кеш-кредиту
       (SELECT TO_CHAR(MAX(valid_from), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_CASHCREDIT_GIVEN')
           AND object_id = c.rnk
           AND valid_from <= bankdate) AS CS_CASHCREDIT_GIVEN_START,  -- Сума наданого кеш-кредиту - Дата встановлення
       (SELECT TO_CHAR(MAX(valid_through), 'dd.mm.yyyy')
          FROM bars.attribute_history
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_CASHCREDIT_GIVEN')
           AND object_id = c.rnk
           AND valid_through > bankdate) AS CS_CASHCREDIT_GIVEN_STOP,   -- Сума наданого кеш-кредиту - Дата закінчення


       null AS CUSTOMER_SEGMENT_KODM, -- Код портфеля менеджера
       null AS CSK_DATE_START, -- Код портфеля менеджера Дата встановлення
       null AS CUSTOMER_SEGMENT_MANAGER, -- ПІБ менеджера
       null AS CUSTOMER_SEGMENT_MANAGER_START -- ПІБ менеджера Дата встановлення
  FROM customer c
  LEFT JOIN vip_flags f ON f.rnk = c.rnk
  LEFT JOIN customerw w ON w.rnk = c.rnk AND w.tag = 'VIP_K';

PROMPT *** Create  grants  V_CUSTOMER_SEGMENTS ***
grant SELECT                                                                 on V_CUSTOMER_SEGMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_SEGMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_SEGMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS.sql =========*** En
PROMPT ===================================================================================== 
