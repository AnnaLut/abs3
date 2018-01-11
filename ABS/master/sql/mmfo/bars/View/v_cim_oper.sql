

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_OPER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_OPER ("REF", "DK", "TT", "KV", "S", "VDAT", "NAM_A", "NLSA", "MFOA", "NAM_B", "NLSB", "MFOB", "PDAT", "SOS", "CURRVISAGRP", "NEXTVISAGRP", "KF", "BRANCH", "NAZN") AS 
  select o.ref, o.dk, o.tt, o.kv, o.s, nvl((select max(fdat) from opldok where ref=o.ref),o.vdat) as vdat,
         o.nam_a, o.nlsa, o.mfoa, o.nam_b, o.nlsb, o.mfob, o.pdat, o.sos, o.currvisagrp, o.nextvisagrp, o.kf, o.branch, o.nazn
  from oper o;

PROMPT *** Create  grants  V_CIM_OPER ***
grant SELECT                                                                 on V_CIM_OPER      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_OPER      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_OPER      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_OPER.sql =========*** End *** ===
PROMPT ===================================================================================== 
