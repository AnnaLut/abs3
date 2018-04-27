PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PRVN_ITOG_YYYY.sql =========*** Run ***
PROMPT ===================================================================================== 
--по SNA добавлена умова  and a.nbs is not null (дублювалися ЦП)

PROMPT *** Create  view PRVN_ITOG_YYYY ***

  CREATE OR REPLACE FORCE VIEW BARS.PRVN_ITOG_YYYY ("MFO", "FDAT", "ORD", "KV", "BV", "BVQ", "REZ23", "REZQ23", "REZ", "REZQ", "SNA", "SNAQ", "BV1", "BVQ1", "REZ231", "REZQ231", "REZ1", "REZQ1", "SNA1", "SNAQ1", "BVD", "BVQD", "REZ23D", "REZQ23D", "REZD", "REZQD", "SNAD", "SNAQD", "UCENKA", "UCENKAQ", "UCENKA1", "UCENKAQ1", "UCENKAD", "UCENKAQD") AS 
  SELECT SUBSTR (f_ourmfo, 1, 6) MFO, r.fdat, DECODE (r.kv, 0, 0, 980, 1, 999 - r.kv) ORD, r.kv,
       r.bv, r.bvq, r.rez23, r.rezq23, r.rez, r.rezq,
       k.SNA, k.SNAQ,
       r1.bv BV1, r1.bvq BVQ1, r1.rez23 REZ231, r1.rezq23 REZq231, r1.rez REZ1, r1.rezq REZQ1,
       k1.SNA SNA1, k1.SNAQ SNAQ1,
       r.bv - r1.bv BVd, r.bvq - r1.bvq BVQd, r.rez23 - r1.rez23 REZ23d, r.rezq23 - r1.rezq23 REZq23d,
       r.rez - r1.rez REZd, r.rezq - r1.rezq REZQd,
       k.sna - k1.SNA SNAd, k.snaq - k1.SNAQ SNAQd,
       p.UCENKA, p.UCENKAQ, p1.UCENKA, p1.UCENKAQ,
       p.UCENKA - p1.UCENKA UCENKAd, p.UCENKAq - p1.UCENKAQ UCENKAQd
