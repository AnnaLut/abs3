

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KL_F00_1.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view KL_F00_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.KL_F00_1 ("KODF", "AA", "A017", "NN", "PERIOD", "PROCC", "R", "SEMANTIC", "RECID", "KODF_EXT", "F_PREF", "PR_TOBO", "UUU", "ZZZ", "PATH_O", "DATF", "NOM", "POLICY_GROUP", "BRANCH") AS 
  select kodf, max(aa), a017, max(nn), max(period), max(procc), max(r), max(semantic),
       max(recid), max(kodf_ext), max(f_pref), max(pr_tobo), max(uuu), max(zzz),
       max(path_o), max(datf), max(nom), max(policy_group), max(branch)  
  from (
   SELECT g.kodf, g.aa, g.a017, g.nn, g.period, g.procc, g.r, g.semantic,
          g.recid, g.kodf_ext, g.f_pref, g.pr_tobo, 
          null uuu, null zzz, null path_o, null datf, null nom, null policy_group, null branch
     from kl_f00$global g
   union all
   select l.kodf, null aa, l.a017, null nn,  null period,  null procc, null r, null semantic,
          null recid, null kodf_ext, null f_pref, null pr_tobo,                         
          l.uuu, l.zzz, l.path_o, l.datf, l.nom, l.policy_group, l.branch
     FROM kl_f00$local l
)
group by kodf,  a017 
 ;

PROMPT *** Create  grants  KL_F00_1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F00_1        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00_1        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on KL_F00_1        to RPBN002;
grant SELECT                                                                 on KL_F00_1        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00_1        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_F00_1        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KL_F00_1.sql =========*** End *** =====
PROMPT ===================================================================================== 
