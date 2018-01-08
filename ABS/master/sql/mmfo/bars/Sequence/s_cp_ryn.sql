

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CP_RYN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CP_RYN ***

   CREATE SEQUENCE  BARS.S_CP_RYN  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 801 NOCACHE  NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CP_RYN ***
grant SELECT                                                                 on S_CP_RYN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CP_RYN.sql =========*** End *** =
PROMPT ===================================================================================== 
