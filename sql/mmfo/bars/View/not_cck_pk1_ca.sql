

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NOT_CCK_PK1_CA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view NOT_CCK_PK1_CA ***

  CREATE OR REPLACE FORCE VIEW BARS.NOT_CCK_PK1_CA ("DAPP", "ACC", "KV", "KOD", "NLS", "NMS", "DAOS", "RNK", "TIP", "ISP", "OST") AS 
  SELECT   dapp, acc, kv, nbs||ob22, nls, nms, daos, rnk, tip, isp,  -ostc / 100
     FROM   accounts A
    WHERE   acc IN
                  (SELECT   acc
                     FROM   accounts
                    WHERE   nbs IN ('2062', '2063', '2067', '2068', '2069',
                                    '2065', '2066', '2072', '2073', '2077',
                                    '2078', '2079', '2075', '2076', '2082',
                                    '2083', '2087', '2088', '2089', '2085',
                                    '2086', '2102', '2103', '2107', '2108',
                                    '2109', '2105', '2106', '3578', '3579',
                                    '9129')
                            AND dazs IS NULL
                   MINUS
                   SELECT   acc FROM nd_acc
                   MINUS
                   SELECT   acc
                     FROM   (SELECT   ACC_OVR ACC
                               FROM   bpk_acc
                              WHERE   ACC_OVR IS NOT NULL
                             UNION ALL
                             SELECT   ACC_9129
                               FROM   bpk_acc
                              WHERE   ACC_9129 IS NOT NULL
                             UNION ALL
                             SELECT   acc_2208
                               FROM   bpk_acc
                              WHERE   ACC_2208 IS NOT NULL));

PROMPT *** Create  grants  NOT_CCK_PK1_CA ***
grant SELECT                                                                 on NOT_CCK_PK1_CA  to BARSREADER_ROLE;
grant SELECT                                                                 on NOT_CCK_PK1_CA  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOT_CCK_PK1_CA  to START1;
grant SELECT                                                                 on NOT_CCK_PK1_CA  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NOT_CCK_PK1_CA.sql =========*** End ***
PROMPT ===================================================================================== 
