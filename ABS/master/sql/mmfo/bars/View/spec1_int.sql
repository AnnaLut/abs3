

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SPEC1_INT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view SPEC1_INT ***

  CREATE OR REPLACE FORCE VIEW BARS.SPEC1_INT ("ACC", "NLS", "NBS", "KV", "NMS", "P080", "OB22", "MFO", "R020_FA", "F_11", "OB88", "DAZS") AS 
  SELECT a.acc,
          a.nls,
          a.nbs,
          a.kv,
          a.nms,
          b.p080,
          a.ob22,
          b.mfo,
          b.r020_fa,
          b.f_11,
          b.ob88,
          a.dazs
     FROM accounts a, specparam_int b
    WHERE a.acc = b.acc;

PROMPT *** Create  grants  SPEC1_INT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPEC1_INT       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPEC1_INT       to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPEC1_INT       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPEC1_INT       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SPEC1_INT       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SPEC1_INT.sql =========*** End *** ====
PROMPT ===================================================================================== 
