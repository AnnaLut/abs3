
CREATE OR REPLACE FORCE VIEW BARS.MONEXRI
( KOD_NBU, FDAT1, FDAT2, FL, RU, NAME_RU, KV, OB22, S_2909, K_2909, S_2809, K_2809, S_0000, K_0000, I_2909, R_2809, RK_2809, S_3739,
  komb1, komb2, komb3 ) AS
SELECT i.kod_nbu, i.FDAT1, i.FDAT2, i.fl, NVL (i.RU, -1), NVL (r.name, 'Не визн.код РУ'), i.KV, i.ob22, i.S_2909, i.K_2909,
       i.S_2809, i.K_2809, i.S_0000, i.K_0000, i.I_2909, i.R_2809, i.RK_2809, i.S_3739, i.komb1, i.komb2, i.komb3
FROM banks_ru r,
    (SELECT r.kod_nbu,   MIN (r.FDAT) fdat1, MAX (r.FDAT) fdat2, r.fl, mfo_ru (SUBSTR (r.branch, 2, 6)) RU, r.kv, r.ob22,
           SUM (r.S_2909) S_2909, SUM (r.K_2909) k_2909, SUM (r.S_2809) S_2809, SUM (r.K_2809) K_2809, SUM (r.S_0000) S_0000,
           SUM (r.K_0000) k_0000, SUM (r.S_2909 + r.K_2909) I_2909, SUM (r.S_2809 + r.S_0000) R_2809, SUM (r.K_2809 + r.K_0000) RK_2809,
           SUM (      r.S_2809    + r.S_0000    + r.K_2809    + r.K_0000    - r.S_2909    - r.K_2909)    S_3739,
           SUM (r.Komb1) komb1,
           SUM (r.Komb2) komb2,
           SUM (r.Komb3) komb3
FROM monexr r, V_SFDAT v  WHERE r.fdat >= v.B AND r.fdat <= v.E
GROUP BY r.kod_nbu, r.fl, mfo_ru (SUBSTR (r.branch, 2, 6)),  r.kv,     r.ob22) i
WHERE i.ru = r.ru(+)
   UNION ALL
SELECT r.kod_nbu, MIN (r.FDAT) fdat1, MAX (r.FDAT) fdat2, r.fl, TO_NUMBER (NULL) RU, 'РАЗОМ по Сист+Вал', r.KV, r.ob22,
       SUM (r.S_2909) S_2909, SUM (r.K_2909) k_2909, SUM (r.S_2809) S_2809, SUM (r.K_2809) K_2809, SUM (r.S_0000) S_0000,
       SUM (r.K_0000) k_0000, SUM (r.S_2909 + r.K_2909) I_2909, SUM (r.S_2809 + r.S_0000) R_2809, SUM (r.K_2809 + r.K_0000) RK_2809,
       SUM ( r.S_2809 + r.S_0000 + r.K_2809 + r.K_0000 - r.S_2909 - r.K_2909)    S_3739,
           SUM (r.Komb1) komb1,
           SUM (r.Komb2) komb2,
           SUM (r.Komb3) komb3
FROM monexr r, V_SFDAT v
WHERE r.fdat >= v.B AND r.fdat <= v.E
GROUP BY r.kod_nbu,  r.fl,  r.kv,  r.ob22;
/

GRANT SELECT ON BARS.MONEXRI TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.MONEXRI TO START1;
