
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_fxs_archive.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_FXS_ARCHIVE ("DEAL_TAG", "NTIK", "KVA", "SUMA", "KVB", "SUMB", "REF", "SOSM", "REFA", "SOSA", "REFB", "SOSB", "REFB2", "REF1", "REFA_SPTOD", "REFB_SPTOD", "REFB2_SPTOD", "KODB", "TA_DIG", "TB_DIG", "SWI_REF", "SWO_REF", "SUMPA", "SUMPB", "SUMP", "SWAP_TAG", "RNK", "OKPO", "MFO", "DAT", "DAT_A", "DAT_B", "KURS", "SUMC", "RATEA", "RATEB", "NB", "RECPAR", "FX_TYPE", "F092") AS 
  SELECT DEAL_TAG, NTIK   , KVA  , SUMA , KVB , SUMB    , REF, SOSM, REFA, SOSA, REFB , SOSB , REFB2, REF1, REFA_SPTOD, REFB_SPTOD, REFB2_SPTOD, KODB  , TA_DIG, TB_DIG,
       SWI_REF , SWO_REF, SUMPA, SUMPB, SUMP, SWAP_TAG, RNK, OKPO, MFO , DAT , DAT_A, DAT_B, KURS , SUMC, RATEA     , RATEB     , NB         , RECPAR,
       FOREX.get_forextype3 (x.DEAL_TAG) FX_type ,
       (select substr(value,1,5)  from operw w where w.tag ='F092' and w.ref = x.REF ) F092
FROM (SELECT DEAL_TAG, NTIK, KVA, SUMA / POWER (10, ta.dig) suma, KVB, SUMB / POWER (10, tb.dig) SUMB, REF,  refa,  refb,
            (SELECT o.sos FROM oper o WHERE o.REF = FX_DEAL.REF ) sosm,
            (SELECT o.sos FROM oper o WHERE o.REF = FX_DEAL.REFA) SOSA,
            (SELECT o.sos FROM oper o WHERE o.REF = FX_DEAL.REFb) sosb,
            refb2, ref1, refa_sptod, refb_sptod, refb2_sptod, kodb, ta.dig ta_dig, tb.dig tb_dig, swi_ref, swo_ref, sumpa / 100 sumpa, sumpb / 100 sumpb, sump / 100 sump, swap_tag,
            fx_deal.rnk, c.okpo, b.mfo, FX_DEAL.DAT, FX_DEAL.DAT_A, FX_DEAL.DAT_B,   fx_deal.nb,
            ROUND (DECODE (curr_base,  'A', sumb/suma, 'B', suma/sumb,   GREATEST (suma, sumb) / LEAST (suma, sumb)), 8) KURS,
            sumc/POWER (10, ta.dig) sumc,
            CASE WHEN FX_DEAL.swap_tag IS NOT NULL  AND FX_DEAL.acc9a IS NOT NULL  THEN   get_int_rate (FX_DEAL.acc9a, FX_DEAL.dat)   ELSE NULL END     ratea,
            CASE WHEN FX_DEAL.swap_tag IS NOT NULL  AND FX_DEAL.acc9b IS NOT NULL  THEN   get_int_rate (FX_DEAL.acc9b, FX_DEAL.dat)   ELSE NULL END     rateb,
           'Редагування Парам.' RECPAR
      FROM  FX_DEAL, tabval ta, tabval tb, customer c, custbank b
      WHERE FX_DEAL.kva = ta.kv   AND FX_DEAL.kvb = tb.kv  AND fx_deal.rnk = c.rnk(+)  AND fx_deal.rnk = b.rnk(+)
     ) x
WHERE sosm > 0
ORDER BY deal_tag DESC, DAT, kodb, KVA, KVB
;
 show err;
 
PROMPT *** Create  grants  V_FXS_ARCHIVE ***
grant SELECT                                                                 on V_FXS_ARCHIVE   to BARSREADER_ROLE;
grant SELECT                                                                 on V_FXS_ARCHIVE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FXS_ARCHIVE   to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_fxs_archive.sql =========*** End *** 
 PROMPT ===================================================================================== 
 