/* Formatted on 16.01.2017 12:21:53 (QP5 v5.256.13226.35510) */
CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_APP_OPER_WEB
(
   CODEOPER,
   NAME,
   ROLENAME,
   APPROVED,
   REVOKED,
   DISABLED,
   ADATE1,
   ADATE2,
   RDATE1,
   RDATE2,
   CODEAPP,
   FRONTEND
)
AS
   SELECT b.codeoper,
          b.name,
          b.rolename,
          NVL (a.approve, 0) approved,
          NVL (a.revoked, 0) revoked,
            1
          - date_is_valid (a.adate1,
                           a.adate2,
                           a.rdate1,
                           a.rdate2)
             disabled,
          a.adate1,
          a.adate2,
          a.rdate1,
          a.rdate2,
          A.CODEAPP,
          b.frontend
     FROM operapp a, operlist b
    WHERE a.codeoper = b.codeoper;


GRANT SELECT ON BARS.V_APPADM_APP_OPER_WEB TO BARS_ACCESS_DEFROLE;
