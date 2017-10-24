

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_BANKS_UPDATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_BANKS_UPDATE ***

   CREATE SEQUENCE  BARS.S_BANKS_UPDATE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 4081 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_BANKS_UPDATE ***
grant SELECT                                                                 on S_BANKS_UPDATE  to ABS_ADMIN;
grant SELECT                                                                 on S_BANKS_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_BANKS_UPDATE  to TOSS;
grant SELECT                                                                 on S_BANKS_UPDATE  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_BANKS_UPDATE.sql =========*** End
PROMPT ===================================================================================== 
