

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC_PROC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC_PROC ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC_PROC ("ACC", "PR") AS 
  select acc,acrn.fprocn(acc,id) from int_accn;

PROMPT *** Create  grants  ACC_PROC ***
grant SELECT                                                                 on ACC_PROC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_PROC        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC_PROC.sql =========*** End *** =====
PROMPT ===================================================================================== 
