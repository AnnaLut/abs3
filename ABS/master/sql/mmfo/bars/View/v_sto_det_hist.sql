

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_DET_HIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_DET_HIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_DET_HIST ("IDD", "ACTION", "WHEN", "USER_MADE", "STATUS", "STATUS_DATE", "DISCLAIM", "USER_CLAIMED") AS 
  SELECT sdu.idd,
         CASE
            WHEN sdu.action = 0 THEN 'Вставка'
            WHEN sdu.action = 1 THEN 'Зміна параметрів'
            WHEN sdu.action = -1 THEN 'Видалення'
         END
            action,
         TO_CHAR (sdu.when, 'dd/mm/yyyy hh:MM') "when",
         (SELECT staff.fio
            FROM staff$base staff
           WHERE staff.id = SDU.USERID_MADE)
            user_made,
         (SELECT ss.name
            FROM sto_status ss
           WHERE ss.id = SDU.STATUS_ID)
            status,
         sdu.STATUS_DATE,
         (SELECT sdis.name
            FROM sto_disclaimer sdis
           WHERE sdis.id = SDU.DISCLAIM_ID)
            disclaim,
         (SELECT staff.fio
            FROM staff$base staff
           WHERE staff.id = sdu.STATUS_UID)
            user_claimed
    FROM sto_det sd, sto_det_update sdu
   WHERE sd.idd = sdu.idd
ORDER BY sdu.idd, sdu.when;

PROMPT *** Create  grants  V_STO_DET_HIST ***
grant SELECT                                                                 on V_STO_DET_HIST  to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_STO_DET_HIST  to BARS_ACCESS_DEFROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_STO_DET_HIST  to STO;
grant SELECT                                                                 on V_STO_DET_HIST  to UPLD;
grant FLASHBACK,SELECT                                                       on V_STO_DET_HIST  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_DET_HIST.sql =========*** End ***
PROMPT ===================================================================================== 
