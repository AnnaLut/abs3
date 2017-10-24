/* Formatted on 15.12.2016 17:31:28 (QP5 v5.256.13226.35510) */
CREATE OR REPLACE FORCE VIEW BARS.V_USER_RESOURCES_CONFIRM
(
   OBJ,
   ID_RES,
   NAME,
   ID,
   LOGNAME,
   FIO,
   STATUS
)
AS
     SELECT "OBJ",
            "ID_RES",
            "NAME",
            "ID",
            "LOGNAME",
            "FIO",
            "STATUS"
       FROM (SELECT 'APPLIST_STAFF' obj,
                    s.codeapp id_res,
                       CASE
                          WHEN NVL (s.approve, 0) = 0
                          THEN
                             'Видача АРМа "'
                          WHEN s.revoked = 1
                          THEN
                             'Вилучення АРМа"'
                       END
                    || a.name
                    || '"'
                       Name,
                    s2.id,
                    s2.logname,
                    s2.fio,
                    CASE
                       WHEN NVL (s.approve, 0) = 0 THEN '+'
                       WHEN s.revoked = 1 THEN '-'
                    END
                       status
               FROM applist a, applist_staff s, staff s2
              WHERE     a.codeapp = s.codeapp
                    AND (NVL (s.approve, 0) = 0 OR s.revoked = 1)
                    AND s.id = s2.id
             UNION ALL
             SELECT 'STAFF_TTS' obj,
                    s.tt id_res,
                       CASE
                          WHEN NVL (s.approve, 0) = 0
                          THEN
                             'Видача операції "'
                          WHEN s.revoked = 1
                          THEN
                             'Вилучення операції "'
                       END
                    || a.name
                    || '"'
                       Name,
                    s2.id,
                    s2.logname,
                    s2.fio,
                    CASE
                       WHEN NVL (s.approve, 0) = 0 THEN '+'
                       WHEN s.revoked = 1 THEN '-'
                    END
                       status
               FROM tts a, staff_tts s, staff s2
              WHERE     a.tt = s.tt
                    AND (NVL (s.approve, 0) = 0 OR s.revoked = 1)
                    AND s.id = s2.id
             UNION ALL
             SELECT 'STAFF_CHK' obj,
                    TO_CHAR (s.chkid) id_res,
                       CASE
                          WHEN NVL (s.approve, 0) = 0
                          THEN
                             'Видача групи контролю "'
                          WHEN s.revoked = 1
                          THEN
                             'Вилучення групи контролю "'
                       END
                    || a.name
                    || '"'
                       Name,
                    s2.id,
                    s2.logname,
                    s2.fio,
                    CASE
                       WHEN NVL (s.approve, 0) = 0 THEN '+'
                       WHEN s.revoked = 1 THEN '-'
                    END
                       status
               FROM chklist a, staff_chk s, staff s2
              WHERE     a.idchk = s.chkid
                    AND (NVL (s.approve, 0) = 0 OR s.revoked = 1)
                    AND s.id = s2.id
             UNION ALL
             SELECT 'STAFF_KLF00' obj,
                    s.kodf id_res,
                       CASE
                          WHEN NVL (s.approve, 0) = 0
                          THEN
                             'Видача групи файлу звітності "'
                          WHEN s.revoked = 1
                          THEN
                             'Вилучення групи файлу звітності "'
                       END
                    || a.semantic
                    || '"'
                       Name,
                    s2.id,
                    s2.logname,
                    s2.fio,
                    CASE
                       WHEN NVL (s.approve, 0) = 0 THEN '+'
                       WHEN s.revoked = 1 THEN '-'
                    END
                       status
               FROM kl_f00 a, staff_klf00 s, staff s2
              WHERE     a.kodf = s.kodf
                    AND (NVL (s.approve, 0) = 0 OR s.revoked = 1)
                    AND s.id = s2.id)
   ORDER BY obj, id, status;


GRANT SELECT ON BARS.V_USER_RESOURCES_CONFIRM TO BARS_ACCESS_DEFROLE;
