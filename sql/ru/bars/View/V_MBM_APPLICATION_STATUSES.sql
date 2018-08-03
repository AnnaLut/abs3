/* Formatted on 03/08/2018 14:16:00 (QP5 v5.267.14150.38573) */
PROMPT View V_MBM_APPLICATION_STATUSES;
--
-- V_MBM_APPLICATION_STATUSES  (View)
--

CREATE OR REPLACE FORCE VIEW BARS.V_MBM_APPLICATION_STATUSES
(
   ID,
   STATUS_CODE,
   MESSAGE,
   PAID_DATE,
   KOM,
   VK_FIO,
   VK_DATE,
   VK_TIME,
   VV_FIO,
   VV_DATE,
   VV_TIME
)
AS
   SELECT TO_CHAR (z.ID) AS ID,
          DECODE (z.sos, 2, 'PAID', 'DELETED') AS STATUS_CODE,
          NULL AS MESSAGE,
          SYSDATE AS PAID_DATE,
          z.kom,
          vk.vk_fio,
          vk.VK_date,
          vk.VK_time,
          vv.VV_fio,
          vv.VV_date,
          vv.VV_time
     FROM bars.ZAYAVKA z,
          (SELECT sb.fio vk_fio,
                  zt.id,
                  TO_CHAR (zt.change_time, 'dd.mm.yyyy') VK_date,
                  TO_CHAR (zt.change_time, 'HH24:MI') VK_time
             FROM bars.zay_track zt, bars.staff$base sb
            WHERE     zt.userid = sb.id
                  AND zt.track_id =
                         (SELECT MAX (zt1.track_id)
                            FROM zay_track zt1
                           WHERE     zt1.old_viza IN (0, -1)
                                 AND zt1.new_viza = 1
                                 AND zt1.id = zt.id)) vk,
          (SELECT sb.fio vv_fio,
                  zt.id,
                  TO_CHAR (zt.change_time, 'dd.mm.yyyy') VV_date,
                  TO_CHAR (zt.change_time, 'HH24:MI') VV_time
             FROM bars.zay_track zt, bars.staff$base sb
            WHERE zt.userid = sb.id AND zt.old_sos = 1 AND zt.new_sos = 2) vv
    WHERE (z.sos = -1 OR z.sos = 2) AND vk.id(+) = z.id AND vv.id(+) = z.id
/


Prompt Grants on VIEW V_MBM_APPLICATION_STATUSES TO BARS_ACCESS_DEFROLE to BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_MBM_APPLICATION_STATUSES TO BARS_ACCESS_DEFROLE
/
