

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PARAMS_PRIME_LOAD.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PARAMS_PRIME_LOAD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PARAMS_PRIME_LOAD ("TT", "N_VALUE", "TAG", "VALUE", "IS_EMPTY", "IS_EDIT", "IS_CA", "PRIME") AS 
  select tt,
       n_value,
       tag,
       value,
       is_empty,
       is_edit,
       is_ca, prime
from   (select tt, prime, n_value, n_value int_value, n_is_empty, n_is_edit, b_value, b_is_empty, b_is_edit, g_value, g_is_empty, g_is_edit, is_ca ,DESCRIPTION
       from   params_prime_load t
       where  t.is_ca = decode(/*f_ourmfo_g*/sys_context('bars_gl', 'mfo'), '300465', 1, 0))
unpivot((value, is_empty, is_edit) for tag in ((int_value, n_is_empty, n_is_edit) as 'KOD_N',
                                              (b_value, b_is_empty, b_is_edit) as 'KOD_B',
                                              (g_value, g_is_empty, g_is_edit) as 'KOD_G'));

PROMPT *** Create  grants  V_PARAMS_PRIME_LOAD ***
grant SELECT                                                                 on V_PARAMS_PRIME_LOAD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PARAMS_PRIME_LOAD.sql =========*** En
PROMPT ===================================================================================== 
