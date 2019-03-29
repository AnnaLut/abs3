

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PRVN_ITOG_YYYY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view PRVN_ITOG_YYYY ***

  CREATE OR REPLACE FORCE VIEW BARS.PRVN_ITOG_YYYY  AS 
  SELECT SUBSTR (f_ourmfo, 1, 6) MFO,
          r.fdat,
          DECODE (r.kv,  0, 0,  980, 1,  999 - r.kv) ORD,
          r.kv,
          r.bv,
          r.bvq,
          r.rez23,
          r.rezq23,
          r.rez,
          r.rezq,
          k.SNA,
          k.SNAQ,
          d.SDI,
          d.SDIQ,
          r1.bv BV1,
          r1.bvq BVQ1,
          r1.rez23 REZ231,
          r1.rezq23 REZq231,
          r1.rez REZ1,
          r1.rezq REZQ1,
          k1.SNA SNA1,
          k1.SNAQ SNAQ1,
          d1.SDI SDI1,
          d1.SDIQ SDIQ1,
          r.bv - r1.bv BVd,
          r.bvq - r1.bvq BVQd,
          r.rez23 - r1.rez23 REZ23d,
          r.rezq23 - r1.rezq23 REZq23d,
          r.rez - r1.rez REZd,
          r.rezq - r1.rezq REZQd,
          k.sna - k1.SNA SNAd,
          k.snaq - k1.SNAQ SNAQd,
          d.sdi - d1.SDI SDId,
          d.sdiq - d1.SDIQ SDIQd,
          p.UCENKA,
          p.UCENKAQ,
          p1.UCENKA UCENKA1,
          p1.UCENKAQ UCENKA1Q,
          p.UCENKA - p1.UCENKA UCENKAd,
          p.UCENKAq - p1.UCENKAQ UCENKAQd,
          f.SDF,
          f.SDFQ,
          f1.SDF SDF1,
          f1.SDFQ SDFQ1,
          f.sdf - f1.SDf SDFd,
          f.sdFq - f1.SDfQ SDfQd
     FROM prvn_itog_r r, 
               prvn_itog_r1 r1, 
               prvn_itog_k k,
               prvn_itog_k1 k1,
               prvn_itog_d d,
               prvn_itog_d1 d1,
               prvn_itog_p p,
               prvn_itog_p1 p1,               
               prvn_itog_f f,
               prvn_itog_f1 f1               
    WHERE     r.fdat = k.fdat(+)
          AND r.fdat = d.fdat(+)
          AND r.fdat = f.fdat(+)
          AND r.fdat = p.fdat(+)
          AND r.fdat1 = r1.fdat(+)
          AND r.fdat1 = k1.fdat(+)
          AND r.fdat1 = d1.fdat(+)
          AND r.fdat1 = f1.fdat(+)
          AND r.fdat1 = p1.fdat(+)
          AND r.kv = k.kv(+)
          AND r.kv = d.kv(+)
          AND r.kv = f.kv(+)
          AND r.kv = p.kv(+)
          AND r.kv = r1.kv(+)
          AND r.kv = k1.kv(+)
          AND r.kv = d1.kv(+)
          AND r.kv = f1.kv(+)
          AND r.kv = p1.kv(+);

PROMPT *** Create  grants  PRVN_ITOG_YYYY ***
grant SELECT                                                                 on PRVN_ITOG_YYYY  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_ITOG_YYYY  to START1;
grant SELECT                                                                 on PRVN_ITOG_YYYY  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PRVN_ITOG_YYYY.sql =========*** End ***
PROMPT ===================================================================================== 