FROM ( SELECT fdat, ADD_MONTHS (fdat, -1) FDAT1, KV, SUM (bv) bv, SUM (bvq) bvq, SUM (rez23) rez23, SUM (rezq23) rezq23,
              SUM (rez) rez, SUM (rezq) rezq FROM   nbu23_rez
       WHERE  bv > 0 AND fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -1) AND fdat < SYSDATE  GROUP BY fdat, kv UNION ALL
       SELECT fdat, ADD_MONTHS (fdat, -1), 0, NULL, SUM (bvq), NULL, SUM (rezq23), NULL, SUM (rezq) FROM   nbu23_rez
       WHERE  bv > 0 AND fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -1) AND fdat < SYSDATE GROUP BY fdat) r,
       --------------
     ( SELECT fdat, KV, SUM (bv) bv, SUM (bvq) bvq, SUM (rez23) rez23, SUM (rezq23) rezq23, SUM (rez) rez, SUM (rezq) rezq  FROM   nbu23_rez
       WHERE  bv > 0 AND fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -1) AND fdat < SYSDATE GROUP BY fdat, kv  UNION ALL
       SELECT fdat, 0, NULL, SUM (bvq), NULL, SUM (rezq23), NULL, SUM (rezq) FROM   nbu23_rez
       WHERE  bv > 0 AND fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -1) AND fdat < SYSDATE GROUP BY fdat) r1,
       --------------
     ( SELECT ADD_MONTHS (m.fdat, 1) fdat, a.kv, SUM (m.ost + m.CRkos - m.CRdos) / 100 SNA, SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100 SNAQ
       FROM   AGG_MONBALS m, accounts a
       WHERE  a.tip = 'SNA' and a.nbs is not null AND m.acc = a.acc AND fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2) GROUP BY m.fdat, a.kv UNION ALL
       SELECT ADD_MONTHS (m.fdat, 1) fdat, 0, NULL, SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100  FROM   AGG_MONBALS m, accounts a
       WHERE  a.tip = 'SNA' and a.nbs is not null AND m.acc = a.acc AND fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2) GROUP BY m.fdat) k,
       --------------
     ( SELECT ADD_MONTHS (m.fdat, 1) fdat, a.kv, SUM (m.ost + m.CRkos - m.CRdos) / 100 SNA, SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100 SNAQ
       FROM   AGG_MONBALS m, accounts a
       WHERE  a.tip = 'SNA' and a.nbs is not null AND m.acc = a.acc AND fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2) GROUP BY m.fdat, a.kv UNION ALL
       SELECT ADD_MONTHS (m.fdat, 1) fdat, 0, NULL, SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100  FROM   AGG_MONBALS m, accounts a
       WHERE  a.tip = 'SNA' and a.nbs is not null AND m.acc = a.acc AND fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)  GROUP BY m.fdat) k1,
       --------------
     ( SELECT ADD_MONTHS (m.fdat, 1) fdat, a.kv, nvl(SUM (m.ost + m.CRkos - m.CRdos) / 100,0) UCENKA, nvl(SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100,0) UCENKAQ
       FROM   AGG_MONBALS m, accounts a
       WHERE  a.nbs in ('1405','1415','1435','3007','3015','3107','3115')  AND m.acc = a.acc AND
              fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2) and (m.ost + m.CRkos - m.CRdos>0 or a.rnk = 90593701 and m.ost + m.CRkos - m.CRdos < 0)
       GROUP BY m.fdat, a.kv UNION ALL
       SELECT ADD_MONTHS (m.fdat, 1) fdat, 0, NULL, round(SUM (m.ostQ + m.CRkosQ - m.CRdosQ),0) / 100  FROM   AGG_MONBALS m, accounts a
       WHERE  a.nbs in ('1405','1415','1435','3007','3015','3107','3115')  AND m.acc = a.acc AND
              fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2) and (m.ost + m.CRkos - m.CRdos>0 or a.rnk = 90593701 and m.ost + m.CRkos - m.CRdos < 0)
       GROUP BY m.fdat) p,
       --------------
     ( SELECT ADD_MONTHS (m.fdat, 1) fdat, a.kv, SUM (m.ost + m.CRkos - m.CRdos) / 100 UCENKA, SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100 UCENKAQ
       FROM   AGG_MONBALS m, accounts a
       WHERE  a.nbs in ('1405','1415','1435','3007','3015','3107','3115')  AND m.acc = a.acc AND
              fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2) and (m.ost + m.CRkos - m.CRdos>0 or a.rnk = 90593701 and m.ost + m.CRkos - m.CRdos < 0)
       GROUP BY m.fdat, a.kv UNION ALL
       SELECT ADD_MONTHS (m.fdat, 1) fdat, 0, NULL, SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100  FROM   AGG_MONBALS m, accounts a
       WHERE  a.nbs in ('1405','1415','1435','3007','3015','3107','3115')  AND m.acc = a.acc AND
              fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2) and (m.ost + m.CRkos - m.CRdos>0 or a.rnk = 90593701 and m.ost + m.CRkos - m.CRdos < 0)
       GROUP BY m.fdat) p1
WHERE  r.fdat = k.fdat(+) AND r.fdat1 = r1.fdat(+) AND r.fdat1 = k1.fdat(+) AND r.kv = k.kv(+) AND r.kv = r1.kv(+) AND r.kv = k1.kv(+) and
       r.fdat = p.fdat(+) AND r.fdat1 = p1.fdat(+) AND r.kv = p.kv(+)  AND r.kv = p1.kv(+);

PROMPT *** Create  grants  PRVN_ITOG_YYYY ***
grant SELECT                                                                 on PRVN_ITOG_YYYY  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_ITOG_YYYY  to START1;
grant SELECT                                                                 on PRVN_ITOG_YYYY  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PRVN_ITOG_YYYY.sql =========*** End ***
PROMPT ===================================================================================== 
