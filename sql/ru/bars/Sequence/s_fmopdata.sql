

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_FMOPDATA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_FMOPDATA ***

   CREATE SEQUENCE  BARS.S_FMOPDATA  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_FMOPDATA ***
grant SELECT                                                                 on S_FMOPDATA      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_FMOPDATA.sql =========*** End ***
PROMPT ===================================================================================== 
