

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_PEREKR_B.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_PEREKR_B ***

   CREATE SEQUENCE  BARS.S_PEREKR_B  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 26053 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_PEREKR_B ***
grant SELECT                                                                 on S_PEREKR_B      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_PEREKR_B.sql =========*** End ***
PROMPT ===================================================================================== 
