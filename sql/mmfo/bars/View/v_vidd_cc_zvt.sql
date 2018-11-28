CREATE OR REPLACE FORCE VIEW BARS.V_VIDD_CC_ZVT
(
   VIDD,
   NAME
)
AS
   SELECT 0 AS VIDD,
          'всі (рівні частини, ануїтет, кредитні лінії'
             AS name
     FROM DUAL
   UNION ALL
   SELECT 4 AS VIDD, 'ануїтет' AS name FROM DUAL;


GRANT SELECT ON BARS.V_VIDD_CC_ZVT TO BARS_ACCESS_USER;