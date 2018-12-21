

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FRX_POPULATE_TMP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FRX_POPULATE_TMP ***

  CREATE OR REPLACE PROCEDURE BARS.FRX_POPULATE_TMP (p_dat date)
is
begin
  delete TMP_SWAP_ARC;
  insert into TMP_SWAP_ARC
  select DAT,
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
         CASE
           WHEN KOD LIKE '%TOD%' THEN
             0
           WHEN KOD LIKE '%SPOT%' AND swap_tag IS NULL THEN
             BVQA - BVQB
           WHEN KOD LIKE '%SPOT%' AND swap_tag IS NOT NULL 
             and greatest(dat_a, dat_b) < dat_next_u(dat, 2) --COBUMMFO-10272 MDom 2018.12.11 Для відсіювання овернайтів
           THEN --swap_spot на дату
             (SELECT SUM(gl.p_icurval(kva, suma, B) - gl.p_icurval(kvb, sumb, B))/100
                FROM fx_deal fx
               WHERE swap_tag = s.swap_tag
                 AND deal_tag <> s.swap_tag
                 AND dat_a >= B)
           ELSE
             FOREX.PVX(coalesce(swap_tag, deal_tag), B)/100
         END PVX,
         IRAE,
         IRBE,
         /*case
           when irAe > 0 and irBe > 0 then
             gl.p_icurval(kva, FOREX.PVXR(coalesce(swap_tag, deal_tag), deal_tag, b, kva, irAe), b)/100
           else null
         end pvx1a,
         case
           when irAe > 0 and irBe > 0 then
             gl.p_icurval(kvb, FOREX.PVXR(coalesce(swap_tag, deal_tag), deal_tag, b, kvb, irbe), b)/100
           else null
         end pvx1b,*/
         --COBUMMFO-10289 MDom 2018.12.11 Переробив попередній закоментований шматок для відсіювання овернайтів
         case
           when kod like '%SWAP%' and dat_a = dat_b and dat_a = dat_next_u(dat, 1) then BVQA
           else
             case
               when irAe > 0 and irBe > 0 then
                 gl.p_icurval(kva, FOREX.PVXR(coalesce(swap_tag, deal_tag), deal_tag, b, kva, irAe), b)/100
               else null
             end
         end pvx1a,
         case
           when kod like '%SWAP%' and dat_a = dat_b and dat_a = dat_next_u(dat, 1) then BVQB
           else
             case
               when irAe > 0 and irBe > 0 then
                 gl.p_icurval(kvb, FOREX.PVXR(coalesce(swap_tag, deal_tag), deal_tag, b, kvb, irbe), b)/100
               else null
             end
         end pvx1b,
         ----
         REF,
         coalesce(SWAP_TAG, 0) SWAP_TAG, --переніс coalesce на рівень вище п.5
         DEAL_TAG,
         CASE
           WHEN swap_tag IS NULL THEN ''
           WHEN ira + irb = 0 THEN 'ВАЛ'
           ELSE 'ДЕПО'
         END KODF,
         KOD,
         BVQA - BVQB BVQ,
         BVQA,
         BVQB,
         b
    from (SELECT acca.nls nlsa,
                 accb.nls nlsb,
                 nmk,
                 p_dat b,
                 x.dat,
                 x.ntik,
                 x.swap_tag,
                 x.deal_tag,
                 x.rnk,
                 x.REF,
                 SUMP/100 PVX1,
                 --coalesce(x.sos, 10) sos,
                 x.dat_a,
                 x.kva,
                 x.suma/100 SUMA,
                 ACRN.FPROCN(x.acc9a, 0, x.dat) ira,
                 --(x.dat_A - p_dat) TERMA,
                 ROUND(FOREX.IR_MB(p_dat, x.KVA, (x.dat_a - p_dat)), 4) irAe,
                 x.dat_b,
                 x.kvb,
                 x.sumb/100 SUMB,
                 ACRN.FPROCN(x.acc9b, 1, x.dat) irb,
                 --(x.dat_B - p_dat) TERMB,
                 ROUND(FOREX.IR_MB(p_dat, x.KVB, (x.dat_B - p_dat)), 4) irBe,
                 gl.p_icurval(x.kva, x.suma, p_dat)/100 BVQA,
                 gl.p_icurval(x.kvb, x.sumb, p_dat)/100 BVQB,
                 SUBSTR(FOREX.get_forextype3(x.deal_tag), 1, 17) KOD  --функция возвращает V.SWAP__ D.SWAP__ длина на 2 знака больше?
            FROM fx_deal x
            JOIN accounts acca on acca.acc = x.acc9a
            JOIN accounts accb on accb.acc = x.acc9b
            JOIN customer c on c.rnk = X.RNK
                 --, V_SFDAT d
           WHERE EXISTS (SELECT 1
                           FROM oper
                          WHERE REF = x.REF
                            AND sos > 0)
             -- убрали условие AND coalesce (x.sos, 10) < 15 п.1,2
             AND (FOREX.get_forextype3(x.deal_tag) LIKE '%SWAP%EN' --функция возвращает V.SWAP__ D.SWAP__?
             AND x.deal_tag <> x.swap_tag OR x.swap_tag IS NULL)) s
   where s.dat <= p_dat
     and s.dat_a > p_dat
     and s.dat_b > p_dat;

  commit;

end;
/
show err;

PROMPT *** Create  grants  FRX_POPULATE_TMP ***
grant EXECUTE                                                                on FRX_POPULATE_TMP to START1;
grant EXECUTE                                                                on FRX_POPULATE_TMP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FRX_POPULATE_TMP.sql =========*** 
PROMPT ===================================================================================== 
