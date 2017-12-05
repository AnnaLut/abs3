 -- виртуальные  обороты  по Ѕал дл¤ #02)
CREATE OR REPLACE FORCE VIEW BARS.SALDO_V02 AS SELECT KF,FDAT, kv, NBS, POS, NBS1, SUM (DOS) dos, SUM (KOS) kos   FROM SALDO_V   GROUP BY KF,FDAT,  kv,   NBS,  POS, NBS1;

GRANT SELECT ON BARS.SALDO_V02 TO BARS_ACCESS_DEFROLE;
-----------------------------------------------------------