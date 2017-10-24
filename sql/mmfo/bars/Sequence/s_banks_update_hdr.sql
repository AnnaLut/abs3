

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_BANKS_UPDATE_HDR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_BANKS_UPDATE_HDR ***

   CREATE SEQUENCE  BARS.S_BANKS_UPDATE_HDR  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 4142 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_BANKS_UPDATE_HDR ***
grant SELECT                                                                 on S_BANKS_UPDATE_HDR to ABS_ADMIN;
grant SELECT                                                                 on S_BANKS_UPDATE_HDR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_BANKS_UPDATE_HDR to TOSS;
grant SELECT                                                                 on S_BANKS_UPDATE_HDR to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_BANKS_UPDATE_HDR.sql =========***
PROMPT ===================================================================================== 
