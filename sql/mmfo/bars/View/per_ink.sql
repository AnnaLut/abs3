

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PER_INK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view PER_INK ***

  CREATE OR REPLACE FORCE VIEW BARS.PER_INK ("NLSA", "KVA", "MFOB", "NLSB", "KVB", "TT", "VOB", "ND", "DATD", "S", "NAM_A", "NAM_B", "NAZN", "NAZN2", "OKPOA", "OKPOB", "GRP", "REF", "SOS", "ID", "SS") AS 
  SELECT a.nls nlsa,
          a.kv kva,
          b.mfob,
          b.nlsb,
          b.kv kvb,
          b.tt,
          b.vob,
          NULL nd,
          (SELECT datd  FROM oper   WHERE REF = o.REF)    datd,
          ROUND (o.s * b.koef) + DECODE ((ROW_NUMBER () OVER (PARTITION BY o.REF ORDER BY b.koef DESC)),1, (  o.s - (SUM (ROUND (o.s * b.koef))
                         OVER (PARTITION BY o.REF ORDER BY b.koef))), 0)     s,
		 CASE
             WHEN    SUBSTR (a.nls, 0, 4) IN  (SELECT nbs FROM NBS_PRINT_BANK) -- AND a.kf <> b.mfob
             THEN     substr(GetGlobalOption ('NAME'),1,38)
             ELSE     SUBSTR (a.nms, 1, 38)
          END         nam_a,
          --SUBSTR (DECODE (b.mfob, f_ourmfo, a.nms, NVL (k.nmkk, k.nmk)), 1, 38)    nam_a,
          polu nam_b,
          b.nazn,
          (SELECT nazn FROM oper WHERE REF = o.REF) nazn2,
		  SUBSTR (f_ourokpo, 1, 8)   okpoa,
          b.okpo okpob,
          s.idg grp,
          o.REF,
          0 sos,
          o.REF id,
          o.s ss
     FROM opldok o,
          perekr_b b,
          specparam s,
          v_gl a,
          customer k
    WHERE     a.acc = s.acc
          AND a.rnk = k.rnk
          AND s.ids = b.ids
          AND o.acc = a.acc
          AND o.fdat between sysdate-5 and sysdate
          AND NOT EXISTS
                 (SELECT 1
                    FROM per_que
                   WHERE REF = o.REF)
          AND o.sos = 5
          AND o.dk = 1;

PROMPT *** Create  grants  PER_INK ***
grant DELETE,SELECT,UPDATE                                                   on PER_INK         to BARS015;
grant DELETE,SELECT,UPDATE                                                   on PER_INK         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PER_INK.sql =========*** End *** ======
PROMPT ===================================================================================== 
