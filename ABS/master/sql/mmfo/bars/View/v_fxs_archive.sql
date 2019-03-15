

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FXS_ARCHIVE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FXS_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FXS_ARCHIVE ("DEAL_TAG", "NTIK", "KVA", "SUMA", "KVB", "SUMB", "REF", "SOSM", "REFA", "SOSA", "REFB", "SOSB", "REFB2", "REF1", "REFA_SPTOD", "REFB_SPTOD", "REFB2_SPTOD", "KODB", "TA_DIG", "TB_DIG", "SWI_REF", "SWO_REF", "SUMPA", "SUMPB", "SUMP", "SWAP_TAG", "RNK", "OKPO", "MFO", "DAT", "DAT_A", "DAT_B", "KURS", "SUMC", "RATEA", "RATEB", "NB", "RECPAR", "FX_TYPE", "F092", "INITIATOR") AS 
  SELECT DEAL_TAG, NTIK,
       KVA, SUMA,
       KVB, SUMB,
       REF, SOSM,
       REFA, SOSA,
       REFB, SOSB,
       REFB2, REF1,
       REFA_SPTOD, REFB_SPTOD,
       REFB2_SPTOD, KODB,
       TA_DIG, TB_DIG,
       SWI_REF, SWO_REF,
       SUMPA, SUMPB,
       SUMP, SWAP_TAG,
       RNK, OKPO, MFO,
       DAT, DAT_A,
       DAT_B, KURS,
       SUMC, RATEA,
       RATEB, NB,
       RECPAR, FOREX.get_forextype3(x.DEAL_TAG) FX_type,
       (select substr(value,1,5)
          from operw
         where tag = 'F092'
           and ref = x.REF) F092,
       (select value
          from operw
         where ref = x.ref
           and tag = 'CP_IN') as initiator
  FROM (SELECT DEAL_TAG, NTIK,
               KVA, SUMA / POWER(10, ta.dig) suma,
               KVB, SUMB / POWER (10, tb.dig) sumb,
               REF, refa, refb,
               (SELECT o.sos FROM oper o WHERE o.REF = FX_DEAL.REF) sosm,
               (SELECT o.sos FROM oper o WHERE o.REF = FX_DEAL.REFA) sosa,
               (SELECT o.sos FROM oper o WHERE o.REF = FX_DEAL.REFb) sosb,
               refb2, ref1,
               refa_sptod, refb_sptod,
               refb2_sptod, kodb,
               ta.dig ta_dig, tb.dig tb_dig,
               swi_ref, swo_ref,
               sumpa / 100 sumpa, sumpb / 100 sumpb,
               sump / 100 sump, swap_tag,
               fx_deal.rnk, c.okpo,
               b.mfo, fx_deal.DAT,
               fx_deal.DAT_A, fx_deal.DAT_B,
               fx_deal.nb,
               ROUND(DECODE(curr_base, 'A', sumb/suma, 'B', suma/sumb, GREATEST(suma, sumb) / LEAST(suma, sumb)), 8) KURS,
               sumc/POWER(10, ta.dig) sumc,
               CASE WHEN FX_DEAL.swap_tag IS NOT NULL AND FX_DEAL.acc9a IS NOT NULL THEN get_int_rate(FX_DEAL.acc9a, FX_DEAL.dat) ELSE NULL END ratea,
               CASE WHEN FX_DEAL.swap_tag IS NOT NULL AND FX_DEAL.acc9b IS NOT NULL THEN get_int_rate(FX_DEAL.acc9b, FX_DEAL.dat) ELSE NULL END rateb,
               'Редагування Парам.' RECPAR
          FROM FX_DEAL
          join tabval ta on ta.kv = FX_DEAL.kva
          join tabval tb on tb.kv = FX_DEAL.kvb
          left join customer c on c.rnk = fx_deal.rnk
          left join custbank b on b.rnk = fx_deal.rnk) x
 WHERE sosm > 0
 ORDER BY deal_tag DESC, DAT, kodb, KVA, KVB
;

PROMPT *** Create  grants  V_FXS_ARCHIVE ***
grant SELECT                                                                 on V_FXS_ARCHIVE   to UPLD;
grant SELECT                                                                 on V_FXS_ARCHIVE   to BARSREADER_ROLE;
grant SELECT                                                                 on V_FXS_ARCHIVE   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FXS_ARCHIVE.sql =========*** End *** 
PROMPT ===================================================================================== 
