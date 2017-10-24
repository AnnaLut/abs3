

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FRX_POPULATE_TMP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FRX_POPULATE_TMP ***

  CREATE OR REPLACE PROCEDURE BARS.FRX_POPULATE_TMP (p_dat date)
is
begin 
delete TMP_SWAP_ARC;
insert into  TMP_SWAP_ARC
select 
DAT,
NTIK,
RNK,
nmk,
KVA,
nlsa,
DAT_A,
SUMA,
KVB,
nlsb,
DAT_B,
SUMB,
PVX1,
PVX,
IRAE,
IRBE,
case when irAe>0 and irBe>0
     then 
     (gl.p_icurval( kva, FOREX.PVXR (nvl(swap_tag,deal_tag),deal_tag,b,kva,irAe),b))/100
     else null 
end pvx1a,
case when irAe>0 and irBe>0
     then 
     (gl.p_icurval( kvb, FOREX.PVXR (nvl(swap_tag,deal_tag),deal_tag,b,kvb,irbe),b))/100
     else null 
end pvx1b,    
REF,
NVL (SWAP_TAG, 0) SWAP_TAG, --переніс NVL на уровени више п.5
DEAL_TAG,
KODF,
KOD,
BVQ,
BVQA,
BVQB,
b
from
(
   SELECT
          nlsa,
          nlsb,
          nmk,
          B,
          dat,
          ntik,
          swap_tag,  --переніс NVL на уровень више п.5
          deal_tag,
          rnk,
          REF,
          PVX1,                                     
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
          ROUND (irAe, 4) irAe,
          dat_b,
          kvb,
          SUMB,
          TERMB,
          irB,
          ROUND (irBe, 4) irBe,
          CASE
             WHEN s.KOD LIKE '%TOD%'
             THEN
                (0)
             WHEN s.KOD LIKE '%SPOT%' AND S.swap_tag IS NULL
             THEN
                (BVQA - BVQB)
             WHEN s.KOD LIKE '%SPOT%' AND S.swap_tag IS NOT NULL
             THEN
			 --swap_spot на дату
                (SELECT   SUM (
                               gl.p_icurval (kva, suma, B)
                             - gl.p_icurval (kvb, sumb, B))
                        / 100
                   FROM fx_deal
                  WHERE     swap_tag = S.swap_tag
                        AND deal_tag <> S.swap_tag
                        AND dat_a >= B)
             ELSE
                (FOREX.PVX (NVL (S.swap_tag, S.deal_tag), B) / 100)
          END
             PVX,
          CASE
             WHEN S.swap_tag IS NULL THEN ''
             WHEN S.ira + S.irb = 0 THEN 'ВАЛ'
             ELSE 'ДЕПО'
          END
             KODF
     FROM (SELECT
                  acca.nls nlsa,
                  accb.nls nlsb,
                  nmk,
                  p_dat b,
                  x.dat,
                  x.ntik,
                  x.swap_tag,
                  x.deal_tag,
                  x.rnk,
                  x.REF,
                  SUMP / 100 PVX1,
                  NVL (x.sos, 10) sos,
                  x.dat_a,
                  x.kva,
                  x.suma / 100 SUMA,
                  ACRN.FPROCN (x.acc9a, 0, x.dat) ira,
                  (x.dat_A - p_dat) TERMA,
                  FOREX.IR_MB (p_dat, x.KVA, (x.dat_a - p_dat)) irAe,
                  x.dat_b,
                  x.kvb,
                  x.sumb / 100 SUMB,
                  ACRN.FPROCN (x.acc9b, 1, x.dat) irb,
                  (x.dat_B - p_dat) TERMB,
                  FOREX.IR_MB (p_dat, x.KVB, (x.dat_B - p_dat)) irBe,
                  gl.p_icurval (x.kva, x.suma, p_dat) / 100 BVQA,
                  gl.p_icurval (x.kvb, x.sumb, p_dat) / 100 BVQB,
                  SUBSTR (FOREX.get_forextype3 (x.deal_tag), 1, 17) KOD  --функция возвращает V.SWAP__ D.SWAP__ длана на 2 знака больше ??
             FROM 
                  fx_deal x,
                  accounts acca,
                  accounts accb,
                  customer c--, V_SFDAT d
            WHERE     
                acca.acc=x.acc9a
            and accb.acc=x.acc9b
            and 
            c.rnk=X.RNK
            and
              EXISTS
                         (SELECT 1
                            FROM oper
                           WHERE REF = x.REF AND sos > 0)
            -- убрали условие AND NVL (x.sos, 10) < 15  п.1,2 
            AND (FOREX.get_forextype3 (x.deal_tag) LIKE '%SWAP%EN'  --функция возвращает V.SWAP__ D.SWAP__ ??
                 AND x.deal_tag <> x.swap_tag
                  OR x.swap_tag IS NULL
                )
          ) S
)
where dat<=p_dat and dat_a>p_dat and dat_b>p_dat
;
commit;

end;
/
show err;

PROMPT *** Create  grants  FRX_POPULATE_TMP ***
grant EXECUTE                                                                on FRX_POPULATE_TMP to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FRX_POPULATE_TMP to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FRX_POPULATE_TMP.sql =========*** 
PROMPT ===================================================================================== 
