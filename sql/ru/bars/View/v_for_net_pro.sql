CREATE OR REPLACE FORCE VIEW BARS.V_FOR_NET_PRO
AS
   SELECT a.RNK,
          a.DAT_A,
          a.KVA,
          LEAST (a.sa, b.sb) SN,
          a.SA,
          a.KA,
          b.SB,
          b.KB,
          0 S,
          '' CC_ID
     FROM (  SELECT kva,
                    dat_a,
                    rnk,
                    NVL (SUM ( (SELECT s
                                  FROM opldok
                                 WHERE REF = refa AND ROWNUM = 1)),
                         0)
                       sa,
                    COUNT (*) ka
               FROM fx_deal
              WHERE dat_a >= gl.bd
           GROUP BY kva, dat_a, rnk) a,
          (  SELECT kvb,
                    dat_b,
                    rnk,
                    NVL (SUM ( (SELECT s
                                  FROM opldok
                                 WHERE REF = refb AND ROWNUM = 1)),
                         0)
                       sb,
                    COUNT (*) kb
               FROM fx_deal
              WHERE dat_b >= gl.bd
           GROUP BY kvb, dat_b, rnk) b
    WHERE     a.kva = b.kvb
          AND a.dat_a = b.dat_b
          AND a.rnk = b.rnk
          AND a.sa > 0
          AND b.sb > 0;


grant select on V_FOR_NET_PRO to bars_access_defrole;