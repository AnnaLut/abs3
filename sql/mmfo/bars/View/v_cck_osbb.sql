CREATE OR REPLACE FORCE VIEW BARS.V_CCK_OSBB
(
   ND,
   CC_ID,
   RNK,
   VIDD,
   SDOG,
   SDATE,
   WDATE,
   BRANCH,
   PROD,
   ERR
)
AS
   SELECT ND,
          CC_ID,
          RNK,
          VIDD,
          SDOG,
          SDATE,
          WDATE,
          BRANCH,
          PROD,
          (SELECT COUNT (*)
             FROM tmp_operW
            WHERE ord = d.nd)
     FROM cc_deal d
    WHERE     sos >= 10
          AND sos < 14 -- Продукт не менялся поэтому добавляем новый
          AND (prod LIKE '206219%' OR prod LIKE '206309%' or prod LIKE '206326%');


GRANT SELECT ON BARS.V_CCK_OSBB TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_CCK_OSBB TO START1;
