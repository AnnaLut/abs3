PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS_HISTORY.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_SEGMENTS_HISTORY ***

  CREATE OR REPLACE VIEW BARS.V_CUSTOMER_SEGMENTS_HISTORY ("ROWNUMBER", "ATTRIBUTE_NAME", "ATTRIBUTE_ID", "RNK", "ID", "PREV_ID", "PREV_VAL", "PREV_VAL_DATE_START", "PREV_DATE_STOP", "ATTRIBUTE_VAL") AS 
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
       SELECT ROW_NUMBER() OVER(PARTITION BY c.rnk, ah.ATTRIBUTE_ID ORDER BY ah.VALUE_DATE DESC, ah.id DESC) AS rownumber,
              BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_NAME(ah.ATTRIBUTE_ID) AS attribute_name,
              ah.ATTRIBUTE_ID,
              c.rnk AS RNK,
              ah.id,
              LAG(ah.id, 1, NULL) OVER(PARTITION BY c.rnk, ah.ATTRIBUTE_ID ORDER BY ah.VALUE_DATE, ah.id) AS prev_id,
              LAG(anh.VALUE, 1, null) OVER(PARTITION BY c.rnk, ah.ATTRIBUTE_ID ORDER BY ah.VALUE_DATE, ah.id) AS prev_val,
              LAG(ah.VALUE_DATE, 1, NULL) OVER(PARTITION BY c.rnk, ah.ATTRIBUTE_ID ORDER BY ah.VALUE_DATE, ah.id) AS prev_val_date_start,
              ah.VALUE_DATE AS prev_date_stop,
              BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_CODE(ah.attribute_id) AS ATTRIBUTE_CODE
         FROM BARS.ATTRIBUTE_HISTORY ah
         join BARS.ATTRIBUTE_NUMBER_HISTORY anh on ah.id = anh.id
         join customer c ON ah.OBJECT_ID = c.rnk
        WHERE ah.attribute_id IN (select id from attribute_kind
                                   where attribute_code = any('CUSTOMER_SEGMENT_ACTIVITY',
                                                              'CUSTOMER_SEGMENT_FINANCIAL',
                                                              'CUSTOMER_SEGMENT_BEHAVIOR',
                                                              'CUSTOMER_SEGMENT_TRANSACTIONS',
                                                              'CUSTOMER_SEGMENT_ATM',
                                                              'CUSTOMER_SEGMENT_BPK_CREDITLINE',
                                                              'CUSTOMER_SEGMENT_CASHCREDIT_GIVEN',
                                                              'CUSTOMER_SEGMENT_PRODUCTS_AMNT'))
          AND ah.VALUE_DATE <= bars.bankdate()
                    )
      WHERE prev_val IS NOT NULL -- 11.10.2017 COBUSUPABS-6479    and rownumber < 3
   ORDER BY 3, 1;

PROMPT *** Create  grants  V_CUSTOMER_SEGMENTS_HISTORY ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_CUSTOMER_SEGMENTS_HISTORY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS_HISTORY.sql =======
PROMPT ===================================================================================== 