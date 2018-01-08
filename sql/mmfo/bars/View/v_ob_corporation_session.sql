

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB_CORPORATION_SESSION.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB_CORPORATION_SESSION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB_CORPORATION_SESSION ("ID", "MFO", "MFO_NAME", "FILE_DATE", "CORPORATION", "STATE", "SYNCTIME") AS 
  SELECT T1.ID AS id,
            TO_CHAR (T1.KF) AS mfo,
            b.nb AS mfo_name,
            TO_CHAR (T1.FILE_DATE, 'DD.MM.YYYY') AS file_date,
            DECODE (T1.FILE_CORPORATION_ID,
                    NULL, 'Всі',
                    T1.FILE_CORPORATION_ID)
               AS corporation,
            DECODE (T1.STATE_ID,
                    NULL, 'Новий',
                    0, 'Новий',
                    1, 'Оброблено',
                    2, 'Оброблено з помилками',
                    3, 'Помилка даних')
               AS state,
            to_char(SYS_TIME,'dd.mm.yyyy hh24:mi:ss') AS synctime
       FROM BARS.ob_corporation_session t1
            LEFT JOIN bars.banks b ON t1.KF = b.mfo
   ORDER BY 1 DESC;

PROMPT *** Create  grants  V_OB_CORPORATION_SESSION ***
grant SELECT                                                                 on V_OB_CORPORATION_SESSION to BARSREADER_ROLE;
grant SELECT                                                                 on V_OB_CORPORATION_SESSION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB_CORPORATION_SESSION to CORP_CLIENT;
grant SELECT                                                                 on V_OB_CORPORATION_SESSION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB_CORPORATION_SESSION.sql =========*
PROMPT ===================================================================================== 
