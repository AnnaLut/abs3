

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VR_9819.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VR_9819 ***

  CREATE OR REPLACE FORCE VIEW BARS.VR_9819 ("BRANCH", "K_02", "S_02", "R_02", "K_03", "S_03", "R_03", "K_79", "S_79", "R_79", "K_83", "S_83", "R_83", "K_I3", "S_I3", "R_I3", "K_B8", "S_B8", "R_B8") AS 
  select
s.branch branch, k.k_02, nvl(s.s02,0) S02, k.k_02- nvl(s.s02,0) r02,
          k.k_03, nvl(s.s03,0) S03, k.k_03- nvl(s.s03,0) r03,
          k.k_79, nvl(s.s79,0) S79, k.k_79- nvl(s.s79,0) r79,
          k.k_83, nvl(s.s83,0) S83, k.k_83- nvl(s.s83,0) r83,
		  k.k_I3, nvl(s.sI3,0) SI3, k.k_I3- nvl(s.sI3,0) rI3,
		  k.k_b8, nvl(s.sb8,0) Sb8, k.k_b8- nvl(s.sb8,0) r83
from
(select substr(branch, 1,15) BRANCH,
  sum( decode (ob22, '02', -ostc,0) )/100 S02,
  sum( decode (ob22, '03', -ostc,0) )/100 S03,
  sum( decode (ob22, '79', -ostc,0) )/100 S79,
  sum( decode (ob22, '83', -ostc,0) )/100 S83,
  sum( decode (ob22, 'I3', -ostc,0) )/100 SI3,
  sum( decode (ob22, 'B8', -ostc,0) )/100 SB8
 from accounts
 where dazs is null and nbs='9819' and ob22 in ('02','03','79','83','I3','B8')
 group by substr(branch, 1,15)
 ) s,
(SELect substr(branch_cx,1,15) BRANCH,
        nvl(sum(k_02),0) K_02, nvl(sum(k_03),0) K_03,
        nvl(sum(k_79),0) K_79, nvl(sum(k_83),0) K_83,
		nvl(sum(k_I3),0) K_I3, nvl(sum(k_B8),0) K_B8
 from VV_9819 gROUP BY substr(branch_cx,1,15)
) k
where s.branch = k.branch;

PROMPT *** Create  grants  VR_9819 ***
grant SELECT                                                                 on VR_9819         to BARSREADER_ROLE;
grant SELECT                                                                 on VR_9819         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VR_9819         to RCC_DEAL;
grant SELECT                                                                 on VR_9819         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VR_9819.sql =========*** End *** ======
PROMPT ===================================================================================== 
