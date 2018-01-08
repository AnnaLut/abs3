

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_REGISTER_LIST.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_REGISTER_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REGISTER_LIST ("ID", "INNER_NUMBER", "OUTER_NUMBER", "CREATE_DATE", "DATE_FROM", "DATE_TO", "REG_TYPE_ID", "REG_TYPE_CODE", "REG_TYPE_NAME", "REG_KIND_ID", "REG_KIND_CODE", "REG_KIND_NAME", "BRANCH", "REG_LEVEL", "REG_LEVEL_CODE", "USER_ID", "USER_NAME", "REG_STATUS_ID", "REG_STATUS_CODE", "REG_STATUS_NAME", "REG_UNION_FLAG", "CREDIT_COUNT", "ERR_COUNT", "VALID_STATUS") AS 
  SELECT t.id,
          t.inner_number,
          t.outer_number,
          t.create_date,
          t.date_from,
          t.date_to,
          t1.id reg_type_id,
          t1.code reg_type_code,
          t1.name reg_type_name,
          t2.id reg_kind_id,
          t2.code reg_kind_code,
          t2.name reg_kind_name,
          t.branch,
          t.reg_level,
          CASE t.reg_level WHEN 1 THEN 'CA' WHEN 0 THEN 'RU' END
             reg_level_code,
          t.user_id,
          t.user_name,
          t3.id reg_status_id,
          t3.code reg_status_code,
          t3.name reg_status_name,
          t.reg_union_flag reg_union_flag,
          t4.credit_count credit_count,
          t4.err_count,
          CASE WHEN t4.err_count = 0 THEN 1 ELSE 0 END valid_status
     FROM escr_register t
          JOIN escr_reg_types t1
             ON t.reg_type_id = t1.id
          JOIN escr_reg_kind t2
             ON t.reg_kind_id = t2.id
          JOIN escr_reg_status t3
             ON t.status_id = t3.id
          JOIN vw_escr_reg_credit_count t4
             ON t.id = t4.reg_id
    WHERE NOT EXISTS
             (SELECT NULL
                FROM escr_reg_mapping rm
               WHERE rm.out_doc_id = t.id);

PROMPT *** Create  grants  VW_ESCR_REGISTER_LIST ***
grant SELECT                                                                 on VW_ESCR_REGISTER_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_REGISTER_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_REGISTER_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_REGISTER_LIST.sql =========*** 
PROMPT ===================================================================================== 
