CREATE OR REPLACE VIEW BARS.V_CUSTOMER_SEGMENTS AS
SELECT c.rnk AS rnk,
       bars.list_utl.get_item_name('CUSTOMER_SEGMENT_ACTIVITY', bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_ACTIVITY', bankdate)) AS customer_segment_activity,
       (SELECT TO_CHAR(MAX(value_date), 'dd.mm.yyyy')
           FROM bars.attribute_history
          WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_ACTIVITY')
            AND object_id = c.rnk
            AND value_date <= bankdate)
       /*   to_char(sysdate,'dd.mm.yyyy')*/ AS csa_date_start,
       NULL AS csa_date_stop,
       
       bars.list_utl.get_item_name('CUSTOMER_SEGMENT_FINANCIAL', bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_FINANCIAL', bankdate)) AS customer_segment_financial,
       /*to_char(sysdate,'dd.mm.yyyy')*/
       (SELECT TO_CHAR(MAX(value_date), 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_FINANCIAL')
           AND object_id = c.rnk
           AND value_date <= bankdate) AS csf_date_start,
       (SELECT TO_CHAR(MAX(value_date) - 1, 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_FINANCIAL')
           AND object_id = c.rnk
           AND value_date > bankdate) AS csf_date_stop,
       
       bars.list_utl.get_item_name('CUSTOMER_SEGMENT_BEHAVIOR', bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_BEHAVIOR', bankdate)) AS customer_segment_behavior,
       /*to_char(sysdate,'dd.mm.yyyy')*/
       (SELECT TO_CHAR(MAX(value_date), 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_BEHAVIOR')
           AND object_id = c.rnk
           AND value_date <= bankdate) AS csb_date_start,
       NULL AS csb_date_stop,
       
       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_PRODUCTS_AMNT', bankdate) AS customer_segment_products_amnt,
       /*to_char(sysdate,'dd.mm.yyyy')*/
       (SELECT TO_CHAR(MAX(value_date), 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_PRODUCTS_AMNT')
           AND object_id = c.rnk
           AND value_date <= bankdate) AS csp_date_start,
       NULL AS csp_date_stop,
       
       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_TRANSACTIONS', bankdate) AS customer_segment_transactions,
       (SELECT TO_CHAR(MAX(value_date), 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_TRANSACTIONS')
           AND object_id = c.rnk
           AND value_date <= bankdate) AS cst_date_start,
       NULL AS cst_date_stop,
       
       list_utl.get_item_name('CUSTOMER_SEGMENT_SOCIAL_VIP', f.kvip) customer_segment_social_vip,
       f.datbeg csv_date_start,
       f.datend csv_date_stop,
       w.VALUE vip_customer_flag,
       
       bars.attribute_utl.get_string_value(c.rnk, 'CUSTOMER_SEGMENT_TVBV', bankdate) AS CUSTOMER_SEGMENT_TVBV, -- Обслуговуюче відділення
       (SELECT TO_CHAR(MAX(value_date), 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_TVBV')
           AND object_id = c.rnk
           AND value_date <= bankdate) AS CUSTOMER_SEGMENT_TVBV_START, -- Обслуговуюче відділення - Дата встановлення
       
       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_ATM', bankdate) AS CUSTOMER_SEGMENT_ATM, -- Кількість операцій зняття готівки в АТМ
       (SELECT TO_CHAR(MAX(value_date), 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_ATM')
           AND object_id = c.rnk
           AND value_date <= bankdate) AS CUSTOMER_SEGMENT_ATM_START, --Кількість операцій зняття готівки в АТМ - Дата встановлення
       
       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_BPK_CREDITLINE', bankdate) AS CS_BPK_CREDITLINE, -- Сума встановленої кредитної лінії на БПК
       (SELECT TO_CHAR(MAX(value_date), 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_BPK_CREDITLINE')
           AND object_id = c.rnk
           AND value_date <= bankdate) AS CS_BPK_CREDITLINE_START, -- Сума встановленої кредитної лінії на БПК - Дата встановлення
       
       bars.attribute_utl.get_number_value(c.rnk, 'CUSTOMER_SEGMENT_CASHCREDIT_GIVEN', bankdate) AS CS_CASHCREDIT_GIVEN, -- Сума наданого кеш-кредиту
       (SELECT TO_CHAR(MAX(value_date), 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_CASHCREDIT_GIVEN')
           AND object_id = c.rnk
           AND value_date <= bankdate) AS CS_CASHCREDIT_GIVEN_START,  -- Сума наданого кеш-кредиту - Дата встановлення
       (SELECT TO_CHAR(MAX(value_date) - 1, 'dd.mm.yyyy')
          FROM bars.attribute_history 
         WHERE attribute_id = bars.attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_CASHCREDIT_GIVEN')
           AND object_id = c.rnk
           AND value_date > bankdate) AS CS_CASHCREDIT_GIVEN_STOP,   -- Сума наданого кеш-кредиту - Дата закінчення


       null AS CUSTOMER_SEGMENT_KODM, -- Код портфеля менеджера
       null AS CSK_DATE_START, -- Код портфеля менеджера Дата встановлення
       null AS CUSTOMER_SEGMENT_MANAGER, -- ПІБ менеджера
       null AS CUSTOMER_SEGMENT_MANAGER_START -- ПІБ менеджера Дата встановлення
  FROM customer c
  LEFT JOIN vip_flags f ON f.rnk = c.rnk
  LEFT JOIN customerw w ON w.rnk = c.rnk AND w.tag = 'VIP_K'
/
show errors
