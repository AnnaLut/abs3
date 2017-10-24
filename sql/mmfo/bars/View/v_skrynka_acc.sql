

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SKRYNKA_ACC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SKRYNKA_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SKRYNKA_ACC ("ACC", "N_SK", "TIP") AS 
  select acc, n_sk, tip
from skrynka_acc
union all
select acc, n_sk, tip
from skrynka_acc_arc;

PROMPT *** Create  grants  V_SKRYNKA_ACC ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SKRYNKA_ACC   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SKRYNKA_ACC.sql =========*** End *** 
PROMPT ===================================================================================== 
