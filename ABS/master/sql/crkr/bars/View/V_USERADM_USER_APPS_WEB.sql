/* Formatted on 15.12.2016 17:14:38 (QP5 v5.256.13226.35510) */
CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_USER_APPS_WEB
(
   CODEAPP,
   NAME,
   APPROVED,
   REVOKED,
   DISABLED,
   SUBSTED,
   ADATE1,
   ADATE2,
   RDATE1,
   RDATE2,
   USERID
)
AS
   SELECT a.codeapp,
          a.name,
          c.approved,
          c.revoked,
          c.disabled,
          c.substed,
          c.adate1,
          c.adate2,
          c.rdate1,
          c.rdate2,
          userid
     FROM (SELECT b.codeapp,
                  NVL (b.approve, 0) approved,
                  NVL (b.revoked, 0) revoked,
                    1
                  - date_is_valid (b.adate1,
                                   b.adate2,
                                   b.rdate1,
                                   b.rdate2)
                     disabled,
                  0 substed,
                  b.adate1,
                  b.adate2,
                  b.rdate1,
                  b.rdate2,
                  b.id userid
             FROM applist_staff b
           UNION ALL
             SELECT b.codeapp,
                    1 approved,
                    0 revoked,
                    0 disabled,
                    1 substed,
                    NULL adate1,
                    NULL adate2,
                    NULL rdate1,
                    NULL rdate2,
                    s.id_who userid
               FROM applist_staff b, staff_substitute s
              WHERE     b.id = s.id_whom
                    AND b.codeapp NOT IN (SELECT codeapp
                                            FROM applist_staff
                                           WHERE id = s.id_who AND approve = 1)
                    AND b.approve = 1
                    AND date_is_valid (b.adate1,
                                       b.adate2,
                                       b.rdate1,
                                       b.rdate2) = 1
                    AND date_is_valid (s.date_start,
                                       s.date_finish,
                                       NULL,
                                       NULL) = 1
           GROUP BY b.codeapp, s.id_who) c,
          applist a
    WHERE a.codeapp = c.codeapp;


GRANT SELECT ON BARS.V_USERADM_USER_APPS_WEB TO BARS_ACCESS_DEFROLE;
