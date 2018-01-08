

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CC_SOB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CC_SOB ***

   CREATE SEQUENCE  BARS.S_CC_SOB  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 41156 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CC_SOB ***
grant SELECT                                                                 on S_CC_SOB        to ABS_ADMIN;
grant SELECT                                                                 on S_CC_SOB        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CC_SOB.sql =========*** End *** =
PROMPT ===================================================================================== 
