

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SWAP.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SWAP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SWAP ("B", "DAT", "NTIK", "SWAP_TAG", "DEAL_TAG", "RNK", "NMK", "REF", "PVX1", "OTM", "OTM1", "DEL1", "DELX", "SOS", "BVQA", "BVQB", "BVQ", "KOD", "DAT_A", "KVA", "SUMA", "TERMA", "IRA", "IRAE", "DAT_B", "KVB", "SUMB", "TERMB", "IRB", "IRBE", "PVX", "KODF") AS 
  SELECT B,
       dat,
       ntik,
       NVL(swap_tag, 0) SWAP_TAG,
       deal_tag,
       rnk,
       NMK,
       REF,
       PVX1,
       0 otm,
       0 otm1,
       '?' DEL1,
       '?' DELX,
       sos,
       BVQA,
       BVQB,
       BVQA - BVQB BVQ,
       s.KOD,
       dat_a,
       kva,
       SUMA,
       TERMA,
       irA,
       ROUND(irAe, 4) irAe,
       dat_b,
       kvb,
       SUMB,
       TERMB,
       irB,
       ROUND(irBe, 4) irBe,
       CASE
         WHEN s.KOD LIKE '%TOD%' THEN 0
         WHEN s.KOD LIKE '%SPOT%' AND S.swap_tag IS NULL THEN BVQA - BVQB
         WHEN s.KOD LIKE '%SPOT%' AND S.swap_tag IS NOT NULL
           and greatest(dat_a, dat_b) < dat_next_u(dat, 2) --COBUMMFO-10272 MDom 2018.12.11 Äëÿ â³äñ³þâàííÿ îâåðíàéò³â
         THEN (SELECT SUM(gl.p_icurval(kva, suma, B) - gl.p_icurval(kvb, sumb, B))/100
                 FROM fx_deal
                WHERE swap_tag = S.swap_tag
                  AND deal_tag <> S.swap_tag
                  AND dat_a >= B)
         ELSE FOREX.PVX(NVL(S.swap_tag, S.deal_tag), B)/100
       END PVX,
       CASE
         WHEN S.swap_tag IS NULL THEN ''
         WHEN S.ira + S.irb = 0 THEN 'ÂÀË'
         ELSE 'ÄÅÏÎ'
       END KODF
  FROM (SELECT d.B,
               x.dat,
               x.ntik,
               x.swap_tag,
               x.deal_tag,
               x.rnk,
               c.nmk,
               x.REF,
               SUMP/100 PVX1,
               NVL(x.sos, 10) sos,
               x.dat_a,
               x.kva,
               x.suma/100 SUMA,
               ACRN.FPROCN(x.acc9a, 0, x.dat) ira,
               (x.dat_A - d.B) TERMA,
               FOREX.IR_MB(d.B, x.KVA, (x.dat_a - d.B)) irAe,
               x.dat_b,
               x.kvb,
               x.sumb/100 SUMB,
               ACRN.FPROCN(x.acc9b, 1, x.dat) irb,
               (x.dat_B - d.B) TERMB,
               FOREX.IR_MB(d.B, x.KVB, (x.dat_B - d.B)) irBe,
               gl.p_icurval(x.kva, x.suma, d.B)/100 BVQA,
               gl.p_icurval(x.kvb, x.sumb, d.B)/100 BVQB,
               SUBSTR(FOREX.get_forextype3(x.deal_tag), 1, 15) KOD
          FROM fx_deal x,
               V_SFDAT d,
               customer c
         WHERE EXISTS (SELECT 1
                         FROM oper
                        WHERE REF = x.REF
                          AND sos > 0)
           AND c.rnk = x.rnk
           AND NVL(x.sos, 10) < 15
           AND (FOREX.get_forextype3(x.deal_tag) LIKE '%SWAP%EN'
           AND x.deal_tag <> x.swap_tag OR x.swap_tag IS NULL)) S
;

PROMPT *** Create  grants  V_SWAP ***
grant SELECT                                                                 on V_SWAP          to UPLD;
grant SELECT                                                                 on V_SWAP          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SWAP          to FOREX;
grant SELECT                                                                 on V_SWAP          to START1;
grant SELECT                                                                 on V_SWAP          to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SWAP.sql =========*** End *** =======
PROMPT ===================================================================================== 
