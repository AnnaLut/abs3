

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/INT_ACCV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view INT_ACCV ***

  CREATE OR REPLACE FORCE VIEW BARS.INT_ACCV ("ACC", "IDR", "KF") AS 
  select ACC, IDR, KF  from INT_ACCN  where ID=0 and METR=7
 ;

PROMPT *** Create  grants  INT_ACCV ***
grant SELECT,UPDATE                                                          on INT_ACCV        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on INT_ACCV        to CUST001;
grant SELECT                                                                 on INT_ACCV        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/INT_ACCV.sql =========*** End *** =====
PROMPT ===================================================================================== 
