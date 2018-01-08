

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_NBS ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_NBS ("REF", "NLSA", "NBSA", "NLSB", "NBSB") AS 
  select ref,nlsa,substr(nlsa,1,4) nbsa ,
       nlsb,substr(nlsb,1,4) nbsb
  from oper;

PROMPT *** Create  grants  OPER_NBS ***
grant SELECT                                                                 on OPER_NBS        to BARSREADER_ROLE;
grant SELECT                                                                 on OPER_NBS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPER_NBS        to START1;
grant SELECT                                                                 on OPER_NBS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
