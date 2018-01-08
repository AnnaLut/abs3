

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PER_INK_N.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view PER_INK_N ***

  CREATE OR REPLACE FORCE VIEW BARS.PER_INK_N ("NLSA", "KVA", "MFOB", "NLSB", "KVB", "TT", "VOB", "ND", "DATD", "S", "NAM_A", "NAM_B", "NAZN", "OKPOA", "OKPOB", "GRP", "REF", "SOS", "ID") AS 
  SELECT a.nls nlsa,
          a.kv kva,
          b.mfob,
          b.nlsb,
          b.kv kvb,
          b.tt,
          b.vob,
          NULL nd,
          (SELECT datd
             FROM oper
            WHERE REF = o.REF)
             datd,
            ROUND (o.s * b.koef)
          + DECODE (
               (ROW_NUMBER () OVER (PARTITION BY o.REF ORDER BY b.koef DESC)),
               1, (  o.s
                   - (SUM (ROUND (o.s * b.koef))
                         OVER (PARTITION BY o.REF ORDER BY b.koef))),
               0)
             s,
          CASE
             WHEN SUBSTR (a.nls, 0, 4) IN (SELECT nbs FROM NBS_PRINT_BANK) -- AND a.kf <> b.mfob
             THEN
                SUBSTR (GetGlobalOption ('NAME'), 1, 38)
             ELSE
                SUBSTR (a.nms, 1, 38)
          END
             nam_a,
          polu nam_b,                                                --b.nazn,
          (SELECT nazn
             FROM oper
            WHERE REF = o.REF)
             nazn,
          SUBSTR (f_ourokpo, 1, 8) okpoa,
          b.okpo okpob,
          s.idg grp,
          o.REF,
          0 sos,
          o.REF id
     FROM opldok o,
          perekr_b b,
          specparam s,
          accounts a,
          saldoa ss
    WHERE     s.acc = ss.acc
          AND (a.nls LIKE '2909%' OR a.nls LIKE '2900%')
          AND s.ids = b.ids
          AND ss.acc = a.acc
          AND ss.fdat BETWEEN SYSDATE - 5 AND SYSDATE
          AND o.fdat = ss.fdat
          AND o.acc = ss.acc
          AND NOT EXISTS
                 (SELECT 1
                    FROM per_que
                   WHERE REF = o.REF)
          AND o.sos = 5
          AND o.dk = 1;

PROMPT *** Create  grants  PER_INK_N ***
grant DELETE,SELECT,UPDATE                                                   on PER_INK_N       to BARS015;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PER_INK_N.sql =========*** End *** ====
PROMPT ===================================================================================== 
