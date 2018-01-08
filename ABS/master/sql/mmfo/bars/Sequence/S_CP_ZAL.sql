

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CP_ZAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CP_ZAL ***

   CREATE SEQUENCE  BARS.S_CP_ZAL  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 198 CACHE 5 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CP_ZAL ***
grant SELECT                                                                 on S_CP_ZAL        to ABS_ADMIN;
grant SELECT                                                                 on S_CP_ZAL        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_CP_ZAL        to TOSS;
grant SELECT                                                                 on S_CP_ZAL        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CP_ZAL.sql =========*** End *** =
PROMPT ===================================================================================== 
