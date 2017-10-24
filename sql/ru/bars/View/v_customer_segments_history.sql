

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS_HISTORY.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_SEGMENTS_HISTORY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_SEGMENTS_HISTORY ("ROWNUMBER", "ATTRIBUTE_NAME", "ATTRIBUTE_ID", "RNK", "ID", "PREV_ID", "PREV_VAL", "PREV_VAL_DATE_START", "PREV_DATE_STOP", "ATTRIBUTE_VAL") AS 
  select
   ROWNUMBER,
   ATTRIBUTE_NAME,
   ATTRIBUTE_ID,
   RNK,
   ID,
   PREV_ID,
   PREV_VAL,
   PREV_VAL_DATE_START,
   PREV_DATE_STOP,
   case
        ATTRIBUTE_CODE
        when 'CUSTOMER_SEGMENT_ACTIVITY'  then BARS.LIST_UTL.GET_ITEM_NAME ('CUSTOMER_SEGMENT_ACTIVITY', PREV_VAL)
        when 'CUSTOMER_SEGMENT_BEHAVIOR'  then BARS.LIST_UTL.GET_ITEM_NAME ('CUSTOMER_SEGMENT_BEHAVIOR', PREV_VAL)
        when 'CUSTOMER_SEGMENT_FINANCIAL' then BARS.LIST_UTL.GET_ITEM_NAME ('CUSTOMER_SEGMENT_FINANCIAL',PREV_VAL)
        else to_char(PREV_VAL) end
 as ATTRIBUTE_val
   from (
   SELECT ROW_NUMBER ()
          OVER (PARTITION BY t3.rnk, T1.ATTRIBUTE_ID
                ORDER BY t1.value_date DESC, t1.id DESC)
             AS rownumber,
          BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_NAME (T1.ATTRIBUTE_ID)
             AS attribute_name,
          T1.ATTRIBUTE_ID,
          t3.rnk AS RNK,
          t1.id,
          LAG (
             t1.id,
             1,
             NULL)
          OVER (PARTITION BY t3.rnk, T1.ATTRIBUTE_ID
                ORDER BY t1.value_date, t1.id)
             AS prev_id,
          LAG (
             t2.VALUE,
             1,
             NULL)
          OVER (PARTITION BY t3.rnk, T1.ATTRIBUTE_ID
                ORDER BY t1.value_date, t1.id)
             AS prev_val,
          LAG (
             t1.value_date,
             1,
             NULL)
          OVER (PARTITION BY t3.rnk, T1.ATTRIBUTE_ID
                ORDER BY t1.value_date, t1.id)
             AS prev_val_date_start,
          T1.VALUE_DATE AS prev_date_stop,
          BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_CODE (t1.attribute_id)
             AS ATTRIBUTE_CODE
     FROM BARS.ATTRIBUTE_HISTORY t1
          JOIN BARS.ATTRIBUTE_NUMBER_HISTORY t2 ON t1.id = t2.id
          JOIN customer t3 ON T1.OBJECT_ID = t3.rnk
    WHERE     t1.attribute_id IN (BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_ID (
                                     'CUSTOMER_SEGMENT_ACTIVITY'),
                                  BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_ID (
                                     'CUSTOMER_SEGMENT_FINANCIAL'),
                                  BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_ID (
                                     'CUSTOMER_SEGMENT_BEHAVIOR'),
                                  BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_ID (
                                     'CUSTOMER_SEGMENT_PRODUCTS_AMNT'),
                                  BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_ID (
                                     'CUSTOMER_SEGMENT_TRANSACTIONS'),
                                  BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_ID (
                                     'CUSTOMER_SEGMENT_ATM'),
                                  BARS.ATTRIBUTE_UTL.GET_ATTRIBUTE_ID (
                                     'CUSTOMER_SEGMENT_BPK_CREDITLINE'))
          AND T1.VALUE_DATE <= bankdate)
          where rownumber<3
          and prev_val is not null
          order by 2,1;

PROMPT *** Create  grants  V_CUSTOMER_SEGMENTS_HISTORY ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_CUSTOMER_SEGMENTS_HISTORY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS_HISTORY.sql =======
PROMPT ===================================================================================== 
