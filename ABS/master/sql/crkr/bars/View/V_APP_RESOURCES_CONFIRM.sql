/* Formatted on 16.01.2017 12:33:17 (QP5 v5.256.13226.35510) */
CREATE OR REPLACE FORCE VIEW BARS.V_APP_RESOURCES_CONFIRM
(
   OBJ,
   ID_RES,
   DESCRIPTION,
   CODEAPP,
   NAME,
   STATUS
)
AS
   SELECT "OBJ",
          "ID_RES",
          "DESCRIPTION",
          "CODEAPP",
          "NAME",
          "STATUS"
     FROM (SELECT 'OPERAPP' obj,
                  oa.codeoper id_res,
                     CASE
                        WHEN NVL (oa.approve, 0) = 0
                        THEN
                           'Видача функції "'
                        WHEN oa.revoked = 1
                        THEN
                           'Вилучення функції "'
                     END
                  || o.name
                  || '" в АРМ "'
                  || a.name
                  || '"'
                     description,
                  a.codeapp,
                  a.name name,
                  CASE
                     WHEN NVL (oa.approve, 0) = 0 THEN '+'
                     WHEN oa.revoked = 1 THEN '-'
                  END
                     status
             FROM operapp oa, applist a, operlist o
            WHERE     oa.codeapp = a.codeapp
                  AND oa.codeoper = o.codeoper
                  AND (NVL (oa.approve, 0) = 0 OR oa.revoked = 1)
           UNION ALL
           SELECT 'APP_REP' obj,
                  oa.coderep id_res,
                     CASE
                        WHEN NVL (oa.approve, 0) = 0
                        THEN
                           'Видача звіту "'
                        WHEN oa.revoked = 1
                        THEN
                           'Вилучення звіту "'
                     END
                  || o.DESCRIPTION
                  || '" в АРМ "'
                  || a.name
                  || '"'
                     description,
                  a.codeapp,
                  a.name name,
                  CASE
                     WHEN NVL (oa.approve, 0) = 0 THEN '+'
                     WHEN oa.revoked = 1 THEN '-'
                  END
                     status
             FROM app_rep oa, applist a, reports o
            WHERE     oa.codeapp = a.codeapp
                  AND oa.coderep = o.id
                  AND (NVL (oa.approve, 0) = 0 OR oa.revoked = 1)
           UNION ALL
           SELECT 'REFAPP' obj,
                  oa.tabid id_res,
                     CASE
                        WHEN NVL (oa.approve, 0) = 0
                        THEN
                           'Видача довідника "'
                        WHEN oa.revoked = 1
                        THEN
                           'Вилучення довідника "'
                     END
                  || o.semantic
                  || '" в АРМ "'
                  || a.name
                  || '"'
                     description,
                  a.codeapp,
                  a.name name,
                  CASE
                     WHEN NVL (oa.approve, 0) = 0 THEN '+'
                     WHEN oa.revoked = 1 THEN '-'
                  END
                     status
             FROM refapp oa, applist a, meta_tables o
            WHERE     oa.codeapp = a.codeapp
                  AND oa.tabid = o.tabid
                  AND (NVL (oa.approve, 0) = 0 OR oa.revoked = 1));


GRANT SELECT ON BARS.V_APP_RESOURCES_CONFIRM TO BARS_ACCESS_DEFROLE;
