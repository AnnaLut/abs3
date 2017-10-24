

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KL_F00_INT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view KL_F00_INT ***

  CREATE OR REPLACE FORCE VIEW BARS.KL_F00_INT ("KODF", "AA", "A017", "NN", "PERIOD", "PROCC", "R", "SEMANTIC", "KODF_EXT", "F_PREF", "UUU", "ZZZ", "PATH_O", "DATF", "NOM", "TYPE_ZNAP", "PROCK", "POLICY_GROUP", "BRANCH", "PR_TOBO") AS 
  SELECT g.kodf,
          g.aa,
          g.a017,
          g.nn,
          g.period,
          g.procc,
          g.r,
          g.semantic,
          g.kodf_ext,
          g.f_pref,
          l.uuu,
          l.zzz,
          l.path_o,
          l.datf,
          l.nom,
          g.TYPE_ZNAP,
          g.PROCK,
          l.policy_group,
          l.branch,
          g.pr_tobo
     FROM kl_f00_int$global g, kl_f00_int$local l
    WHERE g.kodf = l.kodf AND g.a017 = l.a017;

PROMPT *** Create  grants  KL_F00_INT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00_INT      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F00_INT      to KL_F00_INT;
grant SELECT,UPDATE                                                          on KL_F00_INT      to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00_INT      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_F00_INT      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KL_F00_INT.sql =========*** End *** ===
PROMPT ===================================================================================== 
