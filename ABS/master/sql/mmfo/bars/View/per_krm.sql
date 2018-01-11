

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PER_KRM.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view PER_KRM ***

  CREATE OR REPLACE FORCE VIEW BARS.PER_KRM ("NLSA", "KVA", "MFOB", "NLSB", "KVB", "TT", "VOB", "ND", "DATD", "S", "NAM_A", "NAM_B", "NAZN", "OKPOA", "OKPOB", "GRP", "REF", "SOS", "ID") AS 
  SELECT a.nls nlsa,
       a.kv kva,
       b.mfob,
       b.nlsb,
       a.kv kvb,
       b.tt,
       b.vob,
       NULL nd,
       (SELECT datd
          FROM oper
         WHERE REF = o.REF)
          datd,
         ROUND (o.s * b.koef)
       + DECODE ((ROW_NUMBER () OVER (PARTITION BY o.REF ORDER BY b.koef DESC)),
            1, (  o.s - (SUM (ROUND (o.s * b.koef)) OVER (PARTITION BY o.REF ORDER BY b.koef))),
            0)
          s,
       a.nms nam_a,
       polu nam_b,                                                   --b.nazn,
       (SELECT nazn FROM oper WHERE REF = o.REF)  nazn,
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
       nlk_ref n
 WHERE     a.acc = s.acc
       AND s.ids = b.ids
       AND o.acc = a.acc
       AND a.acc = n.acc
       AND o.REF = n.ref1
       AND n.ref2 IS NULL
       AND o.sos = 5
       AND o.dk = 1;

PROMPT *** Create  grants  PER_KRM ***
grant DELETE,SELECT,UPDATE                                                   on PER_KRM         to BARS015;
grant SELECT                                                                 on PER_KRM         to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on PER_KRM         to BARS_ACCESS_DEFROLE;
grant DELETE,SELECT,UPDATE                                                   on PER_KRM         to START1;
grant SELECT                                                                 on PER_KRM         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PER_KRM.sql =========*** End *** ======
PROMPT ===================================================================================== 
