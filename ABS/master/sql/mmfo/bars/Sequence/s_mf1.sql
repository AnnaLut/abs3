

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_MF1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_MF1 ***

   CREATE SEQUENCE  BARS.S_MF1  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 11850 NOCACHE  NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_MF1 ***
grant SELECT                                                                 on S_MF1           to ABS_ADMIN;
grant SELECT                                                                 on S_MF1           to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_MF1.sql =========*** End *** ====
PROMPT ===================================================================================== 
