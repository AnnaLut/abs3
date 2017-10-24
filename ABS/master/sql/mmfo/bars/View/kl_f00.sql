

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KL_F00.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KL_F00 ***

  CREATE OR REPLACE FORCE VIEW BARS.KL_F00 ("KODF", "AA", "A017", "NN", "PERIOD", "PROCC", "R", "SEMANTIC", "RECID", "KODF_EXT", "F_PREF", "PR_TOBO", "UUU", "ZZZ", "PATH_O", "DATF", "NOM", "TYPE_ZNAP", "PROCK", "POLICY_GROUP", "BRANCH") AS 
  select g.kodf, g.aa, g.a017, g.nn, g.period, g.procc, g.r, g.semantic,
						          g.recid, g.kodf_ext, g.f_pref, g.pr_tobo, l.uuu, l.zzz, l.path_o,
						          l.datf, l.nom, g.TYPE_ZNAP, g.PROCK, l.policy_group, l.branch
						     from kl_f00$global g, kl_f00$local l
						    where g.kodf = l.kodf and g.a017 = l.a017 ;

PROMPT *** Create  grants  KL_F00 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F00          to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F00          to KL_F00;
grant SELECT,UPDATE                                                          on KL_F00          to RPBN002;
grant SELECT                                                                 on KL_F00          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_F00          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KL_F00.sql =========*** End *** =======
PROMPT ===================================================================================== 
