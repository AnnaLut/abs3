CREATE OR REPLACE FORCE VIEW BARS.V_FXS_ARCHIVE
(
   DEAL_TAG,
   NTIK,
   KVA,
   SUMA,
   KVB,
   SUMB,
   REF,
   SOSM,
   REFA,
   SOSA,
   REFB,
   SOSB,
   REFB2,
   REF1,
   REFA_SPTOD,
   REFB_SPTOD,
   REFB2_SPTOD,
   KODB,
   TA_DIG,
   TB_DIG,
   SWI_REF,
   SWO_REF,
   SUMPA,
   SUMPB,
   SUMP,
   SWAP_TAG,
   RNK,
   OKPO,
   MFO,
   DAT,
   DAT_A,
   DAT_B,
   KURS,
   SUMC,
   RATEA,
   RATEB,
   NB,
   RECPAR
)
AS
     SELECT DEAL_TAG,
            NTIK,
            KVA,
            SUMA / POWER (10, ta.dig) suma,
            KVB,
            SUMB / POWER (10, tb.dig) SUMB,
            REF,
            (SELECT o.sos
               FROM oper o
              WHERE o.REF = FX_DEAL.REF)
               sosm,
            refa,
            (SELECT o.sos
               FROM oper o
              WHERE o.REF = FX_DEAL.REFA)
               SOSA,
            refb,
            (SELECT o.sos
               FROM oper o
              WHERE o.REF = FX_DEAL.REFb)
               sosb,
            refb2,
            ref1,
            refa_sptod,
            refb_sptod,
            refb2_sptod,
            kodb,
            ta.dig ta_dig,
            tb.dig tb_dig,
            swi_ref,
            swo_ref,
            sumpa / 100 sumpa,
            sumpb / 100 sumpb,
            sump / 100 sump,
            swap_tag,
            fx_deal.rnk,
            c.okpo,
            b.mfo,
            FX_DEAL.DAT,
            FX_DEAL.DAT_A,
            FX_DEAL.DAT_B,
            ROUND (
               DECODE (curr_base,
                       'A', sumb / suma,
                       'B', suma / sumb,
                       GREATEST (suma, sumb) / LEAST (suma, sumb)),
               8)
               KURS,
            sumc / POWER (10, ta.dig) sumc,
            CASE
               WHEN FX_DEAL.swap_tag IS NOT NULL AND FX_DEAL.acc9a IS NOT NULL
               THEN
                  get_int_rate (FX_DEAL.acc9a, FX_DEAL.dat)
               ELSE
                  NULL
            END
               ratea,
            CASE
               WHEN FX_DEAL.swap_tag IS NOT NULL AND FX_DEAL.acc9b IS NOT NULL
               THEN
                  get_int_rate (FX_DEAL.acc9b, FX_DEAL.dat)
               ELSE
                  NULL
            END
               rateb,
            fx_deal.nb,
            'Редагування Парам.'
       FROM FX_DEAL,
            tabval ta,
            tabval tb,
            customer c,
            custbank b
      WHERE     FX_DEAL.kva = ta.kv
            AND FX_DEAL.kvb = tb.kv
            AND fx_deal.rnk = c.rnk(+)
            AND fx_deal.rnk = b.rnk(+)
   ORDER BY deal_tag DESC,
            DAT,
            kodb,
            KVA,
            KVB;

GRANT SELECT ON v_fxs_archive TO BARS_ACCESS_DEFROLE;