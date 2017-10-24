

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CC_DEAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CC_DEAL ***

   CREATE SEQUENCE  BARS.S_CC_DEAL  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 59111267 CACHE 5 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CC_DEAL ***
grant SELECT                                                                 on S_CC_DEAL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_CC_DEAL       to RCC_DEAL;
grant SELECT                                                                 on S_CC_DEAL       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CC_DEAL.sql =========*** End *** 
PROMPT ===================================================================================== 
