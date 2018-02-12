

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS_HISTORY.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_SEGMENTS_HISTORY ***

  CREATE OR REPLACE VIEW BARS.V_CUSTOMER_SEGMENTS_HISTORY AS 
  SELECT ROWNUMBER,
            ATTRIBUTE_NAME,
            ATTRIBUTE_ID,
            RNK,
            ID,
            PREV_ID,
            PREV_VAL,
            PREV_VAL_DATE_START,
            PREV_DATE_STOP,
            CASE ATTRIBUTE_CODE
               WHEN 'CUSTOMER_SEGMENT_ACTIVITY'  THEN BARS.LIST_UTL.GET_ITEM_NAME ('CUSTOMER_SEGMENT_ACTIVITY',  PREV_VAL)
               WHEN 'CUSTOMER_SEGMENT_BEHAVIOR'  THEN BARS.LIST_UTL.GET_ITEM_NAME ('CUSTOMER_SEGMENT_BEHAVIOR',  PREV_VAL)
               WHEN 'CUSTOMER_SEGMENT_FINANCIAL' THEN BARS.LIST_UTL.GET_ITEM_NAME ('CUSTOMER_SEGMENT_FINANCIAL', PREV_VAL)
               ELSE TO_CHAR (PREV_VAL)
            END
               AS ATTRIBUTE_VAL
       FROM (
       SELECT ROW_NUMBER() OVER(PARTITION BY c.rnk, av.ATTRIBUTE_ID ORDER BY av.value_date DESC) AS rownumber,
              BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_NAME(av.ATTRIBUTE_ID) AS attribute_name,
              av.ATTRIBUTE_ID,
              c.rnk AS RNK,
--              av.id,
--              LAG(av.id, 1, NULL) OVER(PARTITION BY c.rnk, av.ATTRIBUTE_ID ORDER BY av.value_date, av.id) AS prev_id,
              null as id, null as prev_id,  -- 16.11.2017  так как поменяли attribute_history на Attribute_Value_By_Date, COBUSUPABS-6598
              LAG(av.NUMBER_VALUE, 1, null) OVER(PARTITION BY c.rnk, av.ATTRIBUTE_ID ORDER BY av.value_date) AS prev_val,
              LAG(av.value_date, 1, NULL) OVER(PARTITION BY c.rnk, av.ATTRIBUTE_ID ORDER BY av.value_date) AS prev_val_date_start,
-- 11.10.2017 COBUSUPABS-6479             LAG(av.VALID_THROUGH, 1, NULL) OVER(PARTITION BY c.rnk, av.ATTRIBUTE_ID ORDER BY av.VALID_THROUGH, av.id) AS prev_date_stop,
              av.value_date AS prev_date_stop,
              BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_CODE(av.attribute_id) AS ATTRIBUTE_CODE
         FROM BARS.Attribute_Value_By_Date av
--         left join ( select attribute_id, object_id, max(NUMBER_VALUE ) keep (dense_rank last order by VALUE_DATE) as NUMBER_VALUE from BARS.attribute_value_by_date group by attribute_id, object_id) avd ON av.attribute_id = avd.attribute_id and av.object_id = avd.object_id
         join customer c ON av.OBJECT_ID = c.rnk
        WHERE av.attribute_id IN (select id from attribute_kind
                                   where attribute_code = any('CUSTOMER_SEGMENT_ACTIVITY',
                                                              'CUSTOMER_SEGMENT_FINANCIAL',
                                                              'CUSTOMER_SEGMENT_BEHAVIOR',
                                                              'CUSTOMER_SEGMENT_TRANSACTIONS',
                                                              'CUSTOMER_SEGMENT_ATM',
                                                              'CUSTOMER_SEGMENT_BPK_CREDITLINE',
                                                              'CUSTOMER_SEGMENT_CASHCREDIT_GIVEN',
                                                              'CUSTOMER_SEGMENT_PRODUCTS_AMNT'))
          AND av.value_date <= bars.bankdate())
      WHERE prev_val IS NOT NULL -- 11.10.2017 COBUSUPABS-6479    and rownumber < 3
   ORDER BY 3, 1;

PROMPT *** Create  grants  V_CUSTOMER_SEGMENTS_HISTORY ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_CUSTOMER_SEGMENTS_HISTORY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS_HISTORY.sql =======
PROMPT ===================================================================================== 
