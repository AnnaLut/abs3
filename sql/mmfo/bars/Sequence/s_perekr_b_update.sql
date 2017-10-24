

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_PEREKR_B_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_PEREKR_B_UPDATE ***

   CREATE SEQUENCE  BARS.S_PEREKR_B_UPDATE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 13962 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_PEREKR_B_UPDATE ***
grant SELECT                                                                 on S_PEREKR_B_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_PEREKR_B_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
