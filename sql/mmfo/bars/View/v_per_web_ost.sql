

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PER_WEB_OST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PER_WEB_OST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PER_WEB_OST ("NLSA", "KVA", "MFOB", "NLSB", "KVB", "TT", "VOB", "OSTC", "KOEF", "S", "NAM_A", "NAM_B", "NAZN", "ACC", "OKPOA", "OKPOB", "IDR", "DIG", "KOD", "FORMULA", "GRP", "SOS", "REF") AS 
  SELECT a.nls nlsa,
            a.kv kva,
            pb.mfob,
            SUBSTR (
               VKRZN (
                  SUBSTR (pb.mfob, 1, 5),
                  TRIM (
                     SUBSTR (
                        DECODE (
                           SUBSTR (pb.nlsb, 5, 1),
                           '*', SUBSTR (pb.nlsb, 1, 4) || SUBSTR (a.nls, 5),
                           pb.nlsb),
                        1,
                        14))),
               1,
               14)
               nlsb,
            pb.kv kvb,
            pb.tt,
            pb.vob,
            KAZ (pa.sps, pa.acc) ostc,
            pb.koef,
            ROUND (KAZ (pa.sps, pa.acc) * pb.koef) s,
            SUBSTR (DECODE (pb.mfob, f_ourmfo, a.nms, NVL (k.nmkk, k.nmk)),
                    1,
                    38)
               nam_a,
            DECODE (SUBSTR (pb.nlsb, 5, 1), '*', NVL (k.nmkk, k.nmk), pb.polu)
               nam_b,
            pb.nazn,
            a.acc,
            k.okpo okpoa,
            DECODE (SUBSTR (pb.nlsb, 5, 1), '*', k.okpo, pb.okpo) okpob,
            pb.idr,
            t.dig,
            pb.kod,
            pb.formula,
            pa.idg AS grp,
            0 sos,
            '' REF
       FROM specparam pa,
            perekr_b pb,
            saldo a,
            tabval t,
            customer k,
            cust_acc c
      WHERE     pa.ids = pb.ids
            AND pa.acc = a.acc
            AND a.kv = t.kv
            AND c.acc = a.acc
            AND c.rnk = k.rnk
            --AND  pa.idg=:grp
            AND pb.koef > 0
            AND KAZ (pa.sps, pa.acc) > 0
   ORDER BY a.nls, a.kv;

PROMPT *** Create  grants  V_PER_WEB_OST ***
grant SELECT                                                                 on V_PER_WEB_OST   to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on V_PER_WEB_OST   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PER_WEB_OST   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PER_WEB_OST.sql =========*** End *** 
PROMPT ===================================================================================== 
