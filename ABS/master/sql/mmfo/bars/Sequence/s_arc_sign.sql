

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ARC_SIGN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ARC_SIGN ***

   CREATE SEQUENCE  BARS.S_ARC_SIGN  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 818197454 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ARC_SIGN ***
grant SELECT                                                                 on S_ARC_SIGN      to ABS_ADMIN;
grant SELECT                                                                 on S_ARC_SIGN      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ARC_SIGN.sql =========*** End ***
PROMPT ===================================================================================== 
