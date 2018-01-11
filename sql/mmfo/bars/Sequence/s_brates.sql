

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_BRATES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_BRATES ***

   CREATE SEQUENCE  BARS.S_BRATES  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1583448 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_BRATES ***
grant SELECT                                                                 on S_BRATES        to ABS_ADMIN;
grant SELECT                                                                 on S_BRATES        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_BRATES        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_BRATES.sql =========*** End *** =
PROMPT ===================================================================================== 
