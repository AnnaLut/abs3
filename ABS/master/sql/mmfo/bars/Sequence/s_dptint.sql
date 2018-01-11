

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPTINT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPTINT ***

   CREATE SEQUENCE  BARS.S_DPTINT  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 22043 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPTINT ***
grant SELECT                                                                 on S_DPTINT        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPTINT.sql =========*** End *** =
PROMPT ===================================================================================== 
