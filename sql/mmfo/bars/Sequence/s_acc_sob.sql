

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ACC_SOB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ACC_SOB ***

   CREATE SEQUENCE  BARS.S_ACC_SOB  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 35201 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ACC_SOB ***
grant SELECT                                                                 on S_ACC_SOB       to ABS_ADMIN;
grant SELECT                                                                 on S_ACC_SOB       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_ACC_SOB       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ACC_SOB.sql =========*** End *** 
PROMPT ===================================================================================== 
