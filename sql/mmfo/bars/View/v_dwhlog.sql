

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DWHLOG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DWHLOG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DWHLOG ("PACKAGE_ID", "STATUS", "ERRORDESCRIPTION", "PACKAGE_TYPE", "RECIEVED_DATE", "BANK_DATE") AS 
  SELECT T1.PACKAGE_ID AS PACKAGE_ID,
            DECODE (T1.PACKAGE_STATUS,
                    'DELIVERED', 'Отримано',
                    'PARSED', 'Оброблено',
                    'Не визначено')
               AS status,
            T1.PACKAGE_ERROR AS ErrorDescription,
            DECODE (T1.PACKAGE_TYPE,
                    1, 'Сегменти',
                    2, 'Продуктове навантаження',
                    3, 'Сегменти ЮО')
               AS package_type,
            TO_CHAR (T1.RECIEVED_DATE, 'DD.MM.YYYY HH24:MM') AS RECIEVED_DATE,
            T1.BANK_DATE AS bank_date
       FROM dwh_log t1
   ORDER BY 1 DESC;

PROMPT *** Create  grants  V_DWHLOG ***
grant SELECT                                                                 on V_DWHLOG        to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_DWHLOG        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DWHLOG        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DWHLOG.sql =========*** End *** =====
PROMPT ===================================================================================== 
