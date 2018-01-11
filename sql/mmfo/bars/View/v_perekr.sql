

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PEREKR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PEREKR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PEREKR ("ISP", "IDG", "KVA", "NLSA", "NMSA", "PROC", "TT", "MFOB", "NLSB", "POLU", "NAZN", "NB") AS 
  select 
a.isp,s.idg,a.kv,a.nls,a.nms,b.koef*100,b.tt,b.mfob,b.nlsb,b.polu,
b.nazn,m.nb from accounts a,specparam s, perekr_b b , banks m
where a.acc=s.acc and s.ids=b.ids and b.mfob=m.mfo;

PROMPT *** Create  grants  V_PEREKR ***
grant SELECT                                                                 on V_PEREKR        to BARSREADER_ROLE;
grant SELECT                                                                 on V_PEREKR        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PEREKR        to START1;
grant SELECT                                                                 on V_PEREKR        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PEREKR.sql =========*** End *** =====
PROMPT ===================================================================================== 
