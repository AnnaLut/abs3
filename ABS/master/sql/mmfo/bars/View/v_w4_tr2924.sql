

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_TR2924.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_TR2924 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_TR2924 ("BRANCH", "NLS") AS 
  select branch, substr(val,1,14)
  from branch_parameters
 where tag = 'TR2924_WAY4'
   and length(branch) = 15 ;

PROMPT *** Create  grants  V_W4_TR2924 ***
grant SELECT                                                                 on V_W4_TR2924     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_TR2924     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_TR2924.sql =========*** End *** ==
PROMPT ===================================================================================== 
