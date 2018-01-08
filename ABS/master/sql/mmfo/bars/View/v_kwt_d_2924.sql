

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KWT_D_2924.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KWT_D_2924 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KWT_D_2924 ("DAT_SYS", "DAT_KWT") AS 
  select   t.dat_sys, t.dat_kwt FROM bars.kwt_d_2924 t;

PROMPT *** Create  grants  V_KWT_D_2924 ***
grant SELECT                                                                 on V_KWT_D_2924    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KWT_D_2924    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KWT_D_2924.sql =========*** End *** =
PROMPT ===================================================================================== 
