

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CONDUCTOR.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CONDUCTOR ***

  CREATE OR REPLACE FORCE VIEW BARS.CONDUCTOR ("NUM") AS 
  SELECT LEVEL num
         FROM DUAL
   CONNECT BY LEVEL < 65526;

PROMPT *** Create  grants  CONDUCTOR ***
grant SELECT                                                                 on CONDUCTOR       to BARSREADER_ROLE;
grant SELECT                                                                 on CONDUCTOR       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CONDUCTOR       to CUST001;
grant SELECT                                                                 on CONDUCTOR       to START1;
grant SELECT                                                                 on CONDUCTOR       to UPLD;
grant SELECT                                                                 on CONDUCTOR       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CONDUCTOR.sql =========*** End *** ====
PROMPT ===================================================================================== 
