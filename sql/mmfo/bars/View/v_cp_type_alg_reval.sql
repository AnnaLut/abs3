
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/View/v_cp_type_alg_reval.sql =*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cp_type_alg_reval ***

  CREATE OR REPLACE FORCE VIEW BARS.v_cp_type_alg_reval ("ID", "NAME") AS 
  select 1, 'по чистій ціні ЦП' from dual
  union
  select 2, 'по брудній ціні(з купоном) ЦП' from dual
  union
  select 3, 'по опціону' from dual;

PROMPT *** Create  grants  v_cp_type_alg_reval ***
grant SELECT                                                                 on v_cp_type_alg_reval         to BARSREADER_ROLE;
grant SELECT                                                                 on v_cp_type_alg_reval         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_cp_type_alg_reval         to START1;
grant SELECT                                                                 on v_cp_type_alg_reval         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cp_type_alg_reval.sql =========*** End *** ======
PROMPT ===================================================================================== 
