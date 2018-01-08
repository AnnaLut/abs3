CREATE OR REPLACE FORCE VIEW BARS.CC_ENERGY
(
   OTM,
   BRANCH,
   CC_ID,
   ND,
   PROD,
   RNK,
   SDATE,
   SDOG,
   SOS,
   WDATE,
   OST
)
AS
   SELECT 0 OTM,
          branch,
          cc_id,
          nd,
          prod,
          rnk,
          sdate,
          sdog,
          sos,
          wdate,
          (SELECT -a.ostc / 100
             FROM accounts a, nd_acc n
            WHERE a.tip = 'LIM' AND a.acc = n.acc AND n.nd = d.ND)
             ost
     FROM cc_deal d -- Продукт не менялся поэтому добавляем новый
    WHERE sos < 14 AND (prod LIKE '220256%' OR prod LIKE '220346%' OR prod LIKE '220379%');



GRANT SELECT ON BARS.CC_ENERGY TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.CC_ENERGY TO START1;

GRANT SELECT ON BARS.CC_ENERGY TO UPLD;
