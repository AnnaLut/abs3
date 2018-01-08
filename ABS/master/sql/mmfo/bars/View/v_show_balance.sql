

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SHOW_BALANCE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SHOW_BALANCE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SHOW_BALANCE ("SHOW_DATE", "KF", "KF_NAME", "NBS", "KV", "DOS", "DOSQ", "KOS", "KOSQ", "OSTD", "OSTDQ", "OSTK", "OSTKQ", "ROW_TYPE") AS 
  SELECT show_date,
            kf,
            kf_name,
            CASE WHEN INSTR (nbs, '%') > 0 THEN 'По всім' ELSE nbs END
               nbs,
            CASE WHEN kv = 0 THEN 'По всім' ELSE TO_CHAR (kv) END kv,
            dos,
            dosq,
            kos,
            kosq,
            ostd,
            ostdq,
            ostk,
            ostkq,
            row_type
       FROM TMP_SHOW_BALANCE_DATA
   ORDER BY kf,
            nbs,
            row_type DESC,
            kv;

PROMPT *** Create  grants  V_SHOW_BALANCE ***
grant SELECT                                                                 on V_SHOW_BALANCE  to BARSREADER_ROLE;
grant SELECT                                                                 on V_SHOW_BALANCE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SHOW_BALANCE.sql =========*** End ***
PROMPT ===================================================================================== 
