CREATE OR REPLACE FORCE VIEW BARS.V_R_SK9
(
   ND,
   TIP,
   ACC_SK9,
   NLS,
   KV,
   DAT_IRR,
   FDAT,
   FDAT_END,
   LIT_DAT,
   DAT_BEG_K,
   DAT_END_K,
   S_NOM,
   S,
   S_K,
   K,
   COMM
)
AS
     SELECT t.ND,
            a.tip,
            t.ACC ACC_SK9,
            a.nls,
            a.kv,
            t.dat_irr,
            dat_next_u (t.FDAT_BEG, -1) FDAT,
            t.FDAT_END,
            (CASE
                WHEN TRUNC (DAT_BEG_K, 'mm') = TRUNC (DAT_END_K - 1, 'mm')
                THEN
                      (SELECT name_plain
                         FROM meta_month
                        WHERE n = TO_CHAR (DAT_BEG_K, 'mm'))
                   || ' '
                   || TO_CHAR (DAT_BEG_K, 'yyyy')
                ELSE
                      (SELECT name_plain
                         FROM meta_month
                        WHERE n = TO_CHAR (DAT_BEG_K, 'mm'))
                   || ' '
                   || TO_CHAR (DAT_BEG_K, 'yyyy')
                   || ' - '
                   || (SELECT name_plain
                         FROM meta_month
                        WHERE n = TO_CHAR (DAT_END_K - 1, 'mm'))
                   || ' '
                   || TO_CHAR (DAT_END_K - 1, 'yyyy')
             END)
               LIT_DAT,
            t.DAT_BEG_K,
            t.DAT_END_K,
            ROUND (t.S_nom) / 100 S_nom,
            ROUND (t.S / 100, 2) S,
            ROUND ( (ROUND (t.S_K) - ROUND (t.S)) / 100, 2) S_K,
            t.K * 100 K,
            t.COMM
       FROM tmp_inflation_court t, accounts a
      WHERE     t.acc = a.acc
            AND (a.tip = 'SK0' OR a.nbs IN ('3578'))
            AND t.dat_beg_k < t.dat_end_k
            AND TRUNC (t.FDAT_BEG, 'MM') < TRUNC (t.fdat_end, 'MM')
            AND t.nd = pul.get ('ND_605')
            AND t.typ_kod =
                   CASE
                      WHEN pul.get ('MOD_605') = 1 THEN 1
                      WHEN pul.get ('MOD_605') = 3 THEN 2
                      ELSE 0
                   END
            AND a.kv = '980'
   ORDER BY t.FDAT_BEG;


GRANT SELECT ON BARS.V_R_SK9 TO BARS_ACCESS_DEFROLE;
