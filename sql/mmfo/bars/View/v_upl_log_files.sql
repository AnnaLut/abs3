

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_UPL_LOG_FILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_LOG_FILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_UPL_LOG_FILES ("KOD_ZP", "PARENT_ID", "FILE_NAME", "UPL_BANKDATE", "REC_TYPE", "TYPE_UPL", "FILE_ID", "FILE_CODE", "START_TIME", "UPL_TIME_MIN", "STATUS_CODE", "ROWS_UPLOADED", "UPL_ERRORS", "KF") AS 
  SELECT id AS kod_zp,
            parent_id AS parent_id,
            file_name AS file_name,
            upl_bankdate AS upl_bankdate,
            rec_type AS rec_type,
            CASE WHEN GROUP_ID IN (1, 3) THEN 'перв.' ELSE 'інкр.' END
               AS type_upl,
            file_id AS file_id,
            file_code AS file_code,
            start_time AS start_time,
            upl_time_min AS upl_time_min,
            status_code AS status_code,
            rows_uploaded AS rows_uploaded,
            upl_errors AS upl_errors,
            kf as KF
       FROM barsupl.v_upl_stats
   ORDER BY id DESC;

PROMPT *** Create  grants  V_UPL_LOG_FILES ***
grant SELECT                                                                 on V_UPL_LOG_FILES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_UPL_LOG_FILES.sql =========*** End **
PROMPT ===================================================================================== 
