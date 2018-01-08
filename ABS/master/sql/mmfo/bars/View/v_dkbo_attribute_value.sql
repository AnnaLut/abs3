

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DKBO_ATTRIBUTE_VALUE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DKBO_ATTRIBUTE_VALUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DKBO_ATTRIBUTE_VALUE ("DEAL_ID", "DEAL_TYPE_ID", "DEAL_NUMBER", "DEAL_DATE_FROM", "DEAL_DATE_TO", "DEAL_BRANCH", "CUSTOMER_ID", "CUSTOMER_NAME", "ATTRIBUTE_CODE", "ATTRIBUTE_NAME", "ATTRIBUTE_TYPE", "ATTRIBUTE_VALUE") AS 
  SELECT
--deal info
 r.deal_id
,r.deal_type_id
,r.deal_number
,r.deal_date_from
,r.deal_date_to
,r.deal_branch
 --customer   info
,r.customer_id
,r.customer_name
 -- attribute     info
,r.attribute_code
,r.attribute_name
,r.attribute_type
,CASE r.attribute_type
   WHEN 'NUMBER' THEN
    trim(to_char(r.number_value, '9999999999999999999999999'))
   WHEN 'STRING' THEN
    r.string_value
   WHEN 'LIST' THEN
    (SELECT li.list_item_name
       FROM list_item li
      WHERE li.list_item_id =
           trim( to_char(r.number_value, '9999999999999999999999999'))
        AND li.list_type_id = att_list_type_id)
   WHEN 'DATE' THEN
    to_char(r.date_value, 'dd/mm/yyyy')
 -- Проаналізувати і дописати
 ELSE
  NULL
END attribute_value
  FROM (SELECT tt.*
          FROM (SELECT
                --deal info
                 d.deal_type_id deal_type_id
                ,d.id           deal_id
                ,d.deal_number  deal_number
                ,d.start_date   deal_date_from
                ,d.close_date   deal_date_to
                ,d.branch_id    deal_branch
                 --customer   info
                ,c.rnk customer_id
                ,c.nmk customer_name
                 -- attribute     info
                ,a.id attribute_id
                ,a.list_type_id att_list_type_id
                ,a.attribute_code attribute_code
                ,a.attribute_name attribute_name
                ,CASE a.value_type_id
                   WHEN 1 THEN
                    'NUMBER'
                   WHEN 2 THEN
                    'STRING'
                   WHEN 3 THEN
                    'DATE'
                   WHEN 4 THEN
                    'CLOB'
                   WHEN 5 THEN
                    'BLOB'
                   WHEN 6 THEN
                    'LIST'
                   ELSE
                    NULL
                 END AS attribute_type
                ,nv.number_value number_value
                ,nv.date_value date_value
                ,nv.string_value string_value
                  FROM deal d
                  JOIN object_type o
                    ON d.deal_type_id = o.id
                   AND o.type_code = 'DKBO'
                  JOIN attribute_kind a
                    ON o.id = a.object_type_id
                   AND a.attribute_code LIKE '%DKBO%'
                  JOIN customer c
                    ON d.customer_id = c.rnk
                  LEFT JOIN attribute_value nv
                    ON nv.object_id = d.id
                   AND nv.attribute_id = a.id
                 ) tt
         WHERE 1 = 1
           AND (tt.number_value IS NOT NULL OR tt.date_value IS NOT NULL OR
               tt.string_value IS NOT NULL)
         ORDER BY tt.deal_number, tt.customer_id) r;

PROMPT *** Create  grants  V_DKBO_ATTRIBUTE_VALUE ***
grant SELECT                                                                 on V_DKBO_ATTRIBUTE_VALUE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DKBO_ATTRIBUTE_VALUE.sql =========***
PROMPT ===================================================================================== 
