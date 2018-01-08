

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_159.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_159 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_159 ("DPTID", "DPTNUM", "DPTDAT", "DATBEG", "DATEND", "TYPEID", "TYPENAME", "RATE", "CURID", "CURCODE", "CUSTID", "CUSTNAME", "CUSTCODE", "DEPACCID", "DEPACCNUM", "DEPACCNAME", "DEPSAL_FACT", "DEPSAL_PLAN", "DEPISP", "DEPGRP", "DEPTYPE", "INTACCID", "INTACCNUM", "INTACCNAME", "INTSAL_FACT", "INTSAL_PLAN", "INTISP", "INTGRP", "INTTYPE", "BRANCH", "BRANCHNAME") AS 
  select d.deposit_id, d.nd, d.datz, d.dat_begin, d.dat_end, v.vidd, v.type_name,
       acrn.fproc(d.acc, bankdate), t.kv, t.lcv, c.rnk, c.nmk, c.okpo,
       dep.acc, dep.nls, dep.nms, dep.ostc, dep.ostb, dep.isp, dep.grp, dep.tip,
       prc.acc, prc.nls, prc.nms, prc.ostc, prc.ostb, prc.isp, prc.grp, prc.tip,
       b.branch, b.name
  from dpt_deposit d,
       customer    c,
       dpt_vidd    v,
       tabval      t,
       branch      b,
       int_accn    i,
       accounts    dep,
       accounts    prc
 where d.rnk      = c.rnk
   and d.vidd     = v.vidd
   and d.kv       = t.kv
   and d.branch   = b.branch
   and d.acc      = i.acc
   and i.id       = 1
   and i.acc      = dep.acc
   and i.acra     = prc.acc
   and d.dat_end  > bankdate
                    -- (select to_date(val, 'mm.dd.yyyy')
                    --   from params$base
                    --  where kf  = '333368'
                    --    and par = 'BANKDATE')
   and dep.nbs    != '2620' -- срочные вклады, для которых перенос еще не выполнен
   and v.type_cod in ('RFSH', 'WPNS','KOMB','MAIB', 'PNS+')
 ;

PROMPT *** Create  grants  V_DPT_159 ***
grant SELECT                                                                 on V_DPT_159       to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_159       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_159       to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_159       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_159.sql =========*** End *** ====
PROMPT ===================================================================================== 
