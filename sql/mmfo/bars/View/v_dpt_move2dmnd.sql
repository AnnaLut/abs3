

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_MOVE2DMND.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_MOVE2DMND ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_MOVE2DMND ("DPTID", "DPTNUM", "DPTDAT", "DATBEG", "DATEND", "TYPEID", "TYPENAME", "EXTEND_FLG", "EXTEND_CNT", "RATE", "CURID", "CURCODE", "CUSTID", "CUSTNAME", "CUSTCODE", "DEPACCID", "DEPACCNUM", "DEPACCNAME", "DEPSAL_FACT", "DEPSAL_PLAN", "DEPISP", "DEPGRP", "DEPTYPE", "INTACCID", "INTACCNUM", "INTACCNAME", "INTSAL_FACT", "INTSAL_PLAN", "INTISP", "INTGRP", "INTTYPE", "DMNDDPTID", "DMNDACCID", "DMNDACCNUM", "DMNDACCNAME", "BRANCH", "BRANCHNAME", "COMMENTS") AS 
  select d.deposit_id, d.nd, d.datz, d.dat_begin, d.dat_end,
       v.vidd, v.type_name, v.fl_dubl, nvl(v.term_dubl, 0),
       acrn.fproc(d.acc, bankdate), t.kv, t.lcv, c.rnk, c.nmk, c.okpo,
       dep.acc, dep.nls, substr(dep.nms, 1, 38), dep.ostc, dep.ostb, dep.isp, dep.grp, dep.tip,
       prc.acc, prc.nls, substr(prc.nms, 1, 38), prc.ostc, prc.ostb, prc.isp, prc.grp, prc.tip,
       d.dpt_d, d.acc_d, d.nls_d, substr(d.nms_d, 1, 38), b.tobo, b.name, d.comments
  from dpt_deposit d,
       customer    c,
       dpt_vidd    v,
       tabval      t,
       tobo        b,
       int_accn    i,
       accounts    dep,
       accounts    prc
 where d.rnk      = c.rnk
   and d.vidd     = v.vidd
   and d.kv       = t.kv
   and dep.tobo   = b.tobo
   and d.acc      = i.acc
   and i.id       = 1
   and i.acc      = dep.acc
   and i.acra     = prc.acc
   and d.dat_end  <= bankdate
   and (d.mfo_d is null or d.mfo_d = substr(f_ourmfo, 1, 6))
   and (dep.ostc > 0 or dep.ostb > 0)
   and (   (v.fl_dubl = 0)
        or (v.fl_dubl = 1 and v.term_dubl = 0)
        or (v.fl_dubl = 1 and v.term_dubl > 0 and v.term_dubl <= d.cnt_dubl)
       )
 ;

PROMPT *** Create  grants  V_DPT_MOVE2DMND ***
grant SELECT                                                                 on V_DPT_MOVE2DMND to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_MOVE2DMND to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_MOVE2DMND.sql =========*** End **
PROMPT ===================================================================================== 
