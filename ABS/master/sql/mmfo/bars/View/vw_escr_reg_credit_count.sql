

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_CREDIT_COUNT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_REG_CREDIT_COUNT ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REG_CREDIT_COUNT ("REG_ID", "CREDIT_COUNT", "ERR_COUNT", "REG_UNION_FLAG") AS 
  WITH all_credit_count
           AS (  SELECT COUNT (t.out_doc_id) credit_count, t.in_doc_id
                   FROM escr_reg_mapping t
                  WHERE t.oper_type = 0
               GROUP BY t.in_doc_id),
        error_credit_count
           AS (  SELECT COUNT (t.out_doc_id) credit_count, t.in_doc_id
                   FROM    escr_reg_mapping t
                        JOIN
                           escr_reg_obj_state t1
                        ON t.out_doc_id = t1.obj_id AND t.oper_type = 0
                           AND t1.id =
                                  (SELECT MAX (t2.id)
                                     FROM escr_reg_obj_state t2
                                    WHERE t2.obj_id = t.out_doc_id
                                          AND t2.status_id IN
                                                 (5, 8, 9, 11, 13, 15, 16)
                                          AND t2.set_date =
                                                 (SELECT MAX (set_date)
                                                    FROM escr_reg_obj_state
                                                   WHERE obj_id = t2.obj_id))
               GROUP BY t.in_doc_id),
        union_reg AS (SELECT t1.in_doc_id, t1.out_doc_id
                        FROM escr_reg_mapping t1
                       WHERE t1.oper_type = 1)
     SELECT t3.in_doc_id reg_id,
            SUM (t2.credit_count) credit_count,
            CASE
               WHEN SUM (t5.credit_count) IS NULL THEN 0
               ELSE SUM (t5.credit_count)
            END
               err_count,
            1 reg_union_flag
       FROM all_credit_count t2
            JOIN union_reg t3
               ON t2.in_doc_id = t3.out_doc_id
            JOIN escr_register t4
               ON t4.id = t2.in_doc_id and t4.reg_level=0
            LEFT JOIN error_credit_count t5
               ON t4.id = t5.in_doc_id
   GROUP BY t3.in_doc_id, t4.reg_union_flag
   UNION ALL
     SELECT t2.in_doc_id reg_id,
            SUM (t2.credit_count) credit_count,
            CASE
               WHEN SUM (t5.credit_count) IS NULL THEN 0
               ELSE SUM (t5.credit_count)
            END
               err_count,
            0 reg_union_flag
       FROM all_credit_count t2
            JOIN escr_register t4
               ON t4.id = t2.in_doc_id and t4.reg_level=0
            LEFT JOIN error_credit_count t5
               ON t4.id = t5.in_doc_id
   GROUP BY t2.in_doc_id, t4.reg_union_flag;

PROMPT *** Create  grants  VW_ESCR_REG_CREDIT_COUNT ***
grant SELECT                                                                 on VW_ESCR_REG_CREDIT_COUNT to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_REG_CREDIT_COUNT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_REG_CREDIT_COUNT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_CREDIT_COUNT.sql =========*
PROMPT ===================================================================================== 
