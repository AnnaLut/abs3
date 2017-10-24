

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_INTPAYERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_INTPAYERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_INTPAYERS ("DEAL_ID", "DEAL_NUM", "DEAL_DAT", "DEAL_GEN", "DEAL_ADD", "VIDD", "DAT_BEGIN", "DAT_END", "DEPACCID", "INT_ACCID", "PAYER_MFO", "PAYER_ACC", "PAYER_CURID", "PAYER_NAME", "PAYER_CODE", "BENEF_MFO", "BENEF_ACC", "BENEF_CURID", "BENEF_NAME", "BENEF_CODE", "AMOUNT", "DK", "TT", "VOB", "NAZN") AS 
  select d.dpu_id, (select g.nd from dpu_deal g where g.dpu_id = nvl(d.dpu_gen, d.dpu_id)),
       d.datz, nvl(d.dpu_gen, d.dpu_id), d.dpu_add,
       d.vidd, d.dat_begin, d.dat_end, d.acc, a.acc,
       substr(f_ourmfo, 1, 6), a.nls, a.kv, substr(c.nmk, 1, 38), c.okpo,
       d.mfo_p, d.nls_p, a.kv, substr(d.nms_p, 1, 38),  NVL (d.okpo_p, c.okpo),
       a.ostc, sign(a.ostc), tts.tt, dpu.get_vob (tts.tt, a.kv, a.kv),
       substr(dpu.get_nazn(4, d.dpu_id, tts.tt, substr(f_ourmfo, 1, 6), a.nls, a.kv, d.mfo_p, d.nls_p, a.kv),1,160)
  from dpu_deal d,
       customer c,
       int_accn i,
       accounts a,
       tts
 where d.rnk  = c.rnk
   and d.acc  = i.acc
   and i.id   = 1
   and i.acra = a.acc
   and nvl(d.dpu_add, 1) != 0
   and a.ostc = a.ostb
   and a.ostc > 0
   and tts.tt = substr(dpu.get_tt(4, a.kv, d.mfo_p, d.nls_p), 1, 3)
   and dpu.get_intpay_state(d.dpu_id, d.freqv, d.dat_begin, d.dat_end, a.acc, bankdate) = 1;

PROMPT *** Create  grants  V_DPU_INTPAYERS ***
grant SELECT                                                                 on V_DPU_INTPAYERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_INTPAYERS to DPT;
grant SELECT                                                                 on V_DPU_INTPAYERS to DPT_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_INTPAYERS.sql =========*** End **
PROMPT ===================================================================================== 
